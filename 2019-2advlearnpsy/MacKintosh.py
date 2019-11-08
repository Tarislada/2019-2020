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

alphaA = .3         # Saliency of X (CS)
alphaB = .3         # Saliency of A (BCK)
initbetaA = .1      # initial Learning rate of US
initbetaB = .1      # initial Learning rate of no US
bias = -0.01


REP_NUM = 100       # of experiments

REP_A = np.zeros((0,trialn))
REP_B = np.zeros((0,trialn))
REP_betaA = np.zeros((0,trialn))
REP_betaB = np.zeros((0,trialn))


for rep in range(REP_NUM):
    np.random.seed()
    trialorder = np.random.permutation(trialn)  # deciding trial types
    VB = np.zeros(trialn)
    VA = np.zeros(trialn)

    betaA = np.ones(trialn) * initbetaA  # Learning rate of US
    betaB = np.ones(trialn) * initbetaB  # Learning rate of no US
    for i in range(pretrain):
        dbetaA = -1 * privatesign(abs(0 - VA[i]) - abs(0 - VB[i])) * abs(abs(0 - VA[i]) - abs(0 - VB[i]) + bias) * betaA[i]
        dbetaB = 0
        betaA[i + 1] = dbetaA + betaA[i]
        betaA[i + 1] = clamp(betaA[i + 1], 0, 1)
        betaB[i + 1] = dbetaB + betaB[i]
        betaB[i + 1] = clamp(betaB[i + 1], 0, 1)

        dA = alphaA * betaA[i] * (0 - VA[i])
        dB = 0
        VA[i + 1] = dA + VA[i]
        VB[i + 1] = dB + VB[i]


    for ii in range(pretrain, trialn - 1):
        if trialorder[ii] <= Aprob * trialn:  # A trials
            if trialorder[ii] <= trialn * Aprob * Ashock:  # A, Yes shock trials
                dbetaA = -1 * privatesign(abs(1 - VA[ii])-abs(1 - VB[ii]))* abs(abs(1 - VA[ii])-abs(1 - VB[ii])+ bias) *betaA[ii]
                dbetaB = 0
                betaA[ii + 1] = dbetaA + betaA[ii]
                betaA[ii + 1] = clamp(betaA[ii + 1], 0, 1)
                betaB[ii + 1] = dbetaB + betaB[ii]
                betaB[ii + 1] = clamp(betaB[ii + 1], 0, 1)

                dA = alphaA * betaA[ii] * (1 - VA[ii])
                dB = 0
                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

            else:  # A, No shock trials
                dbetaA = -1 * privatesign(abs(0 - VA[ii]) - abs(0 - VB[ii])) * abs(abs(0 - VA[ii]) - abs(0 - VB[ii])+ bias) *betaA[ii]
                dbetaB = 0
                betaA[ii + 1] = dbetaA + betaA[ii]
                betaA[ii+1] = clamp(betaA[ii+1], 0, 1)
                betaB[ii + 1] = dbetaB + betaB[ii]
                betaB[ii + 1] = clamp(betaB[ii + 1], 0, 1)

                dA = alphaA * betaA[ii] * (0 - VA[ii])
                dB = 0

                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

        else:  # B trials
            if trialorder[ii] >= trialn - (trialn * (1 - Aprob) * Bshock):  # No CS, yes Shock trials
                dbetaA = 0
                dbetaB = -1 * privatesign(abs(1 - VB[ii]) - abs(1 - VA[ii])) * abs(abs(1 - VB[ii]) - abs(1 - VA[ii])+ bias)*betaB[ii]
                betaA[ii + 1] = dbetaA + betaA[ii]
                betaA[ii + 1] = clamp(betaA[ii + 1], 0, 1)
                betaB[ii + 1] = dbetaB + betaB[ii]
                betaB[ii + 1] = clamp(betaB[ii + 1], 0, 1)

                dA = 0
                dB = alphaB * betaB[ii] * (1 - VB[ii])

                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

            else: # B, no Shock
                dbetaA = 0
                dbetaB = -1 * privatesign(abs(0 - VB[ii]) - abs(0 - VA[ii])) * abs(abs(0 - VB[ii]) - abs(0 - VA[ii])+ bias) *betaB[ii]
                betaA[ii + 1] = dbetaA + betaA[ii]
                betaA[ii + 1] = clamp(betaA[ii + 1], 0, 1)
                betaB[ii + 1] = dbetaB + betaB[ii]
                betaB[ii + 1] = clamp(betaB[ii + 1], 0, 1)


                dA = 0
                dB = alphaB * betaB[ii] * (0 - VB[ii])

                VA[ii + 1] = dA + VA[ii]
                VB[ii + 1] = dB + VB[ii]

#Todo the beta values are skyrocketing. need to set a limitation? yes: 0-1
    REP_A = np.vstack((REP_A, VA))
    REP_B = np.vstack((REP_B, VB))
    REP_betaA = np.vstack((REP_betaA, betaA))
    REP_betaB = np.vstack((REP_betaB, betaB))

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

mbetaA = np.mean(REP_betaA,0)
mbetaB = np.mean(REP_betaB,0)

# ax2 = fig2.subplots(1,2)
plt.plot(mbetaA,'r')
# ax2[0].set_title('$mean beta_{A}$')
plt.plot(mbetaB,'b')
# ax2[1].set_title('$mean beta_{B}$')

