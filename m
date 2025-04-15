Return-Path: <cgroups+bounces-7546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E0A89201
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD691898F71
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697E212FAB;
	Tue, 15 Apr 2025 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FDPWFLSW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E1D528
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685159; cv=none; b=EO9VMQLwZjA3ii0z0uvtaKQu+bH2uogihp8Rh3O6nbHxHwPnT4UYqVX+ybayvB5Tm6Eg/pRjNbr9eLxbmFVvI+fge3QWejTferA+Vf5VTtP6Pvi9XcLO3F5fgzNF8Y8KTevGxq7z6B/r2nKLwjJjhNA4SJ7b4qY79sD/Tv2qhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685159; c=relaxed/simple;
	bh=JBWagI/b04ghXu58sKhKZXloEglf9TTNfTAKDNcOL2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9Gti/RkZRo3stsjI8viGE3HMUfLRK2Oh3FRR/GLwqXYJkI5ieOiLM6E6cKfCMwertYTfW9hs4sCtCURD/TPMtkXhp0kUfT5YlIYYNNytm8LsVulN9vrdhZHLd2x3KbdPdMAVOII+Q1yHBp6IgjH2/aXoSrY+qCmtnaLPANYmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FDPWFLSW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b074d908e56so1461239a12.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685156; x=1745289956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vmef3ZlMZg7TO+ldIj898v58g7NCeQi8xtcn9yDmmsc=;
        b=FDPWFLSWG2HTak8aPJfuex5yNeLuP6Q14D8XTfX4i7z1hOHMVzAD7nhkSM4fF2y1OM
         r7RdADH6TSdWksWvd+mYraOITKaeJZ9MzLzOAlX80CcP1TjhAvzkGh5z7rmnSKfKQV08
         psTeoM1mJT7/WiTeLCGI+Enf05oVaFH0B+6EnkU7IF2QJourLzTavOv2pwTqH1S1bnde
         IHP4cl45og3C91q8/copPBZds6mmaHbsrNJJgfTmF+K7uMBPR9C02Q/c49v+SP/h2wMY
         puzXF9Mlcmr0MbWYa4noCWUMetsj6LFp2AmqoPGgwyBRn1jGD4Jikq6yAOY+lbL062+z
         4uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685156; x=1745289956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vmef3ZlMZg7TO+ldIj898v58g7NCeQi8xtcn9yDmmsc=;
        b=iMx9pSnwqGQRR/rb+svX9Mqgb6fGVyCl8fbA20numpS/KdI6cT54UG+ePvP1phFIPi
         y0AC6R+de3IVc9KiGCCuHJZEiQr8L5De5yk+vKOx9XLNB7fRfjYBW2zzv79ycRqQAO/V
         GzZX9bw4llBBh7gFqNU3jb0ZfuZVaFUyMFi8uc8SD7uqU1OC5lZ7c9XRsQ2fzClsJbEo
         ImXKCI5nmfMrh8gJjpPFX8FilPMInh63uelVYbvl66s+kI4HJOld6Hu8fWlhyB9lkagQ
         RepNcPkuJlJTqXYv2U4rEHhJ/B9xCuFoM4LA9Urzkag3sxhKVPAJT0AM/SXGUX4xMrZg
         0pfw==
X-Forwarded-Encrypted: i=1; AJvYcCVkgWwGDNMdyhDOLF8JBfDsuD8kStJJe7dSf0/gwbnQoatBsnbLDr4SB+lCF3GFKpKf746YN9L5@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAsR+ByxEhIoVCjnqC7JfvU7LCygSgNWdqMunb4X0YEJzxe3p
	30AvjGjluOIDFk5zzZF7wPHelI7m9bTq0nwylMgPPDqTin6uuGS5JA2Ah3RSmeo=
X-Gm-Gg: ASbGncugaeRXQtzGir313Cnzu7FUxLC296+EZNx+jbAvwB5/j//NktWXuTFFnYyWp7P
	SWi3vM2HzVOzb8PmXpjwpDI/0mfc7Iq8B3ZtgbRLcGytE8Xrple4gZOxNgQY+LoMj7q4f1LWW3+
	AuFh8u1nNY7tDIK8A2pVCGSIlw6q8fGfpS1sv5qOB+wyetfS/CBD99QAhPLLMW9V40w0v58zzdX
	4WwnIaQaEgXzNXvVkdsXm9qbKW87YXyBLmDAQ0X3PctBA3PEfpcYzJkx1Ps+ebTjJ3qKTIH3dfb
	qPe+6J9H11lQsz3plbqEWPpN1/XvfTKj0A14a7J+yP3jcnfTYRS5TcOTf6dHRk1VeRqpmTpy
X-Google-Smtp-Source: AGHT+IE0pZ/5yl+DX5hKsSJ8q3otL9DZ3TTCxY1dn2jd+uRX0/xON+LgsEquVuUnMUfbbGTr0hzbkg==
X-Received: by 2002:a17:902:d48d:b0:21f:6546:9af0 with SMTP id d9443c01a7336-22bea502685mr170782125ad.44.1744685155939;
        Mon, 14 Apr 2025 19:45:55 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.45.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:45:53 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
