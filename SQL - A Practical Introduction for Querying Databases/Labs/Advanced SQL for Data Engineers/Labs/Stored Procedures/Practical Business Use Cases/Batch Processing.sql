DELIMITER //
CREATE PROCEDURE APPLY_SEASONAL_DISCOUNT(
    IN discount_percent DECIMAL(5,2),
    IN pet_category VARCHAR(50)
)
BEGIN
    UPDATE PETSALE
    SET SALEPRICE = SALEPRICE * (1 - discount_percent/100)
    WHERE PET = pet_category
      AND SALEDATE BETWEEN '2024-12-01' AND '2024-12-31';
    
    SELECT CONCAT('Applied ', discount_percent, '% discount to ', ROW_COUNT(), ' ', pet_category, ' pets') AS RESULT;
END //
DELIMITER ;