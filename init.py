import sys,os, re
# sys.path.append('/Users/cluo/python')
# sys.path.append('/Users/cluo/wyss')

import pandas as pd
from numpy import *
from pandas import *
from pandas import IndexSlice as ixs
# get_ipython().magic(u'matplotlib inline')
import seaborn as sns
# import Quandl

# import statsmodels.api as sm
import statsmodels.formula.api as smf
import statsmodels.api as sm

import matplotlib.pyplot as plt
plt.style.use('ggplot')
plt.rcParams['figure.figsize'] = [6,4]

from importlib import reload
# import utils.monkey as mk


def add_path(path2add):
    if path2add not in sys.path:
        sys.path.append(path2add)
