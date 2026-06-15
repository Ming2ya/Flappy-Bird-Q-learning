#!/bin/bash

# 折扣因子 (Gamma) 自动化对比实验脚本

echo "Starting Gamma Tuning Experiments..."

# 1. GAMMA = 1.0
echo "========================================"
echo "Running Gamma = 1.0 (No Discounting)"
GAMMA=1.0 EXP_PREFIX="change_gamma/gamma_1.0" ./scripts/run_multiseed_experiments.sh

# 2. GAMMA = 0.99
echo "========================================"
echo "Running Gamma = 0.99"
GAMMA=0.99 EXP_PREFIX="change_gamma/gamma_0.99" ./scripts/run_multiseed_experiments.sh

# 3. GAMMA = 0.95
echo "========================================"
echo "Running Gamma = 0.95"
GAMMA=0.95 EXP_PREFIX="change_gamma/gamma_0.95" ./scripts/run_multiseed_experiments.sh

# 4. GAMMA = 0.9
echo "========================================"
echo "Running Gamma = 0.9"
GAMMA=0.9 EXP_PREFIX="change_gamma/gamma_0.9" ./scripts/run_multiseed_experiments.sh

# 5. GAMMA = 0.8
echo "========================================"
echo "Running Gamma = 0.8"
GAMMA=0.8 EXP_PREFIX="change_gamma/gamma_0.8" ./scripts/run_multiseed_experiments.sh

echo "========================================"
echo "All Gamma Tuning Experiments completed!"
