# ScyllaFLiPSTheStream

Scylla FLiPS The Stream With Apache Pulsar

## Create

````

  
bin/pulsar-admin sink stop --name scylla-test-sink --namespace default --tenant public

bin/pulsar-admin sinks delete --tenant public --namespace default --name scylla-test-sink

bin/pulsar-admin topics create persistent://public/default/chatresult2

bin/pulsar-admin sinks create --tenant public --namespace default --name "scylla-test-sink" --sink-type cassandra --sink-config-file conf/scylla.yml --inputs chatresult2
    
````
## HTML

* https://datatables.net/download/
* https://datatables.net/examples/api/add_row.html


## CSS/JS
````

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.11.3/b-2.1.1/b-html5-2.1.1/b-print-2.1.1/cr-1.5.5/date-1.1.1/sc-2.0.5/datatables.min.css"/>
 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.11.3/b-2.1.1/b-html5-2.1.1/b-print-2.1.1/cr-1.5.5/date-1.1.1/sc-2.0.5/datatables.min.js"></script>

````

#### Info


````
bin/pulsar-client consume "persistent://public/default/scyllacdcsource -s "cdcreader" -n 0
````

#### ScyllaDB Queries

````
docker exec -it devscylla cqlsh

use pulsar_test_keyspace;

desc pulsar_test_keyspace;

cqlsh:pulsar_test_keyspace> select col from pulsar_test_table where key like '%NiFi%' ALLOW FILTERING;

 col
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                           {"id": "(10109,17,-1,-1)", "sentiment": "Positive", "userInfo": "StreamNative Blog User 5000", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "Tim Spann, Developer Advocate @ StreamNative"}
                                                                                                                {"id": "(10109,19,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "tim@spark"}
                                                                                                                {"id": "(10109,22,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "tim@spark"}
  {"id": "(4518,1,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "We all know that Apache Pulsar along with Apache Flink, Apache Spark, Apache NiFi and Scylla DB are the best options for modern streaming data applications.", "contactInfo": "Tim Spann, Developer Advocate @ StreamNative"}
                                                                                                                {"id": "(10109,18,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "tim@spark"}
                                                                                                                {"id": "(10109,20,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "tim@spark"}
                                                                                                                           {"id": "(4518,5,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "Scylla\nApache Pulsar\nApache Flink\nApache Spark\nApache NiFi", "contactInfo": "NYC Pulsar Meetup"}
 {"id": "(4518,2,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "We all know that Apache Pulsar along with Apache Flink, Apache Spark, Apache NiFi and Scylla DB are the best options for modern streaming data applications.", "contactInfo": "Tim Spann - Developer Advocate @ StreamNative"}
                                                                                                                {"id": "(10109,21,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "tim@spark"}
  {"id": "(4518,0,-1,-1)", "sentiment": "Positive", "userInfo": "Tim Spann", "comment": "We all know that Apache Pulsar along with Apache Flink, Apache Spark, Apache NiFi and Scylla DB are the best options for modern streaming data applications.", "contactInfo": "Tim Spann, Developer Advocate @ StreamNative"}
                                                           {"id": "(10109,16,-1,-1)", "sentiment": "Positive", "userInfo": "StreamNative Blog User 5000", "comment": "Apache Spark, Apache Pulsar, Apache NiFi and Apache Flink are awesome projects.", "contactInfo": "Tim Spann, Developer Advocate @ StreamNative"}

---MORE--- 
(11 rows)
cqlsh:pulsar_test_keyspace> select col from pulsar_test_table where key like '%matrix%' ALLOW FILTERING;

 col
------------------------------------------------------------------------------------------------------------------------------
 {"id": "(10109,23,-1,-1)", "sentiment": "Neutral", "userInfo": "Tim Spann", "comment": "matrix", "contactInfo": "tim@spark"}

---MORE--- 

cqlsh:pulsar_test_keyspace> desc pulsar_test_table;

CREATE TABLE pulsar_test_keyspace.pulsar_test_table (
    key text PRIMARY KEY,
    col text
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';
CREATE INDEX pulsar_test_table_col_idx ON pulsar_test_keyspace.pulsar_test_table (col);

CREATE MATERIALIZED VIEW pulsar_test_keyspace.pulsar_test_table_col_idx_index AS
    SELECT col, idx_token, key
    FROM pulsar_test_keyspace.pulsar_test_table
    WHERE col IS NOT NULL
    PRIMARY KEY (col, idx_token, key)
    WITH CLUSTERING ORDER BY (idx_token ASC, key ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

cdc = {'postimage': 'false', 'preimage': 'false', 'ttl': '86400', 'enabled': 'true', 'delta': 'full'}

````

#### Reference
* https://github.com/scylladb/scylla-cdc-source-connector
* https://github.com/scylladb/scylla-cdc-source-connector#advanced-administration
* https://github.com/scylladb/scylla-cdc-source-connector
