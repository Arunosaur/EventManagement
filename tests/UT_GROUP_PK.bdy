CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_GROUP_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_GROUP_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 22nd 2023
|| DESCRIPTION         : Test suite to maintain groups
||---------------------------------------------------------------------------------
|| CHANGELOG
||---------------------------------------------------------------------------------
|| DATE        USER ID     CHANGES
||---------------------------------------------------------------------------------
||02/22/2023   kxpadal
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
      -- Act
      EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 11',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );
    COMMIT;

      -- Assert
      select count(1)
      into   l_count
      from   em.groups
      where  id = l_id;

      ut.expect(l_count).to_equal(1);

     open l_csr_actual
      for
      select id, description, application_id, cycle_id, preferred_run_tm, user_id
      from   em.groups
      where  id = l_id;

      open l_csr_expect
      for
      select l_id id, 'Kranthi simulation group 11' description, 3 application_id, 2 cycle_id,sysdate+1/12 preferred_run_tm, 'kxpadal' user_id
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
     select  t.description, a.description application, c.description cycle, t.preferred_run_tm, t.user_id, t.last_change_date
         from   em.groups       t
         join   em.applications a
         on     a.id = t.application_id
         join   em.cycles       c
         on     c.id = t.cycle_id
      union all
      select  'Kranthi simulation group 12' description, 'WMS Light' application_id, 'Daily' cycle_id,sysdate+1/12 preferred_run_tm, 'kxpadal' user_id,null last_change_date
      from   dual;

       EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 12',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );

      --act
      EM_CODE.GROUP_PK.get(o_groups => l_csr_actual);

      -- Assert
      ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('ID,preferred_run_tm, LAST_CHANGE_DATE').unordered();
      --ut.expect(l_csr_actual).to_have_count(l_expect_count);
   end get;

procedure deregister
as
      l_count   integer;

    begin

      EM_CODE.GROUP_PK.deregister(
                                 i_id          => 12,
                                 i_user_id     => 'kxpadal'
                                 );
    COMMIT;

      -- Assert
      select count(1)
      into   l_count
      from   em.groups
      where  id = 12;

      ut.expect(l_count).to_equal(0);

     end deregister;

procedure change_cycle
as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

      EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 12',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );


      EM_CODE.GROUP_PK.change_cycle(
                                 i_id          => l_id,
                                 i_cycle_id  => 3,
                                 i_user_id     => 'kxpadal'
                                 );


     open l_csr_actual
      for
      select id, cycle_id
      from   em.groups
      where  id = l_id;

      open l_csr_expect
      for
      select l_id id, 3 cycle_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

     end change_cycle;

procedure change_application
as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

      EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 12',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );


      EM_CODE.GROUP_PK.change_application (
                                 i_id          => l_id,
                                 i_application_id  => 2,
                                 i_user_id     => 'kxpadal'
                                 );


     open l_csr_actual
      for
      select id, application_id
      from   em.groups
      where  id = l_id;

      open l_csr_expect
      for
      select l_id id, 2 application_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end change_application;


procedure post_preferred_time
as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

      EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 12',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );


      EM_CODE.GROUP_PK.post_preferred_time (
                                 i_id          => l_id,
                                 i_preferred_run_tm  => sysdate+2/12,
                                 i_user_id     => 'kxpadal'
                                 );


     open l_csr_actual
      for
      select id, preferred_run_tm
      from   em.groups
      where  id = l_id;

      open l_csr_expect
      for
      select l_id id, sysdate+2/12 preferred_run_tm
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end post_preferred_time;

   begin
   -- package initialize
   ENV.set_app_cd('EMS');

end UT_GROUP_PK;
/
