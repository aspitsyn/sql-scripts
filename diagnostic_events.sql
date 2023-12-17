CREATE OR REPLACE PROCEDURE HR.P_ERROR
AS 
	X INT;
BEGIN
	X:=BLABLA;
END;
/

BEGIN--+ FINDME
	EXECUTE IMMEDIATE 'BEGIN HR.P_ERROR(); END;';
END;
/

alter system set events
	'kg_event[6550]
		[sql: fnk3u9tg790mz]
			{occurence: start_after 1, end_after 3}
				errorstack(3)
				incident(plserrorss)
	';
	
select message_text
from v$diag_alert_ext e
where originating_timestamp > systimestamp-interval '5' minute;


alter system set events
	'kg_event[6550]
		[sql: 7ywduh2k0gdyd]
			{occurence: start_after 1, end_after 3}
				errorstack(3)
				incident(plserrors)
	';
	
alter system set events 'kg_event off';

alter system set events
	'kg_event[6550]
		errorstack(3)
		incident(plserrors)
	';

alter system set events 'kg_event off';

SELECT s.sid, s.serial#, p.spid, p.tracefile FROM   v$session s JOIN v$process p ON s.paddr = p.addr WHERE  s.sid = (select distinct sid from v$mystat);

SELECT s.sid, p.spid, p.tracefile FROM   gv$session s JOIN gv$process p ON s.paddr = p.addr AND s.inst_id = p.inst_id WHERE s.inst_id = 3 AND s.sid = 5053 AND s.serial# = 29282;


sqlplus / as as sysdba
oradebug setospid ospid
oradebug short_stack

oradebug setospid 216476
oradebug short_stack

--Attach and get errorstack of the blocking process
sqlplus
connect / as sysdba
oradebug setospid 320935
oradebug unlimit
oradebug dump errorstack 3 

--hanganalyze 3 dump
oradebug setmypid
oradebug unlimit
oradebug hanganalyze 3

alter session set NLS_DATE_FORMAT='YYYY.MM.DD HH24:MI:SS';


alter system set events '6550 trace name errorstack level 3';
alter system set events '6550 trace name errorstack off';

alter session set events '14552 trace name errorstack level 3';
alter session set events '14552 trace name errorstack off';

alter system set events 
        '
        sql_trace[SQL:2paum9yvxw7v7] 
        {occurence: start_after 2, end_after 4}
        bind=true,
        wait=true
        '
;

alter system set events 
        '
        sql_trace[SQL:2paum9yvxw7v7]
        off
        '
;

alter system set events 'sql_trace[SQL:fcnhpra7aq7q0] {occurence: start_after 2, end_after 4} bind=true, wait=true';

alter system set events 'sql_trace[SQL:fcnhpra7aq7q0] off';


--show enabled events
oradebug setmypid
oradebug eventdump system

select ash.BLOCKING_INST_ID, ash.blocking_session, ash.BLOCKING_SESSION_SERIAL#, count(*) from  gv$active_session_history ash
where ash.sample_time >sysdate-0.1/24
and ash.SESSION_TYPE='FOREGROUND'
group by ash.BLOCKING_INST_ID, ash.blocking_session, ash.BLOCKING_SESSION_SERIAL#
order by count(*) desc;

select dash.BLOCKING_SESSION, dash.BLOCKING_SESSION_SERIAL#, dash.BLOCKING_INST_ID, dash.event, count(*) from dba_hist_active_sess_history dash
where dash.dbid=2456194942
and snap_id between 5873 and 5880
and dash.INSTANCE_NUMBER=1
and dash.SESSION_ID=1342  
and dash.session_serial#=55934
group by dash.BLOCKING_SESSION, dash.BLOCKING_SESSION_SERIAL#, dash.BLOCKING_INST_ID, dash.event
order by count(*) desc;


select a.inst_id,a.start_date,b.sid,b.serial#,b.username,b.status,b.osuser,b.machine,b.program,b.sql_id,b.sql_exec_start,b.prev_sql_id,a.flag,b.prev_exec_start,logon_time,C.OWNER,C.OBJECT_NAME,
(select count(*) from gv$active_session_history where blocking_session=b.sid and blocking_inst_id=b.inst_id and sample_time>sysdate-0.1/24) bl_count, -- 360
event,'ALTER SYSTEM KILL SESSION '''||b.sid||','||b.serial#||',@'||b.inst_id||''' immediate;'
from gv$transaction a,gv$session b,dba_objects c
where a.inst_id=b.inst_id and a.addr=b.taddr and a.start_date<sysdate-1/24
and row_wait_obj#=object_id(+)
order by a.start_date; 

set linesize 160 pagesize 200
col RECORD_ID for 9999999 head ID
col ORIGINATING_TIMESTAMP for a20 head Date
col MESSAGE_TEXT for a120 head Message
select 
    record_id,
    to_char(originating_timestamp,'DD.MM.YYYY HH24:MI:SS'),
    message_text 
from 
    x$dbgalertext
WHERE originating_timestamp > (sysdate - INTERVAL '10' minute)
    ORDER BY record_id;

select PAYLOAD
  from   V$DIAG_TRACE_FILE_CONTENTS
    where  TRACE_FILENAME = 'orcl12c_ora_4163.trc'
    order by LINE_NUMBER;

select final_blocking_session_status,final_blocking_instance,final_blocking_session,event,count(*) from gv$session where final_blocking_session is not null /* and sql_id in ('401xa9y7c51ky') */ group by final_blocking_session_status,final_blocking_instance,final_blocking_session,event;