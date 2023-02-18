CREATE OR REPLACE PACKAGE EM_CODE.RESTRICTIONS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : RESTRICTIONS_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 24th 2023
|| DESCRIPTION         : To maintain cycles
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

   procedure get_group(o_restrictions out sys_refcursor);

   procedure add_group
   (
      i_group_id            em.group_restrictions.group_id%type,
      i_restricted_group_id em.group_restrictions.restricted_group_id%type,
      i_user_id             em.group_restrictions.user_id%type
   );

   procedure remove_group
   (
      i_group_id            em.group_restrictions.group_id%type,
      i_restricted_group_id em.group_restrictions.restricted_group_id%type,
      i_user_id             em.group_restrictions.user_id%type
   );

   procedure get_event(o_restrictions out sys_refcursor);

   procedure add_event
   (
      i_event_id            em.event_restrictions.event_id%type,
      i_restricted_event_id em.event_restrictions.restricted_event_id%type,
      i_user_id             em.event_restrictions.user_id%type
   );

   procedure remove_event
   (
      i_event_id            em.event_restrictions.event_id%type,
      i_restricted_event_id em.event_restrictions.restricted_event_id%type,
      i_user_id             em.event_restrictions.user_id%type
   );

   procedure get_group_event(o_restrictions out sys_refcursor);

   procedure add_group_event
   (
      i_group_id            em.group_event_restrictions.group_id%type,
      i_restricted_event_id em.group_event_restrictions.restricted_event_id%type,
      i_user_id             em.group_event_restrictions.user_id%type
   );

   procedure remove_group_event
   (
      i_group_id            em.group_event_restrictions.group_id%type,
      i_restricted_event_id em.group_event_restrictions.restricted_event_id%type,
      i_user_id             em.group_event_restrictions.user_id%type
   );

   procedure get_event_group(o_restrictions out sys_refcursor);

   procedure add_event_group
   (
      i_event_id            em.event_group_restrictions.event_id%type,
      i_restricted_group_id em.event_group_restrictions.restricted_group_id%type,
      i_user_id             em.event_group_restrictions.user_id%type
   );

   procedure remove_event_group
   (
      i_event_id            em.event_group_restrictions.event_id%type,
      i_restricted_group_id em.event_group_restrictions.restricted_group_id%type,
      i_user_id             em.event_group_restrictions.user_id%type
   );

end RESTRICTIONS_PK;
/
