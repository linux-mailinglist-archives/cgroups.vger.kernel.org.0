Return-Path: <cgroups+bounces-7576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C9A893CF
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 08:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C36017798B
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F523D2A2;
	Tue, 15 Apr 2025 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhR5pDhX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237713EFE3;
	Tue, 15 Apr 2025 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744697990; cv=none; b=GbcbM9lisBDu5Y5VB3YEjh+JSnY3duV33zoovJwtfw9a0RH19dt/WU3pQyQwVF8m/z/1tsa7WsO5OVfcA+aJ1FD1IsMScc6Jc1b5BNI3H/MKuQHrSg5oRwdBWJ3OivmgDMlnsdmEgpi5fPv6G4ukj0MKc6MN6VIIRAwHzTiT7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744697990; c=relaxed/simple;
	bh=JOqCX6BM466IKiLtCQ+T24s1tDcWSjUxa/ZU+hvrI70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py5jlNdes9L7jqdPiJleo5yl7495I3UPSgjVKl42tsNfLppkU2KNFx7HDyfKsyGYGOgaxbAAVzhukehAGIV3E1UWn42Gm+6M5mN+7jx5voQFEn+Z+ubFcomnEFerlyFJL/JCoNhNhKm7NHisVGKGvZ2DTAPg1YgDlCUhlIfolN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhR5pDhX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso53111061fa.3;
        Mon, 14 Apr 2025 23:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744697986; x=1745302786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Wv6OGD/mXBijI8bI4QMl+8zCCxYWngmJJ4GivvEdgo=;
        b=PhR5pDhXp8hJ1T4g7CmJU68LK8SmGMYhZE4AIaewycsNznDeDI4FSOujJJFmxSO2V4
         TZsj+jfQz4HeY9T1x9bOkjxvUUnpBZFrhmgWOyheWL7rkK/lljBSU67/zfqbqHoMEPzu
         hD1iK/qoN8NcpeKwTXAmfW5kJQAIcUnomqeu0jraIhKGd7Lxk469b1+xNAXKIMAhYVl1
         qZ2V/uYOSPJDG30Qq94K886ofoNmy2+Y3HYyETdl5NUYjz3Yh+0X/01PdC/DAh1hZ3ID
         qG08u+S1blQqpI5hX1UOF95ktzt7rlYyTglokBK7/25xUWVuskoXHIKG90Dn0tgCD1Ik
         qjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744697986; x=1745302786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Wv6OGD/mXBijI8bI4QMl+8zCCxYWngmJJ4GivvEdgo=;
        b=jAOEc1cFJ+cenrHackPO0jSip/0KFqjofKmz/voBwkwV5VXbJZX800IeMhhsQTmaf3
         nQATUg3ZFS3Qd5sJBCi/EYiLU41eRBY7VciGTHjQR/+hphbkaB/FW82O3+RBl+aL0KMN
         T4vNSiETVqSDqfbK7WhxiE7l2OTA2yFmWcLNY8+/Xe9kezKCotgxWii9DZid2Gq6Eipl
         T2xJhIlE7rk0bh6HtqoO6Ah2LXY8WLr36GV0zyTw1u7yN5PoPhnsa3Ek9ADPoVN1GhfF
         svWn9VdSRypNgddEHt+SI7RbKKZrpYgqSkYDTBaiSiM9Co6QTVhJgy5ARDMMbzCU5ANL
         pKcA==
X-Forwarded-Encrypted: i=1; AJvYcCU33LIULQU4DbHJhoXMcLi/wUg5UTdRzLg82P63xJkhZLb0H2WUOk426zttYkZGxroBtXbubZV8@vger.kernel.org, AJvYcCWOpGsKpQrDRYYYeBReNG9XeRIfCJon9EdDUyrcy3BtUoIILoqdlqkUslZPs8q4g59fIPmECr9Otbm077nc@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfttXYgIJM0h56GmF7DwrPPELxUGUQ0bCZaHUdZ0ejiKq7hbM
	FvVu0u86IWrZBIdJGfpE0ZTkYvj/IXdAPtOZrKIIjR9ptULPLg+5z1vdDA+l67Lpr5YPuTiJezD
	VAs6BRFO71rAXlRuzcZRP5X5uClV+q7a+
X-Gm-Gg: ASbGnctjvbHeuRVouN5ron1DZYmODm8+MUrWhHB8K/HNp9jsZXoNk/Sy3U+TAY17+Gk
	stu9WjsUKVCNiygHTWQJfuR1BnL7YU0NFoZDi1iczJCD+dhlKmoaeWwjudp9qaMIsa3/F529iIg
	oxf1cozHUSyZzQKsKmhQdF2Q==
