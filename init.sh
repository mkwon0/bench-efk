#!/bin/bash

# docker stop $(docker ps -aq) && docker rm $(docker ps -aq) # && docker system prune --all -f
# docker-compose up -d
# while true; do docker ps -a; sleep 5; done

#**** Old method (NOT WORK!!!)
# yum install -y jq
# docker exec efk_elasticsearch_1 bash -c "elasticsearch-plugin install analysis-icu"
# docker exec efk_elasticsearch_1 bash -c "elasticsearch-plugin install org.wikimedia.search:extra:6.3.1.2"

#**** Data preparation
#**** URL: https://dumps.wikimedia.org/enwiki/20190801/
# cd dataset/wikipedia && wget https://dumps.wikimedia.org/enwiki/20190801/enwiki-20190801-pages-articles1.xml-p10p30302.bz2 && cd -
# bunzip2 -d dataset/wikipedia/enwiki-20190801-pages-articles1.xml-p10p30302.bz2

#**** Revised method
#**** --> passing stdin to the container
#**** Test: echo "echo Hello world" | docker exec -i efk_logstash_1 /bin/bash -
# bunzip2 -c dataset/wikipedia/enwiki-20190801-pages-articles1.xml-p10p30302.bz2 | docker attach efk_logstash_1
# docker exec efk_logstash_1 bash -c "./bin/logstash -f /etc/logstash/conf.d/logstash.conf"
# docker exec -i efk_logstash_1 /bin/bash < dataset/wikipedia/enwiki-20190801-pages-articles1.xml-p10p30302
# nc localhost 5000 < dataset/wikipedia/enwiki-20190801-pages-articles1.xml-p10p30302
# docker exec -u 0 -it efk_logstash_1 bash
# docker exec efk_logstash_1 /bin/bash -c "bunzip2 -c dataset/wikipedia/enwiki-20190801-pages-articles1.xml-p10p30302.bz2 | bin/logstash -f /etc/logstash/conf.d/logstash.conf"

# bunzip2 -c dataset/wikipedia/enwiki-20190801-pages-articles1.xml-p10p30302.bz2 | nc localhost 4560

#**** Elasticsearch command
#**** Example
#**** curl -XGET 'localhost:9200'
#**** curl -XGET 'localhost:9200/_cat/indices?v'
#**** curl -XDELETE 'localhost:9200/test_index?pretty'

# PORT=9200
# curl -X GET 'http://localhost:'${PORT}'/_cat/indices?v'
# echo
# ## list all docs in index
# curl -X GET 'http://localhost:'${PORT}'/rd0/_search'
# echo11
# ## query using URL parameters
# curl -X GET 'http://localhost:'${PORT}'/rd0/_search?q=foo'
# echo