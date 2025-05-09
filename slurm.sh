#!/bin/bash
#SBATCH --job-name=LLM
#SBATCH --partition=gpu
#SBATCH --nodelist=cf-prod-node-037
#SBATCH --gres=gpu:a100_80
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=32B_output.log
#SBATCH --error=32B_error.log

source /home/gajdomat/llama3_env/bin/activate

HF_TOKEN=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
huggingface-cli login --token $HF_TOKEN --add-to-git-credential

source vllm/bin/activate

gpustat -a --watch >> gpu_32B &
GPU_MONITOR_PID=$!

vllm serve Qwen/Qwen3-32B \
  --trust-remote-code \
  
#  --max-model-len 2048 \


kill $GPU_MONITOR_PID
