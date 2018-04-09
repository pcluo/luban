import statsmodels.formula.api as sm

import pandas as pd
from pandas import Series, isnull


def winsorize_series(sr, limits=(0.01, 0.01)):
    assert len(limits) == 2
    limits = [x if not isnull(x) else 0 for x in limits]
    assert limits[0] <= 0.5 and limits[1] <= 0.5
    if not isinstance(sr, Series):
        sr = Series(sr)
    quantiles = sr.quantile([limits[0], 1 - limits[1]])
    return sr.clip(lower=quantiles.iloc[0], upper=quantiles.iloc[1])


def winsorize_df(df, cols, limits=(0.01, 0.01), copy=False):
    if copy:
        df = df.copy()
    for col in cols:
        df[col] = winsorize_series(df[col], limits)
    return df



def fama_macbeth(formula, time_label, df, lags=3):
    res = df.groupby(time_label).apply(lambda x: sm.ols(formula=formula,
                                                     data=x).fit())

    l = [x.params for x in res]
    p = pd.DataFrame(l)

    means = {}
    params_labels = res.iloc[0].params.index

    # The ':' character used by patsy doesn't play well with pandas column names.
    p.columns = [x.replace(':', '_INTER_') for x in p.columns]

    for x in p.columns:
        if lags is 0:
            means[x.replace('_INTER_',':')] = sm.ols(formula=x + ' ~ 1',
                                                     data=p[[x]]).fit(use_t=True)
        else:
            means[x.replace('_INTER_',':')] = sm.ols(formula=x + ' ~ 1',
                                                     data=p[[x]]).fit(cov_type='HAC',
                                                                      cov_kwds={'maxlags': lags},
                                                                      use_t=True)

    params = []
    stderrs = []
    tvalues = []
    pvalues = []
    for x in params_labels:
        params.append(means[x].params['Intercept'])
        stderrs.append(means[x].bse['Intercept'])
        tvalues.append(means[x].tvalues['Intercept'])
        pvalues.append(means[x].pvalues['Intercept'])

    result = pd.DataFrame([params, stderrs, tvalues, pvalues]).T
    result.index = params_labels
    result.columns = ['coef', 'stderr', 'tvalue', 'pvalue']
    result['stars'] = ''
    result.loc[result.pvalue < 0.1, 'stars'] = '*'
    result.loc[result.pvalue < 0.05, 'stars'] = '**'
    result.loc[result.pvalue < 0.01, 'stars'] = '***'

    return result