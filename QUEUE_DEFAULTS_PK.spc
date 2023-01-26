create package         QUEUE_DEFAULTS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : QUEUE_DEFAULTS_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 16th 2020
|| DESCRIPTION         : To manage the events
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

   procedure get(o_applications out sys_refcursor);

   procedure add
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_event_sequence      em.event_group_organization_defaults.event_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_preferred_run_tm    em.event_group_organization_defaults.preferred_run_tm%type default null,
      i_user_id             em.event_group_organization_defaults.create_user_id%type
   );

   procedure change_sequence
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_event_sequence      em.event_group_organization_defaults.event_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_new_sequence        em.event_group_organization_defaults.event_sequence%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   );

   procedure remove
   (
      i_id      em.applications.id%type,
      i_user_id varchar2
   );

end QUEUE_DEFAULTS_PK;
/

