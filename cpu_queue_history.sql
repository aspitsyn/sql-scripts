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