#!/usr/bin/python

from __future__ import with_statement

import os
import glob
import optparse

WORKSPACE_DIR = '/Users/jameskozianski/.workspaces'
PROJECT_EXTENSION = '.proj'

(options, args) = optparse.OptionParser().parse_args()

project_path = os.getcwd()
project_name = args[0]
del(args[0])

files = []
for arg in args:
	files.extend(glob.glob(arg))

with open(os.path.join(WORKSPACE_DIR, project_name + PROJECT_EXTENSION), 'w') as f:
	f.write(project_path + "\n\n")
	[f.write(file + "\n") for file in files]
