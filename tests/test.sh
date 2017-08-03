#!/usr/bin/env bash

printf '%.0s-' {1..80}
echo

URL=$1

COUNT_TESTS=0
COUNT_TESTS_FAIL=0

assertTrue() {
    testName="$3"
    pad=$(printf '%0.1s' "."{1..80})
    padlength=78

    if [ "$1" != "$2" ]; then
        printf ' %s%*.*s%s' "$3" 0 $((padlength - ${#testName} - 4)) "$pad" "Fail"
        printf ' (expected %s, assertion %s)\n' "$1" "$2"
        let "COUNT_TESTS_FAIL++"
    else
        printf ' %s%*.*s%s\n' "$3" 0 $((padlength - ${#testName} - 2)) "$pad" "Ok"
    fi
    let "COUNT_TESTS++"
}

testGet() {
    rm -rf /data/*
    curl -s -A "curl" http://$URL/very/long/path?param=value
    ACTUAL=$(diff /data/* /tests/fixtures/testGet.txt;echo $?)

    assertTrue 0 $ACTUAL "$FUNCNAME"
}

testPost() {
    rm -rf /data/*
    curl -s -A "curl" -X POST -d '{"param":"value"}' http://$URL

    ACTUAL=$(diff /data/* /tests/fixtures/testPost.txt;echo $?)

    assertTrue 0 $ACTUAL "$FUNCNAME"
}

testPostMulti() {
    rm -rf /data/*
    curl -s -X POST -H 'Host: imega.club' -A "curl" -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3' --compressed -H 'Referer: http://imega.ru' -H 'Cookie: _ga=GA1.2.291932563.1441102384; nlsrv1022=true; nlsrv0=true; __utma=46259896.291932563.1441102384.1443433133.1443516390.2; nlsrv1363=true; _ym_uid=1462011024640116204; id=765456; token=1754391bf5473520c87679724a1d337270b2fce9; _ga=GA1.3.291932563.1441102384; REFERER=; _ym_visorc_17273296=w; _ym_isad=2; _dc_gtm_UA-27371119-1=1; _gat_UA-27371119-1=1; PHPSESSID=o3vhvbpg1jrvcse81ttop3ga65; _gali=agent-registration' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: multipart/form-data; boundary=---------------------------10350840203924731286393838' --data-binary $'-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[name]"\r\n\r\ndfgdgdfgdf sfgdfgdfg\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[email]"\r\n\r\ninfo@imega.ru\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[city]"\r\n\r\n\xd0\xa1\xd0\xb0\xd0\xbd\xd0\xba\xd1\x82-\xd0\x9f\xd0\xb5\xd1\x82\xd0\xb5\xd1\x80\xd0\xb1\xd1\x83\xd1\x80\xd0\xb3\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[site]"\r\n\r\nhttp://imega.ru\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[about]"\r\n\r\n\xd0\xb2\xd0\xb0\xd0\xbf \xd0\xb2\xd0\xbf \xd0\xb2\xd0\xb0\xd0\xbf \xd0\xb2\xd1\x80 \xd0\xb2\xd0\xb0\xd1\x80\xd0\xb2\xd0\xb0 \xd1\x80\xd0\xb0\xd0\xb2\xd1\x80 \xd0\xb2\xd0\xb0 \xd1\x80\xd0\xb0\xd0\xb2 \xd1\x80\xd0\xb0\xd0\xbf\xd1\x80 \xd0\xb0\xd0\xb2\xd1\x80 \r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[skills][]"\r\n\r\n0\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[skills][]"\r\n\r\n2\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[skills][]"\r\n\r\n4\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[works][]"\r\n\r\nhttp://imega.ru\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="example-placeholder"\r\n\r\n\r\n-----------------------------10350840203924731286393838\r\n\r\nContent-Disposition: form-data; name="form_registration[photo]"; filename="\xd0\xa1\xd0\xbd\xd0\xb8\xd0\xbc\xd0\xbe\xd0\xba \xd1\x8d\xd0\xba\xd1\x80\xd0\xb0\xd0\xbd\xd0\xb0 2016-09-16 \xd0\xb2 11.00.59.png"\r\nContent-Type: image/png\r\n\r\n---------------------------10350840203924731286393838--\r\n' http://$URL/very/long/path?param=value

    ACTUAL=$(diff /data/* /tests/fixtures/testPostMulti.txt;echo $?)

    assertTrue 0 $ACTUAL "$FUNCNAME"
}

testPut() {
    rm -rf /data/*
    curl -s -A "curl" -X PUT -d '{"param":"value"}' http://$URL

    ACTUAL=$(diff /data/* /tests/fixtures/testPut.txt;echo $?)

    assertTrue 0 $ACTUAL "$FUNCNAME"
}

testOptions() {
    rm -rf /data/*
    curl -s -A "curl" -X OPTIONS http://$URL
    ACTUAL=$(diff /data/* /tests/fixtures/testOptions.txt;echo $?)

    assertTrue 0 $ACTUAL "$FUNCNAME"
}

testGet
testPost
testPostMulti
testPut
testOptions

printf '%.0s-' {1..80}
echo
printf 'Total test: %s, fail: %s\n\n' "$COUNT_TESTS" "$COUNT_TESTS_FAIL"

if [ $COUNT_TESTS_FAIL -gt 0 ]; then
    exit 1
fi

exit 0
