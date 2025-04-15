Return-Path: <cgroups+bounces-7575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C77A89250
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C18189C07E
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E46FC5;
	Tue, 15 Apr 2025 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ub4XAogb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982553209;
	Tue, 15 Apr 2025 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685654; cv=none; b=NGwdfi69l5E1obWZMEvU8bwvjNit73RjQvE7zr/HaYwSvQLuzod3qrqnv5hkkBDVYqZ1l5ywQvptoQNRcG1qWHKsfiMx4Z8iQxVQKqxcWBn8XjXj4CX3WX3C8JoaCKwkpdVKV5/XhVIlWnV4/WI9n59LGblHmC59aFvCGNCFDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685654; c=relaxed/simple;
	bh=QHvpMCoyzx8Is3suCIFIYsQ8ahOL4Ymyr3fexcTqk3U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ieCAZpp2y3utOLtmaXIADeCZ5XBZk9FiunEnm4C/Q31B6YVv1ddDHDTjULiQB8yWbjjUmDydh28YjbVj141dEnMno6ycfFLq7/5dwcvcelNhHQjO6q6eceHuHo6+rPH8ai7KonHDs2kph7JnTKC1BEqTRiPASUiRBDY4oT+GNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ub4XAogb; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744685646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnXKXpCFLkpvKYaGY4cocvXQ+p6cGX1HWZGI67SObpY=;
	b=ub4XAogbzymmMKs631kitcLFuc2AO3Zy65P3KbedkITNGKdL+bXCpHLWIFdPKYz9njBsGG
	/sCCzJbYP5y97hmFCyRtWP0WZfhe+233LmASREX6KAwMC/Rg+0kIc5eNr2uRnrKJmDYBoP
	TgCh9EqPIMj2CVAT7idiyqPQZLz2oI8=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
Date: Tue, 15 Apr 2025 10:53:25 +0800
Cc: hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 yosry.ahmed@linux.dev,
 nphamcs@gmail.com,
 chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com,
 yuzhao@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6B3FA7C-857B-4588-9962-2FB91C8E0732@linux.dev>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2025, at 10:45, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> This patchset is based on v6.15-rc2. It functions correctly only when
> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were =
encountered
> during rebasing onto the latest code. For more details and assistance, =
refer
> to the "Challenges" section. This is the reason for adding the RFC =
tag.

Sorry, I forgot to CC Yu Zhao. Now I've included him. I think he may
offer useful value in this aspect.

Muchun,
Thanks.

