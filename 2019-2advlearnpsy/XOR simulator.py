import matplotlib.pyplot as plt
import numpy as np

class XORsim:
    def __init__(self, trialn=1000,alphaA=.03, alphaB=.03, alphaC = .03,beta=.2):
        np.random.seed()
        self.alphaA = alphaA
        self.alphaB = alphaB
        self.alphaC = alphaC
        self.beta = beta
        self.trialn = trialn
# C = Common element of A&B

    def scheduleset(self, REP_NUM=100, Aprob=.2,, Ashock=.8, Bshock=.8):
        self.REP_NUM = REP_NUM
        self.REP_A = np.zeros((0, self.trialn))
        self.REP_B = np.zeros((0, self.trialn))
        self.REP_C = np.zeros((0, self.trialn))
        self.Aprob = Aprob
        self.Bprob = 1-Aprob
        self.Ashock = Ashock
        self.Bshock = Bshock
        self.VA = np.zeros(self.trialn)
        self.VB = np.zeros(self.trialn)
        self.VC = np.zeros(self.trialn)

    def wipeMemory(self):
        self.REP_A = np.zeros((0, self.trialn))
        self.REP_B = np.zeros((0, self.trialn))
        self.REP_C = np.zeros((0, self.trialn))

    def run(self):
        for rep in range(self.REP_NUM):

            trialorder = np.random.permutation(self.trialn)

            self.VA = np.zeros(self.trialn)
            self.VB = np.zeros(self.trialn)
            self.VC = np.zeros(self.trialn)

            for ii in range(self.trialn - 1):
                if trialorder[ii] <= self.AXprob * self.trialn:
                    dA = self.alphaA * self.beta1 * (self.Ashock - self.VAX[ii])
                    dc = self.alphaX * self.beta1 * (self.Cshock - self.VAX[ii])

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