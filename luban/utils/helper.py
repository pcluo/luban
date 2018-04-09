from pandas import (Series,qcut,to_numeric)
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter


def plot_cdf(x, xlim=None):
    """
    x: Series
    """
    x = (x.value_counts().sort_index().cumsum()/x.shape[0])
    x[0] = 0; x = x.sort_index();
    x = Series(x.index, index=x)
    if xlim is not None:
        x = x.loc[xlim[0]:xlim[1]]
    x.plot();
    if xlim is not None:
        plt.xlim(xlim)

    return x


def compound(df, freq='Q'):
    """
    df: DataFrame indexed by daily date
    """
    return (exp(log(1+df).resample(freq).sum()) - 1)


create_decile = lambda x: qcut(x, q=10, labels=False) + 1


def plt_style_paper(figsize=None):
    """usually [6,4] is a good size"""
    plt.style.use('classic')
    plt.rcParams['legend.fontsize'] = 11
    plt.rcParams['figure.facecolor'] = 'white'
    if figsize is not None:
        plt.rcParams['figure.figsize'] = figsize

csfont = {'fontname':'Times New Roman'}


def compress_df(df):
    for col in df.select_dtypes(include=['integer']):
        df[col] = to_numeric(df[col], downcast='integer')

    for col in df.select_dtypes(include=['float']):
        df[col] = to_numeric(df[col], downcast='float')
    return df


def pct_format_yaxis(prec=1, ax=None):
    # Set the formatter
    def _to_percent(y, position):
        # Ignore the passed in position. This has the effect of scaling the default
        # tick locations.
        s = '{:.{prec}f}'.format(100 * y, prec=prec)

        # The percent symbol needs escaping in latex
        if matplotlib.rcParams['text.usetex'] is True:
            return s + r'$\%$'
        else:
            return s + '%'
    _pct_formatter = FuncFormatter(_to_percent)
    if ax is None:
        ax = plt.gca()
    ax.yaxis.set_major_formatter(_pct_formatter)

def center_axis(ax, xpos='center', ypos='center'):
    """pos can be center or zero"""
    if xpos is not None:
        ax.spines['left'].set_color('none')
        ax.spines['right'].set_position(xpos)
    else:
        ax.spines['right'].set_visible(False)
        ax.yaxis.set_ticks_position('left')

    if ypos is not None:
        ax.spines['top'].set_position(ypos)
        ax.spines['bottom'].set_color('none')
    else:
        # so that it doesn't look weird
        ax.spines['top'].set_visible(False)
        ax.xaxis.set_ticks_position('bottom')

# def rolling_beta()
#     d_cov = d_ret.rolling(beta_win, min_periods=0).cov(d_ret.btop)
#     d_std = d_ret.btop.rolling(beta_win, min_periods=0).var()
#     d_beta = d_cov.div(d_std, 0).dropna()
#     return d_beta
