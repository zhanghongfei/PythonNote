
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>python高级编程</title>
    <link rel="stylesheet" href="css/default.css" media="screen">
  </head>
  <body>
    <textarea id="source">

class: middle, inverse, center
```
             _   _              -
 _ __  _   _| |_| |__   ___  _ __
| '_ \| | | | __| '_ \ / _ \| '_ \
 | |_) | |_| | |_| | | | (_) | | | |
 | .__/ \__, |\__|_| |_|\___/|_| |_|
|_|    |___/                     _
```

# 高级编程
### Dongweiming
2014.4.2
---
class: middle, inverse, center
## XX不理解python竟然没有end....
---
class: inverse
### 其实 可以有...
```
__builtins__.end = None

def test(x):
    if x > 0:
        print "a"
    else:
        print "b"
    end
end


def main():
    test(1)
    print('I can use end!')
end
```
---
class: inverse
## 设置全局变量

```
>>> a
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'a' is not defined
>>> d = {'a': 1, 'b':2}
>>> # 粗暴的写法
>>> for k, v in d.iteritems():
...     exec "{}={}".format(k, v)
...
>>> # 文艺的写法
>>> globals().update(d)
>>> a, b
(1, 2)
>>> 'a', 'b'
('a', 'b')
>>> globals()['a'] = 'b'
>>> a
'b'
```
---
class: inverse
## 字符串格式化

```
>>> "{key}={value}".format(key="a", value=10) # 使⽤命名参数
'a=10'
>>> "[{0:<10}], [{0:^10}], [{0:*>10}]".format("a") # 左中右对⻬
'[a         ], [    a     ], [*********a]'
>>> "{0.platform}".format(sys) # 成员
'darwin'
>>> "{0[a]}".format(dict(a=10, b=20)) # 字典
'10'
>>> "{0[5]}".format(range(10)) # 列表
'5'
>>> "My name is {0} :-{{}}".format('Fred') # 真得想显示{},需要双{}
'My name is Fred :-{}'
>>> "{0!r:20}".format("Hello")
"'Hello'             "
>>> "{0!s:20}".format("Hello")
'Hello               '
>>> "Today is: {0:%a %b %d %H:%M:%S %Y}".format(datetime.now())
'Today is: Mon Mar 31 23:59:34 2014'

```

