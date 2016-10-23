#!/bin/bash

set -m 
exec "$@" &

while ! nc -z localhost 8080; do sleep 10; done

curl -X POST -H "Accept: application/json" -H "Authorization: Basic YWRtaW4=" -H "Content-Type: application/json" -d '{
    "@type": "Plone Site",
    "title": "Plone 1",
    "id": "plone",
    "description": "Description"
}' "http://127.0.0.1:8080/zodb1/"


curl -X POST -H "Accept: application/json" -H "Authorization: Basic YWRtaW4=" -H "Content-Type: application/json" -d '{
    "prinrole": {
        "Anonymous User": ["plone.Member", "plone.Reader"]
    }
}' "http://127.0.0.1:8080/zodb1/plone/@sharing"

curl -X POST -H "Accept: application/json" -H "Authorization: Basic YWRtaW4=" -H "Content-Type: application/json" -d '{
    "@type": "Item",
    "title": "News",
    "id": "news"
}' "http://127.0.0.1:8080/zodb1/plone/"

fg
