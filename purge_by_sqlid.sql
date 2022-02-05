set timi on

col addr new_val addr;
col hval new_val hval;

col filename new_val filename;

select '/tmp/purge_by_sqlid'||'_'||to_char(SYSDATE,'YYYYMMDD_HH24MI')||'.log' filename from dual;
spo &filename;
select ADDRESS addr, HASH_VALUE hval from GV$SQLAREA where SQL_ID='&&1' and rownum<=1;

exec DBMS_SHARED_POOL.PURGE('&addr,&hval','C');
spo off
set timing off