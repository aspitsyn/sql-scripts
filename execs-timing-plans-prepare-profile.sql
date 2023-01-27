select inst_id,plan_hash_value,executions,round(elapsed_time/decode(executions,0,1,executions)/1000000,3) sec_query, least_time, '@c:\coe_xfr_1.sql '||sql_id||' '||plan_hash_value qqq,
'@c:\coe_xfr_sql_profile_'||sql_id||'_'||plan_hash_value||'.sql' qqq1 from
(select sql_id,inst_id,plan_hash_value,sum(executions) executions,sum(elapsed_time) elapsed_time, max(last_load_time) least_time from gv$sql where sql_id='03guhbfpak0w7'
group by sql_id,inst_id,plan_hash_value) order by sec_query desc;

select a1.*,b1.begin_interval_time,end_interval_time from 
(select snap_id,instance_number,sql_id,plan_hash_value,round(sum(per_exec),3) per_exec,sum(elapsed_time_delta/1000000) sum_ela,sum(executions_delta) sum_exec from
(select snap_id,instance_number,sql_id,plan_hash_value,elapsed_time_delta/decode(executions_delta,0,1,executions_delta)/1000000 per_exec,elapsed_time_delta,executions_delta 
from DBA_HIST_SQLSTAT where snap_id>=154800 
and sql_id in ('03guhbfpak0w7')) group by snap_id,instance_number,sql_id,plan_hash_value) a1,dba_hist_snapshot b1
where a1.snap_id=b1.snap_id and a1.instance_number=b1.instance_number --and a1.plan_hash_value=4135848670
order by a1.snap_id desc,a1.sql_id asc,a1.instance_number,a1.plan_hash_value;