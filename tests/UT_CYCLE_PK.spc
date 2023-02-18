CREATE OR REPLACE PACKAGE EM_CODE.UT_CYCLE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_CYCLE_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 1st 2023
|| DESCRIPTION         : Test suite to maintain cycles
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

-- %test (add a new cycle)
 procedure add;

 -- %test (Retreivng without a condition)
 procedure get;

-- %test (Modifying an existing cycle)
 procedure modify;

-- %test (Removing an existing cycle)
 procedure remove;

end;
/
