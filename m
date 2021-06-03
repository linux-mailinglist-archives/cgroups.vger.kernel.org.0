Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D1039A3CD
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhFCPAK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 11:00:10 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36435 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhFCPAK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 11:00:10 -0400
Received: by mail-qk1-f169.google.com with SMTP id i68so2610714qke.3;
        Thu, 03 Jun 2021 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlJ05cns3Kw02wHzy/fk7shZWnWXqFlVRCeogh0cQHs=;
        b=QwulaL5sAsbuU3RVIk5owgrkT1UhnwT/VbRG1Xs3XZImPch+XRmXTfjyN78iC274iy
         Izp0D6p8IEw4k37j3ujrwZeTvwWerC+BCYatRHtIRGlSzuD4rUhXoFRh5zrhzv2Qg6GI
         YoSb3jNprRJHK8Aaeuj8tDirOvpyF2ACPDo3G+6y2eFtT88DCa5VP+Qo5pIA05dp7Aif
         w9KDnDBKZyobpCl+SU1T+6CVxzU1KEmCepAREiIyK4oulr/fznqMaIT41w5JZz8ROkEa
         DEc3B0oRBTzxYWTR8bxizx6hs8tfyZ7mqnUSmMeo3Z8NYaYyDWuawMYMXlpWaZxJw9Im
         bYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlJ05cns3Kw02wHzy/fk7shZWnWXqFlVRCeogh0cQHs=;
        b=imVgtLnuy2T8i6pSlgiuzErCuX0X7396+nYY8hr28aH9rN34nb7aCM6cmFnOqCPNXk
         kF1SDYHLVsoIO39sNB2lm6Q733y7W4dp5U1TwvCqK1/Rh6AlMqbsOvPzbgIlmEPcwIZ1
         PywJROQPs9pQonXyuRmcuqcr033HsJEsuQI+ovbkaL5nAVRUoIPTepP3YFxhYs75jB3J
         QnfxTtsTxdwQ/lG1hivMKZnAvIPVJvOj9QHwe59cM3Pc920v2ACQgcW4WHDVB6xtJGVo
         5ZCI3Lul8Ci7J6Eo+5onE8V39/X9GSYaPfE/qz79EeWTL3fiWnuW6rvXgFCJnpJjLwi/
         Uf+Q==
X-Gm-Message-State: AOAM5316Ee1mk9eYqPgPAMbilqUYTgcfFp6m6pfOvytfe36yj5+1Rzum
        v7M20H9QVO4I3xOSeGz8fQuGkSkfMdo=
X-Google-Smtp-Source: ABdhPJx0w507n2feT3WeLa9EFDutgCVqNm17jPyd7ic3GRRlfnlsM41RFs9FF4rQ/zgLCfePYtV7AA==
X-Received: by 2002:a05:620a:44c4:: with SMTP id y4mr24724qkp.216.1622732244807;
        Thu, 03 Jun 2021 07:57:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8008])
        by smtp.gmail.com with ESMTPSA id k124sm2011692qkc.132.2021.06.03.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:57:24 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH V13 0/3] Charge loop device i/o to issuing cgroup
Date:   Thu,  3 Jun 2021 07:57:04 -0700
Message-Id: <20210603145707.4031641-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No significant changes, rebased on Linus's tree.

Jens, this series was intended to go into the mm tree since it had
some conflicts with mm changes. It never got picked up for 5.12 and
the corresponding mm changes are now in linus's tree. This is mostly a
loop change so it feels more appropriate to go through the block tree.
Do you think that makes sense?

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

 drivers/block/loop.c       | 241 ++++++++++++++++++++++++++++++-------
 drivers/block/loop.h       |  15 ++-
 include/linux/memcontrol.h |   6 +
 kernel/cgroup/cgroup.c     |   1 +
 mm/filemap.c               |   2 +-
 mm/memcontrol.c            |  49 +++++---
 mm/shmem.c                 |   4 +-
 7 files changed, 250 insertions(+), 68 deletions(-)

-- 
2.30.2

