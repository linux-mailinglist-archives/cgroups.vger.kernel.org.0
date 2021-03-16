Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9033D7BC
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 16:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhCPPhf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhCPPhK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 11:37:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB0AC06174A;
        Tue, 16 Mar 2021 08:37:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so11932992qtq.4;
        Tue, 16 Mar 2021 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tkj0ia5hpCZDucubv8I4sizyR82LNTriAr2vMPAQj/E=;
        b=fmqt1PM3c9r4ycT0+M0peIYt0t0qYLcjBuaENLbx/bgURKlepe0/DFmwjyLv+NL1Bp
         6BU8XJAV59vNYUVC9nXjmBpPTRRNCP/CTiplDVoETJt9qLIDRkS7W2GRQKQczjlEU/yv
         NJ5y4i+hWh9cJyzwXPEsmB19k3cNXI7y8h4SyZmhZdnIIvSKoXFtqiMXn54u107oblhr
         qN9rTSkdIoB3UUciSVvUOqZeHFgmPwkCL456MECrA54N5VUoh3QnQqHqs+k3d4jOldwF
         cDzQ8oeLbXMQ+chuTZxAdS2KeMuB9lkB40aYVhq36Gfdj2n4zSKFXWJ4ANDmsMvl60rK
         qCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tkj0ia5hpCZDucubv8I4sizyR82LNTriAr2vMPAQj/E=;
        b=HwqfQDaEXxgjg66oPTiVLUDV1OT9+Mw09oUt5+0y+kVampVtzzdFVI8mwu1e8cDXCT
         qHV5lzZglMgs0EhaWkMFTFVNc3b1CqZ4+iyfZD9kIPF8ZumSI4Q219YvQrwgry2eTsiA
         XFAWcLVatDmQz27TgOyZc3PBPok+5XMbjj3LzJ8KJMEDKGdrqidObFOSWoiLQ19B+MAf
         GXxrmDEcOXCVJdYUlOaIIzc5A/PYKbeSNF1xsxW21lKG9Cw1XcHBOwgxR2lbKKobfjaH
         Jpvv3L46X6wxdfPz/Fu2JCukHt8fbOORw2cLHgPLf0l3lmfU5CQriGBHujTWugdLcEhD
         aB4g==
X-Gm-Message-State: AOAM531gUXV57hnjFzFE7SJP57NvuiBdSz07OYCg7dREBf4gVpx8C5A6
        lv6OEel7qOME8EAgxpWsgwU=
X-Google-Smtp-Source: ABdhPJwemAre0PlJRoHQM1SeNE4jPOqETZrw2LN1kDiEtB+J4YeYq2Pdj3MbPBjFrm3tG+aawQdU1A==
X-Received: by 2002:ac8:7f52:: with SMTP id g18mr273540qtk.250.1615909029421;
        Tue, 16 Mar 2021 08:37:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1ee])
        by smtp.gmail.com with ESMTPSA id v7sm15321005qkv.86.2021.03.16.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:37:09 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
Date:   Tue, 16 Mar 2021 08:36:49 -0700
Message-Id: <20210316153655.500806-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No major changes, just rebasing and resubmitting

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
 include/linux/memcontrol.h |  11 ++
 kernel/cgroup/cgroup.c     |   1 +
 mm/filemap.c               |   2 +-
 mm/memcontrol.c            |  15 ++-
 mm/shmem.c                 |   4 +-
 7 files changed, 242 insertions(+), 54 deletions(-)

-- 
2.30.2

