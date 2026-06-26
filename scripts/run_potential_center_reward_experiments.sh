#!/bin/bash

# Potential-based center shaping smoke/grid test.
# Override COEFS, SEEDS, ITERATION, or EXP_PREFIX from the shell if needed.

COEFS="${COEFS:-0 0.005 0.008 0.01 0.02}"

for coef in $COEFS; do
  name=${coef/./_}
  EXP_PREFIX="${EXP_PREFIX:-change_potential_center_reward}/coef_${name}" \
  ALPHA="${ALPHA:-0.5}" \
  GAMMA="${GAMMA:-0.97}" \
  EPSILON="${EPSILON:-0.2}" \
  ITERATION="${ITERATION:-100000}" \
  TEST_INTERVAL="${TEST_INTERVAL:-10000}" \
  EVAL_EPISODES="${EVAL_EPISODES:-100}" \
  DECAY_METHOD="${DECAY_METHOD:-exponential}" \
  EPSILON_MIN="${EPSILON_MIN:-0.01}" \
  EXP_DECAY_RATE="${EXP_DECAY_RATE:-30000}" \
  ALPHA_DECAY_METHOD="${ALPHA_DECAY_METHOD:-count}" \
  ALPHA_DECAY_POWER="${ALPHA_DECAY_POWER:-0.4}" \
  CENTER_REWARD_COEF="$coef" \
  CENTER_REWARD_X_WINDOW="${CENTER_REWARD_X_WINDOW:-0.6}" \
  CENTER_REWARD_MODE="potential" \
  bash scripts/run_multiseed_experiments.sh
done
