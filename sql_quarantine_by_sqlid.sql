DECLARE
  l_sql_quarantine  VARCHAR2(100);
BEGIN
  l_sql_quarantine := sys.DBMS_SQLQ.create_quarantine_by_sql_id(
                        sql_id => 'nnnnnnnnnnnnn'
                      );
  DBMS_OUTPUT.put_line('l_sql_quarantine=' || l_sql_quarantine);
END;
/

DECLARE
  l_sql_quarantine  VARCHAR2(100);
BEGIN
  l_sql_quarantine := sys.DBMS_SQLQ.create_quarantine_by_sql_id(
                        sql_id          => 'nnnnnnnnnnnnn',
                        plan_hash_value => '0000000000'
                      );
  DBMS_OUTPUT.put_line('l_sql_quarantine=' || l_sql_quarantine);
END;
/

-- Quarantine all execution plans for a SQL statement.
DECLARE
  l_sql_quarantine  VARCHAR2(100);
BEGIN
  l_sql_quarantine := sys.DBMS_SQLQ.create_quarantine_by_sql_text(
                        sql_text => TO_CLOB('SELECT /*+ FULL(P) */ * FROM "HR"."EMPLOYEES" P')
                      );
  DBMS_OUTPUT.put_line('l_sql_quarantine=' || l_sql_quarantine);
END;
/

--

SELECT sql_text, sql_id, plan_hash_value, child_number, sql_quarantine, avoided_executions FROM v$sql WHERE  sql_quarantine IS NOT NULL;

SELECT sql_text, name, plan_hash_value, enabled FROM dba_sql_quarantine;

SELECT sql_text, cpu_time, io_megabytes, io_requests, elapsed_time, io_logical FROM   dba_sql_quarantine;

EXEC sys.DBMS_SQLQ.drop_quarantine('SQL_QUARANTINE_dzcj5k5b060yn');