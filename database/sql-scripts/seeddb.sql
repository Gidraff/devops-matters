DELIMITER $$ 
-- DROP PROCEDURE generate_data;
CREATE PROC generate_data() 
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 1000 DO
        INSERT INTO `demo_table` (`first_name`, `last_name`, `age`,`mobile_no`) VALUES (
            CONV(FLOOR(RAND() * 9999999999), 10, 36),
            CONV(FLOOR(RAND() * 9999999999), 10, 36),
            ROUND(RAND() * 100, 2),
            LPAD(FLOOR(RAND() * 10000000000), 10, '0')
        );
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

