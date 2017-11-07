--drop schema performance;
create schema if not exists performance;

CREATE table if not exists performance.QueryRun
(
    QueryRunID SERIAL PRIMARY KEY NOT NULL,
    QueryTestID INT,
    run INT,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    Delta INTERVAL
);

CREATE TABLE if not exists performance.QueryTest
(
  QueryTestID serial primary key not null,
  name varchar(50),
  queryText text,
  PlanID int,
  Type text,
  comment text,
  nRuns int,
  TestStart timestamp,
  TestEnd timestamp,
  status text
);

CREATE TABLE if not exists performance.QueryPlans
(
  PlanID int not null,
  PlanLine int,
  LineText text
);

create table if not exists performance.BaseQuery
(
  basequeryid int not null,
  basequeryname text,
  basequerytext text,
  baseTableName text,
  testTableCode text
);

create table if not exists performance.TestTables
(
  testTableID int not null,
  testTableName text,
  testTableCode text

)