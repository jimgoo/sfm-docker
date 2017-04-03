export DOCKER_HOST=localhost:5001

## start dockerd
sudo dockerd -H unix:///var/run/docker.sock -H tcp://$DOCKER_HOST

# compose containers (long)
docker-compose up -d

# get shell in the JSON data records (data inside /sfm-data/collection_set/)
docker exec -it sfm_twitterstreamharvester_1 bash
# OR
docker-compose run --rm processing /bin/bash

# start a data processing instance
docker-compose run --rm processing /bin/bash

# count records in collection (inside above instance)
find_warcs.py 14b | xargs twitter_stream_warc_iter.py | wc -l

# VIP - this will do iteration in parallel (xargs -P nproc)
find_warcs.py 14b | xargs -P 4 twitter_stream_warc_iter.py | wc -l

# Get ElasticSearch index info
curl 'localhost:9200/_cat/indices?v'

# List some documents in ElasticSearch
curl -XGET 'localhost:9200/logstash-2017.01.12/_search?pretty=1'

#
curl -XDELETE 'localhost:9200/twitter/tweet/_query' -d '{
    "query" : { 
        "_type" : "tweet"
    }
}'


#-----------------------------
cd /sfm-data/collection_set 
#OR 
cd /mnt/raid0/sfm-data/collection_set

# then count all warcs on file
twitter_stream_warc_iter.py */*/*/*/*/*/* | wc -l


