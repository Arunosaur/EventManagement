create or replace function em_code.available_id(i_tab dbms_tf.table_t)
return varchar2 sql_macro
   /*
   ||---------------------------------------------------------------------------
   || NAME                : available_id
   || CREATED BY          : Arun S. Rajagopalan
   || CREATE DATE         : Jan, 22nd 2023
   || DESCRIPTION         : Get the available id for the table provided, it 
   ||                       could be max + 1 or the minimum of missing value.
   ||---------------------------------------------------------------------------
   ||             C H A N G E   L O G
   ||---------------------------------------------------------------------------
   || Date       || USERID     || Changes
   ||---------------------------------------------------------------------------
   || 2023/01/22 || asrajag   || Original
   ||---------------------------------------------------------------------------
   */
is
begin
   return q'{with
                max_id as
                   (select nvl(max(id), 0) mid
                    from   i_tab
                   ),
                row_id_gen as
                   (select level gid
                    from  dual d
                    connect by rownum <= (select mid
                                          from   max_id
                                         )
                   ),
                missing_id as
                   (select min(g.gid) mgid
                    from   row_id_gen g
                    left outer join
                           i_tab      s
                    on     s.id = g.gid
                    where s.id is null
                   )
                select nvl(max(mgid), max(gid) + 1) cid
                from   row_id_gen g
                left outer join
                       missing_id m
                on     m.mgid = g.gid
           }';

end available_id;
/
