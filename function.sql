CREATE TYPE rowps IS OBJECT (
        bar_name  VARCHAR(100),
        company   VARCHAR(100),
        bean_type VARCHAR(100)
    );
/
CREATE TYPE tbl IS
        TABLE OF rows;
/
CREATE OR REPLACE FUNCTION choosebeans (company_name   VARCHAR,
        percent      FLOAT
    ) RETURN tbl
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
    my_rec rows;
    BEGIN
        FOR rec IN cur 
        LOOP
            my_rec.bar_name := rec.bar_name;
            my_rec.company := rec.company;
            my_rec.bean_type := rec.bean_type;
            PIPE ROW ( my_rec );
        END LOOP;
    END;
