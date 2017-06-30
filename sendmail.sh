#!/bin/bash
curl -s --user 'api:key-*YOURKEYID*' \
    https://api.mailgun.net/v3/sandbox*ID*.mailgun.org/messages \
    -F from='VPN Alert <mailgun@sandbox*ID*.mailgun.org>' \
    -F to=*YOUR MAIL ADDRESS* \
    -F subject='VPN on Proxy 1 ' \
    -F text='Looks like VPN is down and please restart it'
