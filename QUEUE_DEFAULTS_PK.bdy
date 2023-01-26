create package body         QUEUE_DEFAULTS_PK
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

   procedure get(o_applications out sys_refcursor)
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_DEFAULTS_PK.get';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_applications for
         select t.id, t.code, t.name, t.description, t.user_id, t.last_change_date
         from   em.applications t;

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
      i_event_sequence      em.event_group_organization_defaults.event_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_preferred_run_tm    em.event_group_organization_defaults.preferred_run_tm%type default null,
      i_user_id             em.event_group_organization_defaults.create_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add
   ||   add default values for the event in a particular group.
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_DEFAULTS_PK.add_default';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_event_sequence', i_event_sequence);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_value', i_value);
      logs.add_parm(l_tt_parms, 'i_preferred_run_tm', i_preferred_run_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.event_group_organization_defaults
         (group_id, event_definition_id, event_sequence, organization_id, value, preferred_run_tm, create_user_id, last_update_user_id)
      values
         (i_group_id, i_event_definition_id, i_event_sequence, i_organization_id, i_value, i_preferred_run_tm, i_user_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add;

   procedure change_parameter_sequence
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_event_sequence      em.event_group_organization_defaults.event_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_new_sequence        em.event_group_organization_defaults.event_sequence%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_parameter_sequence
   ||   Change the sequence for this event in the group
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_DEFAULTS_PK.change_parameter_sequence';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_event_sequence', i_event_sequence);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_new_sequence', i_new_sequence);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.event_group_organization_defaults
      set    event_sequence = i_new_sequence,
             last_update_user_id = i_user_id,
             last_change_date = current_date
      where  group_id = i_group_id
      and    event_definition_id = i_event_definition_id
      and    event_sequence = i_event_sequence
      and    organization_id = i_organization_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end change_parameter_sequence;

   procedure provide_parameter_value
   (
      i_group_id            em.event_group_organization_defaults.group_id%type,
      i_event_definition_id em.event_group_organization_defaults.event_definition_id%type,
      i_event_sequence      em.event_group_organization_defaults.event_sequence%type,
      i_organization_id     em.event_group_organization_defaults.organization_id%type,
      i_value               em.event_group_organization_defaults.value%type,
      i_user_id             em.event_group_organization_defaults.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_sequence
   ||   Change the sequence for this event in the group
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_DEFAULTS_PK.provide_parameter_value';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_event_sequence', i_event_sequence);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_value', i_value);
      logs.add_parm(l_tt_parms, 'i_preferred_run_tm', i_preferred_run_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.event_group_organization_defaults
      set    event_sequence = i_new_sequence,
             last_update_user_id = i_user_id,
             last_change_date = current_date
      where  group_id = i_group_id
      and    event_definition_id = i_event_definition_id
      and    event_sequence = i_event_sequence
      and    organization_id = i_organization_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end provide_parameter_value;

   procedure remove
   (
      i_id      em.applications.id%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || remove
   ||   remove an application, if possible
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_DEFAULTS_PK.remove';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.applications
      where  id = i_id;

      logs.info('This application was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove;

end QUEUE_DEFAULTS_PK;
/

