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
            self.print_commands()

    def prompt_for_workspace(self):
        no_args = len(self._args) == 0
        if no_args:
            self.print_workspaces()
            return (None, [])
        i = self._parse_index(self._args[0])

        if i is None:
            print "Invalid index: %s" % self._args[0]
            self.print_usage()
            self.print_workspaces()
            return (None, [])

        ws = Workspace.all()
        if i < 0 or i >= len(ws):
            print "Index out of range: %d" % i
            self.print_workspaces()
            return (None, [])

        return (ws[i], self._args[1:])

    def print_workspaces(self):
        ws = Workspace.all()
        for i in range(len(ws)):
            print "%d: %s" % (i, ws[i].summary_line())

    def print_usage(self):
        print "usage: li [index] [command] [args...]"
        self.print_commands()

    def print_commands(self):
        print "Valid commands are:"
        for command_name in self._commands.keys():
            print "\t%s" % command_name

    def _parse_index(self, i_str):
        try:
            return int(i_str)
        except ValueError:
            return None
