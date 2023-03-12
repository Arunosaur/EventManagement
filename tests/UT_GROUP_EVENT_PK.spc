CREATE OR REPLACE PACKAGE EM_CODE.UT_GROUP_EVENT_PK
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

-- %test (attach an event to the group)
 procedure register;


 -- %test (Get the events)
 procedure get;

-- %test (Removing an existing group)
 procedure deregister;

-- %test (Change the cycle for this group)
procedure change_event_sequence;


end;
/
