from gymnasium.spaces import multi_discrete
from q_learning import train, play, GameAI, evaluate
import datetime
import argparse
import time
import os
import sys
import random
import numpy as np

parser = argparse.ArgumentParser(description="Flappy Bird")
parser.add_argument("--train", action=argparse.BooleanOptionalAction, default=False,
                    help='Enable or disable the training process, use --no-train to disable it')
parser.add_argument("--alpha", type=float, default=0.7, help="Learning rate alpha")
parser.add_argument("--gamma", type=float, default=0.95, help="Discount factor gamma")
parser.add_argument("--epsilon", type=float, default=0.0, help="Exploration probability epsilon")
parser.add_argument("--iteration", type=int, default=50000, help="Number of training episodes")
parser.add_argument("--exp-name", type=str, default="default_exp", help="Experiment directory name")
parser.add_argument("--test-interval", type=int, default=5000, help="Evaluate every N episodes during training")
parser.add_argument("--eval-episodes", type=int, default=100, help="Number of episodes per evaluation")
parser.add_argument("--decay-method", type=str, choices=["none", "linear", "exponential", "multiplicative"],
                    default="none", help="Exploration decay method")
parser.add_argument("--epsilon-min", type=float, default=0.01, help="Minimum epsilon for decay")
parser.add_argument("--linear-decay-rate", type=float, default=30000.0,
                    help="Number of episodes to decay epsilon linearly to epsilon-min")
parser.add_argument("--exp-decay-rate", type=float, default=10000.0,
                    help="Time constant for exponential decay")
parser.add_argument("--mult-decay-rate", type=float, default=0.9999,
                    help="Multiplicative factor for decay per episode")

args = parser.parse_args()

exp_dir = os.path.join("experiments", args.exp_name)
path_q = os.path.join(exp_dir, "q.pkl")
path_results = os.path.join(exp_dir, "results.txt")

if args.train:
    # 设置随机种子
    random.seed(42)
    np.random.seed(42)
    # 自动创建实验文件夹
    os.makedirs(exp_dir, exist_ok=True)
    
    now_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    # 格式化写入实验参数头信息
    header = (
        "========================================\n"
        f"实验时间: {now_time}\n"
        f"实验名称: {args.exp_name}\n"
        "参数配置:\n"
        f"  学习率 (alpha): {args.alpha}\n"
        f"  折扣因子 (gamma): {args.gamma}\n"
        f"  探索率 (epsilon): {args.epsilon}\n"
        f"  探索率衰减方式 (decay-method): {args.decay_method}\n"
        f"  最小探索率 (epsilon-min): {args.epsilon_min}\n"
        f"  线性衰减局数 (linear-decay-rate): {args.linear_decay_rate}\n"
        f"  指数衰减时间常数 (exp-decay-rate): {args.exp_decay_rate}\n"
        f"  乘数衰减系数 (mult-decay-rate): {args.mult_decay_rate}\n"
        f"  总训练局数 (iteration): {args.iteration}\n"
        f"  测试间隔轮数 (test-interval): {args.test_interval}\n"
        f"  每次评估局数 (eval-episodes): {args.eval_episodes}\n"
        "----------------------------------------\n"
    )
    with open(path_results, "a", encoding="utf-8") as f:
        f.write(header)
        
    start_time = time.time()
    ai = train(
        iteration=args.iteration, 
        alpha=args.alpha, 
        gamma=args.gamma, 
        epsilon=args.epsilon, 
        test_interval=args.test_interval, 
        results_txt_path=path_results,
        eval_episodes=args.eval_episodes,
        decay_method=args.decay_method,
        epsilon_min=args.epsilon_min,
        linear_decay_rate=args.linear_decay_rate,
        exp_decay_rate=args.exp_decay_rate,
        mult_decay_rate=args.mult_decay_rate
    )
    interval = int(time.time() - start_time)  # Get elapsed time in seconds
    minute = interval // 60
    second = interval % 60
    duration_str = f"Training time: {minute} min and {second} sec"
    print(duration_str)
    
    # 最终模型保存
    ai.save_q(path_q)
    print(f"Model saved to: {path_q}")
    
    # 最终测试得分评估
    final_score = evaluate(ai, episodes=args.eval_episodes)
    print(f"Final evaluation score: {final_score:.2f}")
    
    footer = (
        "----------------------------------------\n"
        f"训练耗时: {minute} 分 {second} 秒\n"
        f"最终评估平均得分 ({args.eval_episodes}局): {final_score:.2f}\n"
        "========================================\n\n"
    )
    with open(path_results, "a", encoding="utf-8") as f:
        f.write(footer)

else:
    if not os.path.exists(path_q):
        print(f"Error: 无法找到实验模型文件 {path_q}。请先使用 --train 训练该实验，或确认实验名称是否正确。", file=sys.stderr)
        sys.exit(1)
        
    ai = GameAI()
    print(f"Loading Q-table from {path_q}...")
    ai.load_q(path_q)
    play(ai, render_mode=None, use_lidar=False)
