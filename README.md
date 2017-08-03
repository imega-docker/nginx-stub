# Nginx Stub

[![](https://images.microbadger.com/badges/image/imega/nginx-stub.svg)](http://microbadger.com/images/imega/nginx-stub "Get your own image badge on microbadger.com") [![CircleCI](https://circleci.com/gh/imega-docker/nginx-stub.svg?style=svg)](https://circleci.com/gh/imega-docker/nginx-stub) [![Build Status](https://travis-ci.org/imega-docker/nginx-stub.svg?branch=master)](https://travis-ci.org/imega-docker/nginx-stub)

## Usage

Run daemon with stub
```
$ docker run -d --name nginx_stub -v `pwd`/data:/data -p 80:80 imega/nginx-stub
```

Make expected file
```
$ cat expected-request.txt
PUT / HTTP/1.1
Host: server
User-Agent: curl/7.50.2
Accept: */*
Content-Length: 17
Content-Type: application/x-www-form-urlencoded

{"param":"value"}
```

Run curl and diff files
```
$ curl -s -X PUT -d '{"param":"value"}' http://ngix_stub
$ diff expected-request.txt data/*
```

## The MIT License (MIT)

Copyright © 2016 iMega <info@imega.ru>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
