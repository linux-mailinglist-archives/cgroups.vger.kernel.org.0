Return-Path: <cgroups+bounces-13176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8DD1E630
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68231301595D
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF80D39448C;
	Wed, 14 Jan 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PDSoOYS0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F107387348;
	Wed, 14 Jan 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390061; cv=none; b=OUjMlImmXqk0LgCCngvKRC3li5L7c6WA2SulPkZds63/CrZrtmsewfj2dg9KSCjt3s5dndk9G4RlZMYJEF4AF99QW2I05vqmv8T2vcPShUyUP/m87iaR/QfuFlFs/RufcKeJl+2gW+DJv+fnhFdAkOLtNTSnrh/qb+uJdXalfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390061; c=relaxed/simple;
	bh=JFIW28kXqi5e85aATimWltQfjiQMTLR9iMAwXqjTgLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mj86wZGUGXVdvakVGBnWXSsIQcuAufvQfSfRVUzVyVGvm/WtkRIFeJqROOIio7VUDVrSGDbxsEy4xSMghT+Ko3uGOXE775Tk7De5eLfPaEjdANcL8k94B1wruh5JL9/altmx7eQVbYufk8xIHmyCElvUvXI8+W1WQDqOKT6Lo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PDSoOYS0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EJ0NLkl3WbQqzA9g/N1WxzWPmbIAe8I0MVoMjqxcwe4=;
	b=PDSoOYS0fRemSPYzitxZGZ5SgEjzEK/iiZK7vWu5r3EXZDmTK+mbnJK5J2LADv2fZtmIZf
	e2bCXKU6VpPm2IIWG0GLYlhTnoevMr+ctItq4znbkfavhS6yjLLUA0oDiubVx0Qi8VINvY
	pAS9rEHtUVlUl7QI9X49qsJ2di9aymw=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
Date: Wed, 14 Jan 2026 19:26:43 +0800
Message-ID: <cover.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Changes in v3:
 - modify the commit message in [PATCH v2 04/28], [PATCH v2 06/28],
   [PATCH v2 13/28], [PATCH v2 24/28] and [PATCH v2 27/28]
   (suggested by David Hildenbrand, Chen Ridong and Johannes Weiner)
 - change code style in [PATCH v3 8/30], [PATCH v3 15/30] and [PATCH v3 27/30]
   (suggested by Johannes Weiner and Shakeel Butt)
 - use get_mem_cgroup_from_folio() + mem_cgroup_put() to replace holding rcu
   lock in [PATCH v3 14/30] and [PATCH v3 19/30]
   (pointed by Johannes Weiner)
 - add a comment to folio_split_queue_lock() in [PATCH v3 17/30]
   (suggested by Shakeel Butt)
 - modify the comment above folio_lruvec() in [PATCH v3 24/30]
   (suggested by Johannes Weiner)
 - fix rcu lock issue in lru_note_cost_refault()
   (pointed by Shakeel Butt)
 - add [PATCH v3 28/30] to fix non-hierarchical memcg1_stats issues
   (pointed by Yosry Ahmed)
 - fix lru_zone_size issue in [PATCH v2 24/28] and [PATCH v2 25/28]
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20260114

Changes in v2:
 - add [PATCH v2 04/28] and remove local_irq_disable() in evict_folios()
   (pointed by Harry Yoo)
 - recheck objcg in [PATCH v2 07/28] (pointed by Harry Yoo)
 - modify the commit message in [PATCH v2 12/28] and [PATCH v2 21/28]
   (pointed by Harry Yoo)
 - use rcu lock to protect mm_state in [PATCH v2 14/28] (pointed by Harry Yoo)
 - fix bad unlock balance warning in [PATCH v2 23/28]
 - change nr_pages type to long in [PATCH v2 25/28] (pointed by Harry Yoo)
 - incease mm_state->seq during reparenting to make mm walker work properly in
   [PATCH v2 25/28] (pointed by Harry Yoo)
 - add [PATCH v2 18/28] to fix WARNING in folio_memcg() (pointed by Harry Yoo)
 - collect Reviewed-bys
 - rebase onto the next-20251216

