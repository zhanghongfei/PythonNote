#coding: utf-8
'''
    module: ThreadPoolExecutor
    python < 3
        pip install futures
'''

import time

from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import as_completed


def print_a(a):

    time.sleep(2)
    return a


def test_1():
    ''' 2 s '''

    with ThreadPoolExecutor(max_workers=5) as executor:

        res = [
            executor.submit(print_a, i)
            for i in xrange(5)
        ]
        print res

        for future in as_completed(res):

            print future.result()

def test_2():
    '''  10 s'''

    with ThreadPoolExecutor(max_workers=5) as executor:
        for i in xrange(5):
            res = executor.submit(print_a, i)
            print res.result()


if __name__ == '__main__':

    test_1()
    test_2()
