bin/pulsar-admin topics create persistent://public/default/test_scylla
bin/pulsar-admin topics create persistent://public/default/chat2
bin/pulsar-admin topics create persistent://public/default/chatresult2

bin/pulsar-admin sinks create --tenant public --namespace default --name "sink" \
    --sink-type cassandra --sink-config-file conf/scylla.yml --inputs chatresult2

bin/pulsar-admin topics create persistent://public/default/iotjetsonjson
bin/pulsar-client consume "persistent://public/default/iotjetsonjson" -s "iotjjreader" -n 0

bin/pulsar-admin topics create persistent://public/default/energy
bin/pulsar-client consume "persistent://public/default/energy" -s "mobile2" -n 0

# query data
select from_utf8(__value__), __event_time__ from pulsar."public/default".chatresult2
