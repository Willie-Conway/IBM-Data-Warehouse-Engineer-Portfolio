CREATE PROCEDURE sp_petsale_crud(
    IN operation VARCHAR(10),
    IN pet_id INT,
    IN pet_name VARCHAR(50),
    IN sale_price DECIMAL(10,2)
)
BEGIN
    CASE operation
        WHEN 'CREATE' THEN
            INSERT INTO PETSALE (PET, SALEPRICE, SALEDATE) 
            VALUES (pet_name, sale_price, CURDATE());
        WHEN 'READ' THEN
            SELECT * FROM PETSALE WHERE ID = pet_id;
        WHEN 'UPDATE' THEN
            UPDATE PETSALE 
            SET PET = pet_name, SALEPRICE = sale_price 
            WHERE ID = pet_id;
        WHEN 'DELETE' THEN
            DELETE FROM PETSALE WHERE ID = pet_id;
        ELSE
            SELECT 'Invalid operation' AS ERROR;
    END CASE;
END;