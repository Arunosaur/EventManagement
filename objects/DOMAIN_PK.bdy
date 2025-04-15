create or replace package body em_code.DOMAIN_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : DOMAIN_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Mar, 24th 2023
|| DESCRIPTION         : To retrieve domain entries
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

   procedure get_organization_types(o_organization_types out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_organization_types
   ||   Get the organization types
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/23 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'DOMAIN_PK.get_organization_types';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_organization_types for
         select t.id, t.code, t.description
         from   em.organization_types t;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_organization_types;

   procedure get_data_types(o_data_types out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_data_types
   ||   Get the data types
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/25 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'DOMAIN_PK.get_data_types';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_data_types for
         select t.id, t.description
         from   em.data_types t;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_data_types;

   procedure get_queue_status(o_queue_status out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_queue_status
   ||   Get the queue status
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/28 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'DOMAIN_PK.get_queue_status';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_queue_status for
         select t.id, t.description
         from   em.event_queue_status t;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_queue_status;

   procedure get_helper_sql_types(o_sql_types out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_helper_sql_types
   ||   Get the helper sql types
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/29 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'DOMAIN_PK.get_helper_sql_types';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_sql_types for
         select t.id, t.description
         from   em.helper_sql_types t;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_helper_sql_types;

   procedure get_helper_sql_execution_points(o_execution_points out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_helper_sql_execution_points
   ||   Get the helper sql execution points
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/29 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'DOMAIN_PK.get_helper_sql_execution_points';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_execution_points for
         select t.id, t.description
         from   em.helper_sql_execution_points t;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_helper_sql_execution_points;

   procedure get_procedure_names(o_procedure_names out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_procedure_names
   ||   Get the procedure names
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/30 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'DOMAIN_PK.get_procedure_names';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_procedure_names for
      select lower(p.owner || '.' || p.object_name || decode(p.object_type, 'PACKAGE', '.' || p.procedure_name, null)) procedure_name
      from   dba_procedures p
      where  p.owner like '%CODE'
      and    (   (    p.object_type = 'PACKAGE'
                  and p.procedure_name is not null
                 )
              or p.object_type != 'PACKAGE'
             )
      group by lower(p.owner || '.' || p.object_name || decode(p.object_type, 'PACKAGE', '.' || p.procedure_name, null));

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_procedure_names;

end DOMAIN_PK;
/
