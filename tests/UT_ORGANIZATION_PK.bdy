CREATE OR REPLACE PACKAGE BODY EM_CODE.UT_ORGANIZATION_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_ORGANIZATION_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 2st 2023
|| DESCRIPTION         : Test suite to maintain organizations
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

   procedure get
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
      l_expect_count number;
   begin
      -- Arrange



    select count(1) into l_expect_count from (
    select o.id, o.type,t.description type_description, o.code, o.short_nm, o.name, o.parent_id,p.name, o.user_id,o.last_change_date
         from   em.organization_types t
         join   em.organizations      o
         on     o.type = t.id
         left join
                em.organizations      p
         on     p.id = o.parent_id
      union all
      select 0, 1,null type_description, 'TST' , 'FS11', 'Food Service', 2 ,null parent,'kxpadal',null last_change_date
      from   dual);


       EM_CODE.ORGANIZATION_PK.register(i_code        => 'TST',
                                      i_type         => 1 ,
                                      i_short_nm    => 'FS11',
                                      i_name        => 'Food Service',
                                      i_parent_id   => 2 ,
                                      i_user_id     => 'kxpadal',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.ORGANIZATION_PK.get(o_organizations => l_csr_actual);

      -- Assert
     -- ut.expect(l_csr_actual).to_equal(l_csr_expect).exclude('id, type_description, parent, last_change_date').unordered();
      ut.expect(l_csr_actual).to_have_count(l_expect_count);
   end get;

   procedure register
   as
      l_id      integer;
      l_count   integer;
      l_rt_organizations   em.organizations%rowtype;
      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Act
      EM_CODE.ORGANIZATION_PK.register(i_code        => 'TST',
                                      i_type         => 1 ,
                                      i_short_nm    => 'FS11',
                                      i_name        => 'Food Service',
                                      i_parent_id   => 2 ,
                                      i_user_id     => 'kxpadal',
                                      o_id          => l_id
                                     );

      -- Assert
      select count(1)
      into   l_count
      from   em.organizations
      where  id = l_id;

      ut.expect(l_count).to_equal(1);
      --ut.expect(l_count).to_equal(2);

      select *
      into   l_rt_organizations
      from   em.organizations
      where  id = l_id;

      ut.expect(l_rt_organizations.code).to_equal('TST');
      --ut.expect(l_rt_organizations.code).to_equal('TEST');

      open l_csr_actual
      for
      select code, type, short_nm, name, parent_id, user_id, null as x
      from   em.organizations
      where  id = l_id;

      open l_csr_expect
      for
      select 'TST' as code,  1 as type, 'FS11' as short_nm,  'Food Service' as name, 2 as parent_id, 'kxpadal' as user_id, cast(null as varchar2(1)) as x
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);

   end register;


   procedure modify
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.ORGANIZATION_PK.register(i_code        => 'TST',
                                      i_type         => 1 ,
                                      i_short_nm    => 'FS11',
                                      i_name        => 'Food Service',
                                      i_parent_id   => 2 ,
                                      i_user_id     => 'kxpadal',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.ORGANIZATION_PK.modify(i_id      => l_id,
                                    i_code    => 'TEST',
                                    i_short_nm    => 'FS12',
                                    i_user_id => 'kxpadal'
                                   );

      -- Assert
      open l_csr_actual
      for
      select code, type, short_nm, name, parent_id, user_id
      from   em.organizations
      where  id = l_id;

      open l_csr_expect
      for
      select 'TEST' as code, 1 as type, 'FS12' as short_nm, 'Food Service' as name, 2 as parent_id, 'kxpadal' as user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);
   end modify;

procedure change_parent
as
      l_id integer;

      l_csr_actual   sys_refcursor;
      l_csr_expect   sys_refcursor;
   begin
    -- Arrange
      EM_CODE.ORGANIZATION_PK.register(i_code        => 'TST',
                                      i_type         => 1 ,
                                      i_short_nm    => 'FS11',
                                      i_name        => 'Food Service',
                                      i_parent_id   => 2 ,
                                      i_user_id     => 'kxpadal',
                                      o_id          => l_id
                                     );

      -- Act
      EM_CODE.ORGANIZATION_PK.change_parent(i_id      => l_id,
                                    i_parent_id   => 3 ,
                                    i_user_id => 'kxpadal'
                                   );

      -- Assert
      open l_csr_actual
      for
      select code, type, short_nm, name, parent_id, user_id
      from   em.organizations
      where  id = l_id;

      open l_csr_expect
      for
     select 'TST' as code, 1 as type, 'FS11' as short_nm, 'Food Service' as name, 3 as parent_id, 'kxpadal' as user_id
      from   dual;

      ut.expect(l_csr_actual).to_equal(l_csr_expect);
   end change_parent;

   procedure deregister
   as
      l_id integer;

      l_csr_actual   sys_refcursor;
   begin
      -- Arrange
      EM_CODE.ORGANIZATION_PK.register(i_code        => 'TST',
                                      i_type         => 1 ,
                                      i_short_nm    => 'FS11',
                                      i_name        => 'Food Service',
                                      i_parent_id   => 2 ,
                                      i_user_id     => 'kxpadal',
                                      o_id          => l_id
                                     );


      -- Act
      EM_CODE.ORGANIZATION_PK.deregister(i_id      => l_id,
                                         i_user_id => 'kxpadal'
                                        );

      -- Assert
      open l_csr_actual
      for
      select code, type, short_nm, name, parent_id, user_id
      from   em.organizations
      where  id = l_id;

      ut.expect(l_csr_actual).to_be_empty();
   end deregister;

begin
   -- package initialize
   ENV.set_app_cd('EMS');
end UT_ORGANIZATION_PK;
/
