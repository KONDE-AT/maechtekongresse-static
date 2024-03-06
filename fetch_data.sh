# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/editions && mkdir data/editions
rm -rf data/indices && mkdir data/indices
rm -rf data/meta && mkdir data/meta
curl -LO https://github.com/KONDE-AT/maechtekongresse/archive/refs/heads/master.zip
unzip master

mv ./maechtekongresse-master/data/editions/ ./data
mv ./maechtekongresse-master/data/indices/ ./data
mv ./maechtekongresse-master/data/meta/ ./data

rm master.zip
rm -rf ./maechtekongresse-master
