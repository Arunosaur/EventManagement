CREATE OR REPLACE PACKAGE EM_CODE.UT_EVENT_PK
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

 -- %suite(Event Management System)

 -- %test (Register a new event)
 procedure register;

 -- %test (Retreivng without a condition)
 procedure get;

-- %test (Modifying the existing event)
  procedure modify;

-- %test (Removing an event)
 procedure deregister;

end;
/
