set timing on
set pagesize 50000;
set linesize 8000;
set serverout off;
alter session set "STATISTICS_LEVEL" = 'ALL';
alter session set current_schema = HR;
alter session set cursor_sharing = 'EXACT';
--alter session set sqltune_category='TEST';

-- VAR B1 VARCHAR2(32);
-- VAR B2 NUMBER;
-- VAR B3 NUMBER;
-- VAR B4 NUMBER;
-- VAR B5 VARCHAR2(32);


col filename new_val filename;
select '\tmp\rt_stats'||'_'||to_char(SYSDATE,'YYYYMMDD_HH24MI')||'.log' filename from dual;
SPO &filename;

-- exec  :B5   := 'BBB';
-- exec  :B4   := 231;
-- exec  :B3   := 321;
-- exec  :B2   := 123;
-- exec  :B1   := 'AAA';

set feedback on;
SELECT /*+ MONITOR */ COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID IN (SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID);
SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR(null,null,'ALL ALLSTATS LAST'));
spo off;