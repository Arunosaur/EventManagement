create package         MANAGER_PK
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

   procedure push_default(i_group_id        em.event_queues.group_id%type,
                          i_organization_id em.event_queues.organization_id%type,
                          i_run_after_tm    em.event_queues.run_after_tm%type default null,
                          i_user_id         em.event_queues.user_id%type
                         );

end MANAGER_PK;
/

