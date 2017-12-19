#!/bin/sh

set -e

S3_ACL=${S3_ACL:-private}

[[ -d $MOUNT_POINT ]] && rm -rf $MOUNT_POINT

mkdir -p $MOUNT_POINT

/usr/bin/s3fs ${S3_BUCKET} ${MOUNT_POINT} -o nosuid,nonempty,nodev,allow_other,default_acl=${S3_ACL},retries=5

exec "$@"