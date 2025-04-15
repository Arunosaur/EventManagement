create or replace package em_code.TYPE_PK
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

   e_row_locked exception;
   pragma exception_init(e_row_locked, -54);

   e_event_restricted exception;

end TYPE_PK;
/
