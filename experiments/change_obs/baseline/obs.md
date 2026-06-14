``` python
    x_a = 0.2 + 32 / 288
    x_b = obs[0] + 52 / 288
    if x_a < x_b:
        x_to_1st_pipe = int((x_b - x_a) * obs_mul_factor)
        y_to_1st_btm = int((obs[2] - obs[9]) * obs_mul_factor)
    else:
        x_to_1st_pipe = int(((obs[3] + 52 / 288) - x_a) * obs_mul_factor)
        y_to_1st_btm = int((obs[5] - obs[9]) * obs_mul_factor)
    player_v = int(obs[10] * obs_mul_factor)

    state.extend([x_to_1st_pipe, y_to_1st_btm, player_v])
    return tuple(state)
```