Q: 是否观测量的正负对q-learing没影响？
A: state 只用于索引Q表，理论上来说正负没有影响

Q:  File "/Users/mingya/Documents/Artifitial_Intelligence/Final project/Flappy Bird/src/q_learning.py", line 63, in get_q_value
    if (state, action) in self.q:
       ^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: unhashable type: 'list'
A: Python 字典（`dict`）的键必须是**可哈希的（hashable）**。列表（`list`）是可变对象，属于不可哈希类型；而元组（`tuple`）只有在所有元素都可哈希时才可哈希。因为 `state` 是列表，导致复合键 `(state, action)` 无法被哈希，从而引发 `TypeError`。

Q:  File "/Users/mingya/Documents/Artifitial_Intelligence/Final project/Flappy Bird/src/q_learning.py", line 144, in choose_action
    return GameAI.available_actions(state)[random.randint(0, 1)]
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^
TypeError: 'set' object is not subscriptable
A: available_actions 返回的是一个集合（set，如 {0, 1}）。集合在 Python 中是不支持下标索引的。

Q: 关于训练结果的强随机性
A: 