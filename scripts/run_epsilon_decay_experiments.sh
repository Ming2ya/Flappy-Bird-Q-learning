#!/bin/bash

# Epsilon 衰减实验串行执行脚本

PYTHON_BIN="/Users/mingya/program_sources/miniconda3/envs/reversi/bin/python"
ITERATION=50000
ALPHA=0.1
GAMMA=0.95
TEST_INTERVAL=5000
EVAL_EPISODES=100
EPSILON_MIN=0.01

echo "Starting Epsilon Decay Experiments..."
echo "Configuration: iteration=${ITERATION}, alpha=${ALPHA}, gamma=${GAMMA}, test_interval=${TEST_INTERVAL}, eval_episodes=${EVAL_EPISODES}"

# 1. Baseline_0.02
echo "----------------------------------------"
echo "[1/7] Running Baseline_0.02 (Epsilon=0.02, No Decay)"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.02 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method none \
  --exp-name epsilon_decay/baseline_0.02

# 2. Baseline_0.1
echo "----------------------------------------"
echo "[2/7] Running Baseline_0.1 (Epsilon=0.1, No Decay)"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.1 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method none \
  --exp-name epsilon_decay/baseline_0.1

# 3. Linear_Mid
echo "----------------------------------------"
echo "[3/7] Running Linear_Mid"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.1 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method linear \
  --epsilon-min $EPSILON_MIN --linear-decay-rate 30000 \
  --exp-name epsilon_decay/linear_mid

# 4. Exp_Fast
echo "----------------------------------------"
echo "[4/7] Running Exp_Fast (decay_rate=5000)"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.1 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method exponential \
  --epsilon-min $EPSILON_MIN --exp-decay-rate 5000 \
  --exp-name epsilon_decay/exp_fast

# 5. Exp_Slow
echo "----------------------------------------"
echo "[5/7] Running Exp_Slow (decay_rate=10000)"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.1 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method exponential \
  --epsilon-min $EPSILON_MIN --exp-decay-rate 10000 \
  --exp-name epsilon_decay/exp_slow

# 6. Mult_Fast
echo "----------------------------------------"
echo "[6/7] Running Mult_Fast (decay_rate=0.9998)"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.1 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method multiplicative \
  --epsilon-min $EPSILON_MIN --mult-decay-rate 0.9998 \
  --exp-name epsilon_decay/mult_fast

# 7. Mult_Slow
echo "----------------------------------------"
echo "[7/7] Running Mult_Slow (decay_rate=0.99992)"
$PYTHON_BIN src/train_ai_or_play.py --train \
  --alpha $ALPHA --gamma $GAMMA --epsilon 0.1 \
  --iteration $ITERATION --test-interval $TEST_INTERVAL \
  --eval-episodes $EVAL_EPISODES --decay-method multiplicative \
  --epsilon-min $EPSILON_MIN --mult-decay-rate 0.99992 \
  --exp-name epsilon_decay/mult_slow

echo "----------------------------------------"
echo "All experiments finished!"
