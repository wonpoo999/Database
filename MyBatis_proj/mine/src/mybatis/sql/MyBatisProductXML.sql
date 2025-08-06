DROP TABLE tbl_product

DELETE FROM tbl_product WHERE PCODE = 'P002';
COMMIT;

DROP SEQUENCE seq_product;

CREATE TABLE tbl_product (
    pcode VARCHAR2(20) PRIMARY KEY,
    pname VARCHAR2(50) NOT NULL,
    price NUMBER NOT NULL,
    maker VARCHAR2(100),
    category VARCHAR2(100)
);

CREATE SEQUENCE seq_product START WITH 1 INCREMENT BY 1;


SELECT column_name, data_type, data_length
FROM user_tab_columns
WHERE table_name = 'TBL_PRODUCT';

ALTER TABLE tbl_product ADD maker VARCHAR2(100);

ALTER TABLE tbl_product MODIFY category VARCHAR2(100);

