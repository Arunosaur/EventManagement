create package body         EVENT_PK
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

   procedure get(o_events out sys_refcursor)
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
      l_c_module constant typ.t_maxfqnm := 'EVENT_PK.get';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_events for
         select t.id, t.description, t.procedure_name, t.user_id, t.last_change_date
         from   em.event_definitions t
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   procedure register
   (
      i_description    em.event_definitions.description%type,
      i_procedure_name em.event_definitions.procedure_name%type,
      i_user_id        em.event_definitions.user_id%type,
      o_id             out em.event_definitions.id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || register
   ||   add a new event
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
      l_c_module constant typ.t_maxfqnm := 'EVENT_PK.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_procedure_name', i_procedure_name);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      select *
      into   o_id
      from   available_id(em.event_definitions);

      insert into em.event_definitions
         (id, description, procedure_name, user_id)
      values
         (o_id, i_description, i_procedure_name, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end register;

   procedure modify
   (
      i_id             em.event_definitions.id%type,
      i_description    em.event_definitions.description%type default null,
      i_procedure_name em.event_definitions.procedure_name%type default null,
      i_user_id        em.event_definitions.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify
   ||   modify a given event
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
      l_c_module constant typ.t_maxfqnm := 'EVENT_PK.modify';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_procedure_name', i_procedure_name);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      if i_description is not null
         or i_procedure_name is not null
      then
         update em.event_definitions
         set    description      = nvl(i_description, description),
                procedure_name   = nvl(i_procedure_name, procedure_name),
                user_id          = i_user_id,
                last_change_date = current_date
         where  id = i_id;
      end if;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end modify;

   procedure deregister
   (
      i_id      em.event_definitions.id%type,
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
      l_c_module constant typ.t_maxfqnm := 'EVENT_PK.deregister';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.event_definitions
      where  id = i_id;

      logs.info('This event was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end deregister;

end EVENT_PK;
/

