#!/bin/sh

/usr/sbin/sshd -E /sshd.log

tail -f /sshd.log
