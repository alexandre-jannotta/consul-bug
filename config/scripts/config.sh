#!/usr/bin/env sh

url='http://server-0.server.paris-consul.svc:8500'
token='d8a5fa60-cc67-499b-d363-94128d44b2d1'

consul acl policy create \
    -http-addr ${url} \
    -token ${token} \
    -name 'client' \
    -rules 'node_prefix "" {
  policy = "write"
}
service_prefix "" {
  policy = "write"
}
key_prefix "" {
  policy = "write"
}
'

consul acl token create \
    -http-addr ${url} \
    -token ${token} \
    -description 'client' \
    -policy-name 'client' \
    -accessor 'aaab1e0a-d91b-f689-5f71-33b1305c6d2c' \
    -secret '6a414ac2-850f-7921-2ba2-141ee456f966'

consul acl policy create \
    -http-addr ${url} \
    -token ${token} \
    -name 'dns' \
    -rules 'node_prefix "" {
  policy = "read"
}
service_prefix "" {
  policy = "read"
}
'

consul acl token update \
    -http-addr ${url} \
    -token ${token} \
    -id '00000000-0000-0000-0000-000000000002' \
    -policy-name 'dns'
