# coding: utf-8
'''
    fabfile
    $fab -l
'''

import deploy

from fabric.api import task, run

def test_hello_with_no_args():

    print 'Hello world'

def test_hello_with_args(name='world'):

    print 'Hello {}'.format(name)


@task(alias='hongfei')
def mytask():

    run('ls')
