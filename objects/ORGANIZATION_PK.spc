create package         ORGANIZATION_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : ORGANIZATION_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 24th 2023
|| DESCRIPTION         : To maintain organizations
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

   procedure get(o_organizations out sys_refcursor);

   procedure register
   (
      i_type      em.organizations.type%type,
      i_code      em.organizations.code%type,
      i_short_nm  em.organizations.short_nm%type,
      i_name      em.organizations.name%type,
      i_parent_id em.organizations.parent_id%type,
      i_user_id   em.organizations.user_id%type,
      o_id        out em.organizations.id%type
   );

   procedure modify
   (
      i_id       em.organizations.id%type,
      i_type     em.organizations.type%type default null,
      i_code     em.organizations.code%type default null,
      i_short_nm em.organizations.short_nm%type default null,
      i_name     em.organizations.name%type default null,
      i_user_id  em.organizations.user_id%type
   );

   procedure change_parent
   (
      i_id        em.organizations.id%type,
      i_parent_id em.organizations.parent_id%type,
      i_user_id   em.organizations.user_id%type
   );

   procedure deregister
   (
      i_id      em.organizations.id%type,
      i_user_id varchar2
   );

end ORGANIZATION_PK;
/

