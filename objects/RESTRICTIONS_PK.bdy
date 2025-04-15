create or replace package body em_code.RESTRICTIONS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : RESTRICTIONS_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 24th 2023
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

   procedure get_group(o_restrictions out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_group
   ||   Get the group restrictions
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.get_group';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_restrictions for
         select t.group_id, g.description group_description, t.restricted_group_id, r.description restricted_group, t.user_id, t.last_change_date
         from   em.group_restrictions t
         join   em.groups             g
         on     g.id = t.group_id
         join   em.groups             r
         on     r.id = t.restricted_group_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_group;

   procedure add_group
   (
      i_group_id            em.group_restrictions.group_id%type,
      i_restricted_group_id em.group_restrictions.restricted_group_id%type,
      i_user_id             em.group_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add_group
   ||   add a new group level restriction
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.add_group';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_restricted_group_id', i_restricted_group_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.group_restrictions
         (group_id, restricted_group_id, user_id)
      values
         (i_group_id, i_restricted_group_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add_group;

   procedure remove_group
   (
      i_group_id            em.group_restrictions.group_id%type,
      i_restricted_group_id em.group_restrictions.restricted_group_id%type,
      i_user_id             em.group_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_group
   ||   remove restriction from the group
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.remove_group';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_restricted_group_id', i_restricted_group_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.group_restrictions
      where  group_id = i_group_id
      and    restricted_group_id = i_restricted_group_id;

      logs.info('This group restriction was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_group;

   procedure get_event(o_restrictions out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_event
   ||   Get the event level restrictions
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.get_event';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_restrictions for
         select t.event_id, e.description event, t.restricted_event_id, r.description restricted_event, t.user_id, t.last_change_date
         from   em.event_restrictions t
         join   em.event_definitions  e
         on     e.id = t.event_id
         join   em.event_definitions  r
         on     r.id = t.restricted_event_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_event;

   procedure add_event
   (
      i_event_id            em.event_restrictions.event_id%type,
      i_restricted_event_id em.event_restrictions.restricted_event_id%type,
      i_user_id             em.event_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add_event
   ||   add a new event level restriction
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.add_event';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_id', i_event_id);
      logs.add_parm(l_tt_parms, 'i_restricted_event_id', i_restricted_event_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.event_restrictions
         (event_id, restricted_event_id, user_id)
      values
         (i_event_id, i_restricted_event_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add_event;

   procedure remove_event
   (
      i_event_id            em.event_restrictions.event_id%type,
      i_restricted_event_id em.event_restrictions.restricted_event_id%type,
      i_user_id             em.event_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_event
   ||   remove restriction from the event
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.remove_event';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_id', i_event_id);
      logs.add_parm(l_tt_parms, 'i_restricted_event_id', i_restricted_event_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.event_restrictions
      where  event_id = i_event_id
      and    restricted_event_id = i_restricted_event_id;

      logs.info('This group restriction was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_event;

   procedure get_group_event(o_restrictions out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_group_event
   ||   Get the group event restrictions
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.get_group_event';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_restrictions for
         select t.group_id, g.description group_description, t.restricted_event_id, r.description restricted_event, t.user_id, t.last_change_date
         from   em.group_event_restrictions t
         join   em.groups                   g
         on     g.id = t.group_id
         join   em.event_definitions        r
         on     r.id = t.restricted_event_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_group_event;

   procedure add_group_event
   (
      i_group_id            em.group_event_restrictions.group_id%type,
      i_restricted_event_id em.group_event_restrictions.restricted_event_id%type,
      i_user_id             em.group_event_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add_group_event
   ||   add a new group event restriction
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.add_group_event';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_restricted_event_id', i_restricted_event_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.group_event_restrictions
         (group_id, restricted_event_id, user_id)
      values
         (i_group_id, i_restricted_event_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add_group_event;

   procedure remove_group_event
   (
      i_group_id            em.group_event_restrictions.group_id%type,
      i_restricted_event_id em.group_event_restrictions.restricted_event_id%type,
      i_user_id             em.group_event_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_group_event
   ||   remove a group event restriction
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.remove_group_event';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_restricted_event_id', i_restricted_event_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.group_event_restrictions
      where  group_id = i_group_id
      and    restricted_event_id = i_restricted_event_id;

      logs.info('This group restriction was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_group_event;

   procedure get_event_group(o_restrictions out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_event_group
   ||   Get the event group restrictions
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.get_event_group';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_restrictions for
         select t.event_id, e.description event, t.restricted_group_id, r.description restricted_group, t.user_id, t.last_change_date
         from   em.event_group_restrictions t
         join   em.event_definitions        e
         on     e.id = t.event_id
         join   em.groups                   r
         on     r.id = t.restricted_group_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_event_group;

   procedure add_event_group
   (
      i_event_id            em.event_group_restrictions.event_id%type,
      i_restricted_group_id em.event_group_restrictions.restricted_group_id%type,
      i_user_id             em.event_group_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add_event_group
   ||   add a new event group restriction
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.add_event';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_id', i_event_id);
      logs.add_parm(l_tt_parms, 'i_restricted_group_id', i_restricted_group_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.event_group_restrictions
         (event_id, restricted_group_id, user_id)
      values
         (i_event_id, i_restricted_group_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add_event_group;

   procedure remove_event_group
   (
      i_event_id            em.event_group_restrictions.event_id%type,
      i_restricted_group_id em.event_group_restrictions.restricted_group_id%type,
      i_user_id             em.event_group_restrictions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_event_group
   ||   remove a restriction from the event group
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'RESTRICTIONS_PK.remove_event_group';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_id', i_event_id);
      logs.add_parm(l_tt_parms, 'i_restricted_group_id', i_restricted_group_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.event_group_restrictions
      where  event_id = i_event_id
      and    restricted_group_id = i_restricted_group_id;

      logs.info('This group restriction was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_event_group;

end RESTRICTIONS_PK;
/
