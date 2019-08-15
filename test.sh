# docker-compose -f docker-compose-es.yml down
# sleep 2
# docker-compose -f docker-compose-es.yml up -d
# sleep 2

# curl -XGET 'http://localhost:9200/_cat/health?'
## Example: docker run gdmello/esrally:0.1 --track=geopoint --target-hosts=10.7.18.21:31018 --user-tag="test-type:baseline-geopoint-append-no-conflicts" --pipeline=benchmark-only --challenge=append-no-conflicts
# ARR_TRACK=(eventdata geopoint pmc percolator nyc_taxis geonames geopointshape metricbeat geoshape nested so noaa http_logs)
ARR_TRACK=(eventdata)
for TRACK_NAME in "${ARR_TRACK[@]}"; do
    docker run --rm --network=efk_elk -v data-volume:/tmp \
        elastic/rally --test-mode --pipeline=benchmark-only --target-hosts=efk_elasticsearch_1:9200 --track=${TRACK_NAME} --report-format=csv --report-file=/tmp/${TRACK_NAME}_log.csv
done