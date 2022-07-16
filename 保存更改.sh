#!/usr/bin/sh
just commit || true

https_proxy="http://127.0.0.1:1081" git push origin main
