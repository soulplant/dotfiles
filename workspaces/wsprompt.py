#!/usr/bin/python

import optparse
from workspace import Workspace

(options, args) = optparse.OptionParser().parse_args()

class WSPrompt(object):
    def __init__(self, args):
        self._args = args

    def run(self):
        if len(args) == 0:
            ws = Workspace.all()
            for i in range(len(ws)):
                print "%d: %s" % (i, ws[i].summary_line())
            return None
        else:
            i = int(args[0])
            return Workspace.all()[i]
