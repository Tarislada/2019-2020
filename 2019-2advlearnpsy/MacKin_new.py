import math
import numpy as np
import matplotlib.pyplot as plt

privatesign = lambda x: math.copysign(1, x)
clamp = lambda n, minn, maxn: max(min(maxn, n), minn)

plt.close('all')    # close all open figures to initialize

trialn = 1000       # # of trials in each experiment
Aprob = .5         # Probability of A trial occurrence
Ashock = .8        # Probability of shock in A trials
Bshock = .2         # Probability of shock in B trials

alphaA = .5         # Saliency of X (CS)
alphaB = .5         # Saliency of A (BCK)
initbetaA = .1      # initial Learning rate of US
initbetaB = .1      # initial Learning rate of no US
bias = -0.01


REP_NUM = 100       # of experiments

REP_A = np.zeros((0,trialn))
REP_B = np.zeros((0,trialn))
REP_betaA= np.zeros((0,trialn))
REP_betaB= np.zeros((0,trialn))


for rep in range(REP_NUM):

    trialorder = np.random.permutation(trialn)  # deciding trial types
    # trialorder = trialorder%20
    VB = np.zeros(trialn)
    VA = np.zeros(trialn)

    betaA = np.ones(trialn) * initbetaA  # Learning rate of US
    betaB = np.ones(trialn) * initbetaB  # Learning rate of no US

    for ii in range(trialn - 1):
        if trialorder[ii] <= Aprob * trialn:  # A trials
            if trialorder[ii] <= trialn * Aprob * Ashock:  # A, Yes shock trials
                dbetaA = -1 * privatesign(abs(1 - VA[ii])-abs(1 - VB[ii]))* abs(abs(1 - VA[ii])-abs(1 - VB[ii])+ bias)
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
                dbetaA = -1 * privatesign(abs(0 - VA[ii]) - abs(0 - VB[ii])) * abs(abs(0 - VA[ii]) - abs(0 - VB[ii])+ bias)
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
                dbetaB = -1 * privatesign(abs(1 - VB[ii]) - abs(1 - VA[ii])) * abs(abs(1 - VB[ii]) - abs(1 - VA[ii])+ bias)
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
                dbetaB = -1 * privatesign(abs(0 - VB[ii]) - abs(0 - VA[ii])) * abs(abs(0 - VB[ii]) - abs(0 - VA[ii])+ bias)
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

#
# fig = plt.figure()
# fig.clf()
# ax = fig.subplots(1,2)
# ax[0].plot(VA, 'b')
# ax[0].set_title('$V_{A}$')
# ax[1].plot(VB, 'g')
# ax[1].set_title('$V_{B}$')

fig1 = plt.figure()
fig1.clf()

mVA = np.mean(REP_A,0)
mVB = np.mean(REP_B,0)

# ax1 = fig1.subplots(1,2)
plt.plot(mVA, 'b')
# ax1[0].set_title('$mean V_{A}$')
plt.plot(mVB, 'g')
# ax1[1].set_title('$mean V_{B}$')


fig2 = plt.figure()
fig2.clf()

mbeta1 = np.mean(REP_betaA,0)
mbeta2 = np.mean(REP_betaB,0)

# ax2 = fig2.subplots(1,2)
plt.plot(mbeta1,'r')
# ax2[0].set_title('$mean beta_{A}$')
plt.plot(mbeta2,'b')
# ax2[1].set_title('$mean beta_{B}$')

