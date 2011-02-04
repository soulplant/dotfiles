#!/usr/bin/python

import optparse
from workspace import Workspace

(options, args) = optparse.OptionParser().parse_args()

if len(args) == 0:
    ws = Workspace.all()
    for i in range(len(ws)):
        print "%d: %s" % (i, ws[i].summary_line())
else:
    i = int(args[0])
    Workspace.all()[i].open()