>=20
> ## Introduction
>=20
> This patchset is intended to transfer the LRU pages to the object =
cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup. A consensus has already =
been
> reached regarding this approach recently [1].
>=20
> ## Background
>=20
> The issue of a dying memory cgroup refers to a situation where a =
memory
> cgroup is no longer being used by users, but memory (the metadata
> associated with memory cgroups) remains allocated to it. This =
situation
> may potentially result in memory leaks or inefficiencies in memory
> reclamation and has persisted as an issue for several years. Any =
memory
> allocation that endures longer than the lifespan (from the users'
> perspective) of a memory cgroup can lead to the issue of dying memory
> cgroup. We have exerted greater efforts to tackle this problem by
> introducing the infrastructure of object cgroup [2].
>=20
> Presently, numerous types of objects (slab objects, non-slab kernel
> allocations, per-CPU objects) are charged to the object cgroup without
> holding a reference to the original memory cgroup. The final =
allocations
> for LRU pages (anonymous pages and file pages) are charged at =
allocation
> time and continues to hold a reference to the original memory cgroup
> until reclaimed.
>=20
> File pages are more complex than anonymous pages as they can be shared
> among different memory cgroups and may persist beyond the lifespan of
> the memory cgroup. The long-term pinning of file pages to memory =
cgroups
> is a widespread issue that causes recurring problems in practical
> scenarios [3]. File pages remain unreclaimed for extended periods.
> Additionally, they are accessed by successive instances (second, =
third,
> fourth, etc.) of the same job, which is restarted into a new cgroup =
each
> time. As a result, unreclaimable dying memory cgroups accumulate,
> leading to memory wastage and significantly reducing the efficiency
> of page reclamation.
>=20
> ## Fundamentals
>=20
> A folio will no longer pin its corresponding memory cgroup. It is =
necessary
> to ensure that the memory cgroup or the lruvec associated with the =
memory
> cgroup is not released when a user obtains a pointer to the memory =
cgroup
> or lruvec returned by folio_memcg() or folio_lruvec(). Users are =
required
> to hold the RCU read lock or acquire a reference to the memory cgroup
> associated with the folio to prevent its release if they are not =
concerned
> about the binding stability between the folio and its corresponding =
memory
> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
> desire a stable binding between the folio and its corresponding memory
> cgroup. An approach is needed to ensure the stability of the binding =
while
> the lruvec lock is held, and to detect the situation of holding the
> incorrect lruvec lock when there is a race condition during memory =
cgroup
> reparenting. The following four steps are taken to achieve these =
goals.
>=20
> 1. The first step  to be taken is to identify all users of both =
functions
>   (folio_memcg() and folio_lruvec()) who are not concerned about =
binding
>   stability and implement appropriate measures (such as holding a RCU =
read
>   lock or temporarily obtaining a reference to the memory cgroup for a
>   brief period) to prevent the release of the memory cgroup.
>=20
> 2. Secondly, the following refactoring of folio_lruvec_lock() =
demonstrates
>   how to ensure the binding stability from the user's perspective of
>   folio_lruvec().
>=20
>   struct lruvec *folio_lruvec_lock(struct folio *folio)
>   {
>           struct lruvec *lruvec;
>=20
>           rcu_read_lock();
>   retry:
>           lruvec =3D folio_lruvec(folio);
>           spin_lock(&lruvec->lru_lock);
>           if (unlikely(lruvec_memcg(lruvec) !=3D folio_memcg(folio))) =
{
>                   spin_unlock(&lruvec->lru_lock);
>                   goto retry;
>           }
>=20
>           return lruvec;
>   }
>=20
>   =46rom the perspective of memory cgroup removal, the entire =
reparenting
>   process (altering the binding relationship between folio and its =
memory
>   cgroup and moving the LRU lists to its parental memory cgroup) =
should be
>   carried out under both the lruvec lock of the memory cgroup being =
removed
>   and the lruvec lock of its parent.
>=20
> 3. Thirdly, another lock that requires the same approach is the =
split-queue
>   lock of THP.
>=20
> 4. Finally, transfer the LRU pages to the object cgroup without =
holding a
>   reference to the original memory cgroup.
>=20
> ## Challenges
>=20
> In a non-MGLRU scenario, each lruvec of every memory cgroup comprises =
four
> LRU lists (i.e., two active lists for anonymous and file folios, and =
two
> inactive lists for anonymous and file folios). Due to the symmetry of =
the
> LRU lists, it is feasible to transfer the LRU lists from a memory =
cgroup
> to its parent memory cgroup during the reparenting process.
>=20
> In a MGLRU scenario, each lruvec of every memory cgroup comprises at =
least
> 2 (MIN_NR_GENS) generations and at most 4 (MAX_NR_GENS) generations.
>=20
> 1. The first question is how to move the LRU lists from a memory =
cgroup to
>   its parent memory cgroup during the reparenting process. This is due =
to
>   the fact that the quantity of LRU lists (aka generations) may differ
>   between a child memory cgroup and its parent memory cgroup.
>=20
> 2. The second question is how to make the process of reparenting more
>   efficient, since each folio charged to a memory cgroup stores its
>   generation counter into its ->flags. And the generation counter may
>   differ between a child memory cgroup and its parent memory cgroup =
because
>   the values of ->min_seq and ->max_seq are not identical. Should =
those
>   generation counters be updated correspondingly?
>=20
> I am uncertain about how to handle them appropriately as I am not an
> expert at MGLRU. I would appreciate it if you could offer some =
suggestions.
> Moreover, if you are willing to directly provide your patches, I would =
be
> glad to incorporate them into this patchset.
>=20
> ## Compositions
>=20
> Patches 1-8 involve code refactoring and cleanup with the aim of
> facilitating the transfer LRU folios to object cgroup infrastructures.
>=20
> Patches 9-10 aim to allocate the object cgroup for non-kmem scenarios,
> enabling the ability that LRU folios could be charged to it and =
aligning
> the behavior of object-cgroup-related APIs with that of the memory =
cgroup.
>=20
> Patches 11-19 aim to prevent memory cgroup returned by folio_memcg() =
from
> being released.
>=20
> Patches 20-23 aim to prevent lruvec returned by folio_lruvec() from =
being
> released.
>=20
> Patches 24-25 implement the core mechanism to guarantee binding =
stability
> between the folio and its corresponding memory cgroup while holding =
lruvec
> lock or split-queue lock of THP.
>=20
> Patches 26-27 are intended to transfer the LRU pages to the object =
cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup.
>=20
> Patch 28 aims to add VM_WARN_ON_ONCE_FOLIO to LRU maintenance helpers =
to
> ensure correct folio operations in the future.
>=20
> ## Effect
>=20
> Finally, it can be observed that the quantity of dying memory cgroups =
will
> not experience a significant increase if the following test script is
> executed to reproduce the issue.
>=20
> ```bash
> #!/bin/bash
>=20
> # Create a temporary file 'temp' filled with zero bytes
> dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
>=20
> # Display memory-cgroup info from /proc/cgroups
> cat /proc/cgroups | grep memory
>=20
> for i in {0..2000}
> do
>    mkdir /sys/fs/cgroup/memory/test$i
>    echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
>=20
>    # Append 'temp' file content to 'log'
>    cat temp >> log
>=20
>    echo $$ > /sys/fs/cgroup/memory/cgroup.procs
>=20
>    # Potentially create a dying memory cgroup
>    rmdir /sys/fs/cgroup/memory/test$i
> done
>=20
> # Display memory-cgroup info after test
> cat /proc/cgroups | grep memory
>=20
> rm -f temp log
> ```
>=20
> ## References
>=20
> [1] https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
> [2] https://lwn.net/Articles/895431/
> [3] https://github.com/systemd/systemd/pull/36827
>=20
> Muchun Song (28):
>  mm: memcontrol: remove dead code of checking parent memory cgroup
>  mm: memcontrol: use folio_memcg_charged() to avoid potential rcu lock
>    holding
>  mm: workingset: use folio_lruvec() in workingset_refault()
>  mm: rename unlock_page_lruvec_irq and its variants
>  mm: thp: replace folio_memcg() with folio_memcg_charged()
>  mm: thp: introduce folio_split_queue_lock and its variants
>  mm: thp: use folio_batch to handle THP splitting in
>    deferred_split_scan()
>  mm: vmscan: refactor move_folios_to_lru()
>  mm: memcontrol: allocate object cgroup for non-kmem case
>  mm: memcontrol: return root object cgroup for root memory cgroup
>  mm: memcontrol: prevent memory cgroup release in
>    get_mem_cgroup_from_folio()
>  buffer: prevent memory cgroup release in folio_alloc_buffers()
>  writeback: prevent memory cgroup release in writeback module
>  mm: memcontrol: prevent memory cgroup release in
>    count_memcg_folio_events()
>  mm: page_io: prevent memory cgroup release in page_io module
>  mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
>  mm: mglru: prevent memory cgroup release in mglru
>  mm: memcontrol: prevent memory cgroup release in
>    mem_cgroup_swap_full()
>  mm: workingset: prevent memory cgroup release in lru_gen_eviction()
>  mm: workingset: prevent lruvec release in workingset_refault()
>  mm: zswap: prevent lruvec release in zswap_folio_swapin()
>  mm: swap: prevent lruvec release in swap module
>  mm: workingset: prevent lruvec release in workingset_activation()
>  mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
>  mm: thp: prepare for reparenting LRU pages for split queue lock
>  mm: memcontrol: introduce memcg_reparent_ops
>  mm: memcontrol: eliminate the problem of dying memory cgroup for LRU
>    folios
>  mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
>=20
> fs/buffer.c                      |   4 +-
> fs/fs-writeback.c                |  22 +-
> include/linux/memcontrol.h       | 190 ++++++------
> include/linux/mm_inline.h        |   6 +
> include/trace/events/writeback.h |   3 +
> mm/compaction.c                  |  43 ++-
> mm/huge_memory.c                 | 218 +++++++++-----
> mm/memcontrol-v1.c               |  15 +-
> mm/memcontrol.c                  | 476 +++++++++++++++++++------------
> mm/migrate.c                     |   2 +
> mm/mlock.c                       |   2 +-
> mm/page_io.c                     |   8 +-
> mm/percpu.c                      |   2 +-
> mm/shrinker.c                    |   6 +-
> mm/swap.c                        |  22 +-
> mm/vmscan.c                      |  73 ++---
> mm/workingset.c                  |  26 +-
> mm/zswap.c                       |   2 +
> 18 files changed, 696 insertions(+), 424 deletions(-)
>=20
> --=20
> 2.20.1
>=20


