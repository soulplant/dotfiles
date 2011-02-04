#!/usr/bin/python

from wsprompt import WSPrompt
import optparse

(options, args) = optparse.OptionParser().parse_args()

ws = WSPrompt(args).run()

if ws:
    if len(args) > 1:
        ws.add_note(args[1])
    else:
        print "Usage: %s workspace-index note"
