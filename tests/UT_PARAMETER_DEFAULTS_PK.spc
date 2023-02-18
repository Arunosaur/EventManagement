CREATE OR REPLACE PACKAGE EM_CODE.UT_PARAMETER_DEFAULTS_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : UT_PARAMETER_DEFAULTS_PK
|| CREATED BY          : Kranthi Padala
|| CREATE DATE         : Feb 8th 2023
|| DESCRIPTION         : Test suite to maintain parameter defaults
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
 --procedure add;

 -- %test (Retreivng without a condition)
 procedure get;

-- %test (Modifying an existing cycle)
 --procedure provide_value;

-- %test (Removing an existing cycle)
 --procedure remove;

end;
/
