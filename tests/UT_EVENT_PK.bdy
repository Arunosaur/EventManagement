CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_EVENT_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_EVENT_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Mar 1st 2023
|| DESCRIPTION         : Test suite to maintain events
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

   procedure register
   is
     l_id      integer;
      l_count   integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin
      -- Act
      EM_CODE.EVENT_PK.register (i_description => 'Simulation Package - Simulation - 12',
                                 i_procedure_name => 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12',
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );

      -- Assert
      select count(1)
      into   l_count
      from   em.event_definitions
      where  id = l_id;

      ut.expect(l_count).to_equal(1);

     open l_csr_actual
      for
      select id, description, procedure_name, user_id
      from em.event_definitions
      where  id = l_id;

      open l_csr_expect
      for
      select l_id id, 'Simulation Package - Simulation - 12' description, 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12' procedure_name, 'kxpadal' user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end register;

  procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Arrange
      open l_csr_expect
      for
      select description, procedure_name, user_id
      from   em.event_definitions
      union all
      select 'Simulation Package - Simulation - 12', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12', 'kxpadal'
      from   dual;

      EM_CODE.EVENT_PK.register (i_description => 'Simulation Package - Simulation - 12',
                                 i_procedure_name => 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12',
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );

      -- Act
      EM_CODE.EVENT_PK.get(o_events => l_csr_actual);

      -- Assert
      ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('ID, LAST_CHANGE_DATE').unordered();
      --ut.expect(l_csr_actual).to_have_count(l_expect_count);
   end get;


   procedure modify
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.EVENT_PK.register (i_description => 'Simulation Package - Simulation - 12',
                                 i_procedure_name => 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12',
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );
      -- Act
      EM_CODE.EVENT_PK.modify(i_id      => l_id,
                              i_description => 'Simulation Package - Simulation - 13',
                              i_procedure_name => 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12',
                              i_user_id     => 'kxpadal'
                            );

      -- Assert
      open l_csr_actual
      for
      select description, procedure_name, user_id
      from   em.event_definitions
      where  id = l_id;

      open l_csr_expect
      for
      select 'Simulation Package - Simulation - 13' as description, 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12' as procedure_name, 'kxpadal' as user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);
   end modify;

   procedure deregister
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.EVENT_PK.register (i_description => 'Simulation Package - Simulation - 12',
                                 i_procedure_name => 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_12',
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );

      -- Act
      EM_CODE.EVENT_PK.deregister(i_id      => l_id,
                                         i_user_id => 'kxpadal'
                                        );

      -- Assert
      open l_csr_actual
      for
      select id, description, procedure_name, user_id
      from   em.event_definitions
      where  id = l_id;

      ut.expect(l_csr_actual).to_be_empty();
   end deregister;

begin
   -- package initialize
   ENV.set_app_cd('EMS');
end UT_EVENT_PK;
/
