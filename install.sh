## Install Python Function
## Ubuntu 18.04
## removed Python2
## only one Python
## installed libraries
pip3 install vaderSentiment
pip3 install scylla-driver
pip3 install textblob
pip3 install spacy
pip3 install nltk
python3 -m nltk.downloader popular
python3 -m spacy download en_core_web_sm

## Run notebook
# Http tunnel to jupyter-notebook running on pulsar1
# ssh -L 8888:localhost:8888 tspann@pulsar1

clear

bin/pulsar-admin functions list  --namespace default --tenant public

bin/pulsar-admin functions stop --name Chat2 --namespace default --tenant public

bin/pulsar-admin functions delete --name Chat2 --namespace default --tenant public

bin/pulsar-admin functions create --auto-ack true --py pulsar-pychat-function/src/sentiment.py --classname "sentiment.Chat" --inputs "persistent://public/default/chat2" --log-topic "persistent://public/default/chatlog2" --name Chat --namespace default --output "persistent://public/default/chatresult2" --tenant public

## Consumer Test
bin/pulsar-client consume "persistent://public/default/chatresult2" -s "chatresult2" -n 2

## Reference
echo 'https://github.com/tspannhw/pulsar-pychat-function'
echo 'https://github.com/tspannhw/FLiP-Meetup-Chat'

