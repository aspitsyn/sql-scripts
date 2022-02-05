--set echo on
set timing on;
set pagesize 50000;
set linesize 8000;
set serverout off;
alter session set "STATISTICS_LEVEL" = 'ALL';
alter session set current_schema = HR;
alter session set cursor_sharing = 'EXACT';
alter session set optimizer_index_cost_adj = 100;
--alter session set sqltune_category='TEST';
--alter session set events '10046 trace name context forever, level 12';
--alter session set events 'sql_trace bind=true, wait=true, level=12'; 

VAR B1 NUMBER;
VAR B2 NUMBER;
-- VAR B3 NUMBER;
-- VAR B4 NUMBER;

col filename new_val filename;
select '/tmp/stats'||'_'||to_char(SYSDATE,'YYYYMMDD_HH24MI')||'.log' filename from dual;
SPO &filename;

exec  :B1   := 1;
exec  :B2   := 9;
-- exec  :B3   := 3200000;
-- exec  :B4   := 2022;

set feedback on;
SELECT s.sid, s.serial#, p.spid, p.tracefile FROM v$session s JOIN v$process p ON s.paddr = p.addr WHERE s.sid = (select distinct sid from v$mystat);
set feedback only;
SELECT /*+ monitor bind_aware opt_param('_optimizer_adaptive_cursor_sharing' 'true') opt_param('_optimizer_use_feedback' 'true') opt_param('_optimizer_extended_cursor_sharing_rel' 'SIMPLE') */ EMP.* FROM HR.EMPLOYEES_BIG EMP WHERE DEPARTMENT_ID  BETWEEN :B1 AND :B2;
set feedback on;
SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR(null,null,'ALL ALLSTATS LAST +outline +peeked_binds +hint_report'));
--alter session set events 'sql_trace off';
--alter session set events '10046 trace name context off';
spo off;