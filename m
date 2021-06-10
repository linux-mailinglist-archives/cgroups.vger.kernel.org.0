Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEC3A3258
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFJRm6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 13:42:58 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:46970 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFJRm5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 13:42:57 -0400
Received: by mail-qt1-f182.google.com with SMTP id a15so436533qtx.13;
        Thu, 10 Jun 2021 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWOZidZP0x7GLTaV0tNbVWE6yJUvGbKMUKncxkGIKXc=;
        b=XPC6uYHLKCsy9omlrkaT8PtT4NlJhA4tDwIVebFGd3BKERAT8QsJZ5Q4mcqyl4Wpar
         uLbl9EK46Q5uyJ8hiT+QFeCqqL8DzIrIV9uImuGmRorRcyIPZ11KS7Kr1GkySBLMRNzP
         UUIJkekElO9+gtz56QtAKcdpKrFm9ofEi3WlwmkSHIn2zZHJHxLAHs3jSYCzHYdDcS+a
         zP45WFAebM7tEJjwI0oCGEq+sjCMPfs8MERECC0QCT0Em1G/tZYgXqmGvlBneZ5zeuFc
         j/syk/iQ6rQYop9pxjVnh1/Q2sH5y6Ocb6NbmJ1mmv5DgQ6flUPSVRkYMz+/xWeP1brp
         B+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWOZidZP0x7GLTaV0tNbVWE6yJUvGbKMUKncxkGIKXc=;
        b=oUGnkyQeaeaMyoTIR6K6anu+cUWNGIN8DBAk26lrGQ8HQE0h76PB+Fe7CKiLLgyXvk
         wvQ0LQeo3HddVqU9bU5cBw7SSGD1+l4fbi3st02O10fb2JwwAqbu3YWkfUT31dzcLtPE
         LJqrPqeu1avBI7PXWAIgGk8C+Z+ARnOuB7yYpiLBVlSbBYKeWim6PPYVIV3kUTP3GXjU
         ZwgYtlG2wjPMaOO+8A7j04zVCAuqud3mHvRwCtuhG1MtNjKcNxOoRPlhWwmpnZkegRDi
         2VUPCvMRdJaPrsGwB0wYrcJkR9jseRkOT2ZMmih4FlnjNr4BEZTur3Y+PqWmgHcgnFNO
         skLw==
X-Gm-Message-State: AOAM533SBE5+Usu7GzpGaLdkTeZdezHI0jkKWmLhljS1i/ObC33Qteg6
        kr/OhcwIkUlt1GGp0FfZ9xbTh+QUoCc=
X-Google-Smtp-Source: ABdhPJz1aG5jgPo2g+XJbpQSi3wtAkb4E9Zp6iQ7OEkJHzLAoSKEOAi6jqi90A6lfGUsAsqPQZCFZQ==
X-Received: by 2002:ac8:7311:: with SMTP id x17mr790791qto.3.1623346795690;
        Thu, 10 Jun 2021 10:39:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be7a])
        by smtp.gmail.com with ESMTPSA id 104sm2667808qta.90.2021.06.10.10.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:39:55 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH V14 0/3] Charge loop device i/o to issuing cgroup
Date:   Thu, 10 Jun 2021 10:39:41 -0700
Message-Id: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Rebased on top of mm-tree

As per the suggestion last time [1], could this go through the -mm
tree to deal with memcg conflicts?

[1] https://lore.kernel.org/lkml/CALvZod6FMQQC17Zsu9xoKs=dFWaJdMC2Qk3YiDPUUQHx8teLYg@mail.gmail.com/

Changes since V13:

* Small change to get_mem_cgroup_from_mm to return early when the
  return is root memcg
* Avoid allocating loop worker if the issuing blkcg is root_blkcg

Changes since V12:

* Small change to get_mem_cgroup_from_mm to avoid needing
  get_active_memcg

Changes since V11:

* Removed WQ_MEM_RECLAIM flag from loop workqueue. Technically, this
  can be driven by writeback, but this was causing a warning in xfs
  and likely other filesystems aren't equipped to be driven by reclaim
  at the VFS layer.
