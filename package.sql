CREATE OR REPLACE PACKAGE my_package IS
    TYPE rowprojects IS RECORD (
        bar_name  chocolate.bar_name%TYPE,
        company   chocolate.company%TYPE,
        bean_type chocolate.bean_type%TYPE
    );
    TYPE tblprojects IS
        TABLE OF rowprojects;
--
    FUNCTION choosebeans (
        company_name   VARCHAR,
        percent      FLOAT
    ) RETURN tblprojects
        PIPELINED;

    PROCEDURE add_info (
    id INTEGER,
    name VARCHAR,
    cocoa_perc FLOAT,
    company_name    VARCHAR,
    bean_name   VARCHAR
    );

END my_package;
/
create or replace PACKAGE BODY my_package IS

    PROCEDURE add_info (
    id INTEGER,
    name VARCHAR,
    cocoa_perc FLOAT,
    company_name    VARCHAR,
    bean_name   VARCHAR
) AS
    bean_status NUMBER;
    company_status NUMBER;
    no_data EXCEPTION;
BEGIN

    SELECT
        COUNT(*)
    INTO bean_status
    FROM
        bean
    WHERE
        bean_type LIKE bean_name;

    SELECT
        COUNT(*)
    INTO company_status
    FROM
        company
    WHERE
        company LIKE company_name;

    IF (bean_status = 1) and (company_status = 1)  THEN
    INSERT INTO chocolate(BAR_ID, BAR_NAME, COMPANY, BEAN_TYPE, COCOA_PERC) VALUES(id, name, company_name, bean_name, cocoa_perc);

    ELSE
        RAISE no_data;

    END IF;

EXCEPTION
    WHEN no_data THEN
        dbms_output.put_line('No such bean or company in the database');
    WHEN OTHERS THEN
        dbms_output.put_line('Something else went wrong - '
                             || sqlcode
                             || ' : '
                             || sqlerrm);
END;

FUNCTION choosebeans (company_name   VARCHAR,
        percent      FLOAT
    ) RETURN tblprojects
        PIPELINED
    IS

        CURSOR cur IS
        (SELECT
            bar_name,
            company,
            bean_type
        FROM
            chocolate_view
        WHERE
            company = company_name
            AND cocoa_perc <= percent );
    my_rec rowprojects;
    BEGIN
        FOR rec IN cur 
        LOOP
            my_rec.bar_name := rec.bar_name;
            my_rec.company := rec.company;
            my_rec.bean_type := rec.bean_type;
            PIPE ROW ( my_rec );
        END LOOP;
    END;

END;
