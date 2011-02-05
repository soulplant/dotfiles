#!/usr/bin/python

import optparse
from workspace import Workspace

class WSPrompt(object):
    def __init__(self, args, commands):
        self._args = args
        self._commands = {}
        for c in commands:
            self._commands[c.name()] = c
        self._default_command = commands[0]

    def run(self):
        (ws, args) = self.prompt_for_workspace()
        if ws is None:
            pass
        elif len(args) == 0:
            self._default_command.run(ws, args)
        elif args[0] in self._commands:
            self._commands[args[0]].run(ws, args)
        else:
            print "Unknown command: %s" % args[0]

    def prompt_for_workspace(self):
        if len(self._args) == 0:
            ws = Workspace.all()
            for i in range(len(ws)):
                print "%d: %s" % (i, ws[i].summary_line())
            return (None, [])
        else:
            i = int(self._args[0])
            return (Workspace.all()[i], self._args[1:])
