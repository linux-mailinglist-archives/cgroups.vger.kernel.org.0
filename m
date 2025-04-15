Return-Path: <cgroups+bounces-7578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6EA895F0
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E35317DC67
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCC27B4EA;
	Tue, 15 Apr 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZSYcXyCC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14927F4F8;
	Tue, 15 Apr 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704142; cv=none; b=XDBIs6xRMiV9t9R6dVbgWrkZFTkIzsQuQhCAYEXRxOyJj9TGE3PgNqrTwivYu7M40VNyiMPWk4J6mZe4U4sRqFhQAC6yoc9cykuC3qBbjHhKRkfuk+2X1X6ouod6T6o6shDzXc1Esp1IfGmr5/0Wz0VXPToDetUQmQfK3sFP/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704142; c=relaxed/simple;
	bh=IpUFkysAVRKdNfZ4spIWefqV1SIYCbbx76sdKFC1SKA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DEQyEtZtdcIUG6hvxnS3Nc+sl4Z3OJSyB6NXy4Q1KlAHKxY28F4F1qLPIvuwiMKrDdiM9wQW2lt0jZWOLxq10deK8CPMBjz45UDT7blh/yr8XpZqi8NWoIV6xZrgeTYdObPeycE5w2fXuNhGU0DPMbIgRLurCZdHmI+pD0/reuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZSYcXyCC; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744704137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgX9KHXM4UedpjNeWGFCaRhcQQYZEIU3em8E+zRB/+Q=;
	b=ZSYcXyCCZCNhTtLu+S0iPitAD3pJ+AEg7040nKqEzmMuoSCDMSiXXj8ClcdxWZVaScEt+p
	hkghi63JKp6wlIJvsyVdkat4vjFjgjT6dpDhzNel1oggFVS4DZR+qaJoaI7htfv5hg6Xp0
	ItBacDPNGxZ074xYSXKGAkDS+wZcw4o=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
