# !/bin/bash
# This script will sync your local repository to your remote respoistory
# once you enter in the path to the two locations.

sudo rsync -avh --delete ssh ~/stoneleaf/local/ user@[SERVER]:/path/to/library
