create package body         QUEUE_PK
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

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'BEGIN'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = -1000;

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

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'BEGIN'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = -1000
      and    d.id = i_current_block_id;

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

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'END'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = -1000;

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

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'END'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = -1000
      and    d.id = i_current_block_id;

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

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'GROUP'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'BEGIN'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id;

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

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'GROUP'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'BEGIN'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    d.id = i_current_block_id;

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

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'GROUP'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'END'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id;

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

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'GROUP'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'END'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    d.id = i_current_block_id;

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

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'BEGIN'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    h.sub_reference_id = i_sub_reference_id;

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

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'BEGIN'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    h.sub_reference_id = i_sub_reference_id
      and    d.id = i_current_block_id;

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

      select count(1)
      into   l_count
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'END'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    h.sub_reference_id = i_sub_reference_id;

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

      select d.sql_text
      into   l_sql_block
      from   em.helper_sql_headers          h
      join   em.helper_sql_types            t
      on     t.id = h.type
      and    t.description = 'EVENT'
      join   em.helper_sql_execution_points p
      on     p.id = h.execution_point_id
      and    p.description = 'END'
      join   em.helper_sql_details          d
      on     d.header_id = h.id
      where  h.reference_id = i_reference_id
      and    h.sub_reference_id = i_sub_reference_id
      and    d.id = i_current_block_id;

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
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_command := 'declare' || chr(10);

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

      l_command := l_command || l_cons_call;
      l_command := l_command || l_groupb_call;
      l_command := l_command || l_eventb_call;

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

   procedure push_default(i_group_id        em.event_queues.group_id%type,
                          i_organization_id em.event_queues.organization_id%type,
                          i_run_after_tm    em.event_queues.run_after_tm%type default null,
                          i_user_id         em.event_queues.user_id%type
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
      select g.event_definition_id, g.sequence, min(g.sequence) over() min_sequence
      from   em.group_events g
      where  g.group_id = i_group_id
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
                               i_organization_id     => i_organization_id,
                               i_queue_id            => l_id
                              );

         insert into em.event_queues
            (id, previous_id, group_id, event_definition_id, organization_id, value, status_id, run_after_tm, user_id)
         values
            (l_id, l_previous_queue_id, i_group_id, each_ge.event_definition_id, i_organization_id, l_value, 1, decode(each_ge.min_sequence, each_ge.sequence, i_run_after_tm, null), i_user_id)
         returning id into l_previous_queue_id;

      end loop;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end push_default;

   procedure pull_default(i_group_id        em.event_queues.group_id%type,
                          i_organization_id em.event_queues.organization_id%type,
                          i_user_id         em.event_queues.user_id%type
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
      l_c_module constant typ.t_maxfqnm := 'QUEUE_PK.pull_default';

      l_tt_parms logs.tar_parm;

      cursor csr_group_events
      is
      select e.event_definition_id, e.sequence, min(e.sequence) over() min_sequence, g.cycle_id
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
      l_run_after_tm      date;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      for each_ge in csr_group_events
      loop
         l_value := build_call(i_group_id            => i_group_id,
                               i_event_definition_id => each_ge.event_definition_id,
                               i_organization_id     => i_organization_id,
                               i_queue_id            => l_id
                              );

         insert into em.event_queues
            (previous_id, group_id, event_definition_id, organization_id, value, status_id, run_after_tm, user_id)
         values
            (l_previous_queue_id, i_group_id, each_ge.event_definition_id, i_organization_id, l_value, 1, decode(each_ge.min_sequence, each_ge.sequence, l_run_after_tm, null), i_user_id)
         returning id into l_previous_queue_id;
      end loop;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end pull_default;

   procedure change_status
   (
      i_id        em.event_queues.id%type,
      i_to_status em.event_queue_status.description%type,
      i_user_id   em.event_queues.user_id%type
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
   begin

      select id
      into   l_status_id
      from   em.event_queue_status
      where  lower(trim(description)) = lower(trim(i_to_status));

      update em.event_queues
      set    status_id        = l_status_id,
             user_id          = i_user_id,
             last_change_date = current_date
      where  id        =  i_id
      and    status_id != l_status_id;

      commit;

   exception
      when others then
         rollback;

   end change_status;

end QUEUE_PK;
/

