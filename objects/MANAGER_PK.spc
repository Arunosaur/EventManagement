CREATE OR REPLACE PACKAGE EM_CODE.MANAGER_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : MANAGER_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Jan, 27th 2023
|| DESCRIPTION         : To manage events
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

   procedure disseminate
   (
      i_dc_id   em.organizations.code%type,
      i_user_id varchar2
   );

end MANAGER_PK;
/