Date: Tue, 15 Apr 2025 10:45:04 +0800
Message-Id: <20250415024532.26632-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is based on v6.15-rc2. It functions correctly only when
CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were encountered
during rebasing onto the latest code. For more details and assistance, refer
to the "Challenges" section. This is the reason for adding the RFC tag.

## Introduction

This patchset is intended to transfer the LRU pages to the object cgroup
without holding a reference to the original memory cgroup in order to
address the issue of the dying memory cgroup. A consensus has already been
reached regarding this approach recently [1].

## Background

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

## Fundamentals

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

3. Thirdly, another lock that requires the same approach is the split-queue
   lock of THP.

4. Finally, transfer the LRU pages to the object cgroup without holding a
   reference to the original memory cgroup.

## Challenges

In a non-MGLRU scenario, each lruvec of every memory cgroup comprises four
LRU lists (i.e., two active lists for anonymous and file folios, and two
inactive lists for anonymous and file folios). Due to the symmetry of the
LRU lists, it is feasible to transfer the LRU lists from a memory cgroup
to its parent memory cgroup during the reparenting process.

In a MGLRU scenario, each lruvec of every memory cgroup comprises at least
2 (MIN_NR_GENS) generations and at most 4 (MAX_NR_GENS) generations.

1. The first question is how to move the LRU lists from a memory cgroup to
   its parent memory cgroup during the reparenting process. This is due to
   the fact that the quantity of LRU lists (aka generations) may differ
   between a child memory cgroup and its parent memory cgroup.

2. The second question is how to make the process of reparenting more
   efficient, since each folio charged to a memory cgroup stores its
   generation counter into its ->flags. And the generation counter may
   differ between a child memory cgroup and its parent memory cgroup because
   the values of ->min_seq and ->max_seq are not identical. Should those
   generation counters be updated correspondingly?

I am uncertain about how to handle them appropriately as I am not an
expert at MGLRU. I would appreciate it if you could offer some suggestions.
Moreover, if you are willing to directly provide your patches, I would be
glad to incorporate them into this patchset.

## Compositions

Patches 1-8 involve code refactoring and cleanup with the aim of
facilitating the transfer LRU folios to object cgroup infrastructures.

Patches 9-10 aim to allocate the object cgroup for non-kmem scenarios,
enabling the ability that LRU folios could be charged to it and aligning
the behavior of object-cgroup-related APIs with that of the memory cgroup.

Patches 11-19 aim to prevent memory cgroup returned by folio_memcg() from
being released.

Patches 20-23 aim to prevent lruvec returned by folio_lruvec() from being
released.

Patches 24-25 implement the core mechanism to guarantee binding stability
between the folio and its corresponding memory cgroup while holding lruvec
lock or split-queue lock of THP.

Patches 26-27 are intended to transfer the LRU pages to the object cgroup
without holding a reference to the original memory cgroup in order to
address the issue of the dying memory cgroup.

Patch 28 aims to add VM_WARN_ON_ONCE_FOLIO to LRU maintenance helpers to
ensure correct folio operations in the future.

## Effect

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

## References

[1] https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
[2] https://lwn.net/Articles/895431/
[3] https://github.com/systemd/systemd/pull/36827

Muchun Song (28):
  mm: memcontrol: remove dead code of checking parent memory cgroup
  mm: memcontrol: use folio_memcg_charged() to avoid potential rcu lock
    holding
  mm: workingset: use folio_lruvec() in workingset_refault()
  mm: rename unlock_page_lruvec_irq and its variants
  mm: thp: replace folio_memcg() with folio_memcg_charged()
  mm: thp: introduce folio_split_queue_lock and its variants
  mm: thp: use folio_batch to handle THP splitting in
    deferred_split_scan()
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
  mm: swap: prevent lruvec release in swap module
  mm: workingset: prevent lruvec release in workingset_activation()
  mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
  mm: thp: prepare for reparenting LRU pages for split queue lock
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: eliminate the problem of dying memory cgroup for LRU
    folios
  mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers

 fs/buffer.c                      |   4 +-
 fs/fs-writeback.c                |  22 +-
 include/linux/memcontrol.h       | 190 ++++++------
 include/linux/mm_inline.h        |   6 +
 include/trace/events/writeback.h |   3 +
 mm/compaction.c                  |  43 ++-
 mm/huge_memory.c                 | 218 +++++++++-----
 mm/memcontrol-v1.c               |  15 +-
 mm/memcontrol.c                  | 476 +++++++++++++++++++------------
 mm/migrate.c                     |   2 +
 mm/mlock.c                       |   2 +-
 mm/page_io.c                     |   8 +-
 mm/percpu.c                      |   2 +-
 mm/shrinker.c                    |   6 +-
 mm/swap.c                        |  22 +-
 mm/vmscan.c                      |  73 ++---
 mm/workingset.c                  |  26 +-
 mm/zswap.c                       |   2 +
 18 files changed, 696 insertions(+), 424 deletions(-)

-- 
2.20.1


