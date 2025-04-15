create or replace package body em_code.HELPER_SQL_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : HELPER_SQL_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Feb, 04th 2023
|| DESCRIPTION         : To maintain Helper SQL/PLSQL blocks
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

   function get_type(i_description em.helper_sql_types.description%type)
   return em.helper_sql_types.id%type
   /*
   ||----------------------------------------------------------------------------
   || get_type
   ||   Get the helper sql type id
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/29 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.get_type';

      l_tt_parms logs.tar_parm;

      l_id em.helper_sql_types.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.dbg('ENTRY', l_tt_parms);

      select t.id
      into   l_id
      from   em.helper_sql_types t
      where  t.description = i_description;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_id;

   exception
      when no_data_found then
         return null;

      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end get_type;

   function get_execution_point(i_description em.helper_sql_execution_points.description%type)
   return em.helper_sql_execution_points.id%type
   /*
   ||----------------------------------------------------------------------------
   || get_execution_point
   ||   Get the helper sql execution point id
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/29 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.get_execution_point';

      l_tt_parms logs.tar_parm;

      l_id em.helper_sql_execution_points.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_description', i_description);
      logs.dbg('ENTRY', l_tt_parms);

      select t.id
      into   l_id
      from   em.helper_sql_execution_points t
      where  t.description = i_description;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_id;

   exception
      when no_data_found then
         return null;

      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end get_execution_point;

   procedure get_header(o_headers out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_header
   ||   Get the sql header
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.get_header';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_headers for
         select h.id, type, t.description type_description, execution_point_id, p.description execution, reference_id,
                decode(t.description, 'GROUP', 'G:' || g.description, 'GENERICS', 'C:' || c.description, decode(f.description, null, null, e.description, null, 'E:' || f.description)) group_or_cycle_or_event,
                sub_reference_id, e.description event, h.user_id, h.last_change_date
         from   em.helper_sql_headers          h
         join   em.helper_sql_types            t
         on     t.id = h.type
         join   em.helper_sql_execution_points p
         on     p.id = h.execution_point_id
         left outer join
                em.groups                      g
         on     t.description = 'GROUP'
         and    g.id = to_char(h.reference_id)
         left outer join
                em.event_definitions           e
         on    t.description = 'EVENT' 
         and   e.id = to_char(h.sub_reference_id)
         left outer join
               em.cycles                      c
         on    t.description = 'GENERICS'
         and   c.id = to_char(h.reference_id)
         left outer join
               em.event_definitions           f
         on    t.description = 'EVENT'
         and   f.id = to_char(h.reference_id)
         order by h.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_header;

   procedure add_header
   (
      i_type               em.helper_sql_headers.type%type,
      i_execution_point_id em.helper_sql_headers.execution_point_id%type,
      i_reference_id       em.helper_sql_headers.reference_id%type,
      i_sub_reference_id   em.helper_sql_headers.sub_reference_id%type default null,
      i_user_id            em.helper_sql_headers.user_id%type,
      o_id                 out em.helper_sql_headers.id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add_header
   ||   add a new helper sql header
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
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.add_header';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_type', i_type);
      logs.add_parm(l_tt_parms, 'i_execution_point_id', i_execution_point_id);
      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      select *
      into   o_id
      from   available_id(em.helper_sql_headers);

      insert into em.helper_sql_headers
         (id, type, execution_point_id, reference_id, sub_reference_id, user_id)
      values
         (o_id, i_type, i_execution_point_id, i_reference_id, i_sub_reference_id, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add_header;

   procedure remove_header
   (
      i_id      em.helper_sql_headers.id%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_header
   ||   remove a header, if possible
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.remove_header';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.helper_sql_headers
      where  id = i_id;

      logs.info('This helper header was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_header;

   function get_header_id
   (
      i_sql_type         em.helper_sql_types.description%type,
      i_execution_point  em.helper_sql_execution_points.description%type,
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type default null
   )
   /*
   ||----------------------------------------------------------------------------
   || get_header_id
   ||   Get the header id
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   return em.helper_sql_headers.id%type
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.get_header_id';
   
      l_tt_parms logs.tar_parm;

      l_id em.helper_sql_headers.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_sql_type', i_sql_type);
      logs.add_parm(l_tt_parms, 'i_execution_point', i_execution_point);
      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);

      logs.dbg('ENTRY', l_tt_parms);

      select h.id
      into   l_id
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      where  t.description  = i_sql_type
      and    p.description  = i_execution_point
      and    h.reference_id = i_reference_id
      and    (   i_sub_reference_id is null
              or h.sub_reference_id = i_sub_reference_id
             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_id;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end get_header_id;

   procedure get_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      o_details   out sys_refcursor
   )
   /*
   ||----------------------------------------------------------------------------
   || get_detail
   ||   Get the helper sql detail
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.get_detail';
   
      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_header_id', i_header_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_details for
         select header_id, id, sql_text, user_id, last_change_date
         from   em.helper_sql_details d
         where  d.header_id = i_header_id
         order by id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_detail;

   procedure add_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      i_id        em.helper_sql_details.id%type,
      i_sql_text  em.helper_sql_details.sql_text%type,
      i_user_id   em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || add_detail
   ||   add a new helper sql detail
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
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.add_detail';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_header_id', i_header_id);
      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_sql_text', i_sql_text);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.helper_sql_details
         (header_id, id, sql_text, user_id)
      values
         (i_header_id, i_id, i_sql_text, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end add_detail;

   procedure modify_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      i_id        em.helper_sql_details.id%type,
      i_sql_text  em.helper_sql_details.sql_text%type,
      i_user_id   em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify_detail
   ||   modify a helper sql detail
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
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.modify_detail';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_header_id', i_header_id);
      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_sql_text', i_sql_text);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.helper_sql_details
      set    sql_text         = i_sql_text,
             user_id          = i_user_id,
             last_change_date = current_date
      where  header_id = i_header_id
      and    id        = i_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end modify_detail;

   procedure remove_detail
   (
      i_header_id em.helper_sql_details.header_id%type,
      i_id        em.helper_sql_details.id%type,
      i_user_id   varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_detail
   ||   remove a header, if possible
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.remove_detail';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_id', i_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.helper_sql_details
      where  header_id = i_header_id
      and    id = i_id;

      logs.info('This helper detail was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_detail;

   function is_globally_blocked
   return boolean
   /*
   ||----------------------------------------------------------------------------
   || is_globally_blocked
   ||   check for presence of global blocks
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/04/01 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.is_globally_blocked';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      join   em.helper_sql_execution_points e
      on     e.id = h.execution_point_id
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  t.description  = 'GLOBAL'
      and    e.description  = 'BLOCK'
      and    h.reference_id = -1000;

      return (l_count > 0);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return true;

   end is_globally_blocked;

   procedure future_global_block(i_user_id em.helper_sql_details.user_id%type)
   /*
   ||----------------------------------------------------------------------------
   || future_global_block
   ||   Block any future runs by adding return as the first statement, this is a
   ||   global block.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.future_global_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
      l_sql_text  varchar2(200);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_header_id := get_header_id(i_sql_type        => 'GLOBAL',
                                   i_execution_point => 'BLOCK',
                                   i_reference_id    => -1000
                                  );

      l_sql_text := '   --global_block' || chr(10);
      l_sql_text := l_sql_text || '   RETURN;' || chr(10);

      add_detail(i_header_id => l_header_id,
                 i_id        => 1,
                 i_sql_text  => l_sql_text,
                 i_user_id   => i_user_id
                );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end future_global_block;

   procedure remove_global_block(i_user_id em.helper_sql_details.user_id%type)
   /*
   ||----------------------------------------------------------------------------
   || remove_global_block
   ||   Remove the global block that was added.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.remove_global_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_header_id := get_header_id(i_sql_type        => 'GLOBAL',
                                   i_execution_point => 'BLOCK',
                                   i_reference_id    => -1000
                                  );

      remove_detail(i_header_id => l_header_id,
                    i_id        => 1,
                    i_user_id   => i_user_id
                   );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_global_block;

   procedure get_blocks(o_blocks out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get_blocks
   ||   Look for any blocks...
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/04/01 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.get_blocks';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_blocks for
      select a.id application_id, a.code application_code, a.name application_name, a.description application,
             o.id organization_id, o.code organization_code, o.short_nm organization_short_nm, o.name organization,
             t.description block_type, d.user_id, d.last_change_date
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      join   em.helper_sql_execution_points e
      on     e.id = h.execution_point_id
      left outer join
             em.applications                a
      on     (    t.description in ('APPLICATION', 'APP_ORG')
              and h.reference_id = a.id
             )
      left outer join
             em.organizations               o
      on     (   (    t.description = 'ORGANIZATION'
                  and h.reference_id = o.id
                 )
              or (    t.description = 'APP_ORG'
                  and h.sub_reference_id = o.id
                 )
             )
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  e.description  = 'BLOCK';

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get_blocks;

   procedure future_application_block
   (
      i_application_id em.applications.id%type,
      i_user_id        em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || future_application_block
   ||   Block any future runs by adding return as the first statement, this is an
   ||   application block.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/05 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.future_application_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
      l_sql_text  varchar2(200);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      add_header(i_type               => get_type('APPLICATION'),
                 i_execution_point_id => get_execution_point('BLOCK'),
                 i_reference_id       => i_application_id,
                 i_user_id            => i_user_id,
                 o_id                 => l_header_id
                );

      l_sql_text := '   --application_block' || chr(10);
      l_sql_text := l_sql_text || '   RETURN;' || chr(10);

      add_detail(i_header_id => l_header_id,
                 i_id        => 1,
                 i_sql_text  => l_sql_text,
                 i_user_id   => i_user_id
                );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end future_application_block;

   procedure remove_application_block
   (
      i_application_id em.applications.id%type,
      i_user_id        em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_application_block
   ||   Remove the application block that was placed.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/05 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.remove_application_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_header_id := get_header_id(i_sql_type        => 'APPLICATION',
                                   i_execution_point => 'BLOCK',
                                   i_reference_id    => i_application_id
                                  );

      remove_detail(i_header_id => l_header_id,
                    i_id        => 1,
                    i_user_id   => i_user_id
                   );

      remove_header(i_id => l_header_id, i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_application_block;

   procedure future_organization_block
   (
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || future_organization_block
   ||   Block any future runs by adding return as the first statement, this is an
   ||   organization block.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/05 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.future_organization_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
      l_sql_text  varchar2(200);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      add_header(i_type               => get_type('ORGANIZATION'),
                 i_execution_point_id => get_execution_point('BLOCK'),
                 i_reference_id       => i_organization_id,
                 i_user_id            => i_user_id,
                 o_id                 => l_header_id
                );

      l_sql_text := '   --organization_block' || chr(10);
      l_sql_text := l_sql_text || '   RETURN;' || chr(10);

      add_detail(i_header_id => l_header_id,
                 i_id        => 1,
                 i_sql_text  => l_sql_text,
                 i_user_id   => i_user_id
                );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end future_organization_block;

   procedure remove_organization_block
   (
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_organization_block
   ||   Remove the organization block that was placed.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/05 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.remove_organization_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_header_id := get_header_id(i_sql_type        => 'ORGANIZATION',
                                   i_execution_point => 'BLOCK',
                                   i_reference_id    => i_organization_id
                                  );

      remove_detail(i_header_id => l_header_id,
                    i_id        => 1,
                    i_user_id   => i_user_id
                   );

      remove_header(i_id => l_header_id, i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_organization_block;

   procedure future_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || future_app_org_block
   ||   Block any future runs by adding return as the first statement, this is an
   ||   application plus organization block.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/05 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.future_app_org_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
      l_sql_text  varchar2(200);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      add_header(i_type               => get_type('APP_ORG'),
                 i_execution_point_id => get_execution_point('BLOCK'),
                 i_reference_id       => i_application_id,
                 i_sub_reference_id   => i_organization_id,
                 i_user_id            => i_user_id,
                 o_id                 => l_header_id
                );

      l_sql_text := '   --app_org_block' || chr(10);
      l_sql_text := l_sql_text || '   RETURN;' || chr(10);

      add_detail(i_header_id => l_header_id,
                 i_id        => 1,
                 i_sql_text  => l_sql_text,
                 i_user_id   => i_user_id
                );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end future_app_org_block;

   procedure remove_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type,
      i_user_id         em.helper_sql_details.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_app_org_block
   ||   Remove the application plus organization block that was placed.
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/05 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'HELPER_SQL_PK.remove_app_org_block';

      l_tt_parms logs.tar_parm;

      l_header_id em.helper_sql_headers.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_header_id := get_header_id(i_sql_type         => 'APP_ORG',
                                   i_execution_point  => 'BLOCK',
                                   i_reference_id     => i_application_id,
                                   i_sub_reference_id => i_organization_id
                                  );

      remove_detail(i_header_id => l_header_id,
                    i_id        => 1,
                    i_user_id   => i_user_id
                   );

      remove_header(i_id => l_header_id, i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_app_org_block;

   function get_generic(i_reference_id em.helper_sql_headers.reference_id%type)
   return clob
   /*
   ||----------------------------------------------------------------------------
   || get_generic
   ||   Get the helper sql detail
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_sql_text clob;
   begin

      select d.sql_text
      into   l_sql_text
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      join   em.helper_sql_details d
      on     d.header_id = h.id
      where  t.description   = 'GENERICS'
      and    p.description  = 'CYCLE'
      and    h.reference_id = i_reference_id;

      return l_sql_text;

   exception
      when others then
         return null;

   end get_generic;

end HELPER_SQL_PK;
/
