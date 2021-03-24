set timing on
set pagesize 50000;
set linesize 8000;
set serverout off;
alter session set "STATISTICS_LEVEL" = 'ALL';
alter session set current_schema = HR;
alter session set cursor_sharing = 'EXACT';
alter session set events '10046 trace name context forever, level 8';
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
select count(*) from EMPLOYEES E where E.DEPARTMENT_ID in (select D.DEPARTMENT_ID from DEPARTMENTS D where D.DEPARTMENT_ID = E.DEPARTMENT_ID);
select * from table(dbms_xplan.display_cursor());
SELECT s.sid, p.tracefile FROM   v$session s JOIN v$process p ON s.paddr = p.addr WHERE  s.sid = (select distinct sid from v$mystat);
spo off;
alter session set events '10046 trace name context off';
set timing off;