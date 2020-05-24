create or replace TRIGGER add_chocolate BEFORE INSERT
    ON chocolate FOR EACH ROW  
    
    
BEGIN 
    :new.cocoa_perc := 70;
END;
