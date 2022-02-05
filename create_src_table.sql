set timing on

CREATE TABLE hr.big_table
tablespace HR_DATA
AS
SELECT 1 employee_id
     , 'Mr' first_name
     , 'President' second_name
     , 'BOSS' email
     , '111.111.1111' phone_number
     , TO_DATE('01/01/2003','DD/MM/YYYY')  hire_date
     , 'AD_HEAD' job_id
     , 50000 salary
     , CAST(null as number) commission_pct
     , CAST(null as number) manager_id
     , 90 department_id
  FROM dual
UNION ALL
SELECT dum.dum*10000+employee_id employee_id
     , first_name || '#' || dum.dum first_name
     , last_name || '#' || dum.dum last_name
     , email || dum.dum email
     , phone_number
     , hire_date
     , job_id
     , salary
     , commission_pct   
     , COALESCE(
          dum.dum*10000+manager_id
        , 1
       ) manager_id
     , department_id
  FROM hr.employees
CROSS JOIN (
   SELECT level dum
     FROM dual
   CONNECT BY level <= 100000
) dum;
ALTER TABLE hr.big_table ADD CONSTRAINT big_tbl_pk PRIMARY KEY(employee_id);
CREATE INDEX hr.big_tbl_dep_ix ON hr.big_table (department_id);