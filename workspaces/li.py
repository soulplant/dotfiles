#!/usr/bin/python

from wsprompt import WSPrompt
import optparse

(options, args) = optparse.OptionParser().parse_args()

ws = WSPrompt(args).run()

if ws:
    ws.open()
