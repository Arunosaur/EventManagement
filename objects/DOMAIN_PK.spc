create or replace package em_code.DOMAIN_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : DOMAIN_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Mar, 24th 2023
|| DESCRIPTION         : To retrieve domain entries
||---------------------------------------------------------------------------------
|| CHANGELOG
||---------------------------------------------------------------------------------
|| DATE        USER ID     CHANGES
||---------------------------------------------------------------------------------
||
||---------------------------------------------------------------------------------
||
*/
is

   procedure get_organization_types(o_organization_types out sys_refcursor);

   procedure get_data_types(o_data_types out sys_refcursor);

   procedure get_queue_status(o_queue_status out sys_refcursor);

   procedure get_helper_sql_types(o_sql_types out sys_refcursor);

   procedure get_helper_sql_execution_points(o_execution_points out sys_refcursor);

   procedure get_procedure_names(o_procedure_names out sys_refcursor);

end DOMAIN_PK;
/
