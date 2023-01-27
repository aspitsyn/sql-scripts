-- don't forget to purge a cursor after markhot

select gv$sql.inst_id, kglnahsv from gv$sql, x$kglob where kglhdadr=address and sql_id='c51nc15qcrhgq';

EXEC DBMS_SHARED_POOL.MARKHOT (hash => 'ead85d2c45c42e9ac2868c096ccbc1f6', namespace => 0, global => TRUE);