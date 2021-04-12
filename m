Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63C735CA4E
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 17:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhDLPqF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbhDLPqE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 11:46:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B7C061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 08:45:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z15so2182480qtj.7
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kfoth3DUauDj/zrpRCce8PdDzNFJJLR4/XpIPoAKXQU=;
        b=Owzv05Whms1oDjuZM/6YbmVlFXK8+Ru+WOmEeTUw67LZ9MzyO3tjJcMFUYIgu8JsB/
         F+sdUXv/uPOYDFFOuLUXCEhTfHNicqCX2k8/+9mUBv6WL89MISNCnmgx/F/je51Oqvhh
         ZKfJQzNtFnPaqxkS5robFFOh/ZI2NYKdCGFjCaqgQJrNwko2SThfMxcwbaWyFYSq2cb8
         87AjDiof+oM9uMz9xSWz3ehvEmrX6eySasPvyQHIVtg+6Vr8Rtwy44bpcBJoyOZx/5yy
         YgGWHnrkJw2Q77RhyHZxAINS4Z2N8V8UXge4yxiozkuQWMOPCzhfLxSHpwy4L4YjZVW3
         kZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kfoth3DUauDj/zrpRCce8PdDzNFJJLR4/XpIPoAKXQU=;
        b=LA0KV+RSUKOC3Poof3SQeNEw6AQ42arDHY9PySGhRJRF3wR3Hce4GtHHmIHwksx/MX
         pn9r57PvoDkrZy8L88vAtGMXsvmoFOHCrwCT++tlMRfovdlZaads97s9TXk3DX3+9xEZ
         G241wuehyIzd/+pWE2it5bqInfZ1wS0SK2lt1BSsNGWt+n9Lg1f+cnOYzVEIT8+qXdaj
         kpdAv0py1tIBqoGSNZ9ltKeGM4XeKCgS2/f/6LaboYml3PnbOf4NarTUgcY4sPF46VfY
         KzDsr3gpPhizPyofBWct1uvRRKUHVG29TPKs/pstnltPSZ3rhSSFvkUw4qAcVTOrZApH
         pwrA==
X-Gm-Message-State: AOAM530ORwwuwqSb20GOD2U5UTjVizG5dVXWVU5A3Fgy6xEsFMYkarvS
        e/cQoAyy/bVQXnHP5j7mMVRpsw==
X-Google-Smtp-Source: ABdhPJzSwMCjv1spq+XPwoOE05F5QsYvsil6qFeaLmk9XyX7HnDQh9QYDRCLEYD4NbHp6gHIPz8mhQ==
X-Received: by 2002:ac8:4b7b:: with SMTP id g27mr25360040qts.220.1618242344613;
        Mon, 12 Apr 2021 08:45:44 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k17sm1523563qtp.26.2021.04.12.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:45:44 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:45:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH V12 0/3] Charge loop device i/o to issuing cgroup
Message-ID: <YHRrJ9V6ivpH2QUN@cmpxchg.org>
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It looks like all feedback has been addressed and there hasn't been
any new activity on it in a while.

As per the suggestion last time [1], Andrew, Jens, could this go
through the -mm tree to deal with the memcg conflicts?

[1] https://lore.kernel.org/lkml/CALvZod6FMQQC17Zsu9xoKs=dFWaJdMC2Qk3YiDPUUQHx8teLYg@mail.gmail.com/

