kcat -b ${BOOTSTRAP_SERVER}:9092 -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN -X sasl.username=${API_KEY} -X sasl.password=${API_SECRET} -X api.version.request=true -t imply-news -C -c 10000 >imply-news.sample.json
perl -pe 's/(\"timestamp\":\s+\d+)\.\d+/${1}000/' imply-news.sample.json >imply-news.sample-int.json
