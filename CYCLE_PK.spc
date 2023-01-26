create package         CYCLE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : CYCLE_PK
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

   procedure get(o_cycles out sys_refcursor);

   procedure add
   (
      i_code        em.cycles.code%type,
      i_description em.cycles.description%type,
      i_user_id     em.cycles.user_id%type,
      o_id          out em.cycles.id%type
   );

   procedure modify
   (
      i_id          em.cycles.id%type,
      i_code        em.cycles.code%type default null,
      i_description em.cycles.description%type default null,
      i_user_id     em.cycles.user_id%type
   );

   procedure remove
   (
      i_id      em.cycles.id%type,
      i_user_id varchar2
   );

end CYCLE_PK;
/

