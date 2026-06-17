#!/bin/bash

# 通用多种子对比实验运行基础脚本

PYTHON_BIN="/Users/mingya/program_sources/miniconda3/envs/reversi/bin/python"

# 通过环境变量获取配置，如未指定则使用默认值
ALPHA="${ALPHA:-0.1}"
GAMMA="${GAMMA:-0.95}"
EPSILON="${EPSILON:-0.2}"
ITERATION="${ITERATION:-50000}"
TEST_INTERVAL="${TEST_INTERVAL:-5000}"
EVAL_EPISODES="${EVAL_EPISODES:-100}"
DECAY_METHOD="${DECAY_METHOD:-exponential}"
EPSILON_MIN="${EPSILON_MIN:-0.01}"
EXP_DECAY_RATE="${EXP_DECAY_RATE:-10000}"
LINEAR_DECAY_RATE="${LINEAR_DECAY_RATE:-30000}"
MULT_DECAY_RATE="${MULT_DECAY_RATE:-0.9999}"
EXP_PREFIX="${EXP_PREFIX:-multiseed_experiments}"
ALPHA_DECAY_METHOD="${ALPHA_DECAY_METHOD:-none}"
ALPHA_MIN="${ALPHA_MIN:-0.01}"
ALPHA_LINEAR_DECAY_RATE="${ALPHA_LINEAR_DECAY_RATE:-30000}"
ALPHA_EXP_DECAY_RATE="${ALPHA_EXP_DECAY_RATE:-10000}"
ALPHA_DECAY_POWER="${ALPHA_DECAY_POWER:-1.0}"

# 从环境变量 SEEDS 读取种子列表，以空格分隔（默认跑 42 100 2026）
SEEDS_STR="${SEEDS:-42 100 2026}"
read -r -a SEEDS <<< "$SEEDS_STR"
total=${#SEEDS[@]}

echo "Starting Multi-seed Q-learning Experiments..."
echo "Configuration: iteration=${ITERATION}, alpha=${ALPHA}, gamma=${GAMMA}, test_interval=${TEST_INTERVAL}, eval_episodes=${EVAL_EPISODES}"
echo "Decay method: ${DECAY_METHOD}, epsilon_start=${EPSILON}, epsilon_min=${EPSILON_MIN}"
echo "Alpha Decay method: ${ALPHA_DECAY_METHOD}, alpha_start=${ALPHA}"
echo "ExpPrefix: ${EXP_PREFIX}, Seeds: ${SEEDS_STR}"

for i in "${!SEEDS[@]}"; do
  seed=${SEEDS[$i]}
  current=$((i + 1))
  exp_name="${EXP_PREFIX}/seed_${seed}"
  
  echo "----------------------------------------"
  echo "[$current/$total] Running with seed ${seed}..."
  $PYTHON_BIN src/train_ai_or_play.py --train \
    --alpha $ALPHA --gamma $GAMMA --epsilon $EPSILON \
    --iteration $ITERATION --test-interval $TEST_INTERVAL \
    --eval-episodes $EVAL_EPISODES --decay-method $DECAY_METHOD \
    --epsilon-min $EPSILON_MIN --exp-decay-rate $EXP_DECAY_RATE \
    --linear-decay-rate $LINEAR_DECAY_RATE --mult-decay-rate $MULT_DECAY_RATE \
    --alpha-decay-method "$ALPHA_DECAY_METHOD" --alpha-min "$ALPHA_MIN" \
    --alpha-linear-decay-rate "$ALPHA_LINEAR_DECAY_RATE" \
    --alpha-exp-decay-rate "$ALPHA_EXP_DECAY_RATE" \
    --alpha-decay-power "$ALPHA_DECAY_POWER" \
    --seed $seed --exp-name $exp_name
done

echo "----------------------------------------"
echo "All multi-seed experiments in this group completed!"
