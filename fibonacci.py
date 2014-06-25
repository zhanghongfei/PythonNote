#coding: utf-8

def fib_gen():
    '''斐波那契 生成器'''

    a1, a2 = 1, 0
    while True:
        res = a1 + a2
        yield res
        a1, a2 = a2, res


def fib(length):
    '''斐波那契 指定长度数列'''

    a1, a2 = 1, 0
    res = []
    for i in range(length):
        tmp = a1 + a2
        res.append(tmp)
        a1, a2 = a2, tmp
    return res


if __name__ == '__main__':

    f = fib_gen()
    print 'Fibonacci gen:', f.next(), f.next(), f.next(), f.next(), f.next()

    print 'Fibonacci list:', fib(5)