([PEP3101](http://legacy.python.org/dev/peps/pep-3101/))
---
class: inverse
## 列表去重
```
>>> l = [1, 2, 2, 3, 3, 3]
>>> {}.fromkeys(l).keys()
[1, 2, 3] # 列表去重(1)
>>> list(set(l)) # 列表去重(2)
[1, 2, 3]
In [2]: %timeit list(set(l))
1000000 loops, best of 3: 956 ns per loop
In [3]: %timeit {}.fromkeys(l).keys()
1000000 loops, best of 3: 1.1 µs per loop
In [4]: l = [random.randint(1, 50) for i in range(10000)]
In [5]: %timeit list(set(l))
1000 loops, best of 3: 271 µs per loop
In [6]: %timeit {}.fromkeys(l).keys()
1000 loops, best of 3: 310 µs per loop 
PS: 在字典较大的情况下, 列表去重(1)略慢了
```
---
class: inverse
## 操作字典

```
>>> dict((["a", 1], ["b", 2])) # ⽤两个序列类型构造字典
{'a': 1, 'b': 2}
>>> dict(zip("ab", range(2)))
{'a': 0, 'b': 1}
>>> dict(map(None, "abc", range(2)))
{'a': 0, 'c': None, 'b': 1}
>>> dict.fromkeys("abc", 1) # ⽤序列做 key,并提供默认 value
{'a': 1, 'c': 1, 'b': 1}
>>> {k:v for k, v in zip("abc", range(3))} # 字典解析
{'a': 0, 'c': 2, 'b': 1}
>>> d = {"a":1, "b":2}
>>> d.setdefault("a", 100) # key 存在,直接返回 value
1
>>> d.setdefault("c", 200) # key 不存在,先设置,后返回
200
>>> d
{'a': 1, 'c': 200, 'b': 2}
```
---
class: inverse
## 字典视图

```
>>> d1 = dict(a = 1, b = 2)
>>> d2 = dict(b = 2, c = 3)
>>> d1 & d2 # 字典不⽀支持该操作
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for &: 'dict' and 'dict'
>>> v1 = d1.viewitems()
>>> v2 = d2.viewitems()
>>> v1 & v2 # 交集
set([('b', 2)])
>>> dict(v1 & v2) # 可以转化为字典
{'b': 2}
>>> v1 | v2 # 并集
set([('a', 1), ('b', 2), ('c', 3)])
>>> v1 - v2 #差集(仅v1有,v2没有的)
set([('a', 1)])
>>> v1 ^ v2 # 对称差集 (不会同时出现在 v1 和 v2 中)
set([('a', 1), ('c', 3)])
>>> ('a', 1) in v1 #判断
True
```
---
class: inverse
## vars

```
>>> vars() is locals()
True
>>> vars(sys) is sys.__dict__
True
```
---
class: inverse
### from \_\_future\_\_ import unicode_literals
```
>>> s = '美的'
>>> s
'\xe7\xbe\x8e\xe7\x9a\x84'
>>> from __future__ import unicode_literals
>>> s = '美的'
>>> s
u'\u7f8e\u7684'
>>> s.encode('utf-8')
'\xe7\xbe\x8e\xe7\x9a\x84'
>>> s = b'美的'
>>> s
'\xe7\xbe\x8e\xe7\x9a\x84'
>>> type(s)
<type 'str'>
```
---
class: inverse
### from \_\_future\_\_ import absolute_import
### 不是支持了绝对引入,而是拒绝隐式引入
```
$cat for_absolute_import/string.py
a = 1
$cat for_absolute_import/main.py            
import string # 其实我们要的是当前目录下的string模块
>>> from for_absolute_import.main import string
>>> string # 是隐式引入的
<module 'for_absolute_import.string' from 'for_absolute_import/string.py'>
>>> 1
1
## 我来修改下
$cat for_absolute_import/main.py
from __future__ import absolute_import                                                                                                                                            
import string
>>> from for_absolute_import.main import string
>>> string # 看这里其实还是在用string模块
<module 'string' from '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/string.pyc'>
```
---
class: inverse
## 我靠,我的需求呢? -- 在很多开源项目是拒绝你的隐式用法的,
## 比如celery
## 来点标准做法:
```
from __future__ import absolute_import
from .string import a # 比较常用的风格
from for_absolute_import.string import a \
# 官方推荐的风格,强烈建议这样的风格
```
---
class: inverse
## 一个关于编码的问题
```
$cat encoding_example.py 
# encoding: utf-8
name = 'helló wörld from example'
$cat encoding.py 
# encoding: utf-8
from __future__ import unicode_literals
import encoding_example as a
b = 'helló wörld from this'
print b + a.name
$python encoding.py 
Traceback (most recent call last):
  File "encoding.py", line 6, in <module>
    print b + a.name
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 
in position 4: ordinal not in range(128)
```
---
class: inverse
## 原因是: encoding_example里面没有对文字自动转化为unicode,默认是ascii编码
```
$cat encoding.py 
# encoding: utf-8

>>> from __future__ import unicode_literals
>>> import encoding_example as a
>>> b = 'helló wörld from this'
>>> print b + a.name.decode('utf-8')
helló wörld from thishelló wörld from example
>>> # 或者这样用:
>>> print b.encode('utf-8') + a.name
helló wörld from thishelló wörld from example
```
---
class: inverse
## super 当子类调用父类属性时一般的做法是这样
```
>>> class LoggingDict(dict): 
...     def __setitem__(self, key, value):
...         print('Setting {0} to {1}'.format(key, value))
...         dict.__setitem__(key, value)                                                                                   
```
### 问题是假如你继承的不是dict而是其他,那么就要修改2处,其实可以这样
```
>>> class LoggingDict(dict):
...     def __setitem__(self, key, value):
...         print('Setting {0} to {1}'.format(key, value))
...         super(LoggingDict, self).__setitem__(key, value)
```

### PS: 感觉super自动找到了LoggingDict的父类(dict)，然后把self转化为其实例
---
class: inverse
## 手写一个迭代器

```
>>> class Data(object):
...     def __init__(self):
...         self._data = []
...     def add(self, x):
...         self._data.append(x)
...     def data(self):
...         return iter(self._data)
...
>>> d = Data()
>>> d.add(1)
>>> d.add(2)
>>> d.add(3)
>>> for x in d.data():
...     print(x)
...
1
2
3

```
---
class: inverse
## 标准迭代器

```
>>> class Data(object):
...     def __init__(self, *args):
...         self._data = list(args)
...         self._index = 0
...     def __iter__(self):
...         return self
...     # 兼容python3
...     def __next__(self):
...         return self.next()
...     def next(self):
...         if self._index >= len(self._data):
...             raise StopIteration()
...         d = self._data[self._index]
...         self._index += 1
...         return d
...
>>> d = Data(1, 2, 3)
>>> for x in d:
...     print(x)
...
1
2
3
>>> d = Data(1, 2, 3)
>>> it = iter(d)
>>> next(it)
1
>>> next(it)
2
```
---
class: inverse
## 生成器

```
>>> class Data(object):
...     def __init__(self, *args):
...         self._data = list(args)
...     def __iter__(self):
...         for x in self._data:
...             yield x
...
>>> d = Data(1, 2, 3)
>>> for x in d:
...     print(x)
...
1
2
3
>>> (i for i in [1,2,3]) # 这是生成器表达式
<generator object <genexpr> at 0x10657a640>
```
---
class: inverse
## 斐波那契数列

```
>>> import itertools
>>>
>>> def fib():
...     a, b = 0, 1
...     while 1:
...         yield b
...         a, b = b, a + b
...
>>>
>>> print list(itertools.islice(fib(), 10))
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
```
---
class: inverse
## 其实yield和协程关系很密切

```
>>> def coroutine():
...     print "coroutine start..."
...     result = None
...     while True:
...         s = yield result
...         result = 'result: {}'.format(s)
...
>>> c = coroutine() # 函数返回协程对象
>>> c.send(None) # 使用 send(None) 或 next() 启动协程
coroutine start...
>>> c.send("first") # 向协程发送消息,使其恢复执⾏
'result: first'
>>> c.send("second")
'result: second'
>>> c.close() # 关闭协程,使其退出。或⽤c.throw() 使其引发异常
>>> c.send("never recv")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
```

---
class: inverse
## 来个回调(阻塞的)

```
>>> def framework(logic, callback):
...     s = logic()
...     print "[FX] logic: ", s
...     print "[FX] do something"
...     callback("async: " + s)
...
>>> def logic():
...     s = "mylogic"
...     return s
...
>>> def callback(s):
...     print s
...
>>> framework(logic, callback)
[FX] logic:  mylogic
[FX] do something
async: mylogic
```
---
class: inverse
## 来个回调(异步的)

```
>>> def framework(logic):
...     try:
...         it = logic()
...         s = next(it)
...         print "[FX] logic: ", s
...         print "[FX] do something"
...         it.send("async: " + s)
...     except StopIteration:
...          pass
...
>>> def logic():
...     s = "mylogic"
...     r = yield s
...     print r
...
>>> framework(logic)
[FX] logic:  mylogic
[FX] do something
async: mylogic
```
---
class: inverse
## 实现一个with上下文管理类(自动关闭mongodb连接)
```
>>> import pymongo
>>> class Operation(object):
...     def __init__(self, database,
...                  host='localhost', port=27017):
...         self._db = pymongo.MongoClient(
...                       host, port)[database]
...     def __enter__(self):
...         return self._db
...     def __exit__(self, exc_type, exc_val, exc_tb):
...         self._db.connection.disconnect()
...
>>> with Operation(database='test') as db:
...     print db.test.find_one()
...
{u'a': 0.9075717522597431, u'_id': ObjectId('52e0da5cc23e7dbdb0a1ec36')}
```
---
class: inverse
## 看到这里, 就得说说contextmanager
```
@contextlib.contextmanager
def some_generator(<arguments>):
    <setup>
    try:
        yield <value>
    finally:
        <cleanup>
with some_generator(<arguments>) as <variable>:
    <body>
```

也就是:

```
    <setup>
    try:
        <variable> = <value>
        <body>
    finally:
        <cleanup>
```
---
class: inverse
## contextmanager例子(一)
```
>>> lock = threading.Lock()
>>> @contextmanager
... def openlock():
...     print('Acquire')
...     lock.acquire()
...     yield
...     print('Releasing')
...     lock.release()
... 
>>> with openlock():
...     print('Lock is locked: {}'.format(lock.locked()))
...     print 'Do some stuff'
... 
Acquire
Lock is locked: True
Do some stuff
Releasing
```
---
class: inverse
## contextmanager例子(二)
```
>>> @contextmanager
... def openlock2():
...     print('Acquire')
...     with lock: # threading.Lock其实就是个with的上下文管理器.
...         # __enter__ = acquire
...         yield
...     print('Releasing')
... 
>>> with openlock2():
...     print('Lock is locked: {}'.format(lock.locked()))
...     print 'Do some stuff'
... 
Acquire
Lock is locked: True
Do some stuff
Releasing
```
---
class: inverse
## contextmanager例子(三)
```
>>> @contextmanager
... def operation(database, host='localhost', 
                  port=27017):
...     db = pymongo.MongoClient(host, port)[database]
...     yield db
...     db.connection.disconnect()
... 
>>> import pymongo
>>> with operation('test') as db:
...     print(db.test.find_one())
... 
{u'a': 0.9075717522597431, u'_id': ObjectId('52e0da5cc23e7dbdb0a1ec36')}
```
---
class: inverse
## 包导入

```
>>> import imp
>>> f, filename, description = imp.find_module('sys')
>>> sys = imp.load_module('sys', f, filename, description)
>>> sys
<module 'sys' (built-in)>
>>> os = __import__('os')
>>> os.path
<module 'posixpath' from '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/posixpath.pyc'>
>>> filename = "t.py"
>>> f = open("t.py")
>>> description = ('.py', 'U', 1)
>>> t = imp.load_module('some', f, filename, description) # t就是`import t`后的结果
```
---
class: inverse
## 包构建\_\_all\_\_

```
因为 import 实际导⼊的是⺫标模块 globals 名字空间中的成员,
那么就有⼀个问题: 模块也会导⼊其他模块,这些模块同样在⺫标模块
的名字空间中. "import *" 操作时,所有这些一并被带入到当前模
块中,造成一定程度的污染

__all__ = ["add", "x"]
```
---
class: inverse
## 包构建\_\_path\_\_

```
某些时候,包内的文件太多,需要分类存放到多个目录中,但⼜不想拆分
成新的包或⼦包。这么做是允许的, 只要在 __init__.py 中⽤
__path__ 指定所有⼦目录的全路径即可 (⼦目录可放在包外)

<dir>
  |_ __init__.py
  |
  |_ a <dir>
  .  |_ add.py
  |
  |_ b <dir>
|_ sub.py

from os.path import abspath, join
subdirs = lambda *dirs: [abspath(
    join(__path__[0], sub)) for sub in dirs]
__path__ = subdirs("a", "b")
```
---
class: inverse
## 静态方法和类方法的区别

```
>>> class User(object):
...     def a(self):
...         print 'a'
...     @staticmethod
...     def b():
...         print 'b'
...     @classmethod
...     def c(cls):
...         print 'c'
>>> u = User()
>>> u.a(), u.b(), u.c()
(a, b, c)
>>> User.a()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unbound method a() must be called with User instance as first argument (got nothing instead)
>>> User.b()
b
>>> User.c()
c
```
---
class: inverse
## 静态方法和类方法的区别其实是在这里

```
>>> class User(object):
...     a = 1
...     @staticmethod
...     def b():
...         print self.a
...     @classmethod
...     def c(cls):
...         print cls.a
>>> u = User()
>>> u.b()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 5, in b
NameError: global name 'self' is not defined
>>> User.b()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 5, in b
NameError: global name 'self' is not defined
>>> u.c(), User.c()
(1, 1)
```
---
class: inverse
## \_\_slots\_\_ 大量属性时减少内存占用

```
>>> class User(object):
...     __slots__ = ("name", "age")
...     def __init__(self, name, age):
...         self.name = name
...         self.age = age
...
>>> u = User("Dong", 28)
>>> hasattr(u, "__dict__")
False
>>> u.title = "xxx"
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'User' object has no attribute 'title'
```
---
class: inverse
## Packaging Tools的未来

### "./setup.py install must die"
### pip > 1.6已经消除pip对setuptools的依赖
![History](img/pypa.png)
### [Warehouse-Next Generation Python Package Repository](https://warehouse.readthedocs.org/)
### [Demo-server](https://pypi-preview.a.ssl.fastly.net/)
---
class: inverse
## wheel(即将替代Eggs的二进制包格式)的优点

### 1. 有官方的PEP427支持
### 2. 打包后不包含pyc文件
### 3. 一个wheel包可以提供多python版本标签甚至系统架构

---
class: inverse
## 装饰器

### 普通装饰器

```
>>> def common(func):
...     def _deco(*args, **kwargs):
...         print 'args:', args
...         return func(*args, **kwargs)
...     return _deco
...
>>> @common
... def test(p):
...     print p
...
>>> test
<function _deco at 0x10d996a28>
>>> test(1)
args: (1,)
1

```
---
class: inverse
## 装饰器

### 给函数的类装饰器(避免在装饰器对象上保留状态)

```
>>> class Common(object):
...     def __init__(self, func):
...         self.func = func
...     def __call__(self, *args, **kwargs):
...         print 'args:', args
...         return self.func(*args, **kwargs)
...
>>>
>>> @Common
... def test(p):
...     print p
...
>>> test
<__main__.Common object at 0x10d99bf50>
>>> test(1)
args: (1,)
1
```
---
class: inverse
## 装饰器
### 给类的函数装饰器

```
>>> def borg(cls):
...     cls._state = {}
...     orig_init = cls.__init__
...     def new_init(self, *args, **kwargs):
...         self.__dict__ = cls._state
...         orig_init(self, *args, **kwargs)
...     cls.__init__ = new_init
...     return cls
>>> @borg
... class A(object):
...     def common(self):
...         print hex(id(self))
>>> a, b = A(), A()
>>> b.d
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'A' object has no attribute 'd'
>>> a.d = 1
>>> b.d
1
```
---
class: inverse
## 装饰器
### 带参数的装饰器

```
>>> def common(*args, **kw):
...     a = args
...     def _common(func):
...         def _deco(*args, **kwargs):
...             print 'args:', args, a
...             return func(*args, **kwargs)
...         return _deco
...     return _common
...
>>> @common('c')
... def test(p):
...     print p
...
>>> test
<function _deco at 0x10d99e5f0>
>>> test(1)
args: (1,) ('c',)
1

```
---
class: inverse
## @property

```
>>> class C(object):
...     def __init__(self):
...         self._x = None
...     def getx(self):
...         print 'get x'
...         return self._x
...     def setx(self, value):
...         print 'set x'
...         self._x = value
...     def delx(self):
...         print 'del x'
...         del self._x
...     x = property(getx, setx, delx, "I'm the 'x' property.")
...
>>> c = C()
>>> c.x = 12
set x
>>> c.x
get x
12
>>> del c.x
del x
```
---
class: inverse
## @property的另外使用方法

```
>>> class Parrot(object):
...     def __init__(self):
...         self._voltage = 100000
...     @property
...     def voltage(self):
...         """Get the current voltage."""
...         return self._voltage
...     @voltage.setter
...     def voltage(self, value):
...         """Set to current voltage."""
...         self._voltage = value
...
>>> c = Parrot()
>>> c.voltage
100000
>>> c.voltage = 200
>>> c.voltage
200
```
---
class: inverse
## 描述符
###1. 当希望对某些类的属性进行特别的处理而不会对整体的其他属性有影响的话,可以使用描述符
###2. 只要一个类实现了\_\_get\_\_、\_\_set\_\_、\_\_delete\_\_方法就是描述符
###3. 描述符会"劫持"那些本对于self.\_\_dict\_\_的操作
###4. 把一个类的操作托付与另外一个类
###5. 静态方法, 类方法, property都是构建描述符的类
---
class: inverse
## 描述符的例子
```
>>> class MyDescriptor(object):
...     _value = ''
...     def __get__(self, instance, klass):
...         return self._value
...     def __set__(self, instance, value):
...         self._value = value.swapcase()
>>> class Swap(object):
...     swap = MyDescriptor()
>>> instance = Swap()
>>> instance.swap
''
>>> # 对swap的属性访问被描述符类重载了
>>> instance.swap = 'make it swap'
>>> instance.swap
'MAKE IT SWAP'
>>> instance.__dict__ # 没有用到__dict__:被劫持了
{} 
```
---
class: inverse
## 深入描述符
```
>>> def t(): # 随便定义个函数(或者lambda匿名函数)
...     pass
... 
>>> dir(t)
['__call__', '__class__', '__closure__', '__code__',
'__defaults__', '__delattr__', '__dict__', '__doc__',
'__format__', '__get__', '__getattribute__', '__globals__',
'__hash__', '__init__', '__module__', '__name__', '__new__',
'__reduce__', '__reduce_ex__', '__repr__', '__setattr__',
'__sizeof__', '__str__', '__subclasshook__', 'func_closure',
'func_code', 'func_defaults', 'func_dict', 'func_doc',
'func_globals', 'func_name']
注意: **t有__get__方法.**
总结: 所有 Python 函数都默认是一个描述符. 
这个描述符的特性在"类"这一对象上下文之外没有任何意义，
但只要到了类中:
instance.swap变成了:
Swap.__dict__['swap'].__get__(instance, Swap)
```
---
class: inverse
## 一个开源实现
```
>>> class cached_property(object):
...     # from werkzeug.utils import cached_property
...     def __init__(self, func, name=None, doc=None):
...         self.__name__ = name or func.__name__
...         self.__module__ = func.__module__
...         self.__doc__ = doc or func.__doc__
...         self.func = func
...     def __get__(self, obj, type=None):
...         if obj is None:
...             return self
...         value = obj.__dict__.get(self.__name__, _missing)
...         if value is _missing:
...             value = self.func(obj)
...             obj.__dict__[self.__name__] = value
...         return value
```
---
class: inverse
## 用python实现静态方法和类方法
```
>>> class myStaticMethod(object):
...     def __init__(self, method):
...         self.staticmethod = method
...     def __get__(self, object, type=None):
...         return self.staticmethod
... 
>>> class myClassMethod(object):
...     def __init__(self, method):
...         self.classmethod = method
...     def __get__(self, object, klass=None):
...         if klass is None:
...             klass = type(object)
...         def newfunc(*args):
...             return self.classmethod(klass, *args)
...         return newfunc
```
---
class: center, middle, inverse
# 元类......
## Metaclasses
---
class: inverse
## 元类是什么

### 对象是类的实例，类是它的元类的实例

```
>>> class Myclass(): pass # 不要学我的写法
>>> type(Myclass)
<type 'classobj'>
>>> class Myclass(object): pass
>>> type(Myclass)
<type 'type'>
>>> type(type)
<type 'type'>
>>> class Myclass: # 对于这个例子,有没有括号都无所谓
...     __metaclass__ = type
>>> type(Myclass)
<type 'type'>
>>> print Myclass
<class '__main__.Myclass'>
>>> print Myclass()
<__main__.Myclass object at 0x10d9ad190>
```
---
class: inverse
## 模拟生成一个类
```
>>> def __init__(self, func):
...     self.func = func
>>> def hello(self):
...     print 'hello world'
>>> attrs = {'__init__': __init__, 'hello': hello}
>>> bases = (object,)
>>> Hello = type('Hello', bases, attrs)
>>> h = Hello(lambda a, b=3: a + b)
>>> h.hello()
hello world
# 其实等于下面的类
class Hello(object):
    def __init__(self, func):
        self.func = func
    def hello(self):
        print 'hello world'
```
---
class: inverse
## 元类: \_\_metaclass\_\_(实现前面的Hello类)

```
class HelloMeta(type): # 注意继承至type
    def __new__(cls, name, bases, attrs):
        def __init__(cls, func):
            cls.func = func
        def hello(cls):
            print 'hello world'
        t = type.__new__(cls, name, bases, attrs)
        t.__init__ = __init__
        t.hello = hello
        return t # 要return创建的类哦

class New_Hello(object):
    __metaclass__ = HelloMeta
```
---
class: inverse
## 难懂的元类

```
>>> hellometa = lambda name, parents, attrs: type(
...     name,
...     parents,
...     dict(attrs.items() + [
...         ('__new__', classmethod(
...          lambda cls, *args, **kargs:
...             super(type(cls), cls).__new__(
...                 *args, **kargs)
...         )),
...         ('hello', hello),
...         ('__init__', __init__)
...     ])
... )
>>> class New_Hello2(object):
...     __metaclass__ = hellometa
>>> h = New_Hello2(lambda x:x)
>>> h.func(1)
1
>>> h.hello()
hello world

```
---
class: inverse
## 模块: itertools(一)
```
>>> def chunker(items, chunk_size):
...     for _key, group in itertools.groupby(
...         enumerate(items), lambda x: x[0] // chunk_size):
...             yield [g[1] for g in group]
>>> for i in chunker(range(10), 4):
...     print list(i)
[0, 1, 2, 3]
[4, 5, 6, 7]
[8, 9]
>>> l = [(1, 10), (2, 10), (3, 20), (4, 20)]
>>> for key, group in itertools.groupby(l, lambda t: t[1]):
...     print(key, list(group))
(10, [(1, 10), (2, 10)])
(20, [(3, 20), (4, 20)])
```
### chain: 把多个迭代器合并成一个迭代器
### islice: 迭代器分片islice(func, start, end, step)
---
class: inverse
## 模块: itertools(二)
```
>>> def chunker(items, chunk_size):
...     args = [iter(items)] * chunk_size
...     return itertools.izip_longest(*args)
... 
>>> for i in chunker(range(10), 4):
...     print filter(lambda x:x, list(i))
... 
[1, 2, 3]
[4, 5, 6, 7]
[8, 9]
```
---
class: inverse
## 模块: collections(一)
```
>>> collections.Counter(words).most_common(10) #word就是个单词列表
[('the', 1143), ('and', 966), ('to', 762), ('of', 669), ('i', 631),
 ('you', 554),  ('a', 546), ('my', 514), ('hamlet', 471), ('in', 451)]
 >>> Q = collections.deque()
 >>> Q.append(1)
 >>> Q.appendleft(2)
 >>> Q.extend([3, 4])
 >>> Q.extendleft([5, 6])
 >>> Q
 deque([6, 5, 2, 1, 3, 4])
 >>> Q.pop()
 4
 >>> Q.popleft()
 6
 >>> Q
 deque([5, 2, 1, 3])
 >>> Q.rotate(3)
 >>> Q
 deque([2, 1, 3, 5])
 >>> Q.rotate(-3)
 >>> Q
 deque([5, 2, 1, 3])
```
---
class: inverse
## 模块: collections(二)
```
>>> m = dict((str(x), x) for x in range(10))
>>> print ', '.join(m.keys())
1, 0, 3, 2, 5, 4, 7, 6, 9, 8
>>> m = collections.OrderedDict((str(x), x) for x in range(10))
>>> print ', '.join(m.keys())
0, 1, 2, 3, 4, 5, 6, 7, 8, 9
>>> d = {}
>>> for k, v in [('a', 1), ('c', 2), ('a', 3)]:
...     if k in d:
...         d[k] += v
...     else:
...         d[k] = v
>>> d
{'a': 4, 'c': 2}
>>> m = collections.defaultdict(int)
>>> m['a']
0
>>> for k, v in [('a', 1), ('c', 2), ('a', 3)]:
...     m[k]+= v
>>> m
defaultdict(<type 'int'>, {'a': 4, 'c': 2})
```
---
class: inverse
## 模块: collections(三)

```
其实类似于这样的:
>>> d = {}
>>> for k, v in s:
...     d.setdefault(k, []).append(v)
...
# 默认值是1的defaultdict
>>> g = collections.defaultdict(lambda :1)
>>> g['a'] += 1
>>> g['a']
2
>>> g['b']
1
```
---
class: inverse
## 模块: collections(四)

```
>>> class Mytype(list):
...     def insort(self, arr):
...         bisect.insort_left(self, arr)
...
>>>
... d = defaultdict(Mytype)
>>> d['l'].insort(1)
>>> d['l'].insort(9)
>>> d['l'].insort(4)
>>> print d['l']
[1, 4, 9]
>>> d['a']
[]
```
---
class: inverse
## operator模块(一)
### 用operator写伪lisp
```
>>> reduce(+, (5, 4, 3, 2, 1))
  File "<stdin>", line 1
    reduce(+, (5, 4, 3, 2, 1))
            ^
SyntaxError: invalid syntax
>>> reduce(operator.add, (5, 4, 3, 2, 1))
15
>>> def f(op, *args):
...     return {
...         '+' : operator.add,
...         '-' : operator.sub,
...         '*' : operator.mul,
...         '/' : operator.div,
...         '%' : operator.mod 
...     }[op](*args)
>>> f('*', f('+', 1, 2), 3)
9
```
---
class: inverse
## operator模块(二)
```
>>> l = [1, 2, 3, 4, 5]
>>> operator.itemgetter(1)(l)
2
>>> operator.itemgetter(1,3,4)(l)
(2, 4, 5)
>>> inventory = [('apple', 3), ('banana', 2),
                 ('pear', 5), ('orange', 1)]
>>> sorted(inventory, key=operator.itemgetter(1))
[('orange', 1), ('banana', 2), ('apple', 3), ('pear', 5)]
>>> operator.methodcaller('hello')(h) # 等于h.hello()
hello world
# 等于h.func('a', b=2)
>>> operator.methodcaller('func', 1, b=2)(h)
>>> operator.attrgetter('platform')(sys)
'darwin'
>>> operator.attrgetter('platform', 'maxint')(sys)
('darwin', 9223372036854775807)
```
---
class: inverse
## operator模块(三)
```
>>> class a:
...     '''a"s doc'''
...     class b:
...         c = 1
... 
>>> a.b.c
1
>>> reduce(getattr, 'b.c'.split('.'), a)
1
>>> from operator import attrgetter
>>> attrgetter('b.c')(a)
1
>>> attrgetter('b', '__doc__')(a)
(<class __main__.b at 0x10e563d50>, 'a"s doc')
```
---
class: inverse
## functools模块
### functools.partial 冻结部分函数位置函数或关键字参数，简化函数

```
>>> h = Hello(lambda a, b=3: a + b)
>>> functools.partial(h.func, b=10)(1)
11
>>> import urllib3
>>> make_headers = functools.partial(urllib3.make_headers, keep_alive=True,
                                     user_agent="Batman/1.0")
>>> make_headers(accept_encoding=True)
{'connection': 'keep-alive', 'accept-encoding': 'gzip,deflate', 'user-agent': 'Batman/1.0'}
# 相当于:
>>> make_headers(accept_encoding=True, keep_alive=True, user_agent="Batman/1.0")
```
---
class: inverse
## functools模块
### wraps 把被封装函数的__name__、module、__doc__和 __dict__都复制到封装函数去
### partial(update_wrapper, wrapped=wrapped, assigned=assigned, updated=updated)的简写

```
>>> def common(func):
...     def _deco(*args, **kwargs):
...         '''In _deco'''
...         return func(*args, **kwargs)
...     return _deco
>>> @common
... def test(p):
...     '''In test'''
...     print p
>>> test.__doc__
'In _deco'
```
---
class: inverse
## functools模块
### 加上functools.wraps

```
>>> def common(func):
...     #@wraps(func) # 注意这句
...     def _deco(*args, **kwargs):
...         '''In _deco'''
...         return func(*args, **kwargs)
...     return _deco
...
>>> @common
... def test(p):
...     '''In test'''
...     print p
...
>>> test
<function test at 0x105b1fa28>
>>> test.__doc__
'In test'
```
---
class: inverse
## functools模块
### functools.cmp_to_key 将老式比较函数转换成key函数，用在接受key函数的方法中
1. sorted(), min(), max(), heapq.nlargest(),
2. heapq.nsmallest(), itertools.groupby()

```
>>> def mycmp(x, y):
...     x, y = int(x), int(y)
...     return (x > y) - (x < y) # 不能用cmp 因为python3已经没有了
...
>>> values = [5, '3', 7, 2, '0', '1', 4, '10', 1]
>>> sorted(values, key=functools.cmp_to_key(mycmp))
['0', '1', 1, 2, '3', 4, 5, 7, '10']
>>> cmp(1, 2)
-1
>>> cmp(2, 2)
0
>>> cmp(3, 2)
1
>>> max(values, key=functools.cmp_to_key(mycmp))
'10'
```
---
class: inverse
## functools模块

### functools.total_ordering(一)
```
>>> @total_ordering
... class Test:
...     def __init__(self, value):
...         self.value = value
...     def __lt__(self, other):
...         return self.value < other.value
...
>>> vars(Test) # 注意哦  没有__eq__
{'__module__': '__main__',
'__le__': <function __le__ at 0x105b26500>, '__ge__': <function __ge__ at 0x105b26578>, 
'__gt__': <function __gt__ at 0x105b23b90>, '__lt__': <function __lt__ at 0x105b26488>,
'__doc__': None, '__init__': <function __init__ at 0x105b26410>}
>>> Test(1) < Test(2)
True
>>> Test(3) < Test(2)
False
>>> Test(2) <= Test(2) # 看 答案不对
False
```
---
class: inverse
## functools模块
### functools.total_ordering(二)
```
>>> @total_ordering
... class Test:
...     def __init__(self, value):
...         self.value = value
...     def __lt__(self, other):
...         return self.value < other.value
...     def __eq__(self, other):
...         return self.value == other.value
...
>>> Test(2) <= Test(2) # 答案这次对了
True
```
---
class: inverse
## 开发陷阱(一) 可变默认参数
```
>>> def append_to(element, to=[]):
...     to.append(element)
...     return to
... 
>>> my_list = append_to(12)
>>> my_list
[12]
>>> my_other_list = append_to(42)
>>> my_other_list
[12, 42] # Oh, no~
```
### 原因: 函数创建是其to及创建(一次性的),以后调用都是操作这个列表
```
def append_to(element, to=None):
    if to is None:
        to = []
    to.append(element)
    return to
```
---
class: inverse
## 开发陷阱(二) 闭包变量绑定
```
>>> def create_multipliers():
...     return [lambda x : i * x for i in range(5)]
... 
>>> for multiplier in create_multipliers():
...     print multiplier(2)
... 
8
8
8
8
8
### 看下面的例子
>>> def create_multipliers():
...     s = [lambda x : i * x for i in range(5)]
...     print locals()['i']
...     return s
... 
>>> create_multipliers()
4 # 是的 i其实在循环后已经变成了常量4
[<function <lambda> at 0x10b654b18>, <function <lambda> at 0x10b654b90>,
<function <lambda> at 0x10b654c08>, <function <lambda> at 0x10b654c80>,
<function <lambda> at 0x10b654de8>]
```
---
class: inverse
## 开发陷阱(二) 闭包应该的用法
```
>>> def create_multipliers():
...     return [lambda x, i=i : i * x for i in range(5)]
... 
或者这样:
from functools import partial
from operator import mul

def create_multipliers():
    return [partial(mul, i) for i in range(5)]
```
---
class: center, middle, inverse
# 个人建议
## 1. 在合适的地方用合适的技巧
## 2. 不是它不好,而是你没有用好
---
class: inverse
## ipython的技巧(一)
### 1. ipython的autoreload(不需要退出交互模式在重新import,类似于tornado的autoreload)
### 2. ipython的storemagic(存储对象,下次进入交互模式继续使用)
### 3. ipython的save(保存某些历史记录到某文件里面)
### 4. python/ipython交互模式历史记录搜索
```
$cat ~/.inputrc
## arrow up
"\e[A":history-search-backward
## arrow down
"\e[B":history-search-forward
```
---
class: inverse
## ipython的技巧(二)
### 5. ipython的logstart(会话记录, 退出后ipython -i ipython_log.py获取原来的会话)
### 6. ipython的pastebin(将执行命令保存到github的gist)
---
class: center, middle, inverse
# Q &amp; A
---
class: center, middle, inverse
## 联系方式

### Website: [小明明s à domicile](http://www.dongwm.com)

### GitHub: [dongweiming](http://github.com/dongweiming)

### Gmail: [ciici123@gmail.com](mailto:ciici123@gmail.com)

---
class: center, middle, inverse
# 谢谢大家
#### Made in [Remark](http://remarkjs.com)
    </textarea>
    <script src="js/remark.min.js" type="text/javascript"></script>
    <script type="text/javascript">
      var slideshow = remark.create({
        highlightStyle: 'monokai',
        highlightLanguage: 'remark'
      });
    </script>
  </body>
</html>

