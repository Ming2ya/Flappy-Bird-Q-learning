# Flappy Bird Q-learning Final Project

本仓库是人工智能课程 Flappy Bird 强化学习大作业。项目使用表格式 Q-learning 训练智能体，围绕状态表示、学习率/探索率衰减、折扣因子和奖励函数进行了多组实验，并整理了实验报告与训练结果。

## 目录结构

```text
.
├── src/                         # 训练、评估和游戏代码
│   ├── q_learning.py             # Q-learning 主体、状态处理、reward 修改
│   ├── train_ai_or_play.py        # 命令行训练/加载模型入口
│   └── human_play.py              # 人类玩家模式
├── scripts/                      # 批量实验脚本
├── experiments/                  # 各组实验结果，含 q.pkl 与 results.txt
├── report_LaTeX/                 # 实验报告 LaTeX 源码与 report.pdf
└── Flappy Bird说明文档.pdf        # 作业说明文档
```

## 环境与运行

训练入口为 `src/train_ai_or_play.py`。代码主要依赖以下 Python 包：

- `gymnasium`
- `flappy-bird-gymnasium`
- `numpy`
- `pygame`

可使用 conda 创建环境并安装依赖：

```bash
conda create -n flappy-q python=3.12
conda activate flappy-q
pip install gymnasium flappy-bird-gymnasium numpy pygame
```

本项目实验实际使用的环境中，主要版本为 Python 3.12、`gymnasium 1.3.0`、`numpy 2.4.6`、`pygame 2.5.2`。其他兼容版本通常也可以运行。

单次训练示例：

```bash
python src/train_ai_or_play.py --train \
  --alpha 0.5 \
  --gamma 0.97 \
  --epsilon 0.2 \
  --decay-method exponential \
  --epsilon-min 0.01 \
  --exp-decay-rate 10000 \
  --alpha-decay-method count \
  --alpha-decay-power 0.4 \
  --iteration 50000 \
  --test-interval 5000 \
  --eval-episodes 100 \
  --seed 42 \
  --exp-name example_run
```

训练结果会保存到：

```text
experiments/example_run/
├── q.pkl
└── results.txt
```

加载已有模型并运行游戏：

```bash
python src/train_ai_or_play.py --exp-name example_run
```

批量实验可运行 `scripts/` 下的脚本。部分脚本中写有本机 Python 绝对路径，如需在其他机器运行，应改为对应环境路径，或将脚本中的 Python 命令替换为当前环境的 `python`。

## 主要实验说明

`experiments/` 保存了所有训练实验。每个实验目录通常包含：

- `q.pkl`：该组训练得到的 Q 表模型；
- `results.txt`：实验参数、评估曲线、最终评估平均分；
- 多种子实验一般按 `seed_42`、`seed_100`、`seed_2026` 分目录保存。

主要实验目录含义如下：

| 目录 | 内容 |
| --- | --- |
| `change_obs/` | 比较不同 `process_obs()` 状态定义，包括水平距离、竖直距离和额外状态维度。 |
| `tune_alpha_epsilon/` | 固定学习率与固定探索率的粗网格搜索。 |
| `fine_tune_alpha_epsilon/` | 在较优区域继续细调学习率与探索率。 |
| `epsilon_decay/` | 比较固定探索率、线性衰减、指数衰减、乘数衰减，并细调指数衰减参数。 |
| `change_gamma/` | 多种子比较不同折扣因子 `gamma`。 |
| `alpha_decay/` | 比较固定学习率、全局线性/指数衰减、按访问次数 count 衰减。 |
| `change_alpha/` | 早期学习率衰减扩展实验，包含不同指数衰减速度与 count 衰减指数。 |
| `change_obs_mul_factor/` | 在参数优化后重新比较状态离散化粒度 `obs_mul_factor`。 |
| `change_death_pentalty/` | 比较不同死亡惩罚强度。目录名中 `pentalty` 为早期拼写保留。 |
| `change_center_reward/` | 直接中心奖励实验，测试鼓励小鸟靠近管道中心的 reward 修改。 |
| `change_potential_center_reward/` | 基于势函数的中心奖励塑形实验。 |
| `default/` | 默认参数下的基础训练结果。 |

## 报告与主要结果

实验报告源码位于 `report_LaTeX/report.tex`，编译后的报告为：

```text
report_LaTeX/report.pdf
```

最高分模型对应实验：

```text
experiments/change_death_pentalty/100_death_penalty/seed_42/q.pkl
```

该模型最终评估平均分为 `2052.40`。
