CREATE OR REPLACE PACKAGE EM_CODE.UT_GROUP_PK
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
 is
 -- %suite(Event Management System)

-- %test (add a new group)
 procedure register;


 -- %test (Retreivng without a condition)
 procedure get;

-- %test (Removing an existing group)
 procedure deregister;

-- %test (Change the cycle for this group)
procedure change_cycle;

-- %test (Change the application to which this group belongs)
procedure  change_application;

-- %test (post the next preferred time to run for this group)
procedure  post_preferred_time;

end;
/
