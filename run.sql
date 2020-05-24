
BEGIN
  my_package.add_info(10,'Hello',65,'Soma','Trinitario'); 
  my_package.add_info(10,'Hello',65,'Som','Trinitario'); 
END;

/


SELECT * FROM TABLE(my_package.choosebeans('Soma',70));

/


INSERT  into chocolate(BAR_ID, BAR_NAME, COMPANY, BEAN_TYPE, COCOA_PERC) VALUES (20,'New_choco','Soma','Trinitario',24);
INSERT  into chocolate(BAR_ID, BAR_NAME, COMPANY, BEAN_TYPE, COCOA_PERC) VALUES (20,'New_choco2','Soma','Trinitario',28);