X-Google-Smtp-Source: AGHT+IGHSVaZAFez4uVGYYlGMTKYrqz407FNx7uyL5wqvWr1DNKiSA9rzLGe7ytSTGwFX8LR8jm4JMJ4fhomOl3fjmo=
X-Received: by 2002:a2e:a549:0:b0:30c:460f:f56 with SMTP id
 38308e7fff4ca-31049a1afc5mr44927281fa.20.1744697986177; Mon, 14 Apr 2025
 23:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com>
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 15 Apr 2025 14:19:29 +0800
X-Gm-Features: ATxdqUFIoo8leWhSgNKio3tny0lnfgXi7RhMYezcohewSU1OXRUyhi5BW1sJQeM
Message-ID: <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:46=E2=80=AFAM Muchun Song <songmuchun@bytedance.=
com> wrote:
>
> This patchset is based on v6.15-rc2. It functions correctly only when
> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were encounter=
ed
> during rebasing onto the latest code. For more details and assistance, re=
fer
> to the "Challenges" section. This is the reason for adding the RFC tag.
>
> ## Introduction
>
> This patchset is intended to transfer the LRU pages to the object cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup. A consensus has already bee=
n
> reached regarding this approach recently [1].
>
> ## Background
>
> The issue of a dying memory cgroup refers to a situation where a memory
> cgroup is no longer being used by users, but memory (the metadata
> associated with memory cgroups) remains allocated to it. This situation
> may potentially result in memory leaks or inefficiencies in memory
> reclamation and has persisted as an issue for several years. Any memory
> allocation that endures longer than the lifespan (from the users'
> perspective) of a memory cgroup can lead to the issue of dying memory
> cgroup. We have exerted greater efforts to tackle this problem by
> introducing the infrastructure of object cgroup [2].
>
> Presently, numerous types of objects (slab objects, non-slab kernel
> allocations, per-CPU objects) are charged to the object cgroup without
> holding a reference to the original memory cgroup. The final allocations
> for LRU pages (anonymous pages and file pages) are charged at allocation
> time and continues to hold a reference to the original memory cgroup
> until reclaimed.
>
> File pages are more complex than anonymous pages as they can be shared
> among different memory cgroups and may persist beyond the lifespan of
> the memory cgroup. The long-term pinning of file pages to memory cgroups
> is a widespread issue that causes recurring problems in practical
> scenarios [3]. File pages remain unreclaimed for extended periods.
> Additionally, they are accessed by successive instances (second, third,
> fourth, etc.) of the same job, which is restarted into a new cgroup each
> time. As a result, unreclaimable dying memory cgroups accumulate,
> leading to memory wastage and significantly reducing the efficiency
> of page reclamation.
>
> ## Fundamentals
>
> A folio will no longer pin its corresponding memory cgroup. It is necessa=
ry
> to ensure that the memory cgroup or the lruvec associated with the memory
> cgroup is not released when a user obtains a pointer to the memory cgroup
> or lruvec returned by folio_memcg() or folio_lruvec(). Users are required
> to hold the RCU read lock or acquire a reference to the memory cgroup
> associated with the folio to prevent its release if they are not concerne=
d
> about the binding stability between the folio and its corresponding memor=
y
> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
> desire a stable binding between the folio and its corresponding memory
> cgroup. An approach is needed to ensure the stability of the binding whil=
e
> the lruvec lock is held, and to detect the situation of holding the
> incorrect lruvec lock when there is a race condition during memory cgroup
> reparenting. The following four steps are taken to achieve these goals.
>
> 1. The first step  to be taken is to identify all users of both functions
>    (folio_memcg() and folio_lruvec()) who are not concerned about binding
>    stability and implement appropriate measures (such as holding a RCU re=
ad
>    lock or temporarily obtaining a reference to the memory cgroup for a
>    brief period) to prevent the release of the memory cgroup.
>
> 2. Secondly, the following refactoring of folio_lruvec_lock() demonstrate=
s
>    how to ensure the binding stability from the user's perspective of
>    folio_lruvec().
>
>    struct lruvec *folio_lruvec_lock(struct folio *folio)
>    {
>            struct lruvec *lruvec;
>
>            rcu_read_lock();
>    retry:
>            lruvec =3D folio_lruvec(folio);
>            spin_lock(&lruvec->lru_lock);
>            if (unlikely(lruvec_memcg(lruvec) !=3D folio_memcg(folio))) {
>                    spin_unlock(&lruvec->lru_lock);
>                    goto retry;
>            }
>
>            return lruvec;
>    }
>
>    From the perspective of memory cgroup removal, the entire reparenting
>    process (altering the binding relationship between folio and its memor=
y
>    cgroup and moving the LRU lists to its parental memory cgroup) should =
be
>    carried out under both the lruvec lock of the memory cgroup being remo=
ved
>    and the lruvec lock of its parent.
>
> 3. Thirdly, another lock that requires the same approach is the split-que=
ue
>    lock of THP.
>
> 4. Finally, transfer the LRU pages to the object cgroup without holding a
>    reference to the original memory cgroup.
>

