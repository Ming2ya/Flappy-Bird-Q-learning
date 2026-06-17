#!/bin/bash

# 学习率衰减 (Alpha Decay) 自动化对比实验脚本

echo "Starting Alpha Decay Q-learning Experiments..."

# 固定最佳基础参数
export GAMMA=0.97
export EPSILON=0.2
export DECAY_METHOD="exponential"
export EPSILON_MIN=0.01
export EXP_DECAY_RATE=10000
export ITERATION=50000

# 1. 固定学习率 = 0.1
echo "========================================"
echo "[1/7] Running Alpha = 0.1 (No Decay)"
ALPHA=0.1 ALPHA_DECAY_METHOD="none" EXP_PREFIX="change_alpha/none_0.1" ./scripts/run_multiseed_experiments.sh

# 2. 固定学习率 = 0.5
echo "========================================"
echo "[2/7] Running Alpha = 0.5 (No Decay)"
ALPHA=0.5 ALPHA_DECAY_METHOD="none" EXP_PREFIX="change_alpha/none_0.5" ./scripts/run_multiseed_experiments.sh

# 3. 线性衰减 (0.5 -> 0.01)
echo "========================================"
echo "[3/7] Running Alpha Decay: Linear (0.5 -> 0.01)"
ALPHA=0.5 ALPHA_DECAY_METHOD="linear" ALPHA_MIN=0.01 ALPHA_LINEAR_DECAY_RATE=30000 EXP_PREFIX="change_alpha/linear_decay" ./scripts/run_multiseed_experiments.sh

# 4. 指数衰减 (0.5 -> 0.01)
echo "========================================"
echo "[4/7] Running Alpha Decay: Exponential (0.5 -> 0.01)"
ALPHA=0.5 ALPHA_DECAY_METHOD="exponential" ALPHA_MIN=0.01 ALPHA_EXP_DECAY_RATE=10000 EXP_PREFIX="change_alpha/exp_decay" ./scripts/run_multiseed_experiments.sh

# 5. 局部状态动作访问计数衰减 (p = 1.0)
echo "========================================"
echo "[5/7] Running Alpha Decay: Count (p = 1.0)"
ALPHA=0.5 ALPHA_DECAY_METHOD="count" ALPHA_DECAY_POWER=1.0 EXP_PREFIX="change_alpha/count_p_1.0" ./scripts/run_multiseed_experiments.sh

# 6. 局部状态动作访问计数衰减 (p = 0.6)
echo "========================================"
echo "[6/7] Running Alpha Decay: Count (p = 0.6)"
ALPHA=0.5 ALPHA_DECAY_METHOD="count" ALPHA_DECAY_POWER=0.6 EXP_PREFIX="change_alpha/count_p_0.6" ./scripts/run_multiseed_experiments.sh

# 7. 局部状态动作访问计数衰减 (p = 0.4)
echo "========================================"
echo "[7/7] Running Alpha Decay: Count (p = 0.4)"
ALPHA=0.5 ALPHA_DECAY_METHOD="count" ALPHA_DECAY_POWER=0.4 EXP_PREFIX="change_alpha/count_p_0.4" ./scripts/run_multiseed_experiments.sh

echo "========================================"
echo "All Alpha Decay Q-learning Experiments completed!"
