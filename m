Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65216637D
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 17:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBTQwY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 11:52:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46704 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQwY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 11:52:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so4153718qkh.13;
        Thu, 20 Feb 2020 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XRtdyMfa57xpaqGTGErpzosHOBJSLkhLdrjsJIgZOk=;
        b=GMVJvohK6Uqosdx++Q1UIJDcIwc443iVBHapmNkU3PGw0Gp/Zvb4sb4UC5bp2Vqnjh
         3CNcPOyt+wKRKUoubWndo5lXBiYketttaeW/0TFZNT506r2ehW2MDLqDwKxIN4eTRL6l
         Bbe/9ss0aC0grEW3nn0C41VmK4UZ0iE4dj4Z897q8UHKgHY2T1n9bsgu9G2OYcIDvx+B
         u5klU2+Lw4xtVQXGaop6kWnEt+i2w3JLr/ZPKKBW51NDmVrAy3ZO3uQda80EIss6Qyv+
         H/1orrfd8yQMyvriQ2xSQnzBmiCfFYpDXHVpOfkmdv3fLAt2kdPWJQVF2RC+gEgheTWP
         kuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XRtdyMfa57xpaqGTGErpzosHOBJSLkhLdrjsJIgZOk=;
        b=G+EkzMfZLK8JIobcXun6VIP5s7QRHkO1Bv4yvlOk8MXrANg7RORytf8UoAF6LyO1Rr
         6BMToaBWkhWcHosSTRoBPN6aydx2E864HdkWJh0ltLCVyZqg7xJnNXEyApZEPN17ItLO
         HO91Eg4XB0emI85axoUGr+faTwdXXbqu0VHIm3SlBZdy9mvRo1Y9cPm96bUwd0JKhb5q
         Ut9dyapJ1fc5TRPzT5MfFbfpE+hwxCb9THjz01T4pIyFLdX3ux9a6e5TRBfCw6c5Qb9Q
         MyQiQDjmkl4eVRbIxEaQ7aZ1KgVx3MfBR0O9x+TaCXN0+PXQ7q7IhSTJy1JUk9eaOidf
         seDw==
X-Gm-Message-State: APjAAAUgs6fGLRLAL5hLdJjSKy14Cab87f2QoD26ARJjzgsupZpSX+Nm
        XssfXb1fToPloa5MQwMS9PI=
X-Google-Smtp-Source: APXvYqy4l4khgWGFmnhDAt5LoEZMVrOKFHi8JHSfYZBxEDUKoj4Q/uPqL9B528B9p2SSMSXiU0yT2A==
X-Received: by 2002:a37:a08f:: with SMTP id j137mr28457353qke.467.1582217543184;
        Thu, 20 Feb 2020 08:52:23 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:500::3:edb0])
        by smtp.gmail.com with ESMTPSA id t55sm43567qte.24.2020.02.20.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:52:22 -0800 (PST)
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
Date:   Thu, 20 Feb 2020 11:51:50 -0500
Message-Id: <cover.1582216294.git.schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

 drivers/block/loop.c       | 229 +++++++++++++++++++++++++++++++------
 drivers/block/loop.h       |  14 ++-
 include/linux/memcontrol.h |   6 +
 kernel/cgroup/cgroup.c     |   1 +
 mm/memcontrol.c            |  11 +-
 mm/shmem.c                 |   2 +-
 6 files changed, 217 insertions(+), 46 deletions(-)

-- 
2.17.1

