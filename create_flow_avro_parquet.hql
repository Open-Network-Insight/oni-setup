SET hiveconf:huser;
SET hiveconf:dbname;

CREATE EXTERNAL TABLE IF NOT EXISTS ${hiveconf:dbname}.flow (
  treceived STRING,
  unix_tstamp BIGINT,
  tryear INT,
  trmonth INT,
  trday INT,
  trhour INT,
  trminute INT,
  trsec INT,
  tdur FLOAT,
  sip  STRING,
 dip STRING,
 sport INT,
  dport INT,
  proto STRING,
  flag STRING,
  fwd INT,
  stos INT,
  ipkt BIGINT,
  ibyt BIGINT,
  opkt BIGINT,
  obyt BIGINT,
  input INT,
  output INT,
  sas INT,
  das INT,
  dtos INT,
  dir INT,
  rip STRING
  )
PARTITIONED BY (y INT, m INT, d INT, h int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS PARQUET
LOCATION '${hiveconf:huser}/flow/hive'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "FlowRecord"
  , "namespace" : "com.cloudera.accelerators.flows.avro"
  , "fields": [
        {"name": "treceived",                  "type":["string",   "null"]}
     ,  {"name": "unix_tstamp",                 "type":["long",     "null"]}
     ,  {"name": "tryear",                    "type":["float",   "null"]}
     ,  {"name": "trmonth",                    "type":["float",   "null"]}
     ,  {"name": "trday",                    "type":["float",   "null"]}
     ,  {"name": "trhour",                    "type":["float",   "null"]}
     ,  {"name": "trminute",                    "type":["float",   "null"]}
     ,  {"name": "trsec",                    "type":["float",   "null"]}
     ,  {"name": "tdur",                    "type":["float",   "null"]}
     ,  {"name": "sip",              "type":["string",   "null"]}
     ,  {"name": "sport",                 "type":["int",   "null"]}
     ,  {"name": "dip",         "type":["string",   "null"]}
     ,  {"name": "dport",        "type":["int",   "null"]}
     ,  {"name": "proto",            "type":["string",   "null"]}
     ,  {"name": "flag",            "type":["string",   "null"]}
     ,  {"name": "fwd",                 "type":["int",   "null"]}
     ,  {"name": "stos",                 "type":["int",   "null"]}
     ,  {"name": "ipkt",                 "type":["bigint",   "null"]}
     ,  {"name": "ibytt",                 "type":["bigint",   "null"]}
     ,  {"name": "opkt",                 "type":["bigint",   "null"]}
     ,  {"name": "obyt",                 "type":["bigint",   "null"]}
     ,  {"name": "input",                 "type":["int",   "null"]}
     ,  {"name": "output",                 "type":["int",   "null"]}
     ,  {"name": "sas",                 "type":["int",   "null"]}
     ,  {"name": "das",                 "type":["int",   "null"]}
     ,  {"name": "dtos",                 "type":["int",   "null"]}
     ,  {"name": "dir",                 "type":["int",   "null"]}
     ,  {"name": "rip",                    "type":["string",   "null"]}
  ]
}');

CREATE EXTERNAL TABLE IF NOT EXISTS ${hiveconf:dbname}.flow_sum (
flow_date             STRING,
flows                 BIGINT,
bytes                 BIGINT,
packets               BIGINT,
avg_bps               BIGINT,
avg_pps               INT,
avg_bpp               INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS PARQUET
LOCATION '${hiveconf:huser}/flow/summary'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "RawFlowSummaryRecord"
  , "namespace" : "com.cloudera.accelerators.flow_sum.avro"
  , "fields": [
        {"name": "flow_date",   "type":["string", "null"]}
     ,  {"name": "flows",       "type":["bigint", "null"]}
     ,  {"name": "bytes",       "type":["bigint", "null"]}
     ,  {"name": "packets",     "type":["bigint", "null"]}
     ,  {"name": "avg_bps",     "type":["bigint", "null"]}
     ,  {"name": "avg_pps",     "type":["int", "null"]}
     ,  {"name": "avg_bpp",     "type":["int", "null"]}
  ]
}');

