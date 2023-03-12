CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_EVENT_PARAMETERS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_EVENT_PARAMETERS_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Mar 2nd 2023
|| DESCRIPTION         : Test suite to maintain events
||---------------------------------------------------------------------------------
|| CHANGELOG
||---------------------------------------------------------------------------------
|| DATE        USER ID     CHANGES
||---------------------------------------------------------------------------------
||03/2/2023   kxpadal
||---------------------------------------------------------------------------------
||
*/
IS

 procedure register
   is
     l_id      integer;
      l_count   integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

       EM_CODE.EVENT_PARAMETERS_PK.register (i_event_definition_id => 1,
                                 i_sequence => 3,
                                 i_parameter_name =>'i_dc_id',
                                 i_data_type_id =>2,
                                 i_parameter_size => null,
                                 i_parameter_type => null,
                                 i_user_id     => 'kxpadal'
                                 );


      -- Assert

     open l_csr_actual
      for
      select event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id
      from   em.event_parameters e
      where   e.event_definition_id = 1 and e.sequence=3 and e.parameter_name='i_dc_id' and user_id ='kxpadal';

      open l_csr_expect
      for
      select 1 event_definition_id, 3 sequence, 'i_dc_id' parameter_name,2 data_type_id, null parameter_size,null parameter_type,'kxpadal' user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end register;


procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin


        open l_csr_expect
          for
         select distinct t.event_definition_id, t.sequence, t.parameter_name, t.data_type_id, t.parameter_size, t.parameter_type, t.user_id
             from   em.event_parameters  t
             join   em.event_definitions e
             on     e.id = t.event_definition_id
             join   em.data_types        d
             on     d.id = t.data_type_id
          union all
           select 3 event_definition_id, 3 sequence, 'i_dc_id' parameter_name,2 data_type_id, null parameter_size,null parameter_type,'kxpadal' user_id
          from   dual;



      EM_CODE.EVENT_PARAMETERS_PK.register (i_event_definition_id => 3,
                                 i_sequence => 3,
                                 i_parameter_name =>'i_dc_id',
                                 i_data_type_id =>2,
                                 i_parameter_size => null,
                                 i_parameter_type => null,
                                 i_user_id     => 'kxpadal'
                                 );



      EM_CODE.EVENT_PARAMETERS_PK.get(o_event_parameters => l_csr_actual);

      -- Assert
      ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('description,data_type, last_change_date').unordered();

   end get;

procedure deregister
as
      l_count integer;
      l_id   integer;

    begin

      EM_CODE.EVENT_PARAMETERS_PK.register (i_event_definition_id => 3,
                                 i_sequence => 3,
                                 i_parameter_name =>'i_dc_id',
                                 i_data_type_id =>2,
                                 i_parameter_size => null,
                                 i_parameter_type => null,
                                 i_user_id     => 'kxpadal'
                                 );



      EM_CODE.EVENT_PARAMETERS_PK.deregister(
                                 i_event_definition_id=> 3,
                                 i_sequence => 3,
                                  i_user_id => 'kxpadal'
                                 );


      -- Assert
      select count(1)
      into   l_count
      from   em.event_parameters e where e.event_definition_id=3 and e.sequence=3;

      ut.expect(l_count).to_equal(0);

     end deregister;

procedure change_sequence
as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

     EM_CODE.EVENT_PARAMETERS_PK.register (i_event_definition_id => 3,
                                 i_sequence => 4,
                                 i_parameter_name =>'i_dc_id',
                                 i_data_type_id =>2,
                                 i_parameter_size => null,
                                 i_parameter_type => null,
                                 i_user_id     => 'kxpadal'
                                 );



      EM_CODE.EVENT_PARAMETERS_PK.change_sequence(
                                 i_event_definition_id   =>3,
                                  i_sequence=> 4,
                                  i_new_sequence  => 5,
                                  i_user_id => 'kxpadal'
                                 );


     open l_csr_actual
      for
       select event_definition_id,sequence
      from   em.event_parameters e where e.event_definition_id=3 and e.sequence=5;

      open l_csr_expect
      for
      select 3 event_definition_id, 5 sequence
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

     end change_sequence;

procedure modify
as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

     EM_CODE.EVENT_PARAMETERS_PK.register (i_event_definition_id => 3,
                                 i_sequence => 4,
                                 i_parameter_name =>'i_dc_id',
                                 i_data_type_id =>2,
                                 i_parameter_size => null,
                                 i_parameter_type => null,
                                 i_user_id     => 'kxpadal'
                                 );



      EM_CODE.EVENT_PARAMETERS_PK.modify(
                                  i_event_definition_id => 3,
                                  i_sequence           => 4,
                                  i_parameter_name   => 'i_schema_nm',
                                  i_data_type_id => 2,
                                  i_parameter_size  =>    null,
                                  i_parameter_type  => null,
                                  i_user_id  => 'kxpadal'
                                 );

     open l_csr_actual
      for
       select distinct event_definition_id,sequence,parameter_name
      from   em.event_parameters e where e.event_definition_id=3 and e.sequence=4;

      open l_csr_expect
      for
      select 3 event_definition_id, 4 sequence,'i_schema_nm' parameter_name
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

     end modify;

   begin
   -- package initialize
   ENV.set_app_cd('EMS');

end UT_EVENT_PARAMETERS_PK;
/
