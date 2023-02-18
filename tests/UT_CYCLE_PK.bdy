CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_CYCLE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_CYCLE_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 1st 2023
|| DESCRIPTION         : Test suite to maintain cycles
||---------------------------------------------------------------------------------
|| CHANGELOG
||---------------------------------------------------------------------------------
|| DATE        USER ID     CHANGES
||---------------------------------------------------------------------------------
||
||---------------------------------------------------------------------------------
||
*/
IS

 procedure add
   is
     l_id      integer;
      l_count   integer;
      l_rt_cycles   em.cycles%rowtype;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin
      -- Act
      EM_CODE.CYCLE_PK.add (i_code        => 'TSTCycle',
                             i_description => 'Testing a cycle',
                             i_user_id     => 'kxpadal',
                             o_id          => l_id
                            );

      -- Assert
      select count(1)
      into   l_count
      from   em.cycles
      where  id = l_id;

      ut.expect(l_count).to_equal(1);


      select *
      into   l_rt_cycles
      from   em.cycles
      where  id = l_id;

      ut.expect(l_rt_cycles.code).to_equal('TSTCycle');

      open l_csr_actual
      for
      select code, description, user_id
      from   em.cycles
      where  id = l_id;

      open l_csr_expect
      for
      select 'TSTCycle' as code, 'Testing a cycle' as description, 'kxpadal' as user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end add;

procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
   -- Arrange
      open l_csr_expect
      for
      select code, description, user_id
      from   em.cycles
      union all
      select 'TSTCycle','Testing a cycle', 'kxpadal'
      from   dual;

      EM_CODE.CYCLE_PK.add(i_code        => 'TSTCycle',
                                 i_description => 'Testing a cycle',
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                );

      --act
      EM_CODE.CYCLE_PK.get(o_cycles => l_csr_actual);

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
      EM_CODE.CYCLE_PK.add (i_code        => 'TSTCycle',
                             i_description => 'Testing a cycle',
                             i_user_id     => 'kxpadal',
                             o_id          => l_id
                            );
      -- Act
      EM_CODE.CYCLE_PK.modify(i_id      => l_id,
                               i_code    => 'TSTCycle',
                               i_user_id => 'kxpadal'
                               );

      -- Assert
      open l_csr_actual
      for
      select code, description, user_id
      from   em.cycles
      where  id = l_id;

      open l_csr_expect
      for
      select 'TSTCycle' as code, 'Testing a cycle' as description, 'kxpadal' as user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);
   end modify;

procedure remove
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.CYCLE_PK.add (i_code        => 'TSTCycle',
                             i_description => 'Testing a cycle',
                             i_user_id     => 'kxpadal',
                             o_id          => l_id
                            );
      -- Act
      EM_CODE.CYCLE_PK.remove(i_id      => l_id,
                               i_user_id => 'kxpadal'
                               );

      -- Assert
      open l_csr_actual
      for
      select  user_id
      from   em.cycles
      where  id = l_id;

      ut.expect(l_csr_actual).to_be_empty();
   end remove;
   begin
   -- package initialize
   ENV.set_app_cd('EMS');

end UT_CYCLE_PK;
/
