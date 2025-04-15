create or replace package em_code.EVENT_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : EVENT_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 22nd 2023
|| DESCRIPTION         : To maintain events
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

   procedure get(o_events out sys_refcursor);

   function get(i_description em.event_definitions.description%type)
   return em.event_definitions.id%type;

   procedure register
   (
      i_description    em.event_definitions.description%type,
      i_procedure_name em.event_definitions.procedure_name%type,
      i_user_id        em.event_definitions.user_id%type,
      o_id             out em.event_definitions.id%type
   );

   procedure modify
   (
      i_id             em.event_definitions.id%type,
      i_description    em.event_definitions.description%type default null,
      i_procedure_name em.event_definitions.procedure_name%type default null,
      i_user_id        em.event_definitions.user_id%type
   );

   procedure deregister
   (
      i_id      em.event_definitions.id%type,
      i_user_id varchar2
   );

end EVENT_PK;
/
