-- WHILE loop
WHILE condition DO
    statements;
END WHILE;

-- REPEAT loop (do-while)
REPEAT
    statements;
UNTIL condition
END REPEAT;

-- LOOP with LEAVE
my_loop: LOOP
    statements;
    IF condition THEN
        LEAVE my_loop;
    END IF;
END LOOP my_loop;