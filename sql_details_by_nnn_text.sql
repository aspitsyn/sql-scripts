--alter session set "_parallel_syspls_obey_force" = FALSE;
set trimspool on
set trim on
set pages 0
set linesize 8000
set long 10000000
set longchunksize 10000000
set termout off;
set timing off;
column db_id new_val db_id;
select DBID db_id from v$database;
-- column instnum new_val instnum;
-- select instance_number instnum from v$instance;
column instname new_val instname;
select instance_name instname from gv$instance where inst_id='&&2';
column filename new_val filename;

set veri off;
set feed off;

select '/tmp/sqlmon_' || '&&1' || '_' || '&&3' || '_&instname'||'_'||to_char(SYSDATE,'YYYYMMDD_HH24MI')||'.txt' filename from dual;

spool &filename;
select 
    dbms_sqltune.report_sql_monitor
    (
		sql_id=> '&&1',
		--sql_id=>NULL,
        --dbop_name=>'DBOP002',
        --session_id=>-1,
		sql_exec_id=> '&&3',
        inst_id => '&&2',
        type=>'TEXT'
    ) 
    from dual;
spool off