import scipy as sp
import matplotlib.pylab as plt
import pandas as pd
import numpy as np
import seaborn as sns 

t = sp.linspace(0, 1, 100)

plt.plot(t, t**2)
plt.show()