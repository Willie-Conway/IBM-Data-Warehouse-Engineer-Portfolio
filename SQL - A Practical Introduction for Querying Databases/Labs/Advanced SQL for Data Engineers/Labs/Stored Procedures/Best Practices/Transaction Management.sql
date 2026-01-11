BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Multiple related operations
    UPDATE table1 SET ...;
    INSERT INTO table2 VALUES ...;
    DELETE FROM table3 WHERE ...;
    
    COMMIT;
END;