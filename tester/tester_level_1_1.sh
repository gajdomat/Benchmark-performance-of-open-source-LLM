#!/bin/bash

con=(1 4 16 32 64 128)

for concurenc in "${con[@]}" ; do 
  echo "Testing $concurenc"

  genai-perf profile \
    -m meta-llama/Llama-3.1-8B-Instruct \
    --measurement-interval  10000 \
    --stability-percentage 95 \
    --service-kind openai \
    --synthetic-input-tokens-mean 100 \
    --synthetic-input-tokens-stddev 4 \
    --output-tokens-mean 200 \
    --output-tokens-stddev 4 \
    --endpoint-type completions \
    --streaming \
    --url http://10.38.7.167:8000 \
    --concurrency "$concurenc"
done