Hi, Muchun, thanks for the patch.

> ## Challenges
>
> In a non-MGLRU scenario, each lruvec of every memory cgroup comprises fou=
r
> LRU lists (i.e., two active lists for anonymous and file folios, and two
> inactive lists for anonymous and file folios). Due to the symmetry of the
> LRU lists, it is feasible to transfer the LRU lists from a memory cgroup
> to its parent memory cgroup during the reparenting process.

Symmetry of LRU lists doesn't mean symmetry 'hotness', it's totally
possible that a child's active LRU is colder and should be evicted
first before the parent's inactive LRU (might even be a common
scenario for certain workloads).
This only affects the performance not the correctness though, so not a
big problem.

So will it be easier to just assume dying cgroup's folios are colder?
Simply move them to parent's LRU tail is OK. This will make the logic
appliable for both active/inactive LRU and MGLRU.

>
> In a MGLRU scenario, each lruvec of every memory cgroup comprises at leas=
t
> 2 (MIN_NR_GENS) generations and at most 4 (MAX_NR_GENS) generations.
>
> 1. The first question is how to move the LRU lists from a memory cgroup t=
o
>    its parent memory cgroup during the reparenting process. This is due t=
o
>    the fact that the quantity of LRU lists (aka generations) may differ
>    between a child memory cgroup and its parent memory cgroup.
>
> 2. The second question is how to make the process of reparenting more
>    efficient, since each folio charged to a memory cgroup stores its
>    generation counter into its ->flags. And the generation counter may
>    differ between a child memory cgroup and its parent memory cgroup beca=
use
>    the values of ->min_seq and ->max_seq are not identical. Should those
>    generation counters be updated correspondingly?

I think you do have to iterate through the folios to set or clear
their generation flags if you want to put the folio in the right gen.

MGLRU does similar thing in inc_min_seq. MGLRU uses the gen flags to
defer the actual LRU movement of folios, that's a very important
optimization per my test.

>
> I am uncertain about how to handle them appropriately as I am not an
> expert at MGLRU. I would appreciate it if you could offer some suggestion=
s.
> Moreover, if you are willing to directly provide your patches, I would be
> glad to incorporate them into this patchset.

