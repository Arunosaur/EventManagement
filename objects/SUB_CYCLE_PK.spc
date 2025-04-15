create or replace package em_code.SUB_CYCLE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : SUB_CYCLE_PK
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

   procedure get_add
   (
      i_cycle_id em.cycles.id%type,
      o_unit     out em.sub_cycle_add.units%type,
      o_term     out em.interval_measures.symbol%type
   );

   function get_day_of_the_year
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date;

   function get_week_of_the_year
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date;

   function get_month_of_the_year
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date;

   function get_day_of_the_month
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date;

   function get_week_of_the_month
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date;

   function get_day_of_the_week
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date;

   function get_time_of_the_day
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return em.sub_cycle_time_in_a_day.database_time%type;

end SUB_CYCLE_PK;
/
