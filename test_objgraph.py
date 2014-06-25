#coding: utf-8

'''
    objgraph
        sudo apt-get install xdot
        sudo pip install objgraph
    我用来绘制 引用关系
'''


import objgraph

x = [1, 2, 3]
y = [x, dict(key1=x)]
z = [y, (x, y)]

objgraph.show_refs([z], filename='test_ref.png')
