alter session set NLS_DATE_FORMAT='YYYY.MM.DD HH24:MI:SS';

SELECT
 sample_start_time
 , sample_end_time
 , sched_delay_micro
 FROM
 sys.x$kso_sched_delay_history
 WHERE
 sched_delay_micro != 0
/

SELECT round( cnt/138240*100,2), 'Загрузка ЦПУ' FROM (SELECT event,count(*) AS cnt FROM gv$active_session_history WHERE sample_time  > sysdate - INTERVAL '6' MINUTE AND inst_id=1 GROUP BY event ORDER BY count(*) DESC) WHERE event IS NULL;

SELECT DB_UNIQUE_NAME,OPEN_MODE,TO_CHAR(SCN_TO_TIMESTAMP( CURRENT_SCN),'YYYY.MM.DD HH24:MI:SS') CURR_SCN FROM V$DATABASE;

-- standby scn
col db_unique_name format a15
col open_mode format a25
col curr_scn format a20
SELECT DB_UNIQUE_NAME,OPEN_MODE,TO_CHAR(SCN_TO_TIMESTAMP( CURRENT_SCN),'YYYY.MM.DD HH24:MI:SS') CURR_SCN FROM V$DATABASE;

-- startup history
select startup_time open_time from dba_hist_database_instance WHERE instance_number=4 order by 1 desc FETCH FIRST 5 ROWS ONLY;