bin/pulsar-admin topics create persistent://public/default/test_scylla
bin/pulsar-admin topics create persistent://public/default/chat2
bin/pulsar-admin topics create persistent://public/default/chatresult2

bin/pulsar-admin sinks create --tenant public --namespace default --name "scylla-test-sink" \
    --sink-type cassandra --sink-config-file conf/scylla.yml --inputs chatresult2

bin/pulsar-admin topics create persistent://public/default/iotjetsonjson
bin/pulsar-client consume "persistent://public/default/iotjetsonjson" -s "iotjjreader" -n 0

bin/pulsar-admin topics create persistent://public/default/energy
bin/pulsar-client consume "persistent://public/default/energy" -s "mobile2" -n 0

# create table from scylla cqlsh
CREATE KEYSPACE pulsar_test_keyspace WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
CREATE TABLE pulsar_test_table (key text PRIMARY KEY, col text) with cdc = {'enabled': true};
CREATE INDEX ON pulsar_test_table(col);
 
alter table pulsar_test_keyspace.pulsar_test_table with cdc={'enabled': true};
desc keyspace pulsar_test_keyspace;

# query data - pulsar sql
select from_utf8(__value__), __event_time__ from pulsar."public/default".chatresult2

# query data - scylla
select col from pulsar_test_table where key like '%Pulsar%' ALLOW FILTERING;
