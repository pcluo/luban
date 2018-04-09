import sys,os, re
# sys.path.append('/Users/cluo/python')
# sys.path.append('/Users/cluo/wyss')
from importlib import reload

import matplotlib
import matplotlib.pyplot as plt
plt.style.use('ggplot')
plt.rcParams['figure.figsize'] = [6,4]
# get_ipython().magic(u'matplotlib inline')

# import utils.monkey as mk

import pandas as pd
from numpy import *
from pandas import *
from pandas import IndexSlice as ixs

import seaborn as sns
# import Quandl

# import statsmodels.api as sm
import statsmodels.formula.api as smf
import statsmodels.api as sm

def add_path(path2add):
    if path2add not in sys.path:
        sys.path.append(path2add)
