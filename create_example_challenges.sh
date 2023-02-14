#!/bin/bash

CTFD_API_TOKEN=""
URL="127.0.0.1" #assuming default config in docker-compose

if [[ -z $CTFD_API_TOKEN ]]; then
	echo -e "[!] Obtain a API token via settings -> Access Tokens"
	exit 1;
fi

# Create Challenges
curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"1-helloworld", "value":10,
"description":"Leverage one of the templates to print \"hello world\".",
"category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"2-ghidra-metadata", "value":10,
"description":"This challenge will introduce you to exploring the FlatAPI.\n Look at the documentation for getCurrentProgram, and obtain the following:\n* The executable path\n* The name of the binary\n* The MD5 hash of the binary.",
"category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"3-references", "value":10,
"description":"References allow us to see where interesting code/strings are called within a binary. For this challenge obtain and print references to the **flag** functon.",
"category":"Putting Green",
"type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"4-called-functions", "value":10, "description":"This challenge will have you explore identifying functions that call other functions. Your goal is to complete the attached Ghida Script to print out which function calls secondMain", "category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"5-decompiler", "value":10,
"description":"Write a ghidra script that prints out the decompilation of the **first fuction** in the binary. Then print a MD5 hash of this decompilation.",
"category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"6-defined-data", "value":10,
"description":"Enumerate defined data sections to identify and print decoded base64 strings",
"category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"7-hello-patch", "value":10,
"description":"This challenge will explore patching with Ghidra. Patch Hello World to say \"Hello Ghidra\".",
"category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"8-evil-bytes", "value":10,
"description":"Identify the offset of the evil bytes within the binary", "category":"Putting Green", "type":"standard"}'

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" http://$URL/api/v1/challenges \
-d '{"name":"9-class-function","value":10,
"description":"Write a Ghidra Script to list the methods of each *global* class contained within this program. Then print the class name with the associated method.",
"category":"Putting Green", "type":"standard"}'

# Update flag w/ Ghidra Script answer
curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":1, "content":"hello world", "type":"multi", "data":"", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":2, "content":"/binaries/2-Metadata-Colection\n2-Metadata-Collection\nPUT_FILE_HASH_HERE", "type":"multi", "data":"", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":3, "content":"Reference to address offset: 0x004020f0\nReference to address offset: 0x004021e0\nReference to address offset: 0x004013c6\nReference to address offset: 0x00401424\nReference to address offset: 0x004015c5",
"type":"multi", "data":"", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":4, "content":"fread\nfwrite\nstrlen\ntolower\nprintf\nfopen\nfclose\nputs",
"type":"multi", "data":"", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":5, "content":"Decompilation or MD5 of decompilation goes here",
"type":"multi", "data":"", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":6, "content":"Decoded: welcome to the PGGA","type":"multi", "data":"", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":7, "content":"PUT offset to patch here", "type":"multi", "data":"hello world", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":8, "content":"Evil offset at: 0x004012ea", "type":"multi", "data":"hello world", "hidden":false}' http://$URL/api/v1/flags

curl -X POST -H "Content-Type: application/json" -H "Authorization: Token $CTFD_API_TOKEN" \
-d '{"challenge_id":9, "content":"class: example_Class method: example_method_1\n class: example_class: method: example_method_2",
"type":"multi", "data":"hello world", "hidden":false}' http://$URL/api/v1/flags
