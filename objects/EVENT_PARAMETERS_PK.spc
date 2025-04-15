create or replace package em_code.EVENT_PARAMETERS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : EVENT_PARAMETERS
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 22nd 2023
|| DESCRIPTION         : To maintain events
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

   procedure get(o_event_parameters out sys_refcursor);

   procedure register
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_parameter_name      em.event_parameters.parameter_name%type,
      i_data_type_id        em.event_parameters.data_type_id%type,
      i_parameter_size      em.event_parameters.parameter_size%type default null,
      i_parameter_type      em.event_parameters.parameter_type%type default null,
      i_user_id             em.event_parameters.user_id%type
   );

   procedure modify
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_parameter_name      em.event_parameters.parameter_name%type,
      i_data_type_id        em.event_parameters.data_type_id%type,
      i_parameter_size      em.event_parameters.parameter_size%type default null,
      i_parameter_type      em.event_parameters.parameter_type%type default null,
      i_user_id             em.event_parameters.user_id%type
   );

   procedure change_sequence
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_new_sequence        em.event_parameters.sequence%type,
      i_user_id             em.event_parameters.user_id%type
   );

   procedure deregister
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_user_id             em.event_parameters.user_id%type
   );

end EVENT_PARAMETERS_PK;
/
