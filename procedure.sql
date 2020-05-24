create or replace PROCEDURE add_info (
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
