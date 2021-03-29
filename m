Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2913434D2BB
	for <lists+cgroups@lfdr.de>; Mon, 29 Mar 2021 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhC2OtU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhC2Osz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Mar 2021 10:48:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B085C061574;
        Mon, 29 Mar 2021 07:48:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 1so8820731qtb.0;
        Mon, 29 Mar 2021 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SrhRYacxLlj/HDLWdt9e70QVg4KZ/37qGsIxhEHOfQ=;
        b=bnloEp7HixUEx2GuoGaWnZPs0X9sobCEVYM4s55n8xs4VmBDp22IYYkoENeEFjLtoe
         afVNeOtlv8I3d91sVOWjFY+8RIfZ9PWxoFiLwMeLWdfcK3XAiq4AlTn+wx86Pgc/c0j9
         gPzpuyqrOYTUw8n/MeEwdu//hnwJHzz4ocoIg7Bw1kF3CkOCMOU2BRENZTmuWJ2hAhkn
         9WpAwe2jBIIbXX5EVz/Jm26JifmlRwzsxmJnlpBOBRKkMC9qgnmaCseCcUaVYiiKK7Hv
         UnnyBtjWHJJtsyHJ7LNZbIgSMhEHvww4GIRBKJIYlrXFV3lK0AczOsSiD6fR77uwfJ5I
         F+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SrhRYacxLlj/HDLWdt9e70QVg4KZ/37qGsIxhEHOfQ=;
        b=djzVc47YyomxCz24egrc6OWUNlaKUgisaFzFQlIzzY+S43md21wVc1/E8Fcnddab6W
         yj+kUOCLyvGjdWonx9R54xO0zdRMxsmT6IcsPGSZj2IHjz5nzuu8drWoWPSyS0Gh7z/+
         7cK59umbi9YMBDVE2vYmD0wR5j7USKEDzLxWXLx+SYelDudAIOLlcl1y0J6cpNpJ2u9b
         SQXhigrokqu1vK1mVMGRjX9sO3cMxJ4a8bSN74L2P9XxbKaVTeZXL2MmsroaT9hDrdFs
         Q2fyRqUkU5hvLYQ2c7Q+x1Ish0AV+uvhzKSaibyRdmAK4EuQOStWZNb0Ff7hPA/Bk4CA
         MwuQ==
X-Gm-Message-State: AOAM533miUV9mY64HaxgRj3+SdR40miORMHqpCmji4ULI8LQ8l4FV9TW
        e0DqqyF3n91fgefZu2xVscc=
X-Google-Smtp-Source: ABdhPJwbrme1KH7Nk2u72pH+gk3PhRmgaJmwTfVNx6y49YRCRk3O0LqCiHcT/4+IUaa8utO1fVZcvQ==
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr23567641qtu.276.1617029334613;
        Mon, 29 Mar 2021 07:48:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6ffc])
        by smtp.gmail.com with ESMTPSA id q24sm13156066qki.120.2021.03.29.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:48:54 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH V11 0/3] Charge loop device i/o to issuing cgroup
Date:   Mon, 29 Mar 2021 07:48:22 -0700
Message-Id: <20210329144829.1834347-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No major changes, rebased on top of latest mm tree

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

 drivers/block/loop.c       | 248 ++++++++++++++++++++++++++++++-------
 drivers/block/loop.h       |  15 ++-
 include/linux/memcontrol.h |   6 +
 kernel/cgroup/cgroup.c     |   1 +
 mm/filemap.c               |   2 +-
 mm/memcontrol.c            |  73 ++++++-----
 mm/shmem.c                 |   4 +-
 7 files changed, 267 insertions(+), 82 deletions(-)

-- 
2.30.2

