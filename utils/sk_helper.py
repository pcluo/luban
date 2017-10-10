import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.base import BaseEstimator, TransformerMixin


class CustomScaler(BaseEstimator,TransformerMixin):
    # note: returns the feature matrix with the binary columns ordered first
    def __init__(self,bin_vars_index,cont_vars_index,copy=True,with_mean=True,with_std=True):
        self.scaler = StandardScaler(copy,with_mean,with_std)
        self.bin_vars_index = bin_vars_index
        self.cont_vars_index = cont_vars_index

    def fit(self, X, y=None):
        self.scaler.fit(X[:,self.cont_vars_index].astype(np.number))
        return self

    def transform(self, X, y='deprecated', copy=None):
        X_tail = self.scaler.transform(X[:,self.cont_vars_index].astype(np.number),copy=copy)
        return np.concatenate((X[:,self.bin_vars_index],X_tail), axis=1)


def find_bin_cols(l2, col_x):
    """bin columns only have values 0 or 1"""
    bin_vars = []
    cont_vars = []
    for col in col_x:
        x = l2[col].unique()
        if np.all(np.in1d(x, [0,1])):
            bin_vars.append(col)
        else:
            cont_vars.append(col)
    print('Bin Cols:\t', bin_vars)
    print('Cont Cols:\t', cont_vars)
    bin_vars_index = [l2.columns.get_loc(x) for x in bin_vars]
    cont_vars_index = [l2.columns.get_loc(x) for x in cont_vars]

    return bin_vars_index, cont_vars_index