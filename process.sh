#!/bin/bash
echo "remove netvis stuff"
rm "./data/meta/netvis-config.xml"

echo "add ids"
uv run add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/maechtekongresse/editions"
uv run add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at/maechtekongresse/meta"

echo "denormalize indices"
uv run denormalize-indices -f "./data/*/*.xml" -i "./data/indices/*.xml" -m ".//*[@ref]/@ref" -x ".//tei:title[@type='main']/text()"

echo "remove notegroups from edition files"
uv run rm_notegrp.py

echo "building calendar"
uv run make_calendar_data.py