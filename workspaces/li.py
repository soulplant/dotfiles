#!/usr/bin/python

from __future__ import with_statement

import os
import glob
import optparse

WORKSPACE_DIR='/Users/jameskozianski/.workspaces'

def all_workspaces():
    return [Workspace(f) for f in glob.glob(os.path.join(WORKSPACE_DIR, '*'))]

# TODO Break this out into its own file.
class Tmux(object):
    def __init__(self):
        pass

    def running(self):
        return self._exec('list-sessions') == 0

    def has_session(self, session_name):
        return self._exec('has-session -t %s' % session_name) == 0

    def attach(self, session_name, workspace, dir='.'):
        if self.has_session(session_name):
            self._exec('attach -t %s' % session_name, dir)
        else:
            self._exec('new -s %s "vim %s"' % (session_name, workspace), dir)

    def has_sessions(self, session_name):
        return self._exec('list-sessions | grep %s' % session_name) == 0

    def _exec(self, tmux_command, dir='.'):
        return os.system('(cd %s && tmux %s) 2>/dev/null 1>/dev/null' % (dir, tmux_command))

class Workspace(object):
    def test():
        pass

    def __init__(self, filename, tmux = Tmux()):
        self._filename = filename
        self._tmux = tmux

    def __str__(self):
        return 'Workspace[%s]' % self.name()

    def name(self):
        return os.path.basename(self._filename)

    def path(self):
        with open(self._filename) as f:
            return f.readline().rstrip()

    def open(self):
        self._tmux.attach(self.name(), self._filename, self.path())

    def has_sessions(self):
        return self._tmux.has_sessions(self.name())

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
