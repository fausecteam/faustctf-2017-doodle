#!/usr/bin/python

import requests
import datetime
import random

from urllib.parse import urlparse, parse_qs
from defusedxml.minidom import parseString
from defusedxml.ElementTree import fromstring, tostring

from ctf_gameserver.checker import BaseChecker, OK, NOTFOUND, NOTWORKING

from IPython import embed

_NS = {'h': 'http://www.w3.org/1999/xhtml'}


class PollGenerator:
    def __init__(self):
        self._title = random.choice(['Birthday Party',
                                     'Awesome CTF',
                                     'Orga Meeting'
                                     ])
        self._date = datetime.datetime.now() + datetime.timedelta(minutes=random.uniform(0,120))


    @property
    def title(self):
        return self._title

    @property
    def date(self):
        return self._date


class CommentGenerator:
    def __init__(self, flag=None):
        self._name = (random.choice(['John', 'Jane', 'Alice', 'Bob', 'Carol', 'Dave', 'Eve']),
                      random.choice(['Doe', 'Duck', 'AAAAAAAA']))
        if flag is None:
            fortunes = []
            with open('/usr/share/games/fortunes/pratchett.u8', 'r') as f:
                fortunes = fortunes + f.read().split('%')
            with open('/usr/share/games/fortunes/magic.u8', 'r') as f:
                fortunes = fortunes + f.read().split('%')

            self._text = random.choice(fortunes)
        else:
            self._text = flag


    @property
    def text(self):
        return self._text

    @property
    def name(self):
        return ' '.join(self._name)


class DoodleChecker(BaseChecker):
    def __init__(self, tick, team, service, ip):
        BaseChecker.__init__(self, tick, team, service, ip)
        self._session = requests.session()
        self._data = dict()


    @staticmethod
    def _postprocess(data):
        return data.replace(b'&nbsp;', b' ')


    @staticmethod
    def _prettyprint(etree):
        data = parseString(tostring(etree))
        print(data.toprettyxml())


    def _create_new_poll(self, dom):
        polldata = PollGenerator()
        form = dom.find('.//h:form', _NS)

        data = dict()
        data['28'] = 'Create'

        hidden = form.findall('.//h:input[@type="hidden"]', _NS)
        for hid in hidden:
            data[hid.attrib['name']] = hid.attrib.get('value', '')

        # title
        data['5'] = polldata.title
        # Date, Month += 6
        data['20'], data['6'], data['19'] = polldata.date.year, polldata.date.month + 6, polldata.date.day
        # time
        data['22'], data['23'] = polldata.date.hour, polldata.date.minute

        homepage = self._session.post('http://%s/seaside/doodle' % self._ip, data=data)
        if homepage.status_code != 200:
            return NOTWORKING

        dom = fromstring(self._postprocess(homepage.content))
        tokendom = dom.find('.//h:body/h:p/h:span[@class="access-token"]', _NS)
        query = parse_qs(urlparse(homepage.url).query)
        self._data['polltoken'] = tokendom.text
        self._data['pollid'] = query['pollId'][0]
        resltcode = self._add_comment(dom, CommentGenerator(flag=self.get_flag(self.tick)))
        if resltcode != OK:
            return resltcode

        return OK


    def _add_comment(self, dom, commentdata):
        addcomment = dom.find('.//h:body/h:a', _NS)
        href = addcomment.attrib['href']
        rawresponse = self._session.get(href)
        if rawresponse.status_code != 200:
            return NOTWORKING

        dom = fromstring(rawresponse.content)
        form = dom.find('.//h:form', _NS)
        data = dict()

        hidden = form.findall('.//h:input[@type="hidden"]', _NS)
        for hid in hidden:
            data[hid.attrib['name']] = hid.attrib.get('value', '')

        data['5'] = commentdata.name
        data['6'] = commentdata.text
        data['7'] = 'Create'

        rawresponse = self._session.post('http://%s/seaside/doodle' % self._ip, data=data)
        if rawresponse.status_code != 200:
            return NOTWORKING

        dom = fromstring(rawresponse.content)
        return OK


    def check_flag(self, tick):
        yaml = self.retrieve_yaml(str(tick))
        if yaml is None:
            return NOTFOUND

        homepage = self._session.get('http://%s/seaside/doodle?pollId=%s' % (self._ip, yaml['pollid']))
        if homepage.status_code != 200:
            return NOTFOUND

        dom = fromstring(homepage.content)
        form = dom.find('.//h:form', _NS)
        data = dict()

        hidden = form.findall('.//h:input[@type="hidden"]', _NS)
        for hid in hidden:
            data[hid.attrib['name']] = hid.attrib.get('value', '')

        data['5'] = yaml['polltoken']
        rawresponse = self._session.post('http://%s/seaside/doodle' % self._ip, data=data)
        if rawresponse.status_code != 200:
            return NOTWORKING

        dom = fromstring(rawresponse.content)
        resltcode = self._add_comment(dom, CommentGenerator())
        if resltcode != OK:
            return resltcode

        comments = dom.findall('.//h:div[@class="poll-comment-box"]/h:p', _NS)
        flag = self.get_flag(tick)
        for comment in comments:
            self.logger.info(repr(comment.text), repr(flag))
            if flag == comment.text:
                return OK

        return NOTFOUND


    def place_flag(self):
        homepage = self._session.get('http://%s/seaside/doodle' % self._ip)
        if homepage.status_code != 200:
            return NOTWORKING

        dom = fromstring(homepage.content)
        newpollitem = dom.find('./h:body//h:li[@class="pure-menu-item"][h:a="New Poll"]/h:a', _NS)
        newpoll = self._session.get(newpollitem.attrib['href'])
        if newpoll.status_code != 200:
            return NOTWORKING

        newpolldom = fromstring(self._postprocess(newpoll.content))
        resltcode = self._create_new_poll(newpolldom)

        if resltcode != OK:
            return resltcode

        self.store_yaml(str(self.tick), self._data)
        return OK
