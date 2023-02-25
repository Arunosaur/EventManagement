CREATE OR REPLACE PACKAGE BODY EM_CODE.EVENT_PARAMETERS_PK
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

   procedure get(o_event_parameters out sys_refcursor)
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the events
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'EVENT_PARAMETERS.get';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.dbg('ENTRY', l_tt_parms);

      open o_event_parameters for
         select t.event_definition_id, e.description, t.sequence, t.parameter_name, t.data_type_id, d.description data_type, t.parameter_size, t.parameter_type, t.user_id, t.last_change_date
         from   em.event_parameters  t
         join   em.event_definitions e
         on     e.id = t.event_definition_id
         join   em.data_types        d
         on     d.id = t.data_type_id
         order by t.last_change_date;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end get;

   procedure register
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_parameter_name      em.event_parameters.parameter_name%type,
      i_data_type_id        em.event_parameters.data_type_id%type,
      i_parameter_size      em.event_parameters.parameter_size%type default null,
      i_parameter_type      em.event_parameters.parameter_type%type default null,
      i_user_id             em.event_parameters.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || register
   ||   add a new event parameter
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'EVENT_PARAMETERS.register';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_sequence', i_sequence);
      logs.add_parm(l_tt_parms, 'i_parameter_name', i_parameter_name);
      logs.add_parm(l_tt_parms, 'i_data_type_id', i_data_type_id);
      logs.add_parm(l_tt_parms, 'i_parameter_size', i_parameter_size);
      logs.add_parm(l_tt_parms, 'i_parameter_type', i_parameter_type);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      insert into em.event_parameters
         (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id)
      values
         (i_event_definition_id, i_sequence, i_parameter_name, i_data_type_id, i_parameter_size, i_parameter_type, i_user_id);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end register;

   procedure modify
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_parameter_name      em.event_parameters.parameter_name%type,
      i_data_type_id        em.event_parameters.data_type_id%type,
      i_parameter_size      em.event_parameters.parameter_size%type default null,
      i_parameter_type      em.event_parameters.parameter_type%type default null,
      i_user_id             em.event_parameters.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || modify
   ||   modify an event parameter
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'EVENT_PARAMETERS.modify';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_sequence', i_sequence);
      logs.add_parm(l_tt_parms, 'i_parameter_name', i_parameter_name);
      logs.add_parm(l_tt_parms, 'i_data_type_id', i_data_type_id);
      logs.add_parm(l_tt_parms, 'i_parameter_size', i_parameter_size);
      logs.add_parm(l_tt_parms, 'i_parameter_type', i_parameter_type);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      if i_parameter_name is not null
         or i_data_type_id is not null
         or i_parameter_size is not null
         or i_parameter_type is not null
      then
         update em.event_parameters
         set    parameter_name   = nvl(i_parameter_name, parameter_name),
                data_type_id     = nvl(i_data_type_id, data_type_id),
                parameter_size   = nvl(i_parameter_size, parameter_size),
                parameter_type   = nvl(i_parameter_type, parameter_type),
                user_id          = i_user_id,
                last_change_date = current_date
         where  event_definition_id = i_event_definition_id
         and    sequence = i_sequence;
      end if;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end modify;

   procedure change_sequence
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_new_sequence        em.event_parameters.sequence%type,
      i_user_id             em.event_parameters.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || change_sequence
   ||   chagne the parameter sequence
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'EVENT_PARAMETERS.change_sequence';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_sequence', i_sequence);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      update em.event_parameters
      set    sequence         = i_new_sequence,
             user_id          = i_user_id,
             last_change_date = current_date
      where  event_definition_id = i_event_definition_id
      and    sequence = i_sequence
      and    i_sequence != i_new_sequence;

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end change_sequence;

   procedure deregister
   (
      i_event_definition_id em.event_parameters.event_definition_id%type,
      i_sequence            em.event_parameters.sequence%type,
      i_user_id             em.event_parameters.user_id%type
   )
   /*
   ||----------------------------------------------------------------------------
   || deregister
   ||   remove an event parameter
   ||
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/01/22 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_c_module constant typ.t_maxfqnm := 'EVENT_PARAMETERS.deregister';

      l_tt_parms logs.tar_parm;
   begin
      timer.startme(l_c_module || env.get_session_id);

      logs.add_parm(l_tt_parms, 'i_event_definition_id', i_event_definition_id);
      logs.add_parm(l_tt_parms, 'i_sequence', i_sequence);
      logs.add_parm(l_tt_parms, 'i_user_id', i_user_id);

      logs.dbg('ENTRY', l_tt_parms);

      delete em.event_parameters
      where  event_definition_id = i_event_definition_id
      and    sequence = i_sequence;

      logs.info('This event parameter was removed', l_tt_parms);

      timer.stopme(l_c_module || env.get_session_id);
      logs.dbg('RUNTIME: ' || timer.elapsed(l_c_module || env.get_session_id) || ' secs.');

   exception
      when others then
         logs.err(l_tt_parms);

   end deregister;

end EVENT_PARAMETERS_PK;
/