Date: Tue, 15 Apr 2025 16:01:27 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 hannes@cmpxchg.org,
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
Message-Id: <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
To: Kairui Song <ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2025, at 14:19, Kairui Song <ryncsn@gmail.com> wrote:
>=20
> On Tue, Apr 15, 2025 at 10:46=E2=80=AFAM Muchun Song =
<songmuchun@bytedance.com> wrote:
>>=20
>> This patchset is based on v6.15-rc2. It functions correctly only when
>> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were =
encountered
>> during rebasing onto the latest code. For more details and =
assistance, refer
>> to the "Challenges" section. This is the reason for adding the RFC =
tag.
>>=20
>> ## Introduction
>>=20
>> This patchset is intended to transfer the LRU pages to the object =
cgroup
>> without holding a reference to the original memory cgroup in order to
>> address the issue of the dying memory cgroup. A consensus has already =
been
>> reached regarding this approach recently [1].
>>=20
>> ## Background
>>=20
>> The issue of a dying memory cgroup refers to a situation where a =
memory
>> cgroup is no longer being used by users, but memory (the metadata
>> associated with memory cgroups) remains allocated to it. This =
situation
>> may potentially result in memory leaks or inefficiencies in memory
>> reclamation and has persisted as an issue for several years. Any =
memory
>> allocation that endures longer than the lifespan (from the users'
>> perspective) of a memory cgroup can lead to the issue of dying memory
>> cgroup. We have exerted greater efforts to tackle this problem by
>> introducing the infrastructure of object cgroup [2].
>>=20
>> Presently, numerous types of objects (slab objects, non-slab kernel
>> allocations, per-CPU objects) are charged to the object cgroup =
without
>> holding a reference to the original memory cgroup. The final =
allocations
>> for LRU pages (anonymous pages and file pages) are charged at =
allocation
>> time and continues to hold a reference to the original memory cgroup
>> until reclaimed.
>>=20
>> File pages are more complex than anonymous pages as they can be =
shared
>> among different memory cgroups and may persist beyond the lifespan of
>> the memory cgroup. The long-term pinning of file pages to memory =
cgroups
>> is a widespread issue that causes recurring problems in practical
>> scenarios [3]. File pages remain unreclaimed for extended periods.
>> Additionally, they are accessed by successive instances (second, =
third,
>> fourth, etc.) of the same job, which is restarted into a new cgroup =
each
>> time. As a result, unreclaimable dying memory cgroups accumulate,
>> leading to memory wastage and significantly reducing the efficiency
>> of page reclamation.
>>=20
>> ## Fundamentals
>>=20
>> A folio will no longer pin its corresponding memory cgroup. It is =
necessary
>> to ensure that the memory cgroup or the lruvec associated with the =
memory
>> cgroup is not released when a user obtains a pointer to the memory =
cgroup
>> or lruvec returned by folio_memcg() or folio_lruvec(). Users are =
required
>> to hold the RCU read lock or acquire a reference to the memory cgroup
>> associated with the folio to prevent its release if they are not =
concerned
>> about the binding stability between the folio and its corresponding =
memory
>> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
>> desire a stable binding between the folio and its corresponding =
memory
>> cgroup. An approach is needed to ensure the stability of the binding =
while
>> the lruvec lock is held, and to detect the situation of holding the
>> incorrect lruvec lock when there is a race condition during memory =
cgroup
>> reparenting. The following four steps are taken to achieve these =
goals.
>>=20
>> 1. The first step  to be taken is to identify all users of both =
functions
>>   (folio_memcg() and folio_lruvec()) who are not concerned about =
binding
>>   stability and implement appropriate measures (such as holding a RCU =
read
>>   lock or temporarily obtaining a reference to the memory cgroup for =
a
>>   brief period) to prevent the release of the memory cgroup.
>>=20
>> 2. Secondly, the following refactoring of folio_lruvec_lock() =
demonstrates
>>   how to ensure the binding stability from the user's perspective of
>>   folio_lruvec().
>>=20
>>   struct lruvec *folio_lruvec_lock(struct folio *folio)
>>   {
>>           struct lruvec *lruvec;
>>=20
>>           rcu_read_lock();
>>   retry:
>>           lruvec =3D folio_lruvec(folio);
>>           spin_lock(&lruvec->lru_lock);
>>           if (unlikely(lruvec_memcg(lruvec) !=3D folio_memcg(folio))) =
{
>>                   spin_unlock(&lruvec->lru_lock);
>>                   goto retry;
>>           }
>>=20
>>           return lruvec;
>>   }
>>=20
>>   =46rom the perspective of memory cgroup removal, the entire =
reparenting
>>   process (altering the binding relationship between folio and its =
memory
>>   cgroup and moving the LRU lists to its parental memory cgroup) =
should be
>>   carried out under both the lruvec lock of the memory cgroup being =
removed
>>   and the lruvec lock of its parent.
>>=20
>> 3. Thirdly, another lock that requires the same approach is the =
split-queue
>>   lock of THP.
>>=20
>> 4. Finally, transfer the LRU pages to the object cgroup without =
holding a
>>   reference to the original memory cgroup.
>>=20
>=20
> Hi, Muchun, thanks for the patch.

Thanks for your reply and attention.

>=20
>> ## Challenges
>>=20
>> In a non-MGLRU scenario, each lruvec of every memory cgroup comprises =
four
>> LRU lists (i.e., two active lists for anonymous and file folios, and =
two
>> inactive lists for anonymous and file folios). Due to the symmetry of =
the
>> LRU lists, it is feasible to transfer the LRU lists from a memory =
cgroup
>> to its parent memory cgroup during the reparenting process.
>=20
> Symmetry of LRU lists doesn't mean symmetry 'hotness', it's totally
> possible that a child's active LRU is colder and should be evicted
> first before the parent's inactive LRU (might even be a common
> scenario for certain workloads).

Yes.

> This only affects the performance not the correctness though, so not a
> big problem.
>=20
> So will it be easier to just assume dying cgroup's folios are colder?
> Simply move them to parent's LRU tail is OK. This will make the logic
> appliable for both active/inactive LRU and MGLRU.

I think you mean moving all child LRU list to the parent memcg's =
inactive
list. It works well for your case. But sometimes, due to shared page =
cache
pages, some pages in the child list may be accessed more frequently than
those in the parent's. Still, it's okay as they can be promoted quickly
later. So I am fine with this change.

