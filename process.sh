#!/bin/bash

echo "building calendar"
python make_calendar_data.py

echo "build search index"
python make_ts_index.py