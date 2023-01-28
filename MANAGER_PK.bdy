create package body         MANAGER_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : MANAGER_PK
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

   function build_call(i_group_id            em.event_group_organization_defaults.group_id%type,
                       i_event_definition_id em.event_definitions.id%type,
                       i_organization_id     em.event_group_organization_defaults.organization_id%type
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
   IS
      l_c_module constant typ.t_maxfqnm := 'MANAGER_PK.build_call';

      l_tt_parms logs.tar_parm;

      CURSOR csr_event
      IS
      SELECT d.procedure_name, p.sequence, p.parameter_name, p.parameter_type, t.description data_type, p.parameter_size, trim(e.value) assigned_value, max(p.sequence) over() max_sequence
      from   em.event_group_organization_defaults e
      join   em.event_definitions                 d
      on     d.id = e.event_definition_id
      join   em.event_parameters                  p
      on     p.event_definition_id = d.id
      join   em.data_types                        t
      on     t.id = p.data_type_id
      where  e.group_id = i_group_id
      and    e.event_definition_id = i_event_definition_id
      and    e.organization_id = i_organization_id
      order by p.sequence;

      l_command          CLOB;
      l_object           VARCHAR2(32767);
      l_size_and_value   VARCHAR2(32767);
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);

      logs.dbg('ENTRY', l_tt_parms);

      l_command := 'declare' || chr(10);

      for each_row IN csr_event
      loop
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
               l_size_and_value := ' := null;';
            end if;
         else
            if DBMS_LOB.substr(each_row.assigned_value) is not null
            then
               l_size_and_value := '(' || each_row.parameter_size || ') := ' || '''' || DBMS_LOB.substr(each_row.assigned_value) || ''';';
            else
               l_size_and_value := '(' || each_row.parameter_size || ') := ' || 'null;';
            end if;
         end if;

         l_command := l_command || ' ' || each_row.parameter_name || ' ' || each_row.data_type || l_size_and_value || CHR(10);
      end loop;

      l_command := l_command || 'begin' || CHR(10);

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

      l_command := l_command || l_object;

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
      l_c_module constant typ.t_maxfqnm := 'MANAGER_PK.push_default';

      l_tt_parms logs.tar_parm;

      cursor csr_group_events
      is
      select g.event_definition_id, g.sequence, min(g.sequence) over() min_sequence
      from   em.group_events g
      where  g.group_id = i_group_id
      order by sequence;

      l_previous_queue_id em.event_queues.previous_id%type;
      l_value clob;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_group_id', i_group_id);
      logs.add_parm(l_tt_parms, 'i_organization_id', i_organization_id);
      logs.add_parm(l_tt_parms, 'i_run_after_tm', i_run_after_tm);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      for each_ge in csr_group_events
      loop
         l_value := build_call(i_group_id            => i_group_id,
                               i_event_definition_id => each_ge.event_definition_id,
                               i_organization_id     => i_organization_id
                              );

         insert into em.event_queues
            (previous_id, group_id, event_definition_id, organization_id, value, status_id, run_after_tm, user_id)
         values
            (l_previous_queue_id, i_group_id, each_ge.event_definition_id, i_organization_id, l_value, 1, decode(each_ge.min_sequence, each_ge.sequence, i_run_after_tm, null), i_user_id)
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
      l_c_module constant typ.t_maxfqnm := 'MANAGER_PK.pull_default';

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

      l_previous_queue_id em.event_queues.previous_id%type;
      l_value clob;
      l_run_after_tm date;
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
                               i_organization_id     => i_organization_id
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

end MANAGER_PK;
/

