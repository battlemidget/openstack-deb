#!/bin/bash

. /usr/share/conjure/hooklib/common.sh

if [[ $JUJU_PROVIDERTYPE =~ "lxd" ]]; then
    debug openstack "(post-bootstrap) processing lxd"

    cat lxd-profile.yaml | lxc profile edit juju-`juju switch`

    RET=$?
    if [ $RET -ne 0 ]; then
        exposeResult "Failed" $RET "false"
    else
        exposeResult "Post bootstrap complete" 0 "true"
    fi

elif [[ $JUJU_PROVIDERTYPE =~ "maas" ]]; then
    debug openstack "(post-bootstrap) processing MAAS selection"

    exposeResult "Post complete" 0 "true"
else
    debug openstack "(post-bootstrap) unknown provider type $JUJU_PROVIDERTYPE"

    exposeResult "Unknown provider type" 1 "false"
fi
