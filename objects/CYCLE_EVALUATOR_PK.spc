CREATE OR REPLACE PACKAGE EM_CODE.CYCLE_EVALUATOR_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : CYCLE_EVALUATOR_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Feb, 07th 2023
|| DESCRIPTION         : To maintain cycles
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

   function sub_cycle
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return date;

end CYCLE_EVALUATOR_PK;
/