* Included a small fix from Colin Ian King.
* reworked get_mem_cgroup_from_mm to institute the necessary charge
  priority.

Changes since V10:

* Added page-cache charging to mm: Charge active memcg when no mm is set

Changes since V9:

* Rebased against linus's branch which now includes Roman Gushchin's
  patch this series is based off of

Changes since V8:

* Rebased on top of Roman Gushchin's patch
  (https://lkml.org/lkml/2020/8/21/1464) which provides the nesting
  support for setting active memcg. Dropped the patch from this series
  that did the same thing.

Changes since V7:

* Rebased against linus's branch

Changes since V6:

* Added separate spinlock for worker synchronization
* Minor style changes

Changes since V5:

* Fixed a missing css_put when failing to allocate a worker
* Minor style changes

Changes since V4:

Only patches 1 and 2 have changed.

* Fixed irq lock ordering bug
* Simplified loop detach
* Added support for nesting memalloc_use_memcg

Changes since V3:

* Fix race on loop device destruction and deferred worker cleanup
* Ensure charge on shmem_swapin_page works just like getpage
* Minor style changes

Changes since V2:

* Deferred destruction of workqueue items so in the common case there
  is no allocation needed

Changes since V1:

* Split out and reordered patches so cgroup charging changes are
  separate from kworker -> workqueue change

* Add mem_css to struct loop_cmd to simplify logic

The loop device runs all i/o to the backing file on a separate kworker
thread which results in all i/o being charged to the root cgroup. This
allows a loop device to be used to trivially bypass resource limits
and other policy. This patch series fixes this gap in accounting.

A simple script to demonstrate this behavior on cgroupv2 machine:

'''
#!/bin/bash
set -e

CGROUP=/sys/fs/cgroup/test.slice
LOOP_DEV=/dev/loop0

if [[ ! -d $CGROUP ]]
then
    sudo mkdir $CGROUP
fi

grep oom_kill $CGROUP/memory.events

# Set a memory limit, write more than that limit to tmpfs -> OOM kill
sudo unshare -m bash -c "
echo \$\$ > $CGROUP/cgroup.procs;
echo 0 > $CGROUP/memory.swap.max;
echo 64M > $CGROUP/memory.max;
mount -t tmpfs -o size=512m tmpfs /tmp;
dd if=/dev/zero of=/tmp/file bs=1M count=256" || true

grep oom_kill $CGROUP/memory.events

# Set a memory limit, write more than that limit through loopback
# device -> no OOM kill
sudo unshare -m bash -c "
echo \$\$ > $CGROUP/cgroup.procs;
echo 0 > $CGROUP/memory.swap.max;
echo 64M > $CGROUP/memory.max;
mount -t tmpfs -o size=512m tmpfs /tmp;
truncate -s 512m /tmp/backing_file
losetup $LOOP_DEV /tmp/backing_file
dd if=/dev/zero of=$LOOP_DEV bs=1M count=256;
losetup -D $LOOP_DEV" || true

grep oom_kill $CGROUP/memory.events
'''

Naively charging cgroups could result in priority inversions through
the single kworker thread in the case where multiple cgroups are
reading/writing to the same loop device. This patch series does some
minor modification to the loop driver so that each cgroup can make
forward progress independently to avoid this inversion.

With this patch series applied, the above script triggers OOM kills
when writing through the loop device as expected.

Dan Schatzberg (3):
  loop: Use worker per cgroup instead of kworker
  mm: Charge active memcg when no mm is set
  loop: Charge i/o to mem and blk cg

 drivers/block/loop.c       | 250 +++++++++++++++++++++++++++++++------
 drivers/block/loop.h       |  15 ++-
 include/linux/memcontrol.h |   6 +
 kernel/cgroup/cgroup.c     |   1 +
 mm/filemap.c               |   2 +-
 mm/memcontrol.c            |  42 ++++---
 mm/shmem.c                 |   4 +-
 7 files changed, 258 insertions(+), 62 deletions(-)

-- 
2.30.2