Changes in v1:
 - drop [PATCH RFC 02/28]
 - drop THP split queue related part, which has been merged as a separate
   patchset[2]
 - prevent memory cgroup release in folio_split_queue_lock{_irqsave}() in
   [PATCH v1 16/26]
 - Separate the reparenting function of traditional LRU folios to [PATCH v1 22/26]
 - adapted to the MGLRU scenarios in [PATCH v1 23/26]
 - refactor memcg_reparent_objcgs() in [PATCH v1 24/26]
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20251028

Hi all,

Introduction
============

This patchset is intended to transfer the LRU pages to the object cgroup
without holding a reference to the original memory cgroup in order to
address the issue of the dying memory cgroup. A consensus has already been
reached regarding this approach recently [1].

Background
==========

The issue of a dying memory cgroup refers to a situation where a memory
cgroup is no longer being used by users, but memory (the metadata
associated with memory cgroups) remains allocated to it. This situation
may potentially result in memory leaks or inefficiencies in memory
reclamation and has persisted as an issue for several years. Any memory
allocation that endures longer than the lifespan (from the users'
perspective) of a memory cgroup can lead to the issue of dying memory
cgroup. We have exerted greater efforts to tackle this problem by
introducing the infrastructure of object cgroup [2].

Presently, numerous types of objects (slab objects, non-slab kernel
allocations, per-CPU objects) are charged to the object cgroup without
holding a reference to the original memory cgroup. The final allocations
for LRU pages (anonymous pages and file pages) are charged at allocation
time and continues to hold a reference to the original memory cgroup
until reclaimed.

File pages are more complex than anonymous pages as they can be shared
among different memory cgroups and may persist beyond the lifespan of
the memory cgroup. The long-term pinning of file pages to memory cgroups
is a widespread issue that causes recurring problems in practical
scenarios [3]. File pages remain unreclaimed for extended periods.
Additionally, they are accessed by successive instances (second, third,
fourth, etc.) of the same job, which is restarted into a new cgroup each
time. As a result, unreclaimable dying memory cgroups accumulate,
leading to memory wastage and significantly reducing the efficiency
of page reclamation.

Fundamentals
============

A folio will no longer pin its corresponding memory cgroup. It is necessary
to ensure that the memory cgroup or the lruvec associated with the memory
cgroup is not released when a user obtains a pointer to the memory cgroup
or lruvec returned by folio_memcg() or folio_lruvec(). Users are required
to hold the RCU read lock or acquire a reference to the memory cgroup
associated with the folio to prevent its release if they are not concerned
about the binding stability between the folio and its corresponding memory
cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
desire a stable binding between the folio and its corresponding memory
cgroup. An approach is needed to ensure the stability of the binding while
the lruvec lock is held, and to detect the situation of holding the
incorrect lruvec lock when there is a race condition during memory cgroup
reparenting. The following four steps are taken to achieve these goals.

1. The first step  to be taken is to identify all users of both functions
   (folio_memcg() and folio_lruvec()) who are not concerned about binding
   stability and implement appropriate measures (such as holding a RCU read
   lock or temporarily obtaining a reference to the memory cgroup for a
   brief period) to prevent the release of the memory cgroup.

2. Secondly, the following refactoring of folio_lruvec_lock() demonstrates
   how to ensure the binding stability from the user's perspective of
   folio_lruvec().

   struct lruvec *folio_lruvec_lock(struct folio *folio)
   {
           struct lruvec *lruvec;

           rcu_read_lock();
   retry:
           lruvec = folio_lruvec(folio);
           spin_lock(&lruvec->lru_lock);
           if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
                   spin_unlock(&lruvec->lru_lock);
                   goto retry;
           }

           return lruvec;
   }

   From the perspective of memory cgroup removal, the entire reparenting
   process (altering the binding relationship between folio and its memory
   cgroup and moving the LRU lists to its parental memory cgroup) should be
   carried out under both the lruvec lock of the memory cgroup being removed
   and the lruvec lock of its parent.

3. Finally, transfer the LRU pages to the object cgroup without holding a
   reference to the original memory cgroup.

Effect
======

