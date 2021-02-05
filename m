Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF831104C
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 19:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhBERGP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 12:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhBEQqf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 11:46:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD87C06121C
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:28:26 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id r77so7823137qka.12
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2KeaXbGexKPSD8rISWFG5PeHSxIPuC3Rzo5og1/7Ir0=;
        b=pV0wejWptXCQndSQPQbqSqo3RcnUZw+d6QFJ9TEEnzCMzSHQWc79RNjsbrbcojhnLj
         HByaFRnyfY9pW7EnZ0hgajmYebe0E+XFuM3ERSwpzAY+2J2JBgDRe28TP+oqky6K591o
         cwfu9EA1Dkok8d321pZ3mUjM/ZwN4/PxCPBcSJ5GBJuKy7FlQsIsmmSJKPsJAOmItoaM
         RTgoarqvt6tfiZolIE3A6+tbJ5J4Uias+SRxR9lYvUDoIGPvWiUGoRTDcJ7k3bnkBzyy
         G+QUkCJ9RuYX3eeQFVfJxTWSFgL1zSV5QNqpx/NaHOv3QFiTLiEa07fmlX6L8tky3Iby
         Hctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2KeaXbGexKPSD8rISWFG5PeHSxIPuC3Rzo5og1/7Ir0=;
        b=H1e5gD/H7uegCbySiI5AtzFpXftzVNwLYYQ7WtutWinuSJnurTAQTrGKglamMrudj7
         pizIGfv8wNlBjwl585o1lQMeMe3BcGGbuPrKllfrAs96pyb+TcZBP8GCjgewjckyNeS5
         7m+4shVoATis4e0MslAuPKqUopi2XfftIBHsA3t7udcLi/Nlsyu31eukrshN17lMxccy
         /83dUECbBiUPCsKLEAPndKWskIrYLG1FPwpPHzxTkHYFtCFzNes7MGIvwg/s5u8H2zO7
         RpYI5/FjkexxP4koVUY/DVZ4QBYiEn2OjI6/zFXI+YZgUGLrtHz/QTslwUYbojMWsJ4J
         9NLA==
X-Gm-Message-State: AOAM530xSeCtFIxemhnuNdgZzzyD/Di495BffzRTOEfKcFbnXtBc2hBo
        qhavkXKKcjdPf3cEH+e5ur7Y1g==
X-Google-Smtp-Source: ABdhPJycX5ucJ0FBCl9fuPyJ0FnLf3Uzp45PJxhbLA7Gzzd2vVm0ovAIZl2mOj6xeE0MAgjRr9vJOQ==
X-Received: by 2002:a37:a50e:: with SMTP id o14mr5718870qke.250.1612549705552;
        Fri, 05 Feb 2021 10:28:25 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a203sm10044990qkb.31.2021.02.05.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:24 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/8] mm: memcontrol: switch to rstat v2
Date:   Fri,  5 Feb 2021 13:27:58 -0500
Message-Id: <20210205182806.17220-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is version 2 of the memcg rstat patches. Updates since v1:

- added cgroup selftest output (see test section below) (thanks Roman)
- updated cgroup selftest to match new kernel implementation
- added Fixes: tag to 'mm: memcontrol: fix cpuhotplug statistics flushing' (Shakeel)
- collected review & ack tags
- added rstat overview to 'mm: memcontrol: switch to rstat' changelog (Michal)
- simplified memcg_flush_lruvec_page_state() and removed cpu==-1 case (Michal)

---

This series converts memcg stats tracking to the streamlined rstat
infrastructure provided by the cgroup core code. rstat is already used
by the CPU controller and the IO controller. This change is motivated
by recent accuracy problems in memcg's custom stats code, as well as
the benefits of sharing common infra with other controllers.

The current memcg implementation does batched tree aggregation on the
write side: local stat changes are cached in per-cpu counters, which
are then propagated upward in batches when a threshold (32 pages) is
exceeded. This is cheap, but the error introduced by the lazy upward
propagation adds up: 32 pages times CPUs times cgroups in the subtree.
We've had complaints from service owners that the stats do not
reliably track and react to allocation behavior as expected, sometimes
swallowing the results of entire test applications.

The original memcg stat implementation used to do tree aggregation
exclusively on the read side: local stats would only ever be tracked
in per-cpu counters, and a memory.stat read would iterate the entire
subtree and sum those counters up. This didn't keep up with the times:

- Cgroup trees are much bigger now. We switched to lazily-freed
  cgroups, where deleted groups would hang around until their
  remaining page cache has been reclaimed. This can result in large
  subtrees that are expensive to walk, while most of the groups are
  idle and their statistics don't change much anymore.

