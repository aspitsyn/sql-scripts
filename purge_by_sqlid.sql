set timing on
spool purge_by_sqlid.log
column addr new_val addr;
column hval new_val hval;

select ADDRESS addr, HASH_VALUE hval from GV$SQLAREA where SQL_Id='&sql_id' and rownum<2;

exec DBMS_SHARED_POOL.PURGE('&addr,&hval','C');
spool off
set timing off