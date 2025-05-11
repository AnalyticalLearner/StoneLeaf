# !/bin/bash

sudo rsync -avh --delete ssh ~/stoneleaf/local/ user@[SERVER]:/path/to/library
