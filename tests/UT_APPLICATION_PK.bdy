CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_APPLICATION_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_APPLICATION_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 14th 2020
|| DESCRIPTION         : Test suite to maintain applications
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
   as
      l_id      integer;
      l_count   integer;
      l_rt_applications   em.applications%rowtype;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Act
      EM_CODE.APPLICATION_PK.register(i_code        => 'TST',
                                      i_name        => 'Test',
                                      i_description => 'Testing an application',
                                      i_user_id     => 'asrajag',
                                      o_id          => l_id
                                     );

      -- Assert
      select count(1)
      into   l_count
      from   em.applications
      where  id = l_id;

      ut.expect(l_count).to_equal(1);
      --ut.expect(l_count).to_equal(2);

      select *
      into   l_rt_applications
      from   em.applications
      where  id = l_id;

      ut.expect(l_rt_applications.code).to_equal('TST');
      --ut.expect(l_rt_applications.code).to_equal('TEST');

      open l_csr_actual
      for
      select code, name, description, user_id, null as x
      from   em.applications
      where  id = l_id;

      open l_csr_expect
      for
      select 'TST' as code, 'Test' as name, 'Testing an application' as description, 'asrajag' as user_id, cast(null as varchar2(1)) as x
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

   end register;

   procedure get_by_id
   as
      l_id integer;
      l_actual_lines dbmsoutput_linesarray;
      --l_expect_lines dbmsoutput_linesarray := dbmsoutput_linesarray('5         TST       Test      Testing an application                  asrajag            ');
      l_numlines integer := 1000;
   begin
      -- Arrange
      EM_CODE.APPLICATION_PK.register(i_code        => 'TST',
                                      i_name        => 'Test',
                                      i_description => 'Testing an application',
                                      i_user_id     => 'asrajag',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.APPLICATION_PK.get(i_id => l_id);

      -- Assert
      DBMS_OUTPUT.get_lines(l_actual_lines, l_numlines);
      ut.expect(l_numlines).to_equal(1);
      ut.expect(l_actual_lines.count).to_equal(2);
      --ut.expect(anydata.convertcollection(l_actual_lines)).
      --ut.expect(l_numlines).to_equal(0);
      --ut.expect(anydata.convertcollection(l_actual_lines)).to_be_empty();
      --ut.expect(anydata.convertcollection(l_actual_lines)).to_equal(anydata.convertcollection(l_expect_lines));
      --ut.expect(anydata.convertcollection(l_actual_lines)).to_contain(anydata.convertcollection(l_expect_lines));
   end get_by_id;

   procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Arrange
      open l_csr_expect
      for
      select code, name, description, user_id
      from   em.applications
      union all
      select 'TST', 'Test', 'Testing an application', 'asrajag'
      from   dual;

      EM_CODE.APPLICATION_PK.register(i_code        => 'TST',
                                      i_name        => 'Test',
                                      i_description => 'Testing an application',
                                      i_user_id     => 'asrajag',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.APPLICATION_PK.get(o_applications => l_csr_actual);

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
      EM_CODE.APPLICATION_PK.register(i_code        => 'TST',
                                      i_name        => 'Test',
                                      i_description => 'Testing an application',
                                      i_user_id     => 'asrajag',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.APPLICATION_PK.modify(i_id      => l_id,
                                    i_code    => 'TEST',
                                    i_user_id => 'asrajag'
                                   );

      -- Assert
      open l_csr_actual
      for
      select code, name, description, user_id
      from   em.applications
      where  id = l_id;

      open l_csr_expect
      for
      select 'TEST' as code, 'Test' as name, 'Testing an application' as description, 'asrajag' as user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);
   end modify;

   procedure deregister
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.APPLICATION_PK.register(i_code        => 'TST',
                                      i_name        => 'Test',
                                      i_description => 'Testing an application',
                                      i_user_id     => 'asrajag',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.APPLICATION_PK.deregister(i_id      => l_id,
                                        i_user_id => 'asrajag'
                                       );

      -- Assert
      open l_csr_actual
      for
      select code, name, description, user_id
      from   em.applications
      where  id = l_id;

      ut.expect(l_csr_actual).to_be_empty();
   end deregister;

begin
   -- package initialize
   ENV.set_app_cd('EMS');
end UT_APPLICATION_PK;
/
