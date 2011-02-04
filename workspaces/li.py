#!/usr/bin/python

import os
import glob
import optparse
from workspace import Workspace

(options, args) = optparse.OptionParser().parse_args()

if len(args) == 0:
    # list available workspaces
    ws = Workspace.all()
    for i in range(len(ws)):
        workspace = ws[i]
        has_sessions = workspace.has_sessions()
        star = ''
        if has_sessions:
            star = ' *'
        note = workspace.note() or ""
        if note:
            note = " " * 16 + note
        print "%d: %s%s%s" % (i, workspace.name(), star, note)
else:
    i = int(args[0])
    Workspace.all()[i].open()