>=20
>>=20
>> In a MGLRU scenario, each lruvec of every memory cgroup comprises at =
least
>> 2 (MIN_NR_GENS) generations and at most 4 (MAX_NR_GENS) generations.
>>=20
>> 1. The first question is how to move the LRU lists from a memory =
cgroup to
>>   its parent memory cgroup during the reparenting process. This is =
due to
>>   the fact that the quantity of LRU lists (aka generations) may =
differ
>>   between a child memory cgroup and its parent memory cgroup.
>>=20
>> 2. The second question is how to make the process of reparenting more
>>   efficient, since each folio charged to a memory cgroup stores its
>>   generation counter into its ->flags. And the generation counter may
>>   differ between a child memory cgroup and its parent memory cgroup =
because
>>   the values of ->min_seq and ->max_seq are not identical. Should =
those
>>   generation counters be updated correspondingly?
>=20
> I think you do have to iterate through the folios to set or clear
> their generation flags if you want to put the folio in the right gen.
>=20
> MGLRU does similar thing in inc_min_seq. MGLRU uses the gen flags to
> defer the actual LRU movement of folios, that's a very important
> optimization per my test.

I noticed that, which is why I asked the second question. It's
inefficient when dealing with numerous pages related to a memory
cgroup.

>=20
>>=20
>> I am uncertain about how to handle them appropriately as I am not an
>> expert at MGLRU. I would appreciate it if you could offer some =
suggestions.
>> Moreover, if you are willing to directly provide your patches, I =
would be
>> glad to incorporate them into this patchset.
>=20
> If we just follow the above idea (move them to parent's tail), we can
> just keep the folio's tier info untouched here.
>=20
> For mapped file folios, they will still be promoted upon eviction if
> their access bit are set (rmap walk), and MGLRU's table walker might
> just promote them just fine.
>=20
> For unmapped file folios, if we just keep their tier info and add
> child's MGLRU tier PID counter back to the parent. Workingset
> protection of MGLRU should still work just fine.
>=20
>>=20
>> ## Compositions
>>=20
>> Patches 1-8 involve code refactoring and cleanup with the aim of
>> facilitating the transfer LRU folios to object cgroup =
infrastructures.
>>=20
>> Patches 9-10 aim to allocate the object cgroup for non-kmem =
scenarios,
>> enabling the ability that LRU folios could be charged to it and =
aligning
>> the behavior of object-cgroup-related APIs with that of the memory =
cgroup.
>>=20
>> Patches 11-19 aim to prevent memory cgroup returned by folio_memcg() =
from
>> being released.
>>=20
>> Patches 20-23 aim to prevent lruvec returned by folio_lruvec() from =
being
>> released.
>>=20
>> Patches 24-25 implement the core mechanism to guarantee binding =
stability
>> between the folio and its corresponding memory cgroup while holding =
lruvec
>> lock or split-queue lock of THP.
>>=20
>> Patches 26-27 are intended to transfer the LRU pages to the object =
cgroup
>> without holding a reference to the original memory cgroup in order to
>> address the issue of the dying memory cgroup.
>>=20
>> Patch 28 aims to add VM_WARN_ON_ONCE_FOLIO to LRU maintenance helpers =
to
>> ensure correct folio operations in the future.
>>=20
>> ## Effect
>>=20
>> Finally, it can be observed that the quantity of dying memory cgroups =
will
>> not experience a significant increase if the following test script is
>> executed to reproduce the issue.
>>=20
>> ```bash
>> #!/bin/bash
>>=20
>> # Create a temporary file 'temp' filled with zero bytes
>> dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
>>=20
>> # Display memory-cgroup info from /proc/cgroups
>> cat /proc/cgroups | grep memory
>>=20
>> for i in {0..2000}
>> do
>>    mkdir /sys/fs/cgroup/memory/test$i
>>    echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
>>=20
>>    # Append 'temp' file content to 'log'
>>    cat temp >> log
>>=20
>>    echo $$ > /sys/fs/cgroup/memory/cgroup.procs
>>=20
>>    # Potentially create a dying memory cgroup
>>    rmdir /sys/fs/cgroup/memory/test$i
>> done
>>=20
>> # Display memory-cgroup info after test
>> cat /proc/cgroups | grep memory
>>=20
>> rm -f temp log
>> ```
>>=20
>> ## References
>>=20
>> [1] https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
>> [2] https://lwn.net/Articles/895431/
>> [3] https://github.com/systemd/systemd/pull/36827
>=20
> How much overhead will it be? Objcj has some extra overhead, and we
> have some extra convention for retrieving memcg of a folio now, not
> sure if this will have an observable slow down.

I don't think there'll be an observable slowdown. I think objcg is
more effective for slab objects as they're more sensitive than user
pages. If it's acceptable for slab objects, it should be acceptable
for user pages too.

>=20
> I'm still thinking if it be more feasible to just migrate (NOT that
> Cgroup V1 migrate, just set the folio's memcg to parent for dying
> cgroup and update the memcg charge) and iterate the folios on
> reparenting in a worker or something like that. There is already
> things like destruction workqueue and offline waitqueue. That way
> folios will still just point to a memcg, and seems would avoid a lot
> of complexity.

