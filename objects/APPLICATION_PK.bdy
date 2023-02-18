CREATE OR REPLACE PACKAGE BODY EM_CODE.APPLICATION_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : APPLICATION_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 14th 2023
|| DESCRIPTION         : To maintain applications
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

   procedure get(i_id em.applications.id%type)
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
      l_c_module constant typ.t_maxfqnm := 'APPLICATION_PK.get';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);

      logs.dbg('ENTRY', l_tt_parms);

      for each_row in (select *
                       from   em.applications
                       where  id = i_id
                      )
      loop
         dbms_output.put_line(rpad(each_row.id, 10) ||
                              rpad(each_row.code, 10) ||
                              rpad(each_row.name, 10) ||
                              rpad(each_row.description, 40) ||
                              rpad(each_row.user_id, 20)
                             );
      end loop;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

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
      l_c_module constant typ.t_maxfqnm := 'APPLICATION_PK.get';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_applications for
         select t.id, t.code, t.name, t.description, t.user_id, t.last_change_date
         from   em.applications t
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   procedure register
   (
      i_code        em.applications.code%type,
      i_name        em.applications.name%type,
      i_description em.applications.description%type,
      i_user_id     em.applications.user_id%type,
      o_id          out em.applications.id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || register
   ||   add a new application
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
      l_c_module constant typ.t_maxfqnm := 'APPLICATION_PK.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_code', i_code);
      logs.add_parm(l_tt_parms, 'i_name', i_name);
      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      select *
      into   o_id
      from   available_id(em.applications);

      insert into em.applications
         (id, code, name, description, user_id)
      values
         (o_id, i_code, i_name, i_description, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end register;

   procedure modify
   (
      i_id          em.applications.id%type,
      i_code        em.applications.code%type default null,
      i_name        em.applications.name%type default null,
      i_description em.applications.description%type default null,
      i_user_id     em.applications.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify
   ||   modify a given application
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
      l_c_module constant typ.t_maxfqnm := 'APPLICATION_PK.modify';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_code', i_code);
      logs.add_parm(l_tt_parms, 'i_name', i_name);
      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      if i_code is not null
         or i_name is not null
         or i_description is not null
      then
         update em.applications
         set    code             = nvl(i_code, code),
                name             = nvl(i_name, name),
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

   procedure deregister
   (
      i_id      em.applications.id%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || deregister
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
      l_c_module constant typ.t_maxfqnm := 'APPLICATION_PK.deregister';

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

   end deregister;

end APPLICATION_PK;
/
