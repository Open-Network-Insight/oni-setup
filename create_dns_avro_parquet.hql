SET hiveconf:huser;
SET hiveconf:dbname;

CREATE EXTERNAL TABLE IF NOT EXISTS ${hiveconf:dbname}.dns (
 frame_time STRING,
 unix_tstamp BIGINT,
 frame_len INT,
 ip_dst STRING,
 ip_src STRING,
 dns_qry_name STRING,
 dns_qry_class STRING,
 dns_qry_type INT,
 dns_qry_rcode INT,
 dns_a STRING  
)
PARTITIONED BY (y INT, m INT, d INT, h int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS PARQUET
LOCATION '/user/${hiveconf:huser}/dns/hive'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsRecord"
  , "namespace" : "com.cloudera.accelerators.dns.avro"
  , "fields": [
        {"name": "frame_time",                  "type":["string",   "null"]}
     ,  {"name": "unix_tstamp",                    "type":["bigint",   "null"]}
     ,  {"name": "frame_len",                    "type":["int",   "null"]}
     ,  {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "ip_src",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "dns_qry_class",             "type":["string",   "null"]}
     ,  {"name": "dns_qry_type",              "type":["int",   "null"]}
     ,  {"name": "dns_qry_rcode",             "type":["int",   "null"]}
     ,  {"name": "dns_a",                 "type":["string",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_ml_tmp (
frame_time string,
frame_len int,
ip_dst string,
dns_qry_name string,
dns_qry_class string,
dns_qry_type int,
dns_qry_rcode int,
domain              STRING,
subdomain           STRING,
subdomain_length    INT,
query_length        INT,
num_periods         INT,
subdomain_entropy   FLOAT,
top_domain          STRING,
word                STRING,
score               FLOAT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile 
LOCATION '/user/${hiveconf:huser}/dns/ml/stage'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsMachineLearningRecord"
  , "namespace" : "com.cloudera.accelerators.dnsml.avro"
  , "fields": [
        {"name": "frame_time",                  "type":["string",   "null"]}
     ,  {"name": "frame_len",                    "type":["int",   "null"]}
     ,  {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "dns_qry_class",             "type":["string",   "null"]}
     ,  {"name": "dns_qry_type",              "type":["int",   "null"]}
     ,  {"name": "dns_qry_rcode",             "type":["int",   "null"]}
     ,  {"name": "domain",                  "type":["string",   "null"]}
     ,  {"name": "subdomain",                    "type":["string",   "null"]}
     ,  {"name": "subdomain_length",                    "type":["int",   "null"]}
     ,  {"name": "query_length",                    "type":["int",   "null"]}
     ,  {"name": "num_periods",                    "type":["int",   "null"]}
     ,  {"name": "subdomain_entropy",              "type":["float",   "null"]}
     ,  {"name": "top_domain",             "type":["string",   "null"]}
     ,  {"name": "word",              "type":["string",   "null"]}
     ,  {"name": "score",             "type":["float",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_ml (
frame_time string,
frame_len int,
ip_dst string,
dns_qry_name string,
dns_qry_class string,
dns_qry_type int,
dns_qry_rcode int,
domain              STRING,
subdomain           STRING,
subdomain_length    INT,
query_length        INT,
num_periods         INT,
subdomain_entropy   FLOAT,
top_domain          STRING,
word                STRING,
score               FLOAT
)
PARTITIONED BY (y INT, m INT, d INT, h INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS PARQUET
LOCATION '/user/${hiveconf:huser}/dns/ml'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsMachineLearningRecord"
  , "namespace" : "com.cloudera.accelerators.dnsml.avro"
  , "fields": [
        {"name": "frame_time",                  "type":["string",   "null"]}
     ,  {"name": "frame_len",                    "type":["int",   "null"]}
     ,  {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "dns_qry_class",             "type":["string",   "null"]}
     ,  {"name": "dns_qry_type",              "type":["int",   "null"]}
     ,  {"name": "dns_qry_rcode",             "type":["int",   "null"]}
     ,  {"name": "domain",                  "type":["string",   "null"]}
     ,  {"name": "subdomain",                    "type":["string",   "null"]}
     ,  {"name": "subdomain_length",                    "type":["int",   "null"]}
     ,  {"name": "query_length",                    "type":["int",   "null"]}
     ,  {"name": "num_periods",                    "type":["int",   "null"]}
     ,  {"name": "subdomain_entropy",              "type":["float",   "null"]}
     ,  {"name": "top_domain",             "type":["string",   "null"]}
     ,  {"name": "word",              "type":["string",   "null"]}
     ,  {"name": "score",             "type":["float",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_susp_tmp (
frame_time string,
frame_len int,
ip_dst string,
dns_qry_name string,
dns_qry_class string,
dns_qry_type int,
dns_qry_rcode int,
domain              STRING,
subdomain           STRING,
subdomain_length    INT,
query_length        INT,
num_periods         INT,
subdomain_entropy   FLOAT,
top_domain          STRING,
word                STRING,
score               FLOAT,
query_rep           STRING,
hh                  INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile
LOCATION '/user/${hiveconf:huser}/dns/suspicious/stage'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsSuspiciousRecord"
  , "namespace" : "com.cloudera.accelerators.dnssusp.avro"
  , "fields": [
        {"name": "frame_time",                  "type":["string",   "null"]}
     ,  {"name": "frame_len",                    "type":["int",   "null"]}
     ,  {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "dns_qry_class",             "type":["string",   "null"]}
     ,  {"name": "dns_qry_type",              "type":["int",   "null"]}
     ,  {"name": "dns_qry_rcode",             "type":["int",   "null"]}
     ,  {"name": "domain",                  "type":["string",   "null"]}
     ,  {"name": "subdomain",                    "type":["string",   "null"]}
     ,  {"name": "subdomain_length",                    "type":["int",   "null"]}
     ,  {"name": "query_length",                    "type":["int",   "null"]}
     ,  {"name": "num_periods",                    "type":["int",   "null"]}
     ,  {"name": "subdomain_entropy",              "type":["float",   "null"]}
     ,  {"name": "top_domain",             "type":["string",   "null"]}
     ,  {"name": "word",              "type":["string",   "null"]}
     ,  {"name": "score",             "type":["float",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_susp (
frame_time string,
frame_len int,
ip_dst string,
dns_qry_name string,
dns_qry_class string,
dns_qry_type int,
dns_qry_rcode int,
domain              STRING,
subdomain           STRING,
subdomain_length    INT,
query_length        INT,
num_periods         INT,
subdomain_entropy   FLOAT,
top_domain          STRING,
word                STRING,
score               FLOAT,
query_rep           STRING,
hh                  INT
)
PARTITIONED BY (y INT, m INT, d INT)
CLUSTERED BY (hh) INTO 24 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS PARQUET
LOCATION '/user/${hiveconf:huser}/dns/suspicious'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsSuspiciousRecord"
  , "namespace" : "com.cloudera.accelerators.dnssusp.avro"
  , "fields": [
        {"name": "frame_time",                  "type":["string",   "null"]}
     ,  {"name": "frame_len",                    "type":["int",   "null"]}
     ,  {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "dns_qry_class",             "type":["string",   "null"]}
     ,  {"name": "dns_qry_type",              "type":["int",   "null"]}
     ,  {"name": "dns_qry_rcode",             "type":["int",   "null"]}
     ,  {"name": "domain",                  "type":["string",   "null"]}
     ,  {"name": "subdomain",                    "type":["string",   "null"]}
     ,  {"name": "subdomain_length",                    "type":["int",   "null"]}
     ,  {"name": "query_length",                    "type":["int",   "null"]}
     ,  {"name": "num_periods",                    "type":["int",   "null"]}
     ,  {"name": "subdomain_entropy",              "type":["float",   "null"]}
     ,  {"name": "top_domain",             "type":["string",   "null"]}
     ,  {"name": "word",              "type":["string",   "null"]}
     ,  {"name": "score",             "type":["float",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_scores_tmp (
ip_dst string,
dns_qry_name string,
ip_sev int,
dns_sev int,
mod_date timestamp,
mod_user string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile
LOCATION '/user/${hiveconf:huser}/dns/scores/stage'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsScoreRecord"
  , "namespace" : "com.cloudera.accelerators.dnsscore.avro"
  , "fields": [
        {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "ip_sev",             "type":["int",   "null"]}
     ,  {"name": "dns_sev",              "type":["int",   "null"]}
     ,  {"name": "mod_date",                  "type":["timestamp",   "null"]}
     ,  {"name": "mod_user",              "type":["string",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_scores (
ip_dst string,
dns_qry_name string,
ip_sev int,
dns_sev int,
mod_date timestamp,
mod_user string
)
PARTITIONED BY (y INT, m INT, d INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS PARQUET
LOCATION '/user/${hiveconf:huser}/dns/scores'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsScoreRecord"
  , "namespace" : "com.cloudera.accelerators.dnsscore.avro"
  , "fields": [
        {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "ip_sev",             "type":["int",   "null"]}
     ,  {"name": "dns_sev",              "type":["int",   "null"]}
     ,  {"name": "mod_date",                  "type":["timestamp",   "null"]}
     ,  {"name": "mod_user",              "type":["string",   "null"]}
  ]
}');


CREATE EXTERNAL TABLE ${hiveconf:dbname}.dns_comments (
ip_dst string,
dns_qry_name string,
title string,
summary string,
mod_date timestamp,
mod_user string,
y int,
m int,
d int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile
LOCATION '/user/${hiveconf:huser}/dns/comments'
TBLPROPERTIES ('avro.schema.literal'='{
    "type":   "record"
  , "name":   "DnsCommentRecord"
  , "namespace" : "com.cloudera.accelerators.dnscomment.avro"
  , "fields": [
        {"name": "ip_dst",                    "type":["string",   "null"]}
     ,  {"name": "dns_qry_name",              "type":["string",   "null"]}
     ,  {"name": "title",             "type":["string",   "null"]}
     ,  {"name": "summary",              "type":["string",   "null"]}
     ,  {"name": "mod_date",                  "type":["timestamp",   "null"]}
     ,  {"name": "mod_user",              "type":["string",   "null"]}
     ,  {"name": "y",             "type":["int",   "null"]}
     ,  {"name": "m",             "type":["int",   "null"]}
     ,  {"name": "d",             "type":["int",   "null"]}
  ]
}');


