#!/bin/bash
echo "remove netvis stuff"
rm "./data/meta/netvis-config.xml"

echo "add ids"
add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/maechtekongresse/editions"
add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at/maechtekongresse/meta"

echo "denormalize indices"
denormalize-indices -f "./data/*/*.xml" -i "./data/indices/*.xml" -m ".//*[@ref]/@ref" -x ".//tei:title[@type='main']/text()"

echo "remove notegroups from edition files"
python rm_notegrp.py

echo "building calendar"
python make_calendar_data.py

echo "build search index"
python make_ts_index.py