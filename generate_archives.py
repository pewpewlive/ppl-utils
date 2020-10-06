#!/usr/bin/python

import os

configs = [{'params':"GOOS=windows GOARCH=amd64", 'name':"windows-x64"}, 
           {'params':"GOOS=windows GOARCH=386", 'name':"windows-x32"},
           {'params':"GOOS=darwin GOARCH=amd64", 'name':"macos-x64"},
           {'params':"GOOS=linux GOARCH=amd64", 'name':"linux-x64"},
           {'params':"GOOS=linux GOARCH=386", 'name':"linux-x32"},
           {'params':"GOOS=linux GOARCH=arm64", 'name':"linux-arm64"},
           {'params':"GOOS=linux GOARCH=arm", 'name':"linux-arm"}]

for config in configs:
  os.system("rm ppl-utils")
  os.system("rm ppl-utils.exe")
  os.system("rm -rf ppl-utils")
  os.system("mkdir -p ppl-utils")
  os.system("env " + config['params'] + " go build .")
  os.system("mv ppl-utils.exe ppl-utils/")
  os.system("mv ppl-utils ppl-utils/")
  os.system("cp -r content/ ppl-utils/content/")
  os.system("find . -name \".DS_Store\" -delete")
  os.system("zip -r ppl-utils-" + config['name'] + ".zip ppl-utils")

os.system("rm -rf ppl-utils")
