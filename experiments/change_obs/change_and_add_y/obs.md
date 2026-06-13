``` python
y_to_1st_btm = int((obs[5] - obs[9] - 24 / 512) * obs_mul_factor)
y_to_1st_top = int((obs[9] - obs[1]) * obs_mul_factor)
```
改为小鸟底端到管子底端的距离,添加小鸟顶端到管子顶端的距离