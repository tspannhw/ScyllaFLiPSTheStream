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

#### Reference
* https://github.com/scylladb/scylla-cdc-source-connector
* https://github.com/scylladb/scylla-cdc-source-connector#advanced-administration
* https://github.com/scylladb/scylla-cdc-source-connector
