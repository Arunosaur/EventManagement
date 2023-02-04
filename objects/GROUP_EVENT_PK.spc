create package         GROUP_EVENT_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : GROUP_EVENT_PK
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

   procedure get(o_group_events out sys_refcursor);

   procedure register
   (
      i_group_id            em.group_events.group_id%type,
      i_event_definition_id em.group_events.event_definition_id%type,
      i_sequence            em.group_events.sequence%type,
      i_user_id             em.group_events.user_id%type
   );

   procedure change_event_sequence
   (
      i_group_id            em.group_events.group_id%type,
      i_event_definition_id em.group_events.event_definition_id%type,
      i_sequence            em.group_events.sequence%type,
      i_user_id             em.group_events.user_id%type
   );

   procedure deregister
   (
      i_group_id            em.group_events.group_id%type,
      i_event_definition_id em.group_events.event_definition_id%type,
      i_user_id             varchar2
   );

end GROUP_EVENT_PK;
/

