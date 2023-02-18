CREATE OR REPLACE PACKAGE BODY EM_CODE.GROUP_EVENT_PK
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

   procedure get(o_group_events out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the events
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'GROUP_EVENT_PK.get';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_group_events for
         select t.group_id, g.description group_description, t.event_definition_id, e.description event, t.sequence, t.user_id, t.last_change_date
         from   em.group_events      t
         join   em.groups            g
         on     g.id = t.group_id
         join   em.event_definitions e
         on     e.id = t.event_definition_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   procedure register
   (
      i_group_id            em.group_events.group_id%type,
      i_event_definition_id em.group_events.event_definition_id%type,
      i_sequence            em.group_events.sequence%type,
      i_user_id             em.group_events.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || register
   ||   attach an event to the group
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'GROUP_EVENT_PK.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_sequence', i_sequence);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.group_events
         (group_id, event_definition_id, sequence, user_id)
      values
         (i_group_id, i_event_definition_id, i_sequence, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end register;

   procedure change_event_sequence
   (
      i_group_id            em.group_events.group_id%type,
      i_event_definition_id em.group_events.event_definition_id%type,
      i_sequence            em.group_events.sequence%type,
      i_user_id             em.group_events.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_event_sequence
   ||   change the sequence for this event in the group.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'GROUP_EVENT_PK.change_event_sequence';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_sequence', i_sequence);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.group_events
      set    sequence         = i_sequence,
             user_id          = i_user_id,
             last_change_date = current_date
      where  group_id = i_group_id
      and    event_definition_id = i_event_definition_id
      and    sequence != i_sequence;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end change_event_sequence;

   procedure deregister
   (
      i_group_id            em.group_events.group_id%type,
      i_event_definition_id em.group_events.event_definition_id%type,
      i_user_id             varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || deregister
   ||   remove an event from the group, if possible
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'GROUP_EVENT_PK.deregister';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.group_events
      where  group_id = i_group_id
      and    event_definition_id = i_event_definition_id;

      logs.info('This group/event was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end deregister;

end GROUP_EVENT_PK;
/