Finally, it can be observed that the quantity of dying memory cgroups will
not experience a significant increase if the following test script is
executed to reproduce the issue.

```bash
#!/bin/bash

# Create a temporary file 'temp' filled with zero bytes
dd if=/dev/zero of=temp bs=4096 count=1

# Display memory-cgroup info from /proc/cgroups
cat /proc/cgroups | grep memory

for i in {0..2000}
do
    mkdir /sys/fs/cgroup/memory/test$i
    echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs

    # Append 'temp' file content to 'log'
    cat temp >> log

    echo $$ > /sys/fs/cgroup/memory/cgroup.procs

    # Potentially create a dying memory cgroup
    rmdir /sys/fs/cgroup/memory/test$i
done

# Display memory-cgroup info after test
cat /proc/cgroups | grep memory

rm -f temp log
```

Comments and suggestions are welcome!

Thanks,
Qi

[1].https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
[2].https://lwn.net/Articles/895431/
[3].https://github.com/systemd/systemd/pull/36827

Muchun Song (22):
  mm: memcontrol: remove dead code of checking parent memory cgroup
  mm: workingset: use folio_lruvec() in workingset_refault()
  mm: rename unlock_page_lruvec_irq and its variants
  mm: vmscan: refactor move_folios_to_lru()
  mm: memcontrol: allocate object cgroup for non-kmem case
  mm: memcontrol: return root object cgroup for root memory cgroup
  mm: memcontrol: prevent memory cgroup release in
    get_mem_cgroup_from_folio()
  buffer: prevent memory cgroup release in folio_alloc_buffers()
  writeback: prevent memory cgroup release in writeback module
  mm: memcontrol: prevent memory cgroup release in
    count_memcg_folio_events()
  mm: page_io: prevent memory cgroup release in page_io module
  mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
  mm: mglru: prevent memory cgroup release in mglru
  mm: memcontrol: prevent memory cgroup release in
    mem_cgroup_swap_full()
  mm: workingset: prevent memory cgroup release in lru_gen_eviction()
  mm: workingset: prevent lruvec release in workingset_refault()
  mm: zswap: prevent lruvec release in zswap_folio_swapin()
  mm: swap: prevent lruvec release in lru_gen_clear_refs()
  mm: workingset: prevent lruvec release in workingset_activation()
  mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
  mm: memcontrol: eliminate the problem of dying memory cgroup for LRU
    folios
  mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers

Qi Zheng (8):
  mm: vmscan: prepare for the refactoring the move_folios_to_lru()
  mm: thp: prevent memory cgroup release in
    folio_split_queue_lock{_irqsave}()
  mm: zswap: prevent memory cgroup release in zswap_compress()
  mm: do not open-code lruvec lock
  mm: vmscan: prepare for reparenting traditional LRU folios
  mm: vmscan: prepare for reparenting MGLRU folios
  mm: memcontrol: refactor memcg_reparent_objcgs()
  mm: memcontrol: prepare for reparenting state_local

 fs/buffer.c                      |   4 +-
 fs/fs-writeback.c                |  22 +-
 include/linux/memcontrol.h       | 187 ++++++------
 include/linux/mm_inline.h        |   6 +
 include/linux/mmzone.h           |  20 ++
 include/linux/swap.h             |  20 ++
 include/trace/events/writeback.h |   3 +
 mm/compaction.c                  |  43 ++-
 mm/huge_memory.c                 |  22 +-
 mm/memcontrol-v1.c               |  31 +-
 mm/memcontrol-v1.h               |   3 +
 mm/memcontrol.c                  | 472 ++++++++++++++++++++-----------
 mm/migrate.c                     |   2 +
 mm/mlock.c                       |   2 +-
 mm/page_io.c                     |   8 +-
 mm/percpu.c                      |   2 +-
 mm/shrinker.c                    |   6 +-
 mm/swap.c                        |  61 +++-
 mm/vmscan.c                      | 280 +++++++++++++-----
 mm/workingset.c                  |  25 +-
 mm/zswap.c                       |   5 +
 21 files changed, 835 insertions(+), 389 deletions(-)

-- 
2.20.1


