CREATE OR REPLACE PACKAGE BODY EM_CODE.ORGANIZATION_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : ORGANIZATION_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 24th 2023
|| DESCRIPTION         : To maintain organizations
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

   procedure get(o_organizations out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the organizations
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/14 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'ORGANIZATION_PK.get';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_organizations for
         select o.id, o.type, t.description type_description, o.code, o.short_nm, o.name, o.parent_id, p.name parent, o.user_id, o.last_change_date
         from   em.organization_types t
         join   em.organizations      o
         on     o.type = t.id
         left join
                em.organizations      p
         on     p.id = o.parent_id
         order by o.type, o.parent_id, o.id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   function get(i_code em.organizations.code%type)
   return em.organizations.id%type
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the organization
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/01 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'ORGANIZATION_PK.get';

      l_tt_parms logs.tar_parm;

      l_id em.organizations.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_code', i_code);

      logs.dbg('ENTRY', l_tt_parms);

      select o.id
      into   l_id
      from   em.organizations o
      where  lower(trim(o.code)) = lower(trim(i_code));

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
      i_type      em.organizations.type%type,
      i_code      em.organizations.code%type,
      i_short_nm  em.organizations.short_nm%type,
      i_name      em.organizations.name%type,
      i_parent_id em.organizations.parent_id%type,
      i_user_id   em.organizations.user_id%type,
      o_id        out em.organizations.id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || register
   ||   add a new organization
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
      l_c_module constant typ.t_maxfqnm := 'ORGANIZATION_PK.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_type', i_type);
      logs.add_parm(l_tt_parms, 'i_code', i_code);
      logs.add_parm(l_tt_parms, 'i_short_nm', i_short_nm);
      logs.add_parm(l_tt_parms, 'i_name', i_name);
      logs.add_parm(l_tt_parms, 'i_parent_id', i_parent_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      select *
      into   o_id
      from   available_id(em.organizations);

      insert into em.organizations
         (id, type, code, short_nm, name, parent_id, user_id)
      values
         (o_id, i_type, i_code, i_short_nm, i_name, i_parent_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end register;

   procedure modify
   (
      i_id       em.organizations.id%type,
      i_type     em.organizations.type%type default null,
      i_code     em.organizations.code%type default null,
      i_short_nm em.organizations.short_nm%type default null,
      i_name     em.organizations.name%type default null,
      i_user_id  em.organizations.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify
   ||   modify a given organzation
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
      l_c_module constant typ.t_maxfqnm := 'ORGANIZATION_PK.modify';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_type', i_type);
      logs.add_parm(l_tt_parms, 'i_code', i_code);
      logs.add_parm(l_tt_parms, 'i_short_nm', i_short_nm);
      logs.add_parm(l_tt_parms, 'i_name', i_name);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      if i_type is not null
         or i_code is not null
         or i_short_nm is not null
         or i_name is not null
      then
         update em.organizations
         set    type             = nvl(i_type, type),
                code             = nvl(i_code, code),
                short_nm         = nvl(i_short_nm, short_nm),
                name             = nvl(i_name, name),
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

   procedure change_parent
   (
      i_id        em.organizations.id%type,
      i_parent_id em.organizations.parent_id%type,
      i_user_id   em.organizations.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_parent
   ||   Change the parent for the given organization
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
      l_c_module constant typ.t_maxfqnm := 'ORGANIZATION_PK.change_parent';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_parent_id', i_parent_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.organizations
      set    parent_id        = i_parent_id,
             user_id          = i_user_id,
             last_change_date = current_date
      where  id = i_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end change_parent;

   procedure deregister
   (
      i_id      em.organizations.id%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || deregister
   ||   remove an organization, if possible
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
      l_c_module constant typ.t_maxfqnm := 'ORGANIZATION_PK.deregister';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.organizations
      where  id = i_id;

      logs.info('This application was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end deregister;

end ORGANIZATION_PK;
/
