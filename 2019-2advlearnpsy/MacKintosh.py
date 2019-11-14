import math
import numpy as np
import matplotlib.pyplot as plt

privatesign = lambda x: math.copysign(1, x)
clamp = lambda n, minn, maxn: max(min(maxn, n), minn)

plt.close('all')    # close all open figures to initialize

pretrain = 300
trialn = 1000+pretrain # # of trials in each experiment
Aprob = .5         # Probability of A trial occurrence
Ashock = .8        # Probability of shock in A trials
Bshock = .8         # Probability of shock in B trials

betaA = .3         # betaency of X (CS)
betaB = .3         # betaency of A (BCK)
initalphaA = .1      # initial Learning rate of US
initalphaB = .1      # initial Learning rate of no US
bias = -0.01


REP_NUM = 100       # of experiments

REP_A = np.zeros((0,trialn))
REP_B = np.zeros((0,trialn))
REP_alphaA = np.zeros((0,trialn))
REP_alphaB = np.zeros((0,trialn))


for rep in range(REP_NUM):
    np.random.seed()
    trialorder = np.random.permutation(trialn)  # deciding trial types
    VB = np.zeros(trialn)
    VA = np.zeros(trialn)

    alphaA = np.ones(trialn) * initalphaA  # Learning rate of US
    alphaB = np.ones(trialn) * initalphaB  # Learning rate of no US
    for i in range(pretrain):
        dalphaA = -1 * privatesign(abs(0 - VA[i]) - abs(0 - VB[i])) * abs(abs(0 - VA[i]) - abs(0 - VB[i]) + bias) * (1-alphaA[i])
        dalphaB = 0
        alphaA[i + 1] = dalphaA + alphaA[i]
        alphaA[i + 1] = clamp(alphaA[i + 1], 0, 1)
        alphaB[i + 1] = dalphaB + alphaB[i]
        alphaB[i + 1] = clamp(alphaB[i + 1], 0, 1)
(1-)
        dA = betaA * alphaA[i] * (0 - VA[i])
        dB = 0
        VA[i + 1] = dA + VA[i]
        VB[i + 1] = dB + VB[i]


    for ii in range(pretrain, trialn - 1):
        if trialorder[ii] <= Aprob * trialn:  # A trials
            if trialorder[ii] <= trialn * Aprob * Ashock:  # A, Yes shock trials
                dalphaA = -1 * privatesign(abs(1 - VA[ii])-abs(1 - VB[ii]))* abs(abs(1 - VA[ii])-abs(1 - VB[ii])+ bias) *(1-alphaA[ii])
                dalphaB = 0
                alphaA[ii + 1] = dalphaA + alphaA[ii]
                alphaA[ii + 1] = clamp(alphaA[ii + 1], 0, 1)
                alphaB[ii + 1] = dalphaB + alphaB[ii]
                alphaB[ii + 1] = clamp(alphaB[ii + 1], 0, 1)

                dA = betaA * alphaA[ii] * (1 - VA[ii])
                dB = 0
                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

            else:  # A, No shock trials
                dalphaA = -1 * privatesign(abs(0 - VA[ii]) - abs(0 - VB[ii])) * abs(abs(0 - VA[ii]) - abs(0 - VB[ii])+ bias) *(1-alphaA[ii])
                dalphaB = 0
                alphaA[ii + 1] = dalphaA + alphaA[ii]
                alphaA[ii+1] = clamp(alphaA[ii+1], 0, 1)
                alphaB[ii + 1] = dalphaB + alphaB[ii]
                alphaB[ii + 1] = clamp(alphaB[ii + 1], 0, 1)

                dA = betaA * alphaA[ii] * (0 - VA[ii])
                dB = 0

                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

        else:  # B trials
            if trialorder[ii] >= trialn - (trialn * (1 - Aprob) * Bshock):  # No CS, yes Shock trials
                dalphaA = 0
                dalphaB = -1 * privatesign(abs(1 - VB[ii]) - abs(1 - VA[ii])) * abs(abs(1 - VB[ii]) - abs(1 - VA[ii])+ bias)*(1-alphaB[ii])
                alphaA[ii + 1] = dalphaA + alphaA[ii]
                alphaA[ii + 1] = clamp(alphaA[ii + 1], 0, 1)
                alphaB[ii + 1] = dalphaB + alphaB[ii]
                alphaB[ii + 1] = clamp(alphaB[ii + 1], 0, 1)

                dA = 0
                dB = betaB * alphaB[ii] * (1 - VB[ii])

                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

            else: # B, no Shock
                dalphaA = 0
                dalphaB = -1 * privatesign(abs(0 - VB[ii]) - abs(0 - VA[ii])) * abs(abs(0 - VB[ii]) - abs(0 - VA[ii])+ bias) *(1-alphaB[ii])
                alphaA[ii + 1] = dalphaA + alphaA[ii]
                alphaA[ii + 1] = clamp(alphaA[ii + 1], 0, 1)
                alphaB[ii + 1] = dalphaB + alphaB[ii]
                alphaB[ii + 1] = clamp(alphaB[ii + 1], 0, 1)


                dA = 0
                dB = betaB * alphaB[ii] * (0 - VB[ii])

                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

#Todo the alpha values are skyrocketing. need to set a limitation? yes: 0-1
    REP_A = np.vstack((REP_A, VA))
    REP_B = np.vstack((REP_B, VB))
    REP_alphaA = np.vstack((REP_alphaA, alphaA))
    REP_alphaB = np.vstack((REP_alphaB, alphaB))

fig1 = plt.figure()
fig1.clf()

mVA = np.mean(REP_A,0)
mVB = np.mean(REP_B,0)

# ax1 = fig1.subplots(1,2)
plt.plot(mVA, 'r')
# ax1[0].set_title('$mean V_{A}$')
plt.plot(mVB, 'b')
# ax1[1].set_title('$mean V_{B}$')


fig2 = plt.figure()
fig2.clf()

malphaA = np.mean(REP_alphaA,0)
malphaB = np.mean(REP_alphaB,0)

# ax2 = fig2.subplots(1,2)
plt.plot(malphaA,'r')
# ax2[0].set_title('$mean alpha_{A}$')
plt.plot(malphaB,'b')
# ax2[1].set_title('$mean alpha_{B}$')

