import numpy as np
import matplotlib.pyplot as plt

class RWchp3:
    def __init__(self,trialn=1000,alphaX=.5,alphaA=.1,beta1=.1,beta2=.5):
        np.random.seed()
        self.alphaX = alphaX
        self.alphaA = alphaA
        self.beta1 = beta1
        self.beta2 = beta2
        self.trialn = trialn


    def scheduleset(self,REP_NUM=100,AXprob=.2,AXshock=.8,Ashock=.4):
        self.REP_NUM = REP_NUM
        self.REP_AX = np.zeros((0, self.trialn))
        self.REP_A = np.zeros((0, self.trialn))
        self.REP_X = np.zeros((0, self.trialn))
        self.AXprob = AXprob
        self.AXshock = AXshock
        self.Ashock = Ashock
        self.VX = np.zeros(self.trialn)
        self.VA = np.zeros(self.trialn)
        self.VAX = np.zeros(self.trialn)


    def wipeMemory(self):
        self.REP_AX = np.zeros((0, self.trialn))
        self.REP_A = np.zeros((0, self.trialn))
        self.REP_X = np.zeros((0, self.trialn))

    def run(self):
        for rep in range(self.REP_NUM):

            trialorder = np.random.permutation(self.trialn)

            self.VX = np.zeros(self.trialn)
            self.VA = np.zeros(self.trialn)
            self.VAX = np.zeros(self.trialn)

            for ii in range(self.trialn - 1):
                if trialorder[ii] <= self.AXprob * self.trialn:  # Yes CS trials
                    if trialorder[ii] <= self.trialn * self.AXprob * self.AXshock:  # Yes CS, Yes shock trials
                        dA = self.alphaA * self.beta1 * (1 - self.VAX[ii])
                        dX = self.alphaX * self.beta1 * (1 - self.VAX[ii])

                        self.VA[ii + 1] = dA + self.VA[ii]
                        self.VX[ii + 1] = dX + self.VX[ii]
                        self.VAX[ii + 1] = self.VA[ii] + self.VX[ii]


                    else:  # Yes CS, No shock trials
                        dA = self.alphaA * self.beta2 * (0 - self.VAX[ii])
                        dX = self.alphaX * self.beta2 * (0 - self.VAX[ii])

                        self.VA[ii + 1] = dA + self.VA[ii]
                        self.VX[ii + 1] = dX + self.VX[ii]
                        self.VAX[ii + 1] = self.VA[ii] + self.VX[ii]


                else:  # No CS trials
                    if trialorder[ii] >= self.trialn - (self.trialn * (1 - self.AXprob) * self.Ashock):  # No CS, yes Shock trials
                        dA = self.alphaA * self.beta1 * (1 -self.VA[ii])
                        dX = 0
                        dAX = 0

                        self.VA[ii + 1] = dA + self.VA[ii]
                        self.VX[ii + 1] = dX + self.VX[ii]
                        self.VAX[ii + 1] = dAX + self.VAX[ii]
                    else:  # No CS, no Shock
                        dA = self.alphaA * self.beta2 * (0 - self.VA[ii])
                        dX = 0
                        # dAX = alphaX * beta2 * (0 - VAX[ii])  # used same alpha value for VAX learning rate
                        dAX = 0
                        self.VA[ii + 1] = dA + self.VA[ii]
                        self.VX[ii + 1] = dX + self.VX[ii]
                        self.VAX[ii + 1] = dAX + self.VAX[ii]
            self.REP_AX = np.vstack((self.REP_AX, self.VAX))
            self.REP_A = np.vstack((self.REP_A, self.VA))
            self.REP_X = np.vstack((self.REP_X, self.VX))

    def plot(self):
        fig = plt.figure()
        fig.clf()
        ax = fig.subplots(1, 3)
        ax[0].plot(self.REP_AX[0,:], 'r')
        ax[0].set_title('$V_{AX}$')
        ax[1].plot(self.REP_A[0,:], 'b')
        ax[1].set_title('$V_{A}$')
        ax[2].plot(self.REP_X[0,:], 'g')
        ax[2].set_title('$V_{X}$')

        fig1 = plt.figure()
        fig1.clf()

        mVAX = np.mean(self.REP_AX, 0)
        mVA = np.mean(self.REP_A, 0)
        mVX = np.mean(self.REP_X, 0)

        ax1 = fig1.subplots(1, 3)
        ax1[0].plot(mVAX, 'r')
        ax1[0].set_title('$mean V_{AX}$')
        ax1[0].set_ylim((-1, 1))
        ax1[1].plot(mVA, 'b')
        ax1[1].set_title('$mean V_{A}$')
        ax1[1].set_ylim((-1, 1))
        ax1[2].plot(mVX, 'g')
        ax1[2].set_title('$mean V_{X}$')
        ax1[2].set_ylim((-1, 1))

t = RWchp3()
t.scheduleset(1000,100,.2,.8,.4)
t.run()
t.plot()
