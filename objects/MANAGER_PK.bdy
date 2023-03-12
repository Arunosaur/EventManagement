CREATE OR REPLACE PACKAGE BODY EM_CODE.MANAGER_PK
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

   function is_blocked(i_clob clob)
   return boolean
   /*
   ||----------------------------------------------------------------------------
   || is_blocked
   ||   Check if execution is blocked...
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/04 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_return_pos number;
      l_end_pos    number;
      l_is_blocked boolean := false;
   begin
      l_return_pos := regexp_instr(i_clob, 'block' || chr(10) || '\s*RETURN;' );
      l_end_pos := instr(i_clob, 'EM_CODE.EVENT_LOG_PK.init(i_queue_id => i_queue_id);');
      if (    l_return_pos > 0
          and l_return_pos < l_end_pos
         )
      then
         l_is_blocked := true;
      end if;

      return l_is_blocked;

   exception
      when others then
         return true;

   end is_blocked;

   procedure lock_group
   (
      i_organization_id em.event_queues.organization_id%type,
      i_group_id        em.event_queues.group_id%type,
      i_queue_id        em.event_queues.id%type,
      i_user_id         em.event_queues.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || lock_group
   ||   Lock the group
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      cursor csr_event_queues
      is
      select q.id, q.value
      from   em.event_queues q
      where  q.group_id = i_group_id
      and    q.organization_id = i_organization_id
      start with q.id = i_queue_id
      connect by prior q.id = q.previous_id;

   begin
      for each_row in csr_event_queues
      loop
         exit when is_blocked(each_row.value);

         QUEUE_PK.change_status(i_id        => each_row.id,
                                i_to_status => 'Locked',
                                i_user_id   => i_user_id
                               );
      end loop;

   exception
      when others then
         raise;

   end lock_group;

   procedure unlock_group
   (
      i_organization_id em.event_queues.organization_id%type,
      i_group_id        em.event_queues.group_id%type,
      i_queue_id        em.event_queues.id%type,
      i_user_id         em.event_queues.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || unlock_group
   ||   Un-Lock the group
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      cursor csr_event_queues
      is
      select q.id
      from   em.event_queues q
      where  q.group_id = i_group_id
      and    q.organization_id = i_organization_id
      start with q.id = i_queue_id
      connect by prior q.id = q.previous_id;

   begin
      for each_row in csr_event_queues
      loop
         QUEUE_PK.change_status(i_id        => each_row.id,
                                i_to_status => 'New',
                                i_user_id   => i_user_id
                               );
      end loop;

   exception
      when others then
         raise;

   end unlock_group;

   function is_event_restricted
   (
      i_organization_id     em.event_queues.organization_id%type,
      i_group_id            em.groups.id%type,
      i_event_definition_id em.event_definitions.id%type,
      i_queue_id            em.event_queues.id%type
   )
   return boolean
   /*
   ||----------------------------------------------------------------------------
   || is_event_restricted
   ||   Check if this event is restricted
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is

      l_count integer := 0;
   begin
      with
         in_process_queues as
            (select q.group_id, q.event_definition_id
             from   em.event_queues       q
             join   em.event_queue_status s
             on     s.id = q.status_id
             where  s.description in ('Locked', 'Released', 'Failed')
             and    q.organization_id = i_organization_id
            ),
        count_group_restrictions as
           (select count(1) cnt
            from   in_process_queues     e
            join   em.group_restrictions g
            on     g.group_id = e.group_id
            and    g.restricted_group_id = i_group_id
           ),
        count_group_event_restrictions as
           (select count(1) cnt
            from   in_process_queues           e
            join   em.group_event_restrictions g
            on     g.group_id = e.group_id
            and    g.restricted_event_id = i_event_definition_id
           ),
        count_event_group_restrictions as
           (select count(1) cnt
            from   in_process_queues           e
            join   em.event_group_restrictions g
            on     g.event_id = e.event_definition_id
            and    g.restricted_group_id = i_group_id
           ),
        count_event_restrictions as
           (select count(1) cnt
            from   in_process_queues     e
            join   em.event_restrictions g
            on     g.event_id = e.event_definition_id
            and    g.restricted_event_id = i_event_definition_id
           ),
        for_self_restrictions as
           (select q.group_id, q.event_definition_id, q.organization_id, sys_connect_by_path(q.id, '-') pth
            from   em.event_queues q
            where  connect_by_isleaf = 1
            start with q.id = i_queue_id
            connect by q.previous_id = prior q.id
           ),
        count_self_restrictions as
           (select count(1) cnt
            from   for_self_restrictions r
            where  (   exists (select 1
                               from   em.event_queues       e
                               join   em.event_queue_status s
                               on     s.id = e.status_id
                               where  s.description in ('Locked', 'Released', 'Failed')
                               and    e.event_definition_id = r.event_definition_id
                               and    e.organization_id = r.organization_id
                               and    instr(r.pth, '-' || e.id) = 0
                              )
                    or exists (select 1
                               from   em.event_queues       g
                               join   em.event_queue_status s
                               on     s.id = g.status_id
                               where  s.description in ('Locked', 'Released', 'Failed')
                               and    g.group_id = r.group_id
                               and    g.organization_id = r.organization_id
                               and    instr(r.pth, '-' || g.id) = 0
                              )
                   )
           )
        select (r.cnt + s.cnt + t.cnt + u.cnt + v.cnt)
        into   l_count
        from   count_group_restrictions       r
        join   count_group_event_restrictions s
        on     1 = 1
        join   count_event_group_restrictions t
        on     1 = 1
        join   count_event_restrictions       u
        on     1 = 1
        join   count_self_restrictions        v
        on     1 = 1;

      return (l_count > 0);

   exception
      when others then
         return true;

   end is_event_restricted;

   procedure operate
   (
      i_queue_id em.event_queues.id%type,
      i_start_tm em.event_queues.run_after_tm%type,
      i_user_id  em.event_queues.last_update_user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || operate
   ||   run the events
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      cursor csr_event_queues
      is
      select q.id, q.previous_id, q.value, q.organization_id, q.group_id, q.event_definition_id, decode(c.code, 'ON_DEMAND', 'N', 'Y') is_cycle, connect_by_isleaf is_leaf
      from   em.event_queues       q
      join   em.event_queue_status s
      on     s.id = q.status_id
      join   em.groups             g
      on     g.id = q.group_id
      join   em.cycles             c
      on     c.id = g.cycle_id
      where  s.description = 'Locked'
      start with q.id = i_queue_id
      connect by prior q.id = q.previous_id;

   begin
      <<operator>>
      for each_queue in csr_event_queues
      loop
         begin
            if is_event_restricted(i_organization_id     => each_queue.organization_id,
                                   i_group_id            => each_queue.group_id,
                                   i_event_definition_id => each_queue.event_definition_id,
                                   i_queue_id            => each_queue.id
                                  )
            then
               if each_queue.previous_id is null
               then
                  unlock_group(i_organization_id => each_queue.organization_id,
                               i_group_id        => each_queue.group_id,
                               i_queue_id        => each_queue.id,
                               i_user_id         => i_user_id
                              );
                  raise TYPE_PK.e_event_restricted;
               else
                  <<wip>>
                  loop
                     DBMS_SESSION.sleep(10);
                     exit wip when not is_event_restricted(i_organization_id     => each_queue.organization_id,
                                                           i_group_id            => each_queue.group_id,
                                                           i_event_definition_id => each_queue.event_definition_id,
                                                           i_queue_id            => each_queue.id
                                                          );
                  end loop wip;
               end if;
            end if;

            QUEUE_PK.change_status(i_id        => each_queue.id,
                                   i_to_status => 'Released',
                                   i_user_id   => i_user_id
                                  );

            execute immediate each_queue.value;

            QUEUE_PK.change_status(i_id        => each_queue.id,
                                   i_to_status => 'Completed',
                                   i_user_id   => i_user_id
                                  );

            if (    i_start_tm is not null
                and each_queue.is_cycle = 'Y'
                and each_queue.is_leaf = 1
               )
            then
               QUEUE_PK.pull_default(i_group_id        => each_queue.group_id,
                                     i_organization_id => each_queue.organization_id,
                                     i_start_tm        => i_start_tm,
                                     i_user_id         => i_user_id
                                    );
            end if;

         exception
            when TYPE_PK.e_event_restricted then
               raise;

            when others then
               QUEUE_PK.change_status(i_id        => each_queue.id,
                                      i_to_status => 'Failed',
                                      i_user_id   => i_user_id
                                     );
               raise;
         end;
      end loop operator;

   exception
      when TYPE_PK.e_event_restricted then
         raise;

      when others then
         raise;

   end operate;

   procedure disseminate
   (
      i_dc_id   em.organizations.code%type,
      i_user_id varchar2
   )
   /*
   ||----------------------------------------------------------------------------
   || disseminate
   ||   Disseminate the work
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/27 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is

      cursor csr_group_events
      is
      with
         failed_queues as
            (select connect_by_root q.id root_id, q.*, level lvl
             from   em.organizations      o
             join   em.event_queues       q
             on     q.organization_id = o.id
             join   em.event_queue_status s
             on     s.id = q.status_id
             where  o.code = i_dc_id
             and    s.description = 'New'
             start with (   q.run_after_tm is null
                         or q.run_after_tm <= sysdate
                        )
             and        s.description = 'Completed'
             and        q.previous_id is null
             connect by prior q.id = q.previous_id
            ),
         next_eligible_queue as
           (select f.organization_id, f.id, f.group_id, f.run_after_tm
            from   failed_queues f
            where  lvl = (select min(lvl)
                          from   failed_queues x
                          where  x.root_id = f.root_id
                         )
            )
            select q.organization_id, q.id, q.group_id, q.run_after_tm
            from   em.organizations      o
            join   em.event_queues       q
            on     q.organization_id = o.id
            join   em.event_queue_status s
            on     s.id = q.status_id
            where  o.code = i_dc_id
            and    s.description = 'New'
            and    (   q.run_after_tm is null
                    or q.run_after_tm <= sysdate
                   )
            and    q.previous_id is null
            union all
            select *
            from   next_eligible_queue
            order by 1, 4 nulls first;

      l_is_continue boolean := false;
   begin
      <<disseminator>>
      for each_row in csr_group_events
      loop
         begin
            lock_group(i_organization_id => each_row.organization_id,
                       i_group_id        => each_row.group_id,
                       i_queue_id        => each_row.id,
                       i_user_id         => i_user_id
                      );

            operate(i_queue_id => each_row.id,
                    i_start_tm => each_row.run_after_tm,
                    i_user_id  => i_user_id
                   );

         exception
            when TYPE_PK.e_row_locked then
               l_is_continue := true;
               continue;

            when TYPE_PK.e_event_restricted then
               l_is_continue := true;
               continue;
         end;

         exit when not l_is_continue;

      end loop disseminator;

   exception
      when others then
         raise;

   end disseminate;

end MANAGER_PK;
/
