CREATE OR REPLACE PACKAGE EM_CODE.HELPER_SQL_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : HELPER_SQL_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 22nd 2023
|| DESCRIPTION         : To maintain cycles
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

   procedure get_header(o_headers out sys_refcursor);

   procedure add_header
   (
      i_type               em.helper_sql_headers.type%type,
      i_execution_point_id em.helper_sql_headers.execution_point_id%type,
      i_reference_id       em.helper_sql_headers.reference_id%type,
      i_sub_reference_id   em.helper_sql_headers.sub_reference_id%type default null,
      i_user_id            em.helper_sql_headers.user_id%type,
      o_id                 out em.helper_sql_headers.id%type
   );

   procedure remove_header
   (
      i_id      em.helper_sql_headers.id%type,
      i_user_id varchar2
   );

   procedure get_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      o_details   out sys_refcursor
   );

   procedure add_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      i_id        em.helper_sql_details.id%type,
      i_sql_text  em.helper_sql_details.sql_text%type,
      i_user_id   em.helper_sql_details.user_id%type
   );

   procedure modify_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      i_id        em.helper_sql_details.id%type,
      i_sql_text  em.helper_sql_details.sql_text%type,
      i_user_id   em.helper_sql_details.user_id%type
   );

   procedure remove_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      i_id        em.helper_sql_details.id%type,
      i_user_id   varchar2
   );

   procedure future_global_block(i_user_id em.helper_sql_details.user_id%type);

   procedure remove_global_block(i_user_id em.helper_sql_details.user_id%type);

   procedure future_application_block
   (
      i_application_id em.applications.id%type,
      i_user_id        em.helper_sql_details.user_id%type
   );

   procedure remove_application_block
   (
      i_application_id em.applications.id%type,
      i_user_id        em.helper_sql_details.user_id%type
   );

   procedure future_organization_block
   (
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   );

   procedure remove_organization_block
   (
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   );

   procedure future_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   );

   procedure remove_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   );

   function get_generic(i_reference_id em.helper_sql_headers.reference_id%type)
   return clob;

end HELPER_SQL_PK;
/
