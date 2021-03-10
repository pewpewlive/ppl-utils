#!/usr/bin/python

# This file generates the prebuilt binaries.

import os
import platform
import shutil

configs = [{'env':{'GOOS':'windows', 'GOARCH':'amd64'}, 'name':'windows-x64'},
           {'env':{'GOOS':'windows', 'GOARCH':'386'}, 'name':'windows-x32'},
           {'env':{'GOOS':'darwin', 'GOARCH':'amd64'}, 'name':'macos-x64'},
           {'env':{'GOOS':'linux', 'GOARCH':'amd64'}, 'name':'linux-x64'},
           {'env':{'GOOS':'linux', 'GOARCH':'386'}, 'name':'linux-x32'},
           {'env':{'GOOS':'linux', 'GOARCH':'arm64'}, 'name':'linux-arm64'},
           {'env':{'GOOS':'linux', 'GOARCH':'arm'}, 'name':'linux-arm'}]

for config in configs:
  directory_name = 'ppl-utils-' + config['name']
  print('Creating ' + directory_name + '.zip')

  # Try to remove the Linux/MacOS binary
  try:
    os.remove('ppl-utils')
  except:
    pass

  # Try to remove the Windows binary
  try:
    os.remove('ppl-utils.exe')
  except:
    pass

  # Try to remove the temporary directory we'll use
  try:
    shutil.rmtree(directory_name)
  except:
    pass

  # Create the temporary directory
  os.makedirs(directory_name)

  # Backup environment
  environment_backup = dict(os.environ)

  # Change environment
  for key in config['env']:
    os.environ[key] = config['env'][key]

  # Build
  os.system('go build .')

  # Restore original environment
  os.environ.clear()
  os.environ.update(environment_backup)

  # Move the binary to the temporary directory
  # Try Linux/macOS first
  if os.path.exists('ppl-utils'):
    shutil.move('ppl-utils', directory_name)
  # Try Windows second
  if os.path.exists('ppl-utils.exe'):
    shutil.move('ppl-utils.exe', directory_name)

  # Copy the other content
  shutil.copytree('content', directory_name + '/content')

  # Remove all .DS_Store from the directory
  for root, dirs, files in os.walk(directory_name):
    for file in files:
      if file == ".DS_Store":
        path = os.path.join(root, file)
        os.remove(path)

  # Zip the temporary directory
  shutil.make_archive(directory_name, 'zip', directory_name)

  # Try to remove the temporary directory
  try:
    shutil.rmtree(directory_name)
  except:
    pass
