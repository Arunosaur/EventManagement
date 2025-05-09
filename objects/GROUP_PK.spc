create or replace package em_code.GROUP_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : GROUP_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 22nd 2023
|| DESCRIPTION         : To maintain groups
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

   procedure get(o_groups out sys_refcursor);

   function get
   (
      i_description      em.groups.description%type,
      i_application_code em.applications.code%type
   )
   return em.groups.id%type;

   procedure register
   (
      i_description      em.groups.description%type,
      i_application_id   em.groups.application_id%type,
      i_cycle_id         em.groups.cycle_id%type,
      i_preferred_run_tm em.groups.preferred_run_tm%type,
      i_user_id          em.groups.user_id%type,
      o_id               out em.groups.id%type
   );

   procedure modify
   (
      i_id          em.groups.id%type,
      i_description em.groups.description%type,
      i_user_id     em.groups.user_id%type
   );

   procedure change_cycle
   (
      i_id       em.groups.id%type,
      i_cycle_id em.groups.cycle_id%type,
      i_user_id  em.groups.user_id%type
   );

   procedure change_application
   (
      i_id             em.groups.id%type,
      i_application_id em.groups.application_id%type,
      i_user_id        em.groups.user_id%type
   );

   procedure post_preferred_time
   (
      i_id               em.groups.id%type,
      i_preferred_run_tm em.groups.preferred_run_tm%type,
      i_user_id          em.groups.user_id%type
   );

   procedure deregister
   (
      i_id      em.groups.id%type,
      i_user_id varchar2
   );

end GROUP_PK;
/