On Fri, Apr 02, 2021 at 12:16:31PM -0700, Dan Schatzberg wrote:
> No major changes, rebased on top of latest mm tree
> 
> Changes since V12:
> 
> * Small change to get_mem_cgroup_from_mm to avoid needing
>   get_active_memcg
> 
> Changes since V11:
> 
> * Removed WQ_MEM_RECLAIM flag from loop workqueue. Technically, this
>   can be driven by writeback, but this was causing a warning in xfs
>   and likely other filesystems aren't equipped to be driven by reclaim
>   at the VFS layer.
> * Included a small fix from Colin Ian King.
> * reworked get_mem_cgroup_from_mm to institute the necessary charge
>   priority.
> 
> Changes since V10:
> 
> * Added page-cache charging to mm: Charge active memcg when no mm is set
> 
> Changes since V9:
> 
> * Rebased against linus's branch which now includes Roman Gushchin's
>   patch this series is based off of
> 
> Changes since V8:
> 
> * Rebased on top of Roman Gushchin's patch
>   (https://lkml.org/lkml/2020/8/21/1464) which provides the nesting
>   support for setting active memcg. Dropped the patch from this series
>   that did the same thing.
> 
> Changes since V7:
> 
> * Rebased against linus's branch
> 
> Changes since V6:
> 
> * Added separate spinlock for worker synchronization
> * Minor style changes
> 
> Changes since V5:
> 
> * Fixed a missing css_put when failing to allocate a worker
> * Minor style changes
> 
> Changes since V4:
> 
> Only patches 1 and 2 have changed.
> 
> * Fixed irq lock ordering bug
> * Simplified loop detach
> * Added support for nesting memalloc_use_memcg
> 
> Changes since V3:
> 
> * Fix race on loop device destruction and deferred worker cleanup
> * Ensure charge on shmem_swapin_page works just like getpage
> * Minor style changes
> 
> Changes since V2:
> 
> * Deferred destruction of workqueue items so in the common case there
>   is no allocation needed
> 
> Changes since V1:
> 
> * Split out and reordered patches so cgroup charging changes are
>   separate from kworker -> workqueue change
> 
> * Add mem_css to struct loop_cmd to simplify logic
> 
> The loop device runs all i/o to the backing file on a separate kworker
> thread which results in all i/o being charged to the root cgroup. This
> allows a loop device to be used to trivially bypass resource limits
> and other policy. This patch series fixes this gap in accounting.
> 
> A simple script to demonstrate this behavior on cgroupv2 machine:
> 
> '''
> #!/bin/bash
> set -e
> 
> CGROUP=/sys/fs/cgroup/test.slice
> LOOP_DEV=/dev/loop0
> 
> if [[ ! -d $CGROUP ]]
> then
>     sudo mkdir $CGROUP
> fi
> 
> grep oom_kill $CGROUP/memory.events
> 
> # Set a memory limit, write more than that limit to tmpfs -> OOM kill
> sudo unshare -m bash -c "
> echo \$\$ > $CGROUP/cgroup.procs;
> echo 0 > $CGROUP/memory.swap.max;
> echo 64M > $CGROUP/memory.max;
> mount -t tmpfs -o size=512m tmpfs /tmp;
> dd if=/dev/zero of=/tmp/file bs=1M count=256" || true
> 
> grep oom_kill $CGROUP/memory.events
> 
> # Set a memory limit, write more than that limit through loopback
> # device -> no OOM kill
> sudo unshare -m bash -c "
> echo \$\$ > $CGROUP/cgroup.procs;
> echo 0 > $CGROUP/memory.swap.max;
> echo 64M > $CGROUP/memory.max;
> mount -t tmpfs -o size=512m tmpfs /tmp;
> truncate -s 512m /tmp/backing_file
> losetup $LOOP_DEV /tmp/backing_file
> dd if=/dev/zero of=$LOOP_DEV bs=1M count=256;
> losetup -D $LOOP_DEV" || true
> 
> grep oom_kill $CGROUP/memory.events
> '''
> 
> Naively charging cgroups could result in priority inversions through
> the single kworker thread in the case where multiple cgroups are
> reading/writing to the same loop device. This patch series does some
> minor modification to the loop driver so that each cgroup can make
> forward progress independently to avoid this inversion.
> 
> With this patch series applied, the above script triggers OOM kills
> when writing through the loop device as expected.
> 
> Dan Schatzberg (3):
>   loop: Use worker per cgroup instead of kworker
>   mm: Charge active memcg when no mm is set
>   loop: Charge i/o to mem and blk cg
> 
>  drivers/block/loop.c       | 244 ++++++++++++++++++++++++++++++-------
>  drivers/block/loop.h       |  15 ++-
>  include/linux/memcontrol.h |   6 +
>  kernel/cgroup/cgroup.c     |   1 +
>  mm/filemap.c               |   2 +-
>  mm/memcontrol.c            |  49 +++++---
>  mm/shmem.c                 |   4 +-
>  7 files changed, 253 insertions(+), 68 deletions(-)
> 
> -- 
> 2.30.2
> 
> 
