import os
from tmux import Tmux

class Workspace(object):
    WORKSPACE_DIR='.workspaces'
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
