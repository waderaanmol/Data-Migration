USE sandboxpersonal;
Go

CREATE PROCEDURE [mod].AddLoggingTriggerToTable
    @TableName NVARCHAR(128),
    @TriggerName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    SET @sql = '
    CREATE TRIGGER' +  QUOTENAME(@TriggerName) + '
    ON [mod].' + QUOTENAME(@TableName) + '
    AFTER INSERT, UPDATE
    AS
    BEGIN
        DECLARE @procedure_name VARCHAR(128) = OBJECT_NAME(@@PROCID);
        DECLARE @start_date DATETIME = GETDATE();
        DECLARE @end_date DATETIME = NULL;
        DECLARE @rows_affected INT = (SELECT COUNT(*) FROM inserted);
        DECLARE @status VARCHAR(255) = ''Pending'';
        DECLARE @comment NVARCHAR(255) = ''Insert/Update operation logged'';
        DECLARE @username VARCHAR(100) = SYSTEM_USER;

        BEGIN TRY
            SET @end_date = GETDATE();
            SET @status = ''Success'';
            INSERT INTO mod.log (procedure_name, start_date, end_date, rows_affected, status, comment, username)
            VALUES (@procedure_name, @start_date, @end_date, @rows_affected, @status, @comment, @username);
        END TRY
        BEGIN CATCH
            SET @status = ''Failure'';
            SET @comment = ERROR_MESSAGE();
            INSERT INTO mod.log (procedure_name, start_date, end_date, rows_affected, status, comment, username)
            VALUES (@procedure_name, @start_date, @end_date, @rows_affected, @status, @comment, @username);
        END CATCH;
    END;';

    EXEC sp_executesql @sql;
END;
