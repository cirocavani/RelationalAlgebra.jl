#!/usr/bin/env bash
set -eu

cd $(dirname "$0")

for i in *.ipynb; do
    echo "Running $i..."
    jupyter nbconvert "$i" --to notebook --inplace --execute --ExecutePreprocessor.timeout=21600
done
