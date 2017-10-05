create or replace function build_query(c5table text, qstring text)
returns text as $$
declare myquery text;
begin
	myquery := replace(qstring, 'C5TABLE', c5table);
	return myquery;
end;
$$ LANGUAGE plpgsql;