I didn't adopt this approach for two reasons then:

  1) It's inefficient to change `->memcg_data` to the parent when
     iterating through all pages associated with a memory cgroup.

  2) During iteration, we might come across pages isolated by other
     users. These pages aren't in any LRU list and will thus miss
     being reparented to the parent memory cgroup.

Muchun,
Thanks.

>=20
>=20
>>=20
>> Muchun Song (28):
>>  mm: memcontrol: remove dead code of checking parent memory cgroup
>>  mm: memcontrol: use folio_memcg_charged() to avoid potential rcu =
lock
>>    holding
>>  mm: workingset: use folio_lruvec() in workingset_refault()
>>  mm: rename unlock_page_lruvec_irq and its variants
>>  mm: thp: replace folio_memcg() with folio_memcg_charged()
>>  mm: thp: introduce folio_split_queue_lock and its variants
>>  mm: thp: use folio_batch to handle THP splitting in
>>    deferred_split_scan()
>>  mm: vmscan: refactor move_folios_to_lru()
>>  mm: memcontrol: allocate object cgroup for non-kmem case
>>  mm: memcontrol: return root object cgroup for root memory cgroup
>>  mm: memcontrol: prevent memory cgroup release in
>>    get_mem_cgroup_from_folio()
>>  buffer: prevent memory cgroup release in folio_alloc_buffers()
>>  writeback: prevent memory cgroup release in writeback module
>>  mm: memcontrol: prevent memory cgroup release in
>>    count_memcg_folio_events()
>>  mm: page_io: prevent memory cgroup release in page_io module
>>  mm: migrate: prevent memory cgroup release in =
folio_migrate_mapping()
>>  mm: mglru: prevent memory cgroup release in mglru
>>  mm: memcontrol: prevent memory cgroup release in
>>    mem_cgroup_swap_full()
>>  mm: workingset: prevent memory cgroup release in lru_gen_eviction()
>>  mm: workingset: prevent lruvec release in workingset_refault()
>>  mm: zswap: prevent lruvec release in zswap_folio_swapin()
>>  mm: swap: prevent lruvec release in swap module
>>  mm: workingset: prevent lruvec release in workingset_activation()
>>  mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
>>  mm: thp: prepare for reparenting LRU pages for split queue lock
>>  mm: memcontrol: introduce memcg_reparent_ops
>>  mm: memcontrol: eliminate the problem of dying memory cgroup for LRU
>>    folios
>>  mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
>>=20
>> fs/buffer.c                      |   4 +-
>> fs/fs-writeback.c                |  22 +-
>> include/linux/memcontrol.h       | 190 ++++++------
>> include/linux/mm_inline.h        |   6 +
>> include/trace/events/writeback.h |   3 +
>> mm/compaction.c                  |  43 ++-
>> mm/huge_memory.c                 | 218 +++++++++-----
>> mm/memcontrol-v1.c               |  15 +-
>> mm/memcontrol.c                  | 476 =
+++++++++++++++++++------------
>> mm/migrate.c                     |   2 +
>> mm/mlock.c                       |   2 +-
>> mm/page_io.c                     |   8 +-
>> mm/percpu.c                      |   2 +-
>> mm/shrinker.c                    |   6 +-
>> mm/swap.c                        |  22 +-
>> mm/vmscan.c                      |  73 ++---
>> mm/workingset.c                  |  26 +-
>> mm/zswap.c                       |   2 +
>> 18 files changed, 696 insertions(+), 424 deletions(-)
>>=20
>> --
>> 2.20.1



