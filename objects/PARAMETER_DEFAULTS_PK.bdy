CREATE OR REPLACE PACKAGE BODY EM_CODE.PARAMETER_DEFAULTS_PK
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

   procedure get(o_defaults out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the applications
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/14 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'PARAMETER_DEFAULTS_PK.get';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_defaults for
         select group_id, g.description group_description, event_definition_id, e.description event, parameter_sequence, organization_id, o.name organization, value, create_user_id, create_date, last_update_user_id, t.last_change_date
         from   em.event_group_organization_defaults t
         join   em.groups                            g
         on     g.id = t.group_id
         join   em.event_definitions                 e
         on     e.id = t.event_definition_id
         join   em.organizations                     o
         on     o.id = t.organization_id
         order by group_id, event_definition_id, parameter_sequence;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   procedure add
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_parameter_sequence  em.event_group_organization_defaults.parameter_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_user_id             em.event_group_organization_defaults.create_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add
   ||   add default values for the event parameters in a group
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/16 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'PARAMETER_DEFAULTS_PK.add_default';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_parameter_sequence', i_parameter_sequence);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_value', i_value);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.event_group_organization_defaults
         (group_id, event_definition_id, parameter_sequence, organization_id, value, create_user_id, last_update_user_id)
      values
         (i_group_id, i_event_definition_id, i_parameter_sequence, i_organization_id, i_value, i_user_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add;

   procedure provide_value
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_parameter_sequence  em.event_group_organization_defaults.parameter_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || provide_value
   ||   Provide the value as a default for a parameter in the event in a group.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/16 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'PARAMETER_DEFAULTS_PK.provide_value';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_parameter_sequence', i_parameter_sequence);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_value', i_value);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.event_group_organization_defaults
      set    value               = i_value,
             last_update_user_id = i_user_id,
             last_change_date    = current_date
      where  group_id = i_group_id
      and    event_definition_id = i_event_definition_id
      and    parameter_sequence = i_parameter_sequence
      and    organization_id = i_organization_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end provide_value;

   procedure remove
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_parameter_sequence      em.event_group_organization_defaults.parameter_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove
   ||   removing parameter default
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/14 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'PARAMETER_DEFAULTS_PK.remove';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_parameter_sequence', i_parameter_sequence);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.event_group_organization_defaults
      where  group_id = i_group_id
      and    event_definition_id = i_event_definition_id
      and    parameter_sequence = i_parameter_sequence
      and    organization_id = i_organization_id;

      logs.info('This parameter default was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove;

end PARAMETER_DEFAULTS_PK;
/
