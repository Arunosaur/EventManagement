CREATE OR REPLACE PACKAGE EM_CODE.UT_EVENT_PARAMETERS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_EVENT_PARAMETERS_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Mar 2nd 2023
|| DESCRIPTION         : Test suite to maintain events
||---------------------------------------------------------------------------------
|| CHANGELOG
||---------------------------------------------------------------------------------
|| DATE        USER ID     CHANGES
||---------------------------------------------------------------------------------
||03/2/2023   kxpadal
||---------------------------------------------------------------------------------
||
*/
 is

 -- %suite(Event Management System)

-- %test (add a new event parameter)
 procedure register;

 -- %test (Get the events)
 procedure get;

 -- %test (Modifying an event parameter)
 procedure modify;

 -- %test (change the parameter sequence)
 procedure change_sequence;

-- %test (Removing an event parameter)
 procedure deregister;

end;
/
