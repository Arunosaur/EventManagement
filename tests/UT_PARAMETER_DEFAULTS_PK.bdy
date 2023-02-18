CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_PARAMETER_DEFAULTS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_PARAMETER_DEFAULTS_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 8th 2023
|| DESCRIPTION         : Test suite to maintain parameter defaults
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
/**
 procedure add
   is
     l_id      integer;
      l_count   integer;
      l_rt_cycles   em.cycles%rowtype;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin
      -- Act
      EM_CODE.PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   1,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 99,
                                             i_organization_id   =>  23,
                                             i_value            =>   'TEST',
                                             i_user_id          =>   'kxpadal'
                                            );

      -- Assert
      select count(1)
      into   l_count
      from   em.event_group_organization_defaults
      where  group_id = i_group_id;

      ut.expect(l_count).to_equal(1);
      --ut.expect(l_count).to_equal(2);



      open l_csr_actual
      for
      select group_id, event_definition_id, parameter_sequence, organization_id, value, user_id
      from   em.event_group_organization_defaults
      where  group_id = i_group_id;

      open l_csr_expect
      for
      select 1 group_Id, 3 event_definition_id, 99 parameter_sequence, 23 organization_id, 'TEST' value, 'kxpadal' user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end add;
**/

procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
      l_expect_count number;
   begin
   -- Arrange
      select count(1) into l_expect_count from (
      select group_id, event_definition_id, parameter_sequence, organization_id, value, create_user_id, last_update_user_id
      from   em.event_group_organization_defaults t
         join   em.groups                            g
         on     g.id = t.group_id
         join   em.event_definitions                 e
         on     e.id = t.event_definition_id
         join   em.organizations                     o
         on     o.id = t.organization_id
      union all
      select 1,2,99,23,'TEST','kxpadal', 'kxpadal'
      from dual
    );
      EM_CODE.PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   1,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 99,
                                             i_organization_id   =>  23,
                                             i_value            =>   'TEST',
                                             i_user_id          =>   'kxpadal'
                                            );

      --act
      EM_CODE.PARAMETER_DEFAULTS_PK.get(o_defaults => l_csr_actual);

      -- Assert
      --ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('group_description,event,organization,create_date,last_update_user_id, LAST_CHANGE_DATE').unordered();
      ut.expect(l_csr_actual).to_have_count(l_expect_count);
   end get;
/**
procedure provide_value
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.UT_PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   1,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 99,
                                             i_organization_id   =>  23,
                                             i_value            =>   'TEST',
                                             i_user_id          =>   'kxpadal'
                                            );
      -- Act
      EM_CODE.UT_PARAMETER_DEFAULTS_PK.modify(i_id      => l_id,
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
  **/

   begin
   -- package initialize
   ENV.set_app_cd('EMS');

end UT_PARAMETER_DEFAULTS_PK;
/
