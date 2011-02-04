#!/usr/bin/python

from __future__ import with_statement

import os
import glob
import optparse
from workspace import Workspace

def all_workspaces():
    return [Workspace(f) for f in glob.glob(os.path.join(os.path.expanduser('~'), Workspace.WORKSPACE_DIR, '*'))]

(options, args) = optparse.OptionParser().parse_args()

if len(args) == 0:
    # list available workspaces
    ws = all_workspaces()
    for i in range(len(ws)):
        has_sessions = ws[i].has_sessions()
        str = ''
        if has_sessions:
            str = ' *'
        print "%d: %s%s" % (i, ws[i].name(), str)
else:
    i = int(args[0])
    all_workspaces()[i].open()
