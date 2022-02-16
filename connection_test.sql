SET SERVEROUT ON

DECLARE 
 RES VARCHAR2(10); 
FUNCTION ping (pHostName VARCHAR2, pPort NUMBER DEFAULT 1521) RETURN VARCHAR2 
 IS 
 tcpCnx utl_tcp.connection; 
 cOk    CONSTANT VARCHAR2(2) := 'OK'; 
 cFail  CONSTANT VARCHAR2(5) := 'ERROR'; 
BEGIN 
 tcpCnx := utl_tcp.open_connection (pHostName, pPort); 
 utl_tcp.close_connection(tcpCnx); 
 RETURN cOk; 
EXCEPTION 
 WHEN utl_tcp.network_error THEN 
  IF (UPPER(SQLERRM) LIKE '%HOST%') THEN 
 RETURN cFail; 
  ELSIF (UPPER(SQLERRM) LIKE '%LISTENER%') THEN 
 RETURN cOk; 
  ELSE 
   RAISE; 
  END IF; 
   WHEN OTHERS THEN 
    RAISE; 
END ping; 
BEGIN 
 RES:=ping('localhost.localdomain', 1521); 
 dbms_output.put_line(RES); 
END; 
/