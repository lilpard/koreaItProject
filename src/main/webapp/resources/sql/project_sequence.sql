use project;

create table SEQUENCES
(
	NAME varchar(32),
    CURRVAL BIGINT unsigned
)
ENGINE = InnoDB;

DELIMITER $$
	CREATE procedure `create_sequence` (IN the_name text)
	modifies sql data
	deterministic
	begin
		DELETE FROM SEQUENCES WHERE NAME = the_name;
		INSERT INTO SEQUENCES VALUES(the_name, 0);
	END;


DELIMITER $$
	CREATE function `nextval` (the_name varchar(32))
	RETURNS BIGINT unsigned
    modifies sql data
    deterministic
    BEGIN
		DECLARE ret BIGINT unsigned;
        UPDATE SEQUENCES SET currval = currval + 1 WHERE NAME = the_name;
        SELECT currval INTO ret FROM SEQUENCES WHERE NAME = the_name LIMIT 1;
        RETURN ret;
	END;
    
