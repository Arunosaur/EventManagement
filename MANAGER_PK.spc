create package         MANAGER_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : MANAGER_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 14th 2020
|| DESCRIPTION         : To maintain applications
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

   procedure get(i_id em.applications.id%type);

   procedure get(o_applications out sys_refcursor);

   procedure add
   (
      i_code        em.applications.code%type,
      i_name        em.applications.name%type,
      i_description em.applications.description%type,
      i_user_id     em.applications.user_id%type,
      o_id          out em.applications.id%type
   );

   procedure modify
   (
      i_id          em.applications.id%type,
      i_code        em.applications.code%type default null,
      i_name        em.applications.name%type default null,
      i_description em.applications.description%type default null,
      i_user_id     em.applications.user_id%type
   );

   procedure remove
   (
      i_id      em.applications.id%type,
      i_user_id varchar2
   );

end MANAGER_PK;
/

