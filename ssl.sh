#!/bin/bash
cat <<EOF >/usr/local/kubernetes/ssl/ca-config.json
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "87600h"
      }
    }
  }
}
EOF


cat <<EOF >/usr/local/kubernetes/ssl/ca-csr.json


{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "XS",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

cat <<EOF >/usr/local/kubernetes/ssl/etcd-csr.json 
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "192.168.101.66",
    "192.168.101.77",
    "192.168.101.88"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "XS",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -ca=/usr/local/kubernetes/ssl/ca.pem -ca-key=/usr/local/kubernetes/ssl/ca-key.pem -config=ca-config.json -profile=kubernetes etcd-csr.json | cfssljson -bare etcd


cat <<EOF >/usr/local/kubernetes/ssl/apiserver-csr.json
{
  "CN": "kubernetes",
  "hosts": [
    "127.0.0.1",
    "192.168.101.66",
    "192.168.101.77",
    "192.168.101.88",
    "192.168.101.99",    
    "10.10.10.1",
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.default.svc.cluster.local"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "k8s",
      "OU": "seven"
    }
  ]
}
EOF

cfssl gencert -ca=/usr/local/kubernetes/ssl/ca.pem -ca-key=/usr/local/kubernetes/ssl/ca-key.pem -config=/usr/local/kubernetes/ssl/ca-config.json -profile=kubernetes apiserver-csr.json | cfssljson -bare apiserver  

cat <<EOF >/usr/local/kubernetes/ssl/controller-manager-csr.json

{
    "CN": "system:kube-controller-manager",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "hosts": [
      "127.0.0.1",
      "192.168.101.66",
      "192.168.101.77",
      "192.168.101.88"
    ],
    "names": [
      {
        "C": "CN",
        "ST": "BeiJing",
        "L": "BeiJing",
        "O": "system:kube-controller-manager",
        "OU": "seven"
      }
    ]
}
EOF

cfssl gencert -ca=/usr/local/kubernetes/ssl/ca.pem -ca-key=/usr/local/kubernetes/ssl/ca-key.pem -config=/usr/local/kubernetes/ssl/ca-config.json -profile=kubernetes controller-manager-csr.json | cfssljson -bare controller-manager


cat <<EOF >/usr/local/kubernetes/ssl/scheduler-csr.json
{
    "CN": "system:kube-scheduler",
    "hosts": [
      "127.0.0.1",
      "192.168.101.66",
      "192.168.101.77",
      "192.168.101.88"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
      {
        "C": "CN",
        "ST": "BeiJing",
        "L": "BeiJing",
        "O": "system:kube-scheduler",
        "OU": "seven"
      }
    ]
}
EOF


cfssl gencert -ca=/usr/local/kubernetes/ssl/ca.pem -ca-key=/usr/local/kubernetes/ssl/ca-key.pem -config=/usr/local/kubernetes/ssl/ca-config.json -profile=kubernetes scheduler-csr.json | cfssljson -bare kube-scheduler 



cat <<EOF >/usr/local/kubernetes/ssl/admin-csr.json

{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "system:masters",
      "OU": "seven"
    }
  ]
}
EOF

cfssl gencert -ca=/usr/local/kubernetes/ssl/ca.pem -ca-key=/usr/local/kubernetes/ssl/ca-key.pem -config=/usr/local/kubernetes/ssl/ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin

cat <<EOF >/usr/local/kubernetes/ssl/kube-proxy-csr.json
{
  "CN": "system:kube-proxy",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "k8s",
      "OU": "seven"
    }
  ]
}
EOF

cfssl gencert -ca=/usr/local/kubernetes/ssl/ca.pem -ca-key=/usr/local/kubernetes/ssl/ca-key.pem -config=/usr/local/kubernetes/ssl/ca-config.json -profile=kubernetes  kube-proxy-csr.json | cfssljson -bare kube-proxy
