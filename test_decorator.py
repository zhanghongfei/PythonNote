#coding: utf-8
'''
    decorator test
'''

from functools import wraps


def decorator_with_no_args(function):

    @wraps(function)
    def _deco(*args, **kwargs):
        print 'In decorator_with_no_args'
        return function(*args, **kwargs) + 4
    return _deco


def decorator_with_args(arg):

    def call(function):
        @wraps(function)
        def _deco(*args, **kwargs):
            print 'In decorator_with_args'
            return function(*args, **kwargs) + arg
        return _deco
    return call


def add(a, b):

    return a + b

@decorator_with_no_args
def add_with_deco(a, b):

    return a + b

@decorator_with_args(1)
def add_with_decorator(a, b):

    return a + b

if __name__ == '__main__':

    print '>>>>'
    print add(1, 2)
    print '>>>>'
    print add_with_deco(1, 2)
    print '>>>>'
    print add_with_decorator(1, 2)
