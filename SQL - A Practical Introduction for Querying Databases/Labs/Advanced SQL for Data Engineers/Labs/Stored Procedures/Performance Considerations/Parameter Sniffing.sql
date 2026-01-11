-- Use local variables to prevent parameter sniffing issues
CREATE PROCEDURE GetSalesData(IN start_date DATE)
BEGIN
    DECLARE local_start_date DATE;
    SET local_start_date = start_date;
    
    SELECT * FROM sales 
    WHERE sale_date >= local_start_date;
END;