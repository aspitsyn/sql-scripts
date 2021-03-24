set serveroutput on
set echo off
set feed off
set timing off
set termout off
set veri off
DEF srct      = "HR.BIG_TABLE_STAGE" (CHAR)
DEF destt      = "HR.BIG_TABLE_TO" (CHAR)
DEF schm      = "HR" (CHAR)
DEF partt      = "BIG_TABLE_TO" (CHAR)
spo alter_to_03.sql

begin
 declare  
   CURSOR my_cur IS   
      select 'ALTER TABLE &destt EXCHANGE SUBPARTITION ' || SUBPARTITION_NAME || ' WITH TABLE &srct WITHOUT VALIDATION;' val from dba_tab_subpartitions where table_owner='&schm' and table_name='&partt';
 begin
   for my_rec in my_cur LOOP
    --l_txt:= my_rec.val;
     dbms_output.put_line(my_rec.val);
    END LOOP; 
 end;
end;
/

spo off;