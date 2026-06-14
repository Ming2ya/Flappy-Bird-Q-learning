#!/usr/bin/env bash
set -euo pipefail

# Alpha/epsilon grid for the baseline observation design.
# Override these from the shell if you want a smaller or larger sweep:
#   ALPHAS="0.1 0.2" EPSILONS="0.02 0.05" ./run_alpha_epsilon_experiments.sh

CONDA_ENV="${CONDA_ENV:-reversi}"
EXP_PREFIX="${EXP_PREFIX:-tune_alpha_epsilon}"
ITERATION="${ITERATION:-50000}"
GAMMA="${GAMMA:-0.95}"
TEST_INTERVAL="${TEST_INTERVAL:-5000}"
EVAL_EPISODES="${EVAL_EPISODES:-100}"

read -r -a ALPHA_VALUES <<< "${ALPHAS:-0.1 0.2 0.3 0.5 0.7}"
read -r -a EPSILON_VALUES <<< "${EPSILONS:-0.0 0.02 0.05 0.1}"

total=$(( ${#ALPHA_VALUES[@]} * ${#EPSILON_VALUES[@]} ))
current=0

echo "Running ${total} alpha/epsilon experiments"
echo "env=${CONDA_ENV}, iteration=${ITERATION}, gamma=${GAMMA}, test_interval=${TEST_INTERVAL}, eval_episodes=${EVAL_EPISODES}"

for alpha in "${ALPHA_VALUES[@]}"; do
  for epsilon in "${EPSILON_VALUES[@]}"; do
    current=$((current + 1))
    exp_name="${EXP_PREFIX}/alpha_${alpha}_epsilon_${epsilon}"

    echo
    echo "[$current/$total] ${exp_name}"
    conda run --no-capture-output -n "${CONDA_ENV}" \
      python src/train_ai_or_play.py \
        --train \
        --alpha "${alpha}" \
        --gamma "${GAMMA}" \
        --epsilon "${epsilon}" \
        --iteration "${ITERATION}" \
        --test-interval "${TEST_INTERVAL}" \
        --eval-episodes "${EVAL_EPISODES}" \
        --exp-name "${exp_name}"
  done
done

echo
echo "Done. Results are under experiments/${EXP_PREFIX}/"
