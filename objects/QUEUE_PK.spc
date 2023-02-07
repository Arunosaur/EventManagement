create package         QUEUE_PK
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

   procedure push_default
   (
      i_group_id        em.event_queues.group_id%type,
      i_organization_id em.event_queues.organization_id%type,
      i_run_after_tm    em.event_queues.run_after_tm%type default null,
      i_user_id         em.event_queues.user_id%type
   );

   procedure pull_default
   (
      i_group_id        em.event_queues.group_id%type,
      i_organization_id em.event_queues.organization_id%type,
      i_start_tm        em.event_queues.run_after_tm%type,
      i_user_id         em.event_queues.user_id%type
   );

   procedure change_status
   (
      i_id        em.event_queues.id%type,
      i_to_status em.event_queue_status.description%type,
      i_user_id   em.event_queues.user_id%type
   );

   procedure reset_and_remove_global_block(i_user_id varchar2);

   procedure reset_and_remove_application_block
   (
      i_application_id em.applications.id%type,
      i_user_id        varchar2
   );

   procedure reset_and_remove_organization_block
   (
      i_organization_id em.organizations.id%type,
      i_user_id        varchar2
   );

   procedure reset_and_remove_app_org_block
   (
      i_application_id  em.applications.id%type,
      i_organization_id em.organizations.id%type,
      i_user_id         varchar2
   );

end QUEUE_PK;
/

