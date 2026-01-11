DELIMITER //
CREATE PROCEDURE CALCULATE_TOTAL_SALES()
BEGIN
    DECLARE total_sales DECIMAL(10,2);
    DECLARE avg_price DECIMAL(10,2);
    
    -- Calculate totals
    SELECT SUM(SALEPRICE) INTO total_sales FROM PETSALE;
    SELECT AVG(SALEPRICE) INTO avg_price FROM PETSALE;
    
    -- Return results
    SELECT total_sales AS TOTAL_SALES, avg_price AS AVERAGE_PRICE;
END //
DELIMITER ;