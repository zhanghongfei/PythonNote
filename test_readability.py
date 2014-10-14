#coding: utf-8
'''
    pip install readability-api
'''

import re
from readability import ParserClient
from HTMLParser import HTMLParser

# 在 readability 官网申请账号 在 account 下激活邮箱就可以获取
TOKEN = 'xxxxxxxxx'


def parser_content(url):

    pc = ParserClient(TOKEN)
    req = pc.get_article_content(url)
    return req.content


def strip_html_tags(content):

    # 去html标签
    res = re.sub(r'<[^>]+>', '', content).strip()
    # 去html转移字符
    h = HTMLParser()
    return h.unescape(res)


if __name__ == '__main__':

    url = 'http://blog.sina.com.cn/s/blog_13a7d94150102v7lj.html'
    #url = 'http://tech.sina.com.cn/i/2014-10-14/14279692232.shtml'
    #url = 'http://tech.sina.com.cn/i/2014-10-14/04569690622.shtml'

    req = parser_content(url)
    content = strip_html_tags(req.get('content', ''))
    title = strip_html_tags(req.get('title', ''))
    print 'title >>', title
    print 'content >>', content
