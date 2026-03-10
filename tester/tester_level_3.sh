#!/bin/bash

con=(1 4 16 32 64 128)
a=(20000 20000 30000 30000 40000)


for i in "${!con[@]}" ; do
  concurenc=${con[$i]}
  interval=${a[$i]}
  
  echo "Testing concurrency=$concurenc, interval=$interval"

  genai-perf profile \
    -m meta-llama/Llama-3.1-8B-Instruct \
    --stability-percentage 95 \
    --measurement-interval "$interval" \
    --service-kind openai \
    --synthetic-input-tokens-mean 1000 \
    --synthetic-input-tokens-stddev 0 \
    --output-tokens-mean 1000 \
    --output-tokens-stddev 0 \
    --endpoint-type completions \
    --streaming \
    --url http://10.38.7.167:8000 \
    --generate-plots \
    --concurrency "$concurenc"
done
