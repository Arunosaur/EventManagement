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

   procedure lock_group
   (
      i_organization_id em.event_queues.organization_id%type,
      i_group_id        em.event_queues.group_id%type,
      i_queue_id        em.event_queues.id%type,
      i_user_id         em.event_queues.user_id%type
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
                                i_to_status => 'Locked',
                                i_user_id   => i_user_id
                               );
DBMS_OUTPUT.put_line('Lock: ' || i_organization_id || ' : ' || i_group_id || ' - ' || i_queue_id || ' : ' || i_user_id);
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
      i_user_id         em.event_queues.user_id%type
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
DBMS_OUTPUT.put_line('UnLock: ' || i_organization_id || ' : ' || i_group_id || ' - ' || i_queue_id || ' : ' || i_user_id);
      end loop;

   exception
      when others then
         raise;

   end unlock_group;

   procedure notify_job_manager(i_dc_id integer)
   /*
   ||----------------------------------------------------------------------------
   || notify_job_manager
   ||   Notify the job manager to run more concurrent jobs
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/03 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is

   begin
      null;

   exception
      when others then
         raise;

   end notify_job_manager;

   function is_event_restricted
   (
      i_organization_id     em.event_queues.organization_id%type,
      i_group_id            em.groups.id%type,
      i_event_definition_id em.event_definitions.id%type
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
             and    q.group_id != i_group_id
            ),
        count_wip_queues as
            (select count(1) cnt
             from   in_process_queues
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
           )
        select (q.cnt + r.cnt + s.cnt + t.cnt + u.cnt)
        into   l_count
        from   count_wip_queues               q
        join   count_group_restrictions       r
        on     1 = 1
        join   count_group_event_restrictions s
        on     1 = 1
        join   count_event_group_restrictions t
        on     1 = 1
        join   count_event_restrictions       u
        on     1 = 1;

      return (l_count > 0);

   exception
      when others then
         return true;

   end is_event_restricted;

   procedure operate
   (
      i_queue_id em.event_queues.id%type,
      i_user_id  em.event_queues.user_id%type
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
      select q.id, q.previous_id, q.value, q.organization_id, q.group_id, q.event_definition_id
      from   em.event_queues q
      join   em.event_queue_status s
      on     s.id = q.status_id
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
                                   i_event_definition_id => each_queue.event_definition_id
                                  )
            then
               if each_queue.previous_id is null
               then
                  unlock_group(i_organization_id => each_queue.organization_id,
                               i_group_id        => each_queue.group_id,
                               i_queue_id        => each_queue.id,
                               i_user_id         => i_user_id
                              );
                  exit operator;
               else
                  <<wip>>
                  loop
                     DBMS_SESSION.sleep(10);
                     exit wip when not is_event_restricted(i_organization_id     => each_queue.organization_id,
                                                           i_group_id            => each_queue.group_id,
                                                           i_event_definition_id => each_queue.event_definition_id
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
         exception
            when others then
               QUEUE_PK.change_status(i_id        => each_queue.id,
                                      i_to_status => 'Failed',
                                      i_user_id   => i_user_id
                                     );
               raise;
         end;
      end loop operator;

   exception
      when others then
         raise;

   end operate;

   procedure disseminate
   (
      i_dc_id   integer,
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
      select o.id organization_id, first_value(q.id) over(order by q.last_change_date) queue_id, first_value(group_id) over(order by q.last_change_date) group_id, count(distinct group_id) over() distinct_groups
      from   em.organizations      o
      join   em.event_queues       q
      on     q.organization_id = o.id
      join   em.event_queue_status s
      on     s.id = q.status_id
      where  o.code = to_char(i_dc_id)
      and    s.description = 'New'
      and    (   q.run_after_tm is null
              or q.run_after_tm <= sysdate
             )
      and    q.previous_id is null
      fetch first 1 row only;

   begin
      <<disseminator>>
      for each_row in csr_group_events
      loop
DBMS_OUTPUT.put_line('Disseminate ' || each_row.organization_id || ' : ' || each_row.group_id || ' - ' || each_row.queue_id || ' : ' || i_user_id);
         lock_group(i_organization_id => each_row.organization_id,
                    i_group_id        => each_row.group_id,
                    i_queue_id        => each_row.queue_id,
                    i_user_id         => i_user_id
                   );

         if each_row.distinct_groups > 1
         then
            notify_job_manager(i_dc_id);
         end if;

         operate(i_queue_id => each_row.queue_id, i_user_id => i_user_id);

      end loop disseminator;

   exception
      when others then
         raise;

   end disseminate;

end MANAGER_PK;
/

