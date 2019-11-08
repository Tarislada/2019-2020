import numpy as np
import matplotlib.pyplot as plt

onCS_shock = .8
offCS_shock = .4
sali_CS = .5
sali_bck = .1
rate_CS = .1
rate_bck = .05
trial_n = 100
learn_rate = .3
Vx_curr = np.zeros(trial_n)
Vcs_curr = np.zeros(trial_n)
Vbck_curr = np.zeros(trial_n)

V_CS = onCS_shock*rate_CS / (onCS_shock*rate_CS - (1-onCS_shock)*rate_bck)
V_bck = offCS_shock*rate_CS / (offCS_shock*rate_CS - (1-offCS_shock)*rate_bck)

for t in range(trial_n-1):
    dVcs = sali_CS * learn_rate*rate_CS*(V_CS - Vcs_curr[t])
    dVbck = sali_bck * learn_rate*rate_bck*(V_bck - Vbck_curr[t])
    dVx = dVcs - dVbck
    Vcs_curr[t+1] = dVcs + Vcs_curr[t]
    Vbck_curr[t+1] = dVbck + Vbck_curr[t]
    Vx_curr[t+1] = dVx + Vx_curr[t]
    # if t%5 == 0:
    #     print(Vx_curr[t])
# fig, (ax1, ax2) = plt.subplots(2)
# ax1.plot(np.arange(1,100),Vx_curr, 'r--' , np.arange(1,100),Vcs_curr, 'b--')
# ax2.plot(np.arange(1,100),Vx_curr, 'r--' , np.arange(1,100),Vcs_curr, 'b--')
plt.plot(Vx_curr)