- Automated monitoring increased. With the proliferation of userspace
  oom killing, proactive reclaim, and higher-resolution logging of
  workload trends in general, top-level stat files are polled at least
  once a second in many deployments.

- The lifetime of cgroups got shorter. Where most cgroup setups in the
  past would have a few large policy-oriented cgroups for everything
  running on the system, newer cgroup deployments tend to create one
  group per application - which gets deleted again as the processes
  exit. An aggregation scheme that doesn't retain child data inside
  the parents loses event history of the subtree.

Rstat addresses all three of those concerns through intelligent,
persistent read-side aggregation. As statistics change at the local
level, rstat tracks - on a per-cpu basis - only those parts of a
subtree that have changes pending and require aggregation. The actual
aggregation occurs on the colder read side - which can now skip over
(potentially large) numbers of recently idle cgroups.

---

The test_kmem cgroup selftest is currently failing due to excessive
cumulative vmstat drift from 100 subgroups:

    ok 1 test_kmem_basic
    memory.current = 8810496
    slab + anon + file + kernel_stack = 17074568
    slab = 6101384
    anon = 946176
    file = 0
    kernel_stack = 10027008
    not ok 2 test_kmem_memcg_deletion
    ok 3 test_kmem_proc_kpagecgroup
    ok 4 test_kmem_kernel_stacks
    ok 5 test_kmem_dead_cgroups
    ok 6 test_percpu_basic

As you can see, memory.stat items far exceed memory.current. The
kernel stack alone is bigger than all of charged memory. That's
because the memory of the test has been uncharged from memory.current,
but the negative vmstat deltas are still sitting in the percpu caches.

The test at this time isn't even counting percpu, pagetables etc. yet,
which would further contribute to the error. The last patch in the
series updates the test to include them - as well as match error
expectations on the new implementation to catch future regressions.

With all patches applied, the (updated, more rigorous) test succeeds:

    ok 1 test_kmem_basic
    ok 2 test_kmem_memcg_deletion
    ok 3 test_kmem_proc_kpagecgroup
    ok 4 test_kmem_kernel_stacks
    ok 5 test_kmem_dead_cgroups
    ok 6 test_percpu_basic

---

A kernel build test confirms that overhead is comparable. Two kernels
are built simultaneously in a nested tree with several idle siblings:

root - kernelbuild - one - two - three - four - build-a (defconfig, make -j16)
                                             `- build-b (defconfig, make -j16)
                                             `- idle-1
                                             `- ...
                                             `- idle-9

During the builds, kernelbuild/memory.stat is read once a second.

A perf diff shows that the changes in cycle distribution is
minimal. Top 10 kernel symbols:

     0.09%     +0.08%  [kernel.kallsyms]                       [k] __mod_memcg_lruvec_state
     0.00%     +0.06%  [kernel.kallsyms]                       [k] cgroup_rstat_updated
     0.08%     -0.05%  [kernel.kallsyms]                       [k] __mod_memcg_state.part.0
     0.16%     -0.04%  [kernel.kallsyms]                       [k] release_pages
     0.00%     +0.03%  [kernel.kallsyms]                       [k] __count_memcg_events
     0.01%     +0.03%  [kernel.kallsyms]                       [k] mem_cgroup_charge_statistics.constprop.0
     0.10%     -0.02%  [kernel.kallsyms]                       [k] get_mem_cgroup_from_mm
     0.05%     -0.02%  [kernel.kallsyms]                       [k] mem_cgroup_update_lru_size
     0.57%     +0.01%  [kernel.kallsyms]                       [k] asm_exc_page_fault


---

The on-demand aggregated stats are now fully accurate:

$ grep -e nr_inactive_file /proc/vmstat | awk '{print($1,$2*4096)}'; \
  grep -e inactive_file /sys/fs/cgroup/memory.stat

vanilla:                              patched:
nr_inactive_file 1574105088           nr_inactive_file 1027801088
   inactive_file 1577410560              inactive_file 1027801088

---

 block/blk-cgroup.c                         |  14 +-
 include/linux/memcontrol.h                 | 119 ++++-------
 kernel/cgroup/cgroup.c                     |  34 +--
 kernel/cgroup/rstat.c                      |  62 +++---
 mm/memcontrol.c                            | 306 +++++++++++++--------------
 tools/testing/selftests/cgroup/test_kmem.c |  22 +-
 6 files changed, 266 insertions(+), 291 deletions(-)

Based on v5.11-rc5-mm1.


