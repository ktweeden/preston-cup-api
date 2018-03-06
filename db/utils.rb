require "pg"

def execute_query(sql, values = [])
  result = nil
  begin
    db = PG.connect({ dbname: "preston-cup", host: "localhost" })
    db.prepare("query", sql)
    result = db.exec_prepared("query", values)
  ensure
    db.close if db != nil
  end
  result
end
