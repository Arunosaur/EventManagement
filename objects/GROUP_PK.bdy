create or replace package body em_code.GROUP_PK
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

   procedure get(o_groups out sys_refcursor)
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.get';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_groups for
         select t.id, t.description, t.application_id, a.description application, t.cycle_id, c.description cycle, t.preferred_run_tm, t.user_id, t.last_change_date
         from   em.groups       t
         join   em.applications a
         on     a.id = t.application_id
         join   em.cycles       c
         on     c.id = t.cycle_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   function get
   (
      i_description      em.groups.description%type,
      i_application_code em.applications.code%type
   )
   return em.groups.id%type
  /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the events
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/01 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.get';
   
      l_tt_parms logs.tar_parm;

      l_id em.groups.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_description', i_description);

      logs.dbg('ENTRY', l_tt_parms);

      select t.id
      into   l_id
      from   em.groups       t
      join   em.applications a
      on     a.id = t.application_id
      where  lower(trim(t.description)) = lower(trim(i_description))
      and    a.code = i_application_code;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_id;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end get;
   
   procedure register
   (
      i_description      em.groups.description%type,
      i_application_id   em.groups.application_id%type,
      i_cycle_id         em.groups.cycle_id%type,
      i_preferred_run_tm em.groups.preferred_run_tm%type,
      i_user_id          em.groups.user_id%type,
      o_id               out em.groups.id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || register
   ||   add a new group
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_cycle_id', i_cycle_id);
      logs.add_parm(l_tt_parms, 'i_preferred_tm', i_preferred_run_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      select *
      into   o_id
      from   available_id(em.groups);

      insert into em.groups
         (id, description, application_id, cycle_id, preferred_run_tm, user_id)
      values
         (o_id, i_description, i_application_id, i_cycle_id, i_preferred_run_tm, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end register;

   procedure change_cycle
   (
      i_id       em.groups.id%type,
      i_cycle_id em.groups.cycle_id%type,
      i_user_id  em.groups.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_cycle
   ||   change the cycle for this group
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.change_cycle';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_cycle_id', i_cycle_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.groups
      set    cycle_id         = i_cycle_id,
             user_id          = i_user_id,
             last_change_date = current_date
      where  id = i_id
      and    cycle_id != i_cycle_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end change_cycle;

   procedure change_application
   (
      i_id             em.groups.id%type,
      i_application_id em.groups.application_id%type,
      i_user_id        em.groups.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_application
   ||   change the application to which this group belongs
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.change_application';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.groups
      set    application_id   = i_application_id,
             user_id          = i_user_id,
             last_change_date = current_date
      where  id = i_id
      and    application_id != i_application_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end change_application;

   procedure post_preferred_time
   (
      i_id               em.groups.id%type,
      i_preferred_run_tm em.groups.preferred_run_tm%type,
      i_user_id          em.groups.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || post_preferred_time
   ||   post the next preferred time to run for this group.
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.post_preferred_time';

      l_tt_parms logs.tar_parm;

      l_c_date constant date := date '1900-01-01';
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_preferred_run_tm', i_preferred_run_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.groups
      set    preferred_run_tm = i_preferred_run_tm,
             user_id          = i_user_id,
             last_change_date = current_date
      where  id = i_id
      and    nvl(preferred_run_tm, l_c_date) != nvl(i_preferred_run_tm, l_c_date);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end post_preferred_time;

   procedure modify
   (
      i_id          em.groups.id%type,
      i_description em.groups.description%type,
      i_user_id     em.groups.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify
   ||   update the group description
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.modify';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.groups
      set    description      = i_description,
             user_id          = i_user_id,
             last_change_date = current_date
      where  id = i_id
      and    description != i_description;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end modify;

   procedure deregister
   (
      i_id      em.groups.id%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || deregister
   ||   remove an event, if possible
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
      l_c_module constant typ.t_maxfqnm := 'GROUP_PK.deregister';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.groups
      where  id = i_id;

      logs.info('This event was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end deregister;

end GROUP_PK;
/
