#!/usr/bin/env bash

# config for work_nodes only 
kubeadm join 192.168.1.10:6443 --token ynubvp.41q3tia2ylqp7pjl \
        --discovery-token-ca-cert-hash sha256:e859a67868e72e981e26062548f20f516a85a120ed2ea3452635fd7804126a84
        