CREATE OR REPLACE PACKAGE EM_CODE.EVENT_LOG_PK
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

end EVENT_LOG_PK;
/
