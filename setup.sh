#!/bin/bash

echo -e "[+] Creating dir structure for CTFd - Ghidra Golf"
# create CTFd files w/ non-root perms
mkdir -p .data/{CTFd,mysql,redis}
mkdir -p .data/CTFd/uploads;
touch .data/CTFd/{access.log,error.log,logins.log,registrations.log,submissions.log}
sudo chown 1001:1001 -R .data/CTFd;

if [[ $? -eq 0 ]]; then
    echo -e "[*] Directories created successfully, spawning docker-compose"
    docker-compose up -d;
    echo -e "[*] After CTFd has spawned, update create_example_tokens.sh with your CTFd API token.\nThen execute the script \"create_example_challenges.sh\" to create example challenges.\nNote: CTFd does not provide an API endpoint to connect binaries to challenges. You will still have to manually upload them."
else
		echo -e "[!] Error! Quitting!"
		exit 1;
fi
