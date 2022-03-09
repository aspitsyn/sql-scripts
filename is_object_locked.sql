select l.session_id, l.owner, l.name, l.type, inst_id, sql_id 
     , a.sql_fulltext 
     , 'alter system kill session '''||s.sid||','||s.serial#||',@'||inst_id||''' immediate;' ddl 
  from dba_ddl_locks l  
  join gv$session s on s.sid = l.session_id 
  join gv$sql a using(inst_id, sql_id) 
 where l.owner='HR' and l.name = 'EMP_DETAILS_VIEW';

select s.inst_id,s.sid,s.sql_id
     , 'alter system kill session '''||s.sid||','||s.serial#||',@'||s.inst_id||''' immediate;' ddl
from gv$session s, gv$sqltext st 
where s.sql_address = st.address and s.inst_id = st.inst_id and st.sql_text like '%EMP_DETAILS_VIEW%'
and s.status='ACTIVE'
and s.sid not in (select distinct sid from v$mystat);