import numpy as np
import matplotlib.pyplot as plt
plt.close('all')
AXprob = .2
alphaX = .5
alphaA = .1
beta1 = .1
beta2 = .05
trialn = 1000

AXshock = .8
Ashock = .6


REP_NUM = 100

REP_AX = np.zeros((0,trialn))
REP_A = np.zeros((0,trialn))
REP_X = np.zeros((0,trialn))

for rep in range(REP_NUM):

    trialorder = np.random.permutation(trialn)
    VX = np.zeros(trialn)
    VA = np.zeros(trialn)
    VAX = np.zeros(trialn)


    for ii in range(trialn - 1):
        if trialorder[ii] <= AXprob * trialn:  # Yes CS trials
            if trialorder[ii] <= trialn * AXprob * AXshock:  # Yes CS, Yes shock trials
                dA = alphaA * beta1 * (1 - VAX[ii])
                dX = alphaX * beta1 * (1 - VAX[ii])

                VA[ii + 1] = dA + VA[ii]
                VX[ii + 1] = dX + VX[ii]
                VAX[ii+1] = VA[ii] + VX[ii]
                # VAX[ii + 1] = dAX + VAX[ii]

            else:  # Yes CS, No shock trials
                dA = alphaA * beta2 * (0 - VAX[ii])
                dX = alphaX * beta2 * (0 - VAX[ii])

                VA[ii + 1] = dA + VA[ii]
                VX[ii + 1] = dX + VX[ii]
                VAX[ii+1] = VA[ii] + VX[ii]
                # VAX[ii + 1] = dAX + VAX[ii]

        else:  # No CS trials
            if trialorder[ii] >= trialn - (trialn * (1 - AXprob) * Ashock):  # No CS, yes Shock trials
                dA = alphaA * beta1 * (1 - VA[ii])
                dX = 0
                dAX = 0

                VA[ii + 1] = dA + VA[ii]
                VX[ii + 1] = dX + VX[ii]
                VAX[ii + 1] = dAX + VAX[ii]
            else: # No CS, no Shock
                dA = alphaA * beta2 * (0 - VA[ii])
                dX = 0
                dAX = 0

                VA[ii + 1] = dA + VA[ii]
                VX[ii + 1] = dX + VX[ii]
                VAX[ii + 1] = dAX + VAX[ii]
    REP_AX = np.vstack((REP_AX, VAX))
    REP_A = np.vstack((REP_A, VA))
    REP_X = np.vstack((REP_X, VX))



fig = plt.figure()
fig.clf()
ax = fig.subplots(1,3)
ax[0].plot(VAX, 'r')
ax[0].set_title('$V_{AX}$')
ax[1].plot(VA, 'b')
ax[1].set_title('$V_{A}$')
ax[2].plot(VX, 'g')
ax[2].set_title('$V_{X}$')

fig1 = plt.figure()
fig1.clf()

mVAX = np.mean(REP_AX,0)
mVA = np.mean(REP_A,0)
mVX = np.mean(REP_X,0)

ax1 = fig1.subplots(1,3)
ax1[0].plot(mVAX, 'r')
ax1[0].set_title('$mean V_{AX}$')
ax1[0].set_ylim((-1,1))
ax1[1].plot(mVA, 'b')
ax1[1].set_title('$mean V_{A}$')
ax1[1].set_ylim((-1,1))
ax1[2].plot(mVX, 'g')
ax1[2].set_title('$mean V_{X}$')
ax1[2].set_ylim((-1,1))




# things to try
# 1. A&X, no AX - not working
# 2. AX & A, no X - something interesting, but not correct
# 3. AX & X, no A - fking nonsense
# 4. A & X & AX - interesting, but #2 is better
# NOT A THING IS FUCKING WORKING
# set specific range for most detalied condition, and delete two ifs


