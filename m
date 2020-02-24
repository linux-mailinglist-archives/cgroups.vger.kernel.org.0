Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC29E16B3B4
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2020 23:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgBXWSH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Feb 2020 17:18:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36072 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWSG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Feb 2020 17:18:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id f3so7243960qkh.3;
        Mon, 24 Feb 2020 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tuG46v7pUNtXQODDHrjX+i51IKR3M2oYfS7laFORPp4=;
        b=XEpAdGo026I77uzxt7/HRuwG0Z3ke5/JatppxUYtFyVC7CZO/badnU2tLHdHpc7SQs
         LxRFS9iknH4NyfX/AQqvLkzYm0urksQlsKHuN5mQwQ2OSRx8CermDM7iWC9OTgoj7LDw
         qpOIhqv5qlSSt4FWsAmR/8ZEEwtKaLN9TECZ6IGCtzzy+ulUSUz2nw1DP1/DSnxY5EcI
         4hBqe8dOgP+t95iSSDy1aS67ojRZrqZiTQFfAFBxWBE1AayChECN+sXvulVRYglTIkEq
         wzdtBxOaWYMUH+YEG9gFBXdZF41ySIe+aKtyt/pXvBIaw4SBHmwq0f9riXNn4n3sb5BN
         Tc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tuG46v7pUNtXQODDHrjX+i51IKR3M2oYfS7laFORPp4=;
        b=AKTSMEWnoobCuDjZSE4A0lYqFEBWrpl927laELkCQ55HMteDvi8eVJL6rCBQhGtRM0
         GZFjAyTONRvYIw6xZgMQ72AEuaT0BUBxz3MOBgUX9sFlj4CgInic/KUQsAyXExdk4VoS
         46A75s9RG27vC1SMB59n8/zWV7G/ZqHkXKyVI+hWom6NVPbgN1GD3vHSoHlmrN5MFUzH
         jYWGdxWy5YOU26ggD8rZ0tO5Uc2Vp521bQrsXjksL1/ebfRlLbM9+zWdxYg+Fa4Xj5VA
         CFHe/Sto5nxr5LuxE9polZVxHEnKx3+JRYXttSZHujvzHEWdtcUL5b9vTA9bF8iy7tex
         68nQ==
X-Gm-Message-State: APjAAAXS+l7kOjWG1Sufjh5Xdri3ubZMLKvkfXX9y0z3Cni5OJVLK21D
        tMVpBwbDZ0IYtkfK8oVf7Zs=
X-Google-Smtp-Source: APXvYqwuPk7+hhjm59kepkZOFZVJxYndmI2m8lWGURnJAjQVfx6w4pZF1QXH2n28q2DSmYnrMolx/w==
X-Received: by 2002:a37:7746:: with SMTP id s67mr51588255qkc.127.1582582684427;
        Mon, 24 Feb 2020 14:18:04 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:500::2:b19b])
        by smtp.gmail.com with ESMTPSA id o17sm6648870qtj.80.2020.02.24.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:18:03 -0800 (PST)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v3 0/3] Charge loop device i/o to issuing cgroup
Date:   Mon, 24 Feb 2020 17:17:44 -0500
Message-Id: <cover.1582581887.git.schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

 drivers/block/loop.c       | 246 +++++++++++++++++++++++++++++++------
 drivers/block/loop.h       |  14 ++-
 include/linux/memcontrol.h |   6 +
 kernel/cgroup/cgroup.c     |   1 +
 mm/memcontrol.c            |  11 +-
 mm/shmem.c                 |   4 +-
 6 files changed, 235 insertions(+), 47 deletions(-)

-- 
2.17.1