If we just follow the above idea (move them to parent's tail), we can
just keep the folio's tier info untouched here.

For mapped file folios, they will still be promoted upon eviction if
their access bit are set (rmap walk), and MGLRU's table walker might
just promote them just fine.

For unmapped file folios, if we just keep their tier info and add
child's MGLRU tier PID counter back to the parent. Workingset
protection of MGLRU should still work just fine.

>
> ## Compositions
>
> Patches 1-8 involve code refactoring and cleanup with the aim of
> facilitating the transfer LRU folios to object cgroup infrastructures.
>
> Patches 9-10 aim to allocate the object cgroup for non-kmem scenarios,
> enabling the ability that LRU folios could be charged to it and aligning
> the behavior of object-cgroup-related APIs with that of the memory cgroup=
.
>
> Patches 11-19 aim to prevent memory cgroup returned by folio_memcg() from
> being released.
>
> Patches 20-23 aim to prevent lruvec returned by folio_lruvec() from being
> released.
>
> Patches 24-25 implement the core mechanism to guarantee binding stability
> between the folio and its corresponding memory cgroup while holding lruve=
c
> lock or split-queue lock of THP.
>
> Patches 26-27 are intended to transfer the LRU pages to the object cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup.
>
> Patch 28 aims to add VM_WARN_ON_ONCE_FOLIO to LRU maintenance helpers to
> ensure correct folio operations in the future.
>
> ## Effect
>
> Finally, it can be observed that the quantity of dying memory cgroups wil=
l
> not experience a significant increase if the following test script is
> executed to reproduce the issue.
>
> ```bash
> #!/bin/bash
>
> # Create a temporary file 'temp' filled with zero bytes
> dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
>
> # Display memory-cgroup info from /proc/cgroups
> cat /proc/cgroups | grep memory
>
> for i in {0..2000}
> do
>     mkdir /sys/fs/cgroup/memory/test$i
>     echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
>
>     # Append 'temp' file content to 'log'
>     cat temp >> log
>
>     echo $$ > /sys/fs/cgroup/memory/cgroup.procs
>
>     # Potentially create a dying memory cgroup
>     rmdir /sys/fs/cgroup/memory/test$i
> done
>
> # Display memory-cgroup info after test
> cat /proc/cgroups | grep memory
>
> rm -f temp log
> ```
>
> ## References
>
> [1] https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
> [2] https://lwn.net/Articles/895431/
> [3] https://github.com/systemd/systemd/pull/36827

How much overhead will it be? Objcj has some extra overhead, and we
have some extra convention for retrieving memcg of a folio now, not
sure if this will have an observable slow down.

I'm still thinking if it be more feasible to just migrate (NOT that
Cgroup V1 migrate, just set the folio's memcg to parent for dying
cgroup and update the memcg charge) and iterate the folios on
reparenting in a worker or something like that. There is already
things like destruction workqueue and offline waitqueue. That way
folios will still just point to a memcg, and seems would avoid a lot
of complexity.


>
> Muchun Song (28):
>   mm: memcontrol: remove dead code of checking parent memory cgroup
>   mm: memcontrol: use folio_memcg_charged() to avoid potential rcu lock
>     holding
>   mm: workingset: use folio_lruvec() in workingset_refault()
>   mm: rename unlock_page_lruvec_irq and its variants
>   mm: thp: replace folio_memcg() with folio_memcg_charged()
>   mm: thp: introduce folio_split_queue_lock and its variants
>   mm: thp: use folio_batch to handle THP splitting in
>     deferred_split_scan()
>   mm: vmscan: refactor move_folios_to_lru()
>   mm: memcontrol: allocate object cgroup for non-kmem case
>   mm: memcontrol: return root object cgroup for root memory cgroup
>   mm: memcontrol: prevent memory cgroup release in
>     get_mem_cgroup_from_folio()
>   buffer: prevent memory cgroup release in folio_alloc_buffers()
>   writeback: prevent memory cgroup release in writeback module
>   mm: memcontrol: prevent memory cgroup release in
>     count_memcg_folio_events()
>   mm: page_io: prevent memory cgroup release in page_io module
>   mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
>   mm: mglru: prevent memory cgroup release in mglru
>   mm: memcontrol: prevent memory cgroup release in
>     mem_cgroup_swap_full()
>   mm: workingset: prevent memory cgroup release in lru_gen_eviction()
>   mm: workingset: prevent lruvec release in workingset_refault()
>   mm: zswap: prevent lruvec release in zswap_folio_swapin()
>   mm: swap: prevent lruvec release in swap module
>   mm: workingset: prevent lruvec release in workingset_activation()
>   mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
>   mm: thp: prepare for reparenting LRU pages for split queue lock
>   mm: memcontrol: introduce memcg_reparent_ops
>   mm: memcontrol: eliminate the problem of dying memory cgroup for LRU
>     folios
>   mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
>
>  fs/buffer.c                      |   4 +-
>  fs/fs-writeback.c                |  22 +-
>  include/linux/memcontrol.h       | 190 ++++++------
>  include/linux/mm_inline.h        |   6 +
>  include/trace/events/writeback.h |   3 +
>  mm/compaction.c                  |  43 ++-
>  mm/huge_memory.c                 | 218 +++++++++-----
>  mm/memcontrol-v1.c               |  15 +-
>  mm/memcontrol.c                  | 476 +++++++++++++++++++------------
>  mm/migrate.c                     |   2 +
>  mm/mlock.c                       |   2 +-
>  mm/page_io.c                     |   8 +-
>  mm/percpu.c                      |   2 +-
>  mm/shrinker.c                    |   6 +-
>  mm/swap.c                        |  22 +-
>  mm/vmscan.c                      |  73 ++---
>  mm/workingset.c                  |  26 +-
>  mm/zswap.c                       |   2 +
>  18 files changed, 696 insertions(+), 424 deletions(-)
>
> --
> 2.20.1
>
>

