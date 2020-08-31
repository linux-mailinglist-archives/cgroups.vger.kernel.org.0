Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE62257D6D
	for <lists+cgroups@lfdr.de>; Mon, 31 Aug 2020 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHaPhW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Aug 2020 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgHaPhT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Aug 2020 11:37:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B064C061573;
        Mon, 31 Aug 2020 08:37:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cr8so638967qvb.10;
        Mon, 31 Aug 2020 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jiQBbNngqw8IuyIhXzfGIT0+JHoFfv7mtdOFjAup3WM=;
        b=nY4/WHzeh14Gz4k06j9sj2hHUQgb0o0vKw83EYBDo5y2WJsyE+naeliL14ibXte6Mg
         V5mlr5G5VXGwpvrJIAulVbWl2WMu0MNti1mRnLS/OFmdogahV8iuN8NTk2XzSBv8x9ug
         fnmLbmeCinlu+AvChQIYP8Th9ja5yiGygdDs5gFEZKzZlSnm96gGwPgLF2yGmUJ4EMHK
         N4pt7R5/46LHkh2qIlTjLtJVE7YGdciFYQJ+ekoKK/TGDyilTy0qJ4B2Lp9QIijcgE90
         skgwGyYDnLtjhGD3Qew2OzXoghx4qp7kvFLLtBBeXfyIFYlLYKEM8nqF8GcMCOp2yice
         ggrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jiQBbNngqw8IuyIhXzfGIT0+JHoFfv7mtdOFjAup3WM=;
        b=JamgA223/xcWaCVeoOik3jQVvnIxOba9Sb/JSaVtJv4+hoBsvwSHAzScjSuHY88HFM
         yU0KnlWmIXbWXU7c0IxeYNAZF/foDB4qU+E4U23Ma2nv6Su7t6tkI8vCDu2/ZJ5wNbYh
         L/lpUiy34Fh2JtvdRV/l88ZHlHPMbvqFDW2tFnaj5LIzjykRqa3S4Ry4mfug0DVnvLG7
         om53s908VqkDfNXYnSanBEjNCGLwWVitFdFKYPypRqo6zfILRk0kjDXxaTPLYZAXBTPh
         rCAqeMWG2x61g4AYVDXfztNWZDip2Z+ZgH6yOeHc3q48t69ATmaWbpC4570eKJ2WVwgL
         rexQ==
X-Gm-Message-State: AOAM531GFs6GH+BdsBqZhpNSnSXWhmWGtlhKETcnSY9BcwvbVkVvAeJJ
        yU9t23CJuesRchT7Uowaf5o=
X-Google-Smtp-Source: ABdhPJz4hqK1YGX+tTjEMtxf1tCzkK3llJ6iE4/enptUHC9YObIoMBc4iFMY8Ul+vZqN1hQDSBMxzQ==
X-Received: by 2002:a0c:ec86:: with SMTP id u6mr1613973qvo.58.1598888238587;
        Mon, 31 Aug 2020 08:37:18 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:2edc])
        by smtp.gmail.com with ESMTPSA id s5sm9908872qke.120.2020.08.31.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 08:37:17 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v8 0/3] Charge loop device i/o to issuing cgroup
Date:   Mon, 31 Aug 2020 11:36:57 -0400
Message-Id: <20200831153704.16848-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Much of the discussion about this has died down. There's been a
concern raised that we could generalize infrastructure across loop,
md, etc. This may be possible, in the future, but it isn't clear to me
how this would look like. I'm inclined to fix the existing issue with
loop devices now (this is a problem we hit at FB) and address
consolidation with other cases if and when those need to be addressed.

Note that this series needs to be based off of Roman Gushchin's patch
(https://lkml.org/lkml/2020/8/21/1464) to compile.

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
 mm/memcontrol.c            |  11 +-
 mm/shmem.c                 |   4 +-
 6 files changed, 232 insertions(+), 53 deletions(-)

-- 
2.24.1

