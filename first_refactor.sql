  /*
   * Первый вариант, который прошел тесты
   * 
   */
  with put_pages as
  (
        select v.id            as version_id
              ,v.test_id       as test_id
              ,v.name          as version_name
              ,sp.student_id   as student_id
              ,count(*)        as cnt
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
  )
  select pp.version_id
        ,pp.test_id
        ,pp.version_name
        ,pp.student_id
        ,(select array_to_string(ARRAY(
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
          ), ',')) as lst
    from put_pages pp
   where 1 = 1
     and (pp.test_id = _test_id or _test_id is null)
   order by pp.student_id
           ,pp.test_id;
