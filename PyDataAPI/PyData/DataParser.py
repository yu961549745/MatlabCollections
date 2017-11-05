""" Data Parser Between Matlab And Python """
import numpy as np


def mx2py(x, dtype):
    """ parse matlab array to numpy array """
    sz = list(map(int, x['shape'].tolist()))
    y = x['data']
    # TensorFlow 如果 order='F' 速度会慢将近两倍
    return np.array(np.array(y, dtype=np.dtype(dtype)).reshape(sz, order='F'), order='C')


class mxArray(object):
    """ parse numpy array to matlab array """

    def __init__(self, x):
        self.shape = x.shape
        self.data = x.reshape([-1], order='F').tolist()
