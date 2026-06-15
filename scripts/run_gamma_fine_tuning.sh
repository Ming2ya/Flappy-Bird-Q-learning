#!/bin/bash

# 折扣因子 (Gamma) [0.95, 0.99] 精细化调优实验脚本

echo "Starting Gamma Fine-Tuning Experiments..."

# 1. GAMMA = 0.96
echo "========================================"
echo "Running Gamma = 0.96"
GAMMA=0.96 EXP_PREFIX="change_gamma/gamma_0.96" ./scripts/run_multiseed_experiments.sh

# 2. GAMMA = 0.97
echo "========================================"
echo "Running Gamma = 0.97"
GAMMA=0.97 EXP_PREFIX="change_gamma/gamma_0.97" ./scripts/run_multiseed_experiments.sh

# 3. GAMMA = 0.98
echo "========================================"
echo "Running Gamma = 0.98"
GAMMA=0.98 EXP_PREFIX="change_gamma/gamma_0.98" ./scripts/run_multiseed_experiments.sh

echo "========================================"
echo "All Gamma Fine-Tuning Experiments completed!"
