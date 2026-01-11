-- View initial data
CALL RETRIEVE_ALL();

-- Apply BAD discount to animal ID 1
CALL UPDATE_SALEPRICE(1, 'BAD');

-- View updated data
CALL RETRIEVE_ALL();

-- Apply WORSE discount to animal ID 3
CALL UPDATE_SALEPRICE(3, 'WORSE');

-- View final data
CALL RETRIEVE_ALL();