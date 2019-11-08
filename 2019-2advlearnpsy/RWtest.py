import numpy as np
import matplotlib.pyplot as plt

alpha_A = 1
alpha_B = 1
alpha_X = 1
Beta1 = .05
Beta2 = .05
trialn = 1000
us1prob = 50
VA = np.zeros(trialn)
VB = np.zeros(trialn)
VX = np.zeros(trialn)

trialorder = np.random.permutation(trialn)
trialorder = trialorder%100

for ii in range(trialn-1):
    if trialorder[ii]<=us1prob:
        dVA = alpha_A*Beta1*(1-(VA[ii]+VX[ii]))
        VA[ii+1] = dVA + VA[ii]
        dVX = alpha_X*Beta1*(1-(VA[ii]+VX[ii]))
        VX[ii+1] = dVX+VX[ii]

    else :
        dVB = alpha_B*Beta2*(0-(VB[ii]+VX[ii]))
        VB[ii+1] = dVB + VB[ii]
        dVX = alpha_X*Beta2*(0-(VB[ii]+VX[ii]))
        VX[ii+1] = dVX+VX[ii]
#         A랑 X를 하는게 아니라,AX랑 A를 하고 BX랑 B를 해야하나?
#         아니면 AX랑 X, BX랑 B?
# trialorder[ii]>us1prob
# plt.plot(VA)
# plt.plot(VB)
plt.plot(VX)
plt.plot(VA+VX)
# plt.plot(VB+VX)