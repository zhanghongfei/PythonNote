# coding: utf-8
'''
    归并排序
    两个有序的数组
    res = []
        [1, 3, 6]
        [2, 5, 8, 9 , 11]
    res = [1]
        [3, 6]
        [2, 5, 8, 9 , 11]
    res = [1, 2]
        [3, 6]
        [5, 8, 9 , 11]
    res = [1, 2, 3]
        [6]
        [5, 8, 9 , 11]
    res = [1, 2, 3, 5]
        [6]
        [8, 9 , 11]
    res = [1, 2, 3, 5, 6]
        []
        [8, 9 , 11]
'''

def merge(left, right):

    res = []
    while len(left) and len(right):
        if left[0] <= right[0]:
            res.append(left.pop(0))
        else:
            res.append(right.pop(0))
    res.extend(left)
    res.extend(right)
    return res

def merge_sort(data):

    length = len(data)
    if length <= 1:
        return data

    left = merge_sort(data[:length/2])
    right = merge_sort(data[length/2:])
    return merge(left, right)


if __name__ == '__main__':

    q = [3, 6, 4, 2, 8, 1, 9, 5]
    print 'q =', q
    print 'MergeSortRecursion', merge_sort(q)
