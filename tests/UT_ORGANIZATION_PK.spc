CREATE OR REPLACE PACKAGE EM_CODE.UT_ORGANIZATION_PK
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

 -- %suite(Event Management System)

 -- %test (Register a new Organization)
 procedure register;

 -- %test (Retreivng without a condition)
 procedure get;

-- %test (Modifying the existing Organization)
 procedure modify;

--%test (Change the parent id for the given organization)
 procedure change_parent;

-- %test (Removing an organization)
 procedure deregister;

end;
/
