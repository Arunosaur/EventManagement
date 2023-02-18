CREATE OR REPLACE PACKAGE BODY EM_CODE.EVENT_LOG_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : EVENT_LOG_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 31st 2023
|| DESCRIPTION         : To maintain event logs
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

   procedure get
   (
      i_application_id  em.applications.id%type default null,
      i_organization_id em.organizations.id%type default null,
      o_logs            out sys_refcursor
   )
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the event logs
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/31 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is

   begin

      open o_logs for
      with
         event_log as
            (select t.queue_id, t.lap_id, a.description application, g.description group_description, d.description event,  q.organization_id, o.name organization, message, create_ts, begin_ts, end_ts, finish_cd, q.status_id, s.description status
             from   em.event_logs   t
             join   em.event_queues q
             on     q.id = t.queue_id
             join   em.event_queue_status s
             on     s.id = q.status_id
             join   em.organizations o
             on     o.id = q.organization_id
             join   em.groups g
             on     g.id = q.group_id
             join   em.event_definitions d
             on     d.id = q.event_definition_id
             join   em.applications a
             on     a.id = g.application_id
             where  o.id = nvl(i_organization_id, o.id)
             and    a.id = nvl(i_application_id, a.id)
            )
         select g.*, cast(multiset(select y.*
                                   from   event_log y
                                   where  y.queue_id = g.queue_id
                                   and    y.lap_id  != g.lap_id
                                   order by lap_id desc
                                  ) as event_logs_t
                         ) sub_event_logs
         from   event_log g
         where  g.lap_id = (select max(x.lap_id)
                            from   em.event_log x
                            where  x.queue_id = g.queue_id
                           )
         order by g.application, g.organization_id, g.begin_ts desc, g.end_ts desc;

   exception
      when others then
         null;

   end get;

   procedure init(i_queue_id em.event_logs.queue_id%type)
   /*
   ||----------------------------------------------------------------------------
   || init
   ||   Initiate a queue to the log
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/31 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      pragma autonomous_transaction;

   begin

      insert into em.event_logs
         (queue_id, message, create_ts, finish_cd)
      values
         (i_queue_id, 'Will start shortly...', systimestamp, 0);

      commit;

   exception
      when others then
         rollback;

   end init;

   procedure tweet
   (
      i_queue_id     em.event_logs.queue_id%type,
      i_is_increment boolean default false,
      i_message      em.event_logs.message%type
   )
   /*
   ||----------------------------------------------------------------------------
   || tweet
   ||   update about the queue_id to the log
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/31 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      pragma autonomous_transaction;

      l_lap_id em.event_logs.lap_id%type;
   begin

      if i_is_increment
      then
         select max(lap_id)
         into   l_lap_id
         from   em.event_logs l
         where  l.queue_id = i_queue_id;

         update em.event_logs t
         set    t.begin_ts  = nvl(t.begin_ts, systimestamp),
                t.end_ts    = systimestamp,
                t.finish_cd = 1
         where  t.queue_id = i_queue_id
         and    t.lap_id = l_lap_id;

         insert into em.event_logs
            (queue_id, lap_id, message, create_ts, begin_ts, finish_cd)
         values
            (i_queue_id, l_lap_id + 1, i_message, systimestamp, systimestamp, 0);
      else
         update em.event_logs t
         set    t.message  = i_message,
                t.begin_ts = nvl(t.begin_ts, systimestamp)
         where  t.queue_id = i_queue_id;
      end if;

      commit;

   exception
      when others then
         rollback;

   end tweet;

   procedure finalize
   (
      i_queue_id     em.event_logs.queue_id%type,
      i_is_increment boolean default false,
      i_message      em.event_logs.message%type
   )
   /*
   ||----------------------------------------------------------------------------
   || finalize
   ||   Finalize a queue to the log
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/02 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      pragma autonomous_transaction;

      l_lap_id em.event_logs.lap_id%type;
   begin

      if i_is_increment
      then
         select max(lap_id)
         into   l_lap_id
         from   em.event_logs l
         where  l.queue_id = i_queue_id;

         update em.event_logs t
         set    t.begin_ts  = nvl(t.begin_ts, systimestamp),
                t.end_ts    = systimestamp,
                t.finish_cd = 1
         where  t.queue_id = i_queue_id
         and    t.lap_id = l_lap_id;

         insert into em.event_logs
            (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
         values
            (i_queue_id, l_lap_id + 1, i_message, systimestamp, systimestamp, systimestamp, 1);
      else
         update em.event_logs t
         set    t.message   = i_message,
                t.finish_cd = 1,
                t.end_ts    = systimestamp
         where  t.queue_id = i_queue_id;
      end if;

      commit;

   exception
      when others then
         rollback;

   end finalize;

end EVENT_LOG_PK;
/
