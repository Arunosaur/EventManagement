create or replace package em_code.EVENT_LOG_PK
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
   );

   procedure get_last
   (
      i_application_id  em.applications.id%type default null,
      i_organization_id em.organizations.id%type default null,
      o_logs            out sys_refcursor
   );

   procedure get_sub
   (
      i_queue_id em.event_queues.id%type,
      o_logs     out sys_refcursor
   );

   procedure init(i_queue_id em.event_logs.queue_id%type);

   procedure tweet
   (
      i_queue_id     em.event_logs.queue_id%type,
      i_is_increment boolean default false,
      i_message      em.event_logs.message%type
   );

   procedure finalize
   (
      i_queue_id     em.event_logs.queue_id%type,
      i_is_increment boolean default false,
      i_message      em.event_logs.message%type
   );

   procedure get_statistics(o_statistics out sys_refcursor);

end EVENT_LOG_PK;
/
