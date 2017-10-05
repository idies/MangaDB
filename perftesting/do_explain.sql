drop function do_explain(text);
create or replace function do_explain(myquery text) returns table(explain_line text)
as $$
declare
	myquery2 text;
	explain_text text;
	explain_xml xml;
	
begin
	myquery2 := 'EXPLAIN ' || myquery;
	--execute myquery2 into explain_xml;
	return query execute myquery2;
	--raise notice '%', explain_text;
	--explain_text := execute 'EXPLAIN ' || myquery;
	--return explain_xml;
end;
$$ language plpgsql;
