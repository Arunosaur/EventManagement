CREATE OR REPLACE PACKAGE EM_CODE.TYPE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : TYPE_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Feb, 17th 2023
|| DESCRIPTION         : For types used across packages
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

   type rt_date is record
   (id               integer,
    description      varchar2(15),
    approximate_date date
   );

end TYPE_PK;
/
