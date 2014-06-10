#coding: utf-8
'''
    选择排序
    O(n^2)
'''

def select_sort(lst):

    end = len(lst)
    for i in range(end-1):
        for j in range(i+1, end):
            if lst[i] > lst[j]:
                lst[i], lst[j] = lst[j], lst[i]
        print lst

    return lst


if __name__ == '__main__':

    q = [3, 6, 4, 2, 8, 1, 9, 5]
    print 'q =', q
    print select_sort(q)
