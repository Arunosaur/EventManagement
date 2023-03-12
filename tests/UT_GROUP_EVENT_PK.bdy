CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_GROUP_EVENT_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_GROUP_EVENT_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 22nd 2023
|| DESCRIPTION         : Test suite to maintain groups events
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

       EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 11',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );


      EM_CODE.GROUP_EVENT_PK.register (
                                  i_group_id   =>l_id,
                                  i_event_definition_id=> 2,
                                  i_sequence  => 1,
                                  i_user_id => 'kxpadal'
                                 );
    COMMIT;

      -- Assert
      select count(1)
      into   l_count
      from   em.group_events
      where  group_id = l_id and event_definition_id =2 and user_id ='kxpadal';

      ut.expect(l_count).to_equal(1);

     open l_csr_actual
      for
      select group_id,event_definition_id,sequence, user_id
      from   em.group_events
      where   group_id = l_id and event_definition_id =2 and user_id ='kxpadal';

      open l_csr_expect
      for
      select l_id group_id, 2 event_definition_id, 1 sequence,  'kxpadal' user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

end register;


procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin


       EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 11',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );

       open l_csr_expect
      for
     select distinct t.group_id, t.event_definition_id, t.sequence, t.user_id
         from   em.group_events      t
         join   em.groups            g
         on     g.id = t.group_id
         join   em.event_definitions e
         on     e.id = t.event_definition_id
      union all
      select  l_id group_id, 2 event_definition_id, 1 sequence,  'kxpadal' user_id
      from   dual;

      EM_CODE.GROUP_EVENT_PK.register (
                                  i_group_id   =>l_id,
                                  i_event_definition_id=> 2,
                                  i_sequence  => 1,
                                  i_user_id => 'kxpadal'
                                 );

      --act
      EM_CODE.GROUP_EVENT_PK.get(o_group_events => l_csr_actual);

      -- Assert
      ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('group_description,event, LAST_CHANGE_DATE').unordered();

   end get;

procedure deregister
as
      l_count integer;
      l_id   integer;

    begin

     EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 11',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );


      EM_CODE.GROUP_EVENT_PK.register (
                                  i_group_id   =>l_id,
                                  i_event_definition_id=> 2,
                                  i_sequence  => 1,
                                  i_user_id => 'kxpadal'
                                 );

      EM_CODE.GROUP_EVENT_PK.deregister(
                                 i_group_id   =>l_id,
                                  i_event_definition_id=> 2,
                                  i_user_id => 'kxpadal'
                                 );


      -- Assert
      select count(1)
      into   l_count
     from em.group_events
      where  group_id = l_id
      and    event_definition_id = 2;

      ut.expect(l_count).to_equal(0);

     end deregister;

procedure change_event_sequence
as
      l_id integer;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;

    begin

      EM_CODE.GROUP_PK.register (i_description => 'Kranthi simulation group 11',
                                 i_application_id => 3,
                                 i_cycle_id =>2,
                                 i_preferred_run_tm =>sysdate+1/12,
                                 i_user_id     => 'kxpadal',
                                 o_id          => l_id
                                 );


      EM_CODE.GROUP_EVENT_PK.register (
                                  i_group_id   =>l_id,
                                  i_event_definition_id=> 2,
                                  i_sequence  => 1,
                                  i_user_id => 'kxpadal'
                                 );



      EM_CODE.GROUP_EVENT_PK.change_event_sequence(
                                 i_group_id   =>l_id,
                                  i_event_definition_id=> 2,
                                  i_sequence  => 2,
                                  i_user_id => 'kxpadal'
                                 );


     open l_csr_actual
      for
      select group_id, sequence
      from   em.group_events
      where   group_id = l_id
      and    event_definition_id = 2;

      open l_csr_expect
      for
      select l_id id, 2 sequence
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

     end change_event_sequence;


   begin
   -- package initialize
   ENV.set_app_cd('EMS');

end UT_GROUP_EVENT_PK;
/
