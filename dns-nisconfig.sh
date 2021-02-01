#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"

subfinder -all --silent -d $1 | httpx -silent -follow-redirects -mc 200 | cut -d '/' -f3 | sort -u > alive;
cat alive | httpx -follow-redirects -silent -mc 404 >> dead;
for i in $(cat alive)
do
        host localhost.$i | grep -qs '127.0.0.1' && echo -e "${GREEN} $i DNS Missconfig ${NC}" || echo -e "${RED} $i  Not Vulnerable ${NC}" > result

done