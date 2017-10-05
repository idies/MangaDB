--drop function exec_query(text, text);
create or replace function exec_query(c5table text, qstring text)  
returns interval as $$
declare 
	myquery text;
	StartTime timestamptz;
	EndTime timestamptz;
	Delta interval;
begin
	--build query
	myquery := build_query(c5table, qstring);
	
	--display query
	RAISE NOTICE '%', myquery;
	
	--execute query
	StartTime := clock_timestamp();
	perform myquery;
	EndTime := clock_timestamp();
	Delta := 1000 * (extract(epoch from EndTime) - extract(epoch from StartTime));
	
	return Delta;
	
end;
$$ language plpgsql;
