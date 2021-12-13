## Install Python Function
## Ubuntu 18.04
## removed Python2
## only one Python
## installed libraries
pip3 install vaderSentiment

clear

bin/pulsar-admin functions stop --name Chat2 --namespace default --tenant public

bin/pulsar-admin functions delete --name Chat2 --namespace default --tenant public

bin/pulsar-admin functions create --auto-ack true --py pulsar-pychat-function/src/sentiment.py --classname "sentiment.Chat" --inputs "persistent://public/default/chat2" --log-topic "persistent://public/default/chatlog2" --name Chat --namespace default --output "persistent://public/default/chatresult2" --tenant public

## Consumer Test
bin/pulsar-client consume "persistent://public/default/chatresult2" -s "chatresult2" -n 2

## Reference
echo 'https://github.com/tspannhw/pulsar-pychat-function'
