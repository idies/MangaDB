--drop function exec_query(interval);
create or replace function exec_query(c5table text, qstring text, qname text, run int, comment text)  
returns void
as $$
--returns interval as $$
declare 
	myquery text;
	StartTime timestamptz;
	EndTime timestamptz;
	Delta interval;
begin
	
	CREATE TEMPORARY TABLE t1
	(
		qname text,
		qtext text,
		tablename text,
		run int,
		starttime timestamptz,
		endtime timestamptz,
		delta INTERVAL,
		comment text
	) 
	ON COMMIT DELETE ROWS;
	
	--build query
	myquery := build_query(c5table, qstring);
	
	--display query
	RAISE NOTICE '%', myquery;
	
	--execute query
	StartTime := clock_timestamp();
	perform myquery;
	EndTime := clock_timestamp();
	Delta := 1000 * (extract(epoch from EndTime) - extract(epoch from StartTime));
	
	INSERT INTO t1 (qname, qtext, tablename, run, starttime, endttime, delta, comment )
	VALUES (qname, myquery, c5table, run, StartTime, EndTime, Delta, comment);
	
	INSERT INTO performance.queryresults
	SELECT * FROM t1;
	
	
	
	
end;
$$ language plpgsql;
