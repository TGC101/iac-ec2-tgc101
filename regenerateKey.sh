#!/bin/bash

echo "Regenerate SSH KEY..."
ssh-keygen -q  -N  "" -f ~/.ssh/id_rsa <<< y > /dev/null
echo "Done"