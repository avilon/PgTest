/**
 * \descr Возвращает таблицу учащихся, пройденных ими тестов и потерянных (несданых) листов с заданиями
 * \author Bykov A.
 * \version 1.0
 */
create or replace function get_missing_pages (
        _test_id int default null
)

returns table (
    student_id        int,
    test_id           int,
    version_name      char,
    lost_page_indices text
)

as $$
declare
  rec record;

  rc_out_data cursor for  
  with put_pages as
  (     --- Тесты, учащиеся, которые их сдавали и количество сданых страниц
        select v.id            as version_id
              ,v.test_id       as test_id
              ,v.name          as version_name
              ,sp.student_id   as student_id
              ,count(*)        as cnt_put
          from versions v
              ,pages p
              ,student_pages sp
         where 1 = 1
           and p.version_id = v.id
           and sp.page_id = p.id
        group by v.id
                ,v.test_id
                ,v.name
                ,sp.student_id
  ), tot_pages as (
        --- Общее количество страниц в тесте  
        select v.id        as version_id
              ,v.test_id   as test_id
              ,v.name      as test_name
              ,count(*)    as cnt_tot
          from versions v
              ,pages    p
         where 1 = 1
           and p.version_id = v.id
         group by v.id
                 ,v.test_id
                 ,v.name
  )
  select pp.version_id
        ,pp.test_id
        ,pp.version_name
        ,pp.student_id
        ,pp.cnt_put
        ,tt.cnt_tot
        ,case
           when pp.cnt_put <> tt.cnt_tot then
              --- Построение списка потерянных листов
			  --- TODO: вынести в отдельную функцию (?)
              (select array_to_string(ARRAY(
                              select p.index
                                from versions v
                                    ,pages    p
                               where 1 = 1
                                 and p.version_id = v.id
                                 and v.id = pp.version_id
                                 and p.id not in (
                                      select px.id
                                        from pages         px
                                            ,student_pages spx
                                       where 1 = 1
                                         and spx.page_id = px.id
                                         and px.version_id = v.id
                                         and spx.student_id = pp.student_id
                                 )
                          ), ',')
              )
           ---------
           else ''
         end as lst
    from put_pages pp
        ,tot_pages tt
   where 1 = 1
     and tt.version_id = pp.version_id
     and tt.test_id = pp.test_id
     and ( pp.test_id = _test_id or _test_id is null )
   order by pp.student_id
           ,pp.test_id;
begin
  for rec in rc_out_data loop
    if length(rec.lst) >  0 then
      student_id := rec.student_id;
      test_id    := rec.test_id;
      version_name := rec.version_name;
      lost_page_indices := rec.lst;
      return next;
    end if;
  end loop;

end;
$$
language 'plpgsql' volatile


/*

-- Тестовые хзапуски
select * from get_missing_pages(1) t;
select * from get_missing_pages() t;

*/
