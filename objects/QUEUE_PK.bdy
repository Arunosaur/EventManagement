CREATE OR REPLACE PACKAGE BODY EM_CODE.QUEUE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : QUEUE_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 27th 2023
|| DESCRIPTION         : To manage events
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

   function counter
   (
      i_sql_type         em.helper_sql_types.description%type,
      i_execution_point  em.helper_sql_execution_points.description%type,
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type default null
   )
   return integer
   /*
   ||---------------------------------------------------------------------------
   || counter
   ||  Count the number of helpers
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.counter';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);
      logs.add_parm(l_tt_parms, 'i_sql_type', i_sql_type);
      logs.add_parm(l_tt_parms, 'i_execution_point', i_execution_point);
      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);

      logs.dbg('ENTRY', l_tt_parms);

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = i_sql_type
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = i_execution_point
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    (   i_sub_reference_id is null
              or h.sub_reference_id = i_sub_reference_id
             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end counter;

   function sql_text
   (
      i_sql_type         em.helper_sql_types.description%type,
      i_execution_point  em.helper_sql_execution_points.description%type,
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type default null,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || sql_text
   ||  provide the sql/plsql text for the given detail
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.sql_text';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);
      logs.add_parm(l_tt_parms, 'i_sql_type', i_sql_type);
      logs.add_parm(l_tt_parms, 'i_execution_point', i_execution_point);
      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = i_sql_type
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = i_execution_point
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    (   i_sub_reference_id is null
              or h.sub_reference_id = i_sub_reference_id
             )
      and    d.id = i_current_block_id;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end sql_text;

   function count_global_block
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_global_block
   ||  Count the number of blocks at a global level
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_global_block';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'GLOBAL',
                         i_execution_point => 'BLOCK',
                         i_reference_id    => -1000
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_global_block;

   function global_block(i_current_block_id em.helper_sql_details.id%type)
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || global_block
   ||  Get the PLSQL blocks at the global level.
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.global_block';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'GLOBAL',
                              i_execution_point  => 'BLOCK',
                              i_reference_id     => -1000,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end global_block;

   function count_application_block(i_application_id em.applications.id%type)
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_application_block
   ||  Count the number of blocks at the application level
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_application_block';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'APPLICATION',
                         i_execution_point => 'BLOCK',
                         i_reference_id    => i_application_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_application_block;

   function application_block
   (
      i_application_id   em.applications.id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || application_block
   ||  Get the PLSQL blocks for application level blocking
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.application_block';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'APPLICATION',
                              i_execution_point  => 'BLOCK',
                              i_reference_id     => i_application_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end application_block;

   function count_organization_block(i_organization_id em.organizations.id%type)
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_organization_block
   ||  Count the number of blocks at the organization level
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_organization_block';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'ORGANIZATION',
                         i_execution_point => 'BLOCK',
                         i_reference_id    => i_organization_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_organization_block;

   function organization_block
   (
      i_organization_id   em.organizations.id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || organization_block
   ||  Get the PLSQL blocks for organization level blocking
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.organization_block';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'ORGANIZATION',
                              i_execution_point  => 'BLOCK',
                              i_reference_id     => i_organization_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end organization_block;

   function count_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type
   )
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_app_org_block
   ||  Count the number of blocks for application & organization
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_app_org_block';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type         => 'APP_ORG',
                         i_execution_point  => 'BLOCK',
                         i_reference_id     => i_application_id,
                         i_sub_reference_id => i_organization_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_app_org_block;

   function app_org_block
   (
      i_application_id   em.applications.id%type,
      i_organization_id  em.organizations.id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || app_org_block
   ||  Get the PLSQL blocks that need to be excecuted at the application &
   ||  organization level
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.app_org_block';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'APP_ORG',
                              i_execution_point  => 'BLOCK',
                              i_reference_id     => i_application_id,
                              i_sub_reference_id => i_organization_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end app_org_block;

   function count_event_constructor
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_event_constructor
   ||  Count the number of constructor an event
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_event_constructor';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'EVENT',
                         i_execution_point => 'BEGIN',
                         i_reference_id    => -1000
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_event_constructor;

   function event_constructor(i_current_block_id em.helper_sql_details.id%type)
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || event_constructor
   ||  Get the PLSQL blocks that need to be exceduted in the beginning
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.event_constructor';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'EVENT',
                              i_execution_point  => 'BEGIN',
                              i_reference_id     => -1000,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end event_constructor;

   function count_event_destructor
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_event_destructor
   ||  Count the number of destructor events
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_event_destructor';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'EVENT',
                         i_execution_point => 'END',
                         i_reference_id    => -1000
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_event_destructor;

   function event_destructor(i_current_block_id em.helper_sql_details.id%type)
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || event_destructor
   ||  Get the PLSQL blocks that need to be exceduted at the end
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.event_destructor';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'EVENT',
                              i_execution_point  => 'END',
                              i_reference_id     => -1000,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end event_destructor;

   function count_group_initializer(i_reference_id em.helper_sql_headers.reference_id%type)
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_group_initializer
   ||  Count the number of initializers for this group
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_group_initializer';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'GROUP',
                         i_execution_point => 'BEGIN',
                         i_reference_id    => i_reference_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_group_initializer;

   function group_initializer
   (
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || group_initializer
   ||  Get the PLSQL blocks that need to be exceduted in the beginning
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.group_initializer';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'GROUP',
                              i_execution_point  => 'BEGIN',
                              i_reference_id     => i_reference_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end group_initializer;

   function count_group_finalizer(i_reference_id em.helper_sql_headers.reference_id%type)
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_group_finalizer
   ||  Count the number of finalizers for this group
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_group_finalizer';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type        => 'GROUP',
                         i_execution_point => 'END',
                         i_reference_id    => i_reference_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_group_finalizer;

   function group_finalizer
   (
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || group_finalizer
   ||  Get the PLSQL blocks that need to be exceduted at the end
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.group_finalizer';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'GROUP',
                              i_execution_point  => 'END',
                              i_reference_id     => i_reference_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end group_finalizer;

   function count_event_initializer
   (
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type
   )
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_event_initializer
   ||  Count the number of initializers for this event
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_event_initializer';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type         => 'EVENT',
                         i_execution_point  => 'BEGIN',
                         i_reference_id     => i_reference_id,
                         i_sub_reference_id => i_sub_reference_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_event_initializer;

   function event_initializer
   (
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || event_initializer
   ||  Get the PLSQL blocks that need to be exceduted in the beginning
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.event_initializer';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'EVENT',
                              i_execution_point  => 'BEGIN',
                              i_reference_id     => i_reference_id,
                              i_sub_reference_id => i_sub_reference_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end event_initializer;

   function count_event_finalizer
   (
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type
   )
   return integer
   /*
   ||---------------------------------------------------------------------------
   || count_event_finalizer
   ||  Count the number of finalizers for this event
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.count_event_finalizer';

      l_tt_parms logs.tar_parm;

      l_count integer;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_count := counter(i_sql_type         => 'EVENT',
                         i_execution_point  => 'END',
                         i_reference_id     => i_reference_id,
                         i_sub_reference_id => i_sub_reference_id
                        );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_count;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return 0;

   end count_event_finalizer;

   function event_finalizer
   (
      i_reference_id     em.helper_sql_headers.reference_id%type,
      i_sub_reference_id em.helper_sql_headers.sub_reference_id%type,
      i_current_block_id em.helper_sql_details.id%type
   )
   return varchar2
   /*
   ||---------------------------------------------------------------------------
   || event_finalizer
   ||  Get the PLSQL blocks that need to be exceduted at the end
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.event_finalizer';

      l_tt_parms logs.tar_parm;

      l_sql_block varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_reference_id', i_reference_id);
      logs.add_parm(l_tt_parms, 'i_sub_reference_id', i_sub_reference_id);
      logs.add_parm(l_tt_parms, 'i_current_block_id', i_current_block_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_sql_block := sql_text(i_sql_type         => 'EVENT',
                              i_execution_point  => 'END',
                              i_reference_id     => i_reference_id,
                              i_sub_reference_id => i_sub_reference_id,
                              i_current_block_id => i_current_block_id
                             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_sql_block;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end event_finalizer;

   function build_call(i_group_id            em.event_group_organization_defaults.group_id%type,
                       i_event_definition_id em.event_definitions.id%type,
                       i_application_id      em.applications.id%type,
                       i_organization_id     em.event_group_organization_defaults.organization_id%type,
                       i_queue_id            em.event_queues.id%type
                      )
   return em.event_queues.value%type
   /*
   ||---------------------------------------------------------------------------
   || build_call
   ||  Builds the procedure string to be executed
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/27 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.build_call';

      l_tt_parms logs.tar_parm;

      cursor csr_event
      is
      select d.procedure_name, p.sequence, p.parameter_name, p.parameter_type, t.description data_type, p.parameter_size, trim(e.value) assigned_value, max(p.sequence) over() max_sequence
      from   em.group_events                      g
      join   em.event_definitions                 d
      on     d.id = g.event_definition_id
      join   em.event_parameters                  p
      on     p.event_definition_id = d.id
      left outer join
             em.event_group_organization_defaults e
      on     e.group_id            = g.group_id
      and    e.event_definition_id = p.event_definition_id
      and    e.parameter_sequence  = p.sequence
      and    e.organization_id     = i_organization_id
      join   em.data_types                        t
      on     t.id = p.data_type_id
      where  g.group_id = i_group_id
      and    g.event_definition_id = i_event_definition_id
      order by g.event_definition_id, g.sequence, p.sequence;

      l_helper_count integer;
      l_sql_block    varchar2(32767);

      l_global_block        varchar2(32767);
      l_application_block   varchar2(32767);
      l_organization_block  varchar2(32767);
      l_app_org_block       varchar2(32767);

      l_cons_call    clob;
      l_groupb_call  clob;
      l_eventb_call  clob;
      l_evente_call  clob;
      l_groupe_call  clob;

      l_command          clob;
      l_object           varchar2(32767);
      l_size_and_value   varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_command := 'declare' || chr(10);

      l_helper_count := count_global_block;
      for each_block in 1 .. l_helper_count
      loop
         l_sql_block := global_block(each_block) || chr(10);
         l_global_block := l_global_block || '   ' || l_sql_block;
      end loop;

      l_helper_count := count_application_block(i_application_id => i_application_id);
      for each_block in 1 .. l_helper_count
      loop
         l_sql_block := application_block(i_application_id, each_block) || chr(10);
         l_application_block := l_application_block || '   ' || l_sql_block;
      end loop;

      l_helper_count := count_organization_block(i_organization_id => i_organization_id);
      for each_block in 1 .. l_helper_count
      loop
         l_sql_block := organization_block(i_organization_id, each_block) || chr(10);
         l_organization_block := l_organization_block || '   ' || l_sql_block;
      end loop;

      l_helper_count := count_app_org_block(i_application_id, i_organization_id);
      for each_block in 1 .. l_helper_count
      loop
         l_sql_block := app_org_block(i_application_id, i_organization_id, each_block) || chr(10);
         l_app_org_block := l_app_org_block || '   ' || l_sql_block;
      end loop;

      l_helper_count := count_event_constructor;
      for each_block in 1 .. l_helper_count
      loop
         l_sql_block := event_constructor(each_block) || chr(10);
         l_cons_call := l_cons_call || '   ' || l_sql_block;
      end loop;

      for each_row IN csr_event
      loop
         if each_row.sequence = 1
         then
            l_helper_count := count_group_initializer(i_group_id);
            for each_block in 1 .. l_helper_count
            loop
               l_sql_block := group_initializer(i_group_id, each_block) || chr(10);
               l_groupb_call := l_groupb_call || '   ' || l_sql_block;
            end loop;

            l_helper_count := count_event_initializer(i_group_id, i_event_definition_id);
            for each_block in 1 .. l_helper_count
            loop
               l_sql_block := event_initializer(i_group_id, i_event_definition_id, each_block) || chr(10);
               l_eventb_call := l_eventb_call || '   ' || l_sql_block;
            end loop;

            l_helper_count := count_event_finalizer(i_group_id, i_event_definition_id);
            for each_block in 1 .. l_helper_count
            loop
               l_sql_block := event_finalizer(i_group_id, i_event_definition_id, each_block) || chr(10);
               l_evente_call := l_evente_call || '   ' || l_sql_block;
            end loop;
         elsif each_row.sequence = each_row.max_sequence
         then
            l_helper_count := count_group_finalizer(i_group_id);
            for each_block in 1 .. l_helper_count
            loop
               l_sql_block := group_finalizer(i_group_id, each_block) || chr(10);
               l_groupe_call := l_groupe_call || '   ' || l_sql_block;
            end loop;
         end if;

         if csr_event%rowcount = 1
         then
            l_object := each_row.procedure_name || '(';
         end if;

         if each_row.parameter_size is null
         then
            if DBMS_LOB.substr(each_row.assigned_value) is not null
            then
               if each_row.data_type = 'CLOB'
               then
                  l_size_and_value := ';';
               else
                  l_size_and_value := ' := ' ||
                                     case each_row.data_type
                                        when 'DATE' then
                                           'to_date(''' || DBMS_LOB.substr(each_row.assigned_value) || ''', ''YYYYMMDDHH24MISS'');'
                                        when 'TIMESTAMP' then
                                           'to_timestamp(''' || DBMS_LOB.substr(each_row.assigned_value) || ''', ''YYYYMMDDHH24MISS.FF'');'
                                        else
                                           DBMS_LOB.substr(each_row.assigned_value) || ';'
                                     end;
               end if;
            else
               l_size_and_value := ' := ' || case each_row.parameter_name when 'i_queue_id' then i_queue_id else 'null' end || ';';
            end if;
         else
            if DBMS_LOB.substr(each_row.assigned_value) is not null
            then
               l_size_and_value := '(' || each_row.parameter_size || ') := ' || '''' || DBMS_LOB.substr(each_row.assigned_value) || ''';';
            else
               l_size_and_value := '(' || each_row.parameter_size || ') := null;';
            end if;
         end if;

         l_command := l_command || '   ' || each_row.parameter_name || ' ' || each_row.data_type || l_size_and_value || CHR(10);
      end loop;

      l_command := l_command || 'begin' || CHR(10);

      l_command := l_command || l_global_block || l_application_block || l_organization_block || l_app_org_block || l_cons_call || l_groupb_call || l_eventb_call;

      for each_parm in csr_event
      loop
         if each_parm.data_type = 'CLOB'
         then
            l_command := l_command
                            || 'select value' || chr(10)
                            || 'into' || each_parm.parameter_name || chr(10)
                            || 'from   event_group_organization_defaults' || chr(10)
                            || 'where  group_id = ' || i_group_id || chr(10)
                            || 'and    event_definition_id = ' || i_event_definition_id || chr(10)
                            || 'and    organization_id = ' || i_organization_id || chr(10)
                            || 'and    sequence = ' || each_parm.sequence || ';' || chr(10);
         end if;
      end loop;

      l_command := l_command || '   ' || l_object;

      for each_event_parm in csr_event
      loop
         l_command := l_command || each_event_parm.parameter_name;
         if each_event_parm.sequence = each_event_parm.max_sequence
         then
            l_command := l_command || ');' || chr(10);
         else
            l_command := l_command || ',' || chr(10);
         end if;
      end loop;

      l_command := l_command || l_evente_call;
      l_command := l_command || l_groupe_call;

      l_helper_count := count_event_destructor;
      for each_block in 1 .. l_helper_count
      loop
         l_sql_block := event_destructor(each_block) || chr(10);
         l_command := l_command || '   ' || l_sql_block;
      end loop;

      l_command := l_command || 'end;' || chr(10);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_command;

   exception
      when others then
         logs.err(l_tt_parms, i_reraise => false);
         return null;

   end build_call;

   procedure push_default
   (
      i_group_id        em.event_queues.group_id%type,
      i_organization_id em.event_queues.organization_id%type,
      i_run_after_tm    em.event_queues.run_after_tm%type default null,
      i_user_id         em.event_queues.create_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || push_default
   ||   push the default to the event queue
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/27 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.push_default';

      l_tt_parms logs.tar_parm;

      cursor csr_group_events
      is
      select g.application_id, e.event_definition_id, e.sequence, min(e.sequence) over() min_sequence
      from   em.groups       g
      join   em.group_events e
      on     e.group_id = g.id
      where  g.id = i_group_id
      order by sequence;

      l_id                em.event_queues.id%type;
      l_previous_queue_id em.event_queues.previous_id%type;
      l_value             clob;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_run_after_tm', i_run_after_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      for each_ge in csr_group_events
      loop
         l_id := em.event_queues_id.nextval;

         l_value := build_call(i_group_id            => i_group_id,
                               i_event_definition_id => each_ge.event_definition_id,
                               i_application_id      => each_ge.application_id,
                               i_organization_id     => i_organization_id,
                               i_queue_id            => l_id
                              );

         insert into em.event_queues
            (id, previous_id, group_id, event_definition_id, organization_id, value, status_id, run_after_tm, create_user_id, last_update_user_id)
         values
            (l_id, l_previous_queue_id, i_group_id, each_ge.event_definition_id, i_organization_id, l_value, 1, decode(each_ge.min_sequence, each_ge.sequence, i_run_after_tm, null), i_user_id, i_user_id)
         returning id into l_previous_queue_id;

      end loop;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end push_default;

   procedure push_default
   (
      i_group_description em.groups.description%type,
      i_application_code  em.applications.code%type,
      i_organization_code em.organizations.code%type,
      i_run_after_tm      em.event_queues.run_after_tm%type default null,
      i_user_id           em.event_queues.create_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || push_default
   ||   push the default to the event queue
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/03/01 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.push_default';

      l_tt_parms logs.tar_parm;

      l_group_id        em.groups.id%type;
      l_organization_id em.organizations.id%type;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_description', i_group_description);
      logs.add_parm(l_tt_parms, 'i_application_code', i_application_code);
      logs.add_parm(l_tt_parms, 'i_organization_code', i_organization_code);
      logs.add_parm(l_tt_parms, 'i_run_after_tm', i_run_after_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_group_id := GROUP_PK.get(i_description      => i_group_description,
                                 i_application_code => i_application_code
                                );

      l_organization_id := ORGANIZATION_PK.get(i_code => i_organization_code);

      push_default(i_group_id        => l_group_id,
                   i_organization_id => l_organization_id,
                   i_run_after_tm    => i_run_after_tm,
                   i_user_id         => i_user_id
                  );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end push_default;

   procedure pull_default
   (
      i_group_id        em.event_queues.group_id%type,
      i_organization_id em.event_queues.organization_id%type,
      i_start_tm        em.event_queues.run_after_tm%type,
      i_user_id         em.event_queues.create_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || pull_default
   ||   pull the default for the queue
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/27 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      pragma autonomous_transaction;

      cursor csr_group_events
      is
      select g.application_id, e.event_definition_id, e.sequence, min(e.sequence) over() min_sequence, g.cycle_id
      from   em.group_events e
      join   em.groups       g
      on     g.id = e.group_id
      join   em.cycles       c
      on     c.id = g.cycle_id
      where  g.id = i_group_id
      order by sequence;

      l_id                em.event_queues.id%type;
      l_previous_queue_id em.event_queues.previous_id%type;
      l_value             clob;

      l_run_after_tm date;
   begin
      for each_ge in csr_group_events
      loop
         if csr_group_events%rowcount = 1
         then
            l_run_after_tm := CYCLE_EVALUATOR_PK.sub_cycle(each_ge.cycle_id, i_start_tm);
         end if;

         if l_run_after_tm is not null
         then
            l_id := em.event_queues_id.nextval;

            l_value := build_call(i_group_id            => i_group_id,
                                  i_event_definition_id => each_ge.event_definition_id,
                                  i_application_id      => each_ge.application_id,
                                  i_organization_id     => i_organization_id,
                                  i_queue_id            => l_id
                                 );

            insert into em.event_queues
               (id, previous_id, group_id, event_definition_id, organization_id, value, status_id, run_after_tm, create_user_id, last_update_user_id)
            values
               (l_id, l_previous_queue_id, i_group_id, each_ge.event_definition_id, i_organization_id, l_value, 1, decode(each_ge.min_sequence, each_ge.sequence, l_run_after_tm, null), i_user_id, i_user_id)
            returning id into l_previous_queue_id;
         end if;
      end loop;

      commit;

   exception
      when others then
         rollback;

   end pull_default;

   procedure change_status
   (
      i_id        em.event_queues.id%type,
      i_to_status em.event_queue_status.description%type,
      i_user_id   em.event_queues.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_status
   ||   Change the status of the queue
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
      pragma autonomous_transaction;

      l_status_id em.event_queue_status.id%type;

      l_id em.event_queues.id%type;
   begin
      select id
      into   l_status_id
      from   em.event_queue_status
      where  lower(trim(description)) = lower(trim(i_to_status));

      select id
      into   l_id
      from   em.event_queues
      where  id        =  i_id
      and    status_id != l_status_id
      for update nowait;

      update em.event_queues
      set    status_id           = l_status_id,
             last_update_user_id = i_user_id,
             last_change_date    = current_date
      where  id = i_id;

      commit;

   exception
      when TYPE_PK.e_row_locked then
         rollback;
         raise;

      when others then
         rollback;

   end change_status;

   procedure remove_block_string
   (
      i_before_string   varchar2,
      i_application_id  em.applications.id%type default null,
      i_organization_id em.organizations.id%type default null,
      i_user_id         em.event_queues.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || remove_block_string
   ||   Remove the blocking string and update the queue
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.remove_block_string';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_before_string', i_before_string);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.info('ENTRY', l_tt_parms);

      update em.event_queues t
      set    t.value               = regexp_replace(t.value, i_before_string || chr(10) || '\s*RETURN;', i_before_string || ' RETURN;'),
             t.last_update_user_id = i_user_id,
             t.last_change_date    = current_date
      where  t.status_id = 1
      and    dbms_lob.instr(t.value, 'RETURN;') > 1
      and    dbms_lob.instr(t.value, i_before_string) > 1
      and    (   i_application_id is null
              or exists (select 1
                         from   em.groups g
                         where  g.id             = t.group_id
                         and    g.application_id = i_application_id
                        )
             )
      and    (   i_organization_id is null
              or t.organization_id = i_organization_id
             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end remove_block_string;

   procedure reset_and_remove_global_block(i_user_id varchar2)
   /*
   ||----------------------------------------------------------------------------
   || reset_and_remove_global_block
   ||   Reset the queues value and remove from future additions
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.reset_and_remove_global_block';

      l_tt_parms logs.tar_parm;

      l_c_before_string constant varchar2(15) := '--global_block';
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      remove_block_string(i_before_string => l_c_before_string, i_user_id => i_user_id);

      HELPER_SQL_PK.remove_global_block(i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end reset_and_remove_global_block;

   procedure reset_and_remove_application_block
   (
      i_application_id em.applications.id%type,
      i_user_id        varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || reset_and_remove_application_block
   ||   Reset the queues value and remove from future additions
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.reset_and_remove_application_block';

      l_tt_parms logs.tar_parm;

      l_c_before_string constant varchar2(15) := '--application_block';
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      remove_block_string(i_before_string => l_c_before_string, i_application_id => i_application_id, i_user_id => i_user_id);

      HELPER_SQL_PK.remove_application_block(i_application_id => i_application_id, i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end reset_and_remove_application_block;

   procedure reset_and_remove_organization_block
   (
      i_organization_id em.organizations.id%type,
      i_user_id        varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || reset_and_remove_organization_block
   ||   Reset the queues value and remove from future additions
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.reset_and_remove_organization_block';

      l_tt_parms logs.tar_parm;


      l_c_before_string constant varchar2(15) := '--organization_block';
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      remove_block_string(i_before_string => l_c_before_string, i_organization_id => i_organization_id, i_user_id => i_user_id);

      HELPER_SQL_PK.remove_organization_block(i_organization_id => i_organization_id, i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end reset_and_remove_organization_block;

   procedure reset_and_remove_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type,
      i_user_id         varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || reset_and_remove_app_org_block
   ||   Reset the queues value and remove from future additions
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.reset_and_remove_app_org_block';

      l_tt_parms logs.tar_parm;

      l_c_before_string constant varchar2(15) := '--app_org_block';
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_application_id', i_application_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      remove_block_string(i_before_string => l_c_before_string, i_application_id => i_application_id, i_organization_id => i_organization_id, i_user_id => i_user_id);

      HELPER_SQL_PK.remove_app_org_block(i_application_id => i_application_id, i_organization_id => i_organization_id, i_user_id => i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end reset_and_remove_app_org_block;

   function get_count
   return varchar2
   /*
   ||----------------------------------------------------------------------------
   || get_count
   ||   get the event queue count by application
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.get_count';

      l_tt_parms logs.tar_parm;

      l_events varchar2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      select listagg(cnt) within group (order by cnt)
      into   l_events
      from   (select lower('UPDATE EM_' || sys_context('userenv', 'db_name') || '_' || a.code || '_' || o.short_nm || '_' || o.code) || ' ' || count(q.group_id) || chr(10) cnt
              from   em.organizations      o
              join   em.event_queues       q
              on     q.organization_id = o.id
              join   em.event_queue_status s
              on     s.id = q.status_id
              join   em.groups             g
              on     g.id = q.group_id
              join   em.applications       a
              on     a.id = g.application_id
              where  s.description = 'New'
              and    (   q.run_after_tm is null
                      or q.run_after_tm <= sysdate
                     )
              and    q.previous_id is null
              group by 'UPDATE EM_' || sys_context('userenv', 'db_name') || '_' || a.code || '_' || o.short_nm || '_' || o.code
             );

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

      return l_events;

   exception
      when others then
         return null;

   end get_count;

   procedure get
   (
      i_application_id  em.applications.id%type default null,
      i_organization_id em.organizations.id%type default null,
      o_queues          out sys_refcursor
   )
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the event queues
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/24 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is

   begin

      open o_queues
      for
      select q.id, a.description application, g.description group_description, d.description event, q.organization_id, o.name organization, q.status_id, s.description status, q.run_after_tm
      from   em.event_queues       q
      join   em.event_queue_status s
      on     s.id = q.status_id
      join   em.organizations      o
      on     o.id = q.organization_id
      join   em.groups             g
      on     g.id = q.group_id
      join   em.event_definitions  d
      on     d.id = q.event_definition_id
      join   em.applications       a
      on     a.id = g.application_id
      where  o.id = nvl(i_organization_id, o.id)
      and    a.id = nvl(i_application_id, a.id)
      and    not exists (select 1
                         from   em.event_logs l
                         where  l.queue_id = q.id
                        )
      order by a.id, o.id, q.run_after_tm nulls first;

   exception
      when others then
         null;

   end get;

end QUEUE_PK;
/
