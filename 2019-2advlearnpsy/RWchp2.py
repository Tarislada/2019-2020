import numpy as np
import matplotlib.pyplot as plt

al_a = 1
al_b = 1
al_x = 1
beta1 = .05
beta2 = .05
lam1 = 1
lam2 = 0
lam_AX = (.5*lam1 - (-.5)*beta2*lam2)/(.5*beta1 - (-.5)*beta2)
lam_BX =  ((al_b+2*al_x)/2*al_x)*lam_AX

VAXcurr = np.zeros(100)
VBXcurr = np.zeros(100)
VAcurr = np.zeros(100)
VBcurr = np.zeros(100)
VXcurr = np.zeros(100)

# VA = np.ones(100,1)
# VB = np.ones(100,1)


for t in range(99):

    dVAX = 1*.05*(lam_AX - VAXcurr[t])
    VAXcurr[t+1] = dVAX + VAXcurr[t]

    dVA = al_a*beta1*(lam1 - VAcurr[t])
    VAcurr[t + 1] = dVA + VAcurr[t]

    dVBX = 1*.05*(lam_BX - VBXcurr[t])
    VBXcurr[t+1] = dVBX + VBXcurr[t]

    dVB = al_b*beta2*(lam2 - VBcurr[t])
    VBcurr = dVB + VBcurr

    dVX = al_x*beta2*(lam2 - VXcurr[t])
    VXcurr[t+1] = dVX + VXcurr[t]

    if t%10 ==0:
        print(VAcurr)
        print(VBcurr)
plt.plot(VAXcurr)
plt.plot(VBXcurr)
plt.plot(VAcurr)
plt.plot(VBcurr)
plt.plot(VXcurr)
