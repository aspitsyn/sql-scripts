select inst_id, tablespace_name, sum(used_blocks*8096/power(2,30)), 
sum(free_blocks*8096/power(2,30)), sum(used_blocks*8096/power(2,30))+sum(free_blocks*8096/power(2,30)),
round(sum(used_blocks)*100/(sum(used_blocks)+sum(free_blocks)),1) perc from gv$sort_segment
where tablespace_name='CUSTOM_TEMP' group by inst_id, tablespace_name --order by sum(free_blocks)
union ALL
select 31, tablespace_name, sum(used_blocks*8096/power(2,30)), 
sum(free_blocks*8096/power(2,30)), sum(used_blocks*8096/power(2,30))+sum(free_blocks*8096/power(2,30)),
round(sum(used_blocks*8096/power(2,30))*100/(sum(used_blocks*8096/power(2,30))+sum(free_blocks*8096/power(2,30))),1) perc from
gv$sort_segment where tablespace_name='CUSTOM_TEMP' group by tablespace_name;