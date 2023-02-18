CREATE OR REPLACE PACKAGE EM_CODE.UT_APPLICATION_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : APPLICATION_PK
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

   -- %suite(Event Management System)

   -- %test (Register a new application)
   procedure register;

   -- %test (Retreiving by id)
   procedure get_by_id;

   -- %test (Retreivng without a condition)
   procedure get;

   -- %test (Modifying an existing application)
   procedure modify;

   -- %test (Removing an existing application)
   procedure deregister;

end UT_APPLICATION_PK;
/
