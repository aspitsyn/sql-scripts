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