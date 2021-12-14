bin/pulsar-admin topics create persistent://public/default/test_scylla

bin/pulsar-admin sinks create --tenant public --namespace default --name "sink" \
    --sink-type cassandra --sink-config-file conf/scylla.yml --inputs test_scylla
