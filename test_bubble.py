# coding: utf-8
'''
    冒泡排序
    O(n^2)
'''

def bubble1(data):
    '''循环次数较少'''

    for j in range(len(data)-1, 0, -1):
        for i in range(0,j):
            if data[i]>data[i+1]:
                data[i],data[i+1]=data[i+1],data[i]
        print data
    return data

def bubble2(data):
    '''循环次数较多'''

    for i in range(len(data)-1):
        for j in range(len(data)-1):
            if data[j] > data[j+1]:
                data[j], data[j+1] = data[j+1], data[j]
        print data
    return data


if __name__ == '__main__':

    q = [3, 6, 4, 2, 8, 1, 9, 5]
    print 'q =', q
    print bubble1(q)
    #print bubble2(q)
