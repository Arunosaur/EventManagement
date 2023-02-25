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
   procedure add
   is
     l_id      integer;
      l_count   integer;
      l_rt_cycles   em.cycles%rowtype;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
      l_group_id number :=11;
      l_value clob:='test';

    begin
      -- Act
      EM_CODE.PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   l_group_id,
                                             i_event_definition_id => 12,
                                             i_parameter_sequence => 1,
                                             i_organization_id   =>  1,
                                             i_value            =>   l_value,
                                             i_user_id          =>   'kxpadal'
                                            );

      -- Assert
      select count(1)
      into   l_count
      from   em.event_group_organization_defaults e
      where  group_id = l_group_id and e.create_user_id= 'kxpadal';


      ut.expect(l_count).to_equal(1);
      --ut.expect(l_count).to_equal(2);



      open l_csr_actual
      for
      select group_id, event_definition_id, parameter_sequence, organization_id, value, create_user_id user_id
      from   em.event_group_organization_defaults
      where  group_id = l_group_id and create_user_id= 'kxpadal';

      open l_csr_expect
      for
      select l_group_id group_Id, 12 event_definition_id, 1 parameter_sequence, 1 organization_id, l_value value, 'kxpadal' user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end add;


procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
      l_expect_count number;
      l_value clob :='test';
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
      select 1,2,99,23,l_value,'kxpadal', 'kxpadal'
      from dual
    );
      EM_CODE.PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   1,
                                             i_event_definition_id => 1,
                                             i_parameter_sequence => 1,
                                             i_organization_id   =>  23,
                                             i_value            =>   l_value,
                                             i_user_id          =>   'kxpadal'
                                            );

      --act
      EM_CODE.PARAMETER_DEFAULTS_PK.get(o_defaults => l_csr_actual);

      -- Assert
      --ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('group_description,event,organization,create_date,last_update_user_id, LAST_CHANGE_DATE').unordered();
      ut.expect(l_csr_actual).to_have_count(l_expect_count);
   end get;

procedure provide_value
   as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect  sys_refcursor;
      l_group_id number :=2;
        l_value clob :='test';
          l_modfied_value clob :='testmodify';

   begin
      -- Arrange
      EM_CODE.PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   l_group_id,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 1,
                                             i_organization_id   =>  1,
                                             i_value            =>   l_value,
                                             i_user_id          =>   'kxpadal'
                                            );
      -- Act
      EM_CODE.PARAMETER_DEFAULTS_PK.provide_value ( i_group_id  =>   l_group_id,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 1,
                                             i_organization_id   =>  1,
                                             i_value            =>   l_modfied_value,
                                             i_user_id          =>   'kxpadal'
                                            );

      -- Assert
       open l_csr_actual for
      select  t.value
      from   em.event_group_organization_defaults t
        where t.group_id =l_group_id   and    event_definition_id = 2
      and    parameter_sequence = 1
      and    organization_id = 1 and create_user_id= 'kxpadal';

     open l_csr_expect for
     select l_modfied_value from dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);
   end provide_value;


procedure remove
    as
      l_id integer;
        l_actual_count number;
      l_group_id number :=3;
        l_value clob :='test';


   begin
      -- Arrange
      EM_CODE.PARAMETER_DEFAULTS_PK.add ( i_group_id  =>   l_group_id,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 1,
                                             i_organization_id   =>  1,
                                             i_value            =>   l_value,
                                             i_user_id          =>   'kxpadal'
                                            );
      -- Act
      EM_CODE.PARAMETER_DEFAULTS_PK.remove ( i_group_id  =>   l_group_id,
                                             i_event_definition_id => 2,
                                             i_parameter_sequence => 1,
                                             i_organization_id   =>  4,
                                             i_user_id          =>   'kxpadal'
                                            );

      -- Assert

      select  count(*) into l_actual_count
      from   em.event_group_organization_defaults t
        where t.group_id =l_group_id  and t.event_definition_id=2 and t.parameter_sequence=1 and create_user_id= 'kxpadal';

      ut.expect(l_actual_count).to_equal(0);
   end
remove;

BEGIN
   -- package initialize
    env.set_app_cd('EMS');
END UT_PARAMETER_DEFAULTS_PK;
/
