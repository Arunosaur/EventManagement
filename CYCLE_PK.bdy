create package body         CYCLE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : CYCLE_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 22nd 2023
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

   procedure get(o_cycles out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the cycles
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'CYCLE_PK.get';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_cycles for
         select t.id, t.code, t.description, t.user_id, t.last_change_date
         from   em.cycles t
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   procedure add
   (
      i_code        em.cycles.code%type,
      i_description em.cycles.description%type,
      i_user_id     em.cycles.user_id%type,
      o_id          out em.cycles.id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add
   ||   add a new cycle
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
      l_c_module constant typ.t_maxfqnm := 'CYCLE_PK.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_code', i_code);
      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      select *
      into   o_id
      from   available_id(em.groups);

      insert into em.cycles
         (id, code, description, user_id)
      values
         (o_id, i_code, i_description, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add;

   procedure modify
   (
      i_id          em.cycles.id%type,
      i_code        em.cycles.code%type default null,
      i_description em.cycles.description%type default null,
      i_user_id     em.cycles.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify
   ||   modify a given cycle
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
      l_c_module constant typ.t_maxfqnm := 'CYCLE_PK.modify';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_code', i_code);
      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      if i_code is not null
         or i_description is not null
      then
         update em.cycles
         set    code             = nvl(i_code, code),
                description      = nvl(i_description, description),
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

   procedure remove
   (
      i_id      em.cycles.id%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || remove
   ||   remove a cycle, if possible
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
      l_c_module constant typ.t_maxfqnm := 'CYCLE_PK.remove';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.cycles
      where  id = i_id;

      logs.info('This cycle was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove;

end CYCLE_PK;
/

