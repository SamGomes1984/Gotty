#!/bin/bash

# Start the SSH service
service ssh start

# Start ttyd for web-based terminal access
/usr/local/bin/ttyd bash
