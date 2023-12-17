SELECT s.inst_id, s.program, sum(ss.value) FROM
GV$SESSTAT SS JOIN GV$STATNAME SN ON ss.statistic# = sn.statistic#
AND ss.inst_id = sn.inst_id
JOIN gv$session s ON ss.sid = s.sid AND ss.inst_id = s.inst_id
WHERE sn.name = 'redo size'
AND s.type='USER'
GROUP BY s.inst_id, s.program
ORDER BY sum(ss.value) DESC FETCH FIRST 100 ROWS ONLY;
