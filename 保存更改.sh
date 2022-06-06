#!/usr/bin/sh
just commit || true

https_proxy="http://127.0.0.1:8124" git push origin main
