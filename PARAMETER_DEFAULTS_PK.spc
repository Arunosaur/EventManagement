create package         PARAMETER_DEFAULTS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : PARAMETER_DEFAULTS_PK
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

   procedure get(o_defaults out sys_refcursor);

   procedure add
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_parameter_sequence  em.event_group_organization_defaults.parameter_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_user_id             em.event_group_organization_defaults.create_user_id%type
   );

   procedure provide_value
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_parameter_sequence  em.event_group_organization_defaults.parameter_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   );

   procedure remove
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_parameter_sequence      em.event_group_organization_defaults.parameter_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   );

end PARAMETER_DEFAULTS_PK;
/

