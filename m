Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59423153F2
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhBIQef (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 11:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhBIQeJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 11:34:09 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881FC061756
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 08:33:28 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j13so8934794qvu.10
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqwbjVKT92bgGmTwHneB7S6uqWbAlrDany7fE7oGT1Y=;
        b=wl5iSzgZjMYgWkqOkI6F1OA6EQOr0VBwWz+1jGJaqi9r0iUCCJMwGfNy2ZgOyJmrST
         vI9XWIPnkXj3pyoS9MC9dwZeK338IHOw9TivjHI1cpLlskJGdf5qqx53svtAV2vJ1MP+
         4gjuaJl6/GvvI9OK4j1vD+s8KCK/lEJ3wnl16G3olAhs+NxlVEHkzb/mrooKe86FFG86
         K8jc53i5n0xi4ZZKuID1hBG8PLcyVmjfJ00zIKKsi8iZzFGEwYc8oDqm+IViUkuIzBHA
         TPd5DYSVcdaXjzcwLruGKXCJgCuxRWnF/I3rqeoMLw37Dnmv1MGK8blqtFqMuuXyLG9m
         I1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqwbjVKT92bgGmTwHneB7S6uqWbAlrDany7fE7oGT1Y=;
        b=kODWHZxbx23G/jTV5V8mONKdmasuHioJlfhl92fJLu2hP4IcylAGyYFaJCDUMPiJxa
         leLV/9233zIwezxVWUuiFGP+6ZF3nmOPwnzG1II4PfK78SPj6nSm4bDwNLxQ2WZ+I7VX
         vrhLAioIixe7fDXgC/YIs1aUqPGLW/r6KI4+nPtKoWE1NDU3VjbxMaaoZHRcOAIpeI7b
         OI9fpp4iA9DrWvM0tklRneFvUtZ01ca/oAzFRYViTFtf1GpAwODinb6Zy18SkZk5sipg
         SQbPUz5vmea5WuivK12vc8ClG5UGCDw8lHhrvelj6YWY5aBJKGBfZG2dpZZ11o17BP7N
         zJ+A==
X-Gm-Message-State: AOAM530UyalXqFP/PY8+PH+7jnXaPZIuyMFHwY2HsvQ9DtYe2YAryjKE
        FF4eB7LhMWniuhrmm/ZfzN6Wiw==
X-Google-Smtp-Source: ABdhPJx0wrSrroGhdi/SB2WSKmIinjBZ9twNIoDRE69zDqkSKMnz4qGrEtx2k+a0Kcyg4wM2ewXlmw==
X-Received: by 2002:a0c:814e:: with SMTP id 72mr12762669qvc.16.1612888407771;
        Tue, 09 Feb 2021 08:33:27 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h12sm18296262qko.29.2021.02.09.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:26 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 0/8] mm: memcontrol: switch to rstat
Date:   Tue,  9 Feb 2021 11:32:56 -0500
Message-Id: <20210209163304.77088-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is version 3 of the memcg rstat patches.

Updates since v2:
- optimize root level in io controller's rstat flush callback (Tejun)
- add comments and changelog notes on root level optimization (Tejun)
- eliminate mem_cgroup_usage() rstat flush for leaf cgroups (Shakeel)
- collected review & ack tags

Updates since v1:
- added cgroup selftest output (see test section below) (thanks Roman)
- patched cgroup selftest so error expectations match kernel implementation
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
series updates the test to include them - as well as reduces the
vmstat tolerances in general to only expect page_counter batching.

With all patches applied, the (now more stringent) test succeeds:

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

 block/blk-cgroup.c                         |  17 +-
 include/linux/memcontrol.h                 | 119 ++++-------
 kernel/cgroup/cgroup.c                     |  34 +--
 kernel/cgroup/rstat.c                      |  63 +++---
 mm/memcontrol.c                            | 305 +++++++++++++--------------
 tools/testing/selftests/cgroup/test_kmem.c |  22 +-
 6 files changed, 267 insertions(+), 293 deletions(-)

Based on v5.11-rc6-mmotm-2021-02-02-20-19.


