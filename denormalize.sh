#!/bin/bash

echo "add ids"
add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/maechtekongresse/editions"

echo "denormalize indices"
denormalize-indices -f "./data/editions/*.xml" -i "./data/indices/*.xml" -m ".//*[@ref]/@ref" -x ".//tei:title[@type='main']/text()"

python rm_notegrp.py