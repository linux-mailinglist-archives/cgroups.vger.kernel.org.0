Return-Path: <cgroups+bounces-4213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4B94FA2A
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 01:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57941F22CD8
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9E170A0D;
	Mon, 12 Aug 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bicXCiH6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185681804F
	for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723504632; cv=none; b=eyvvbodMOJ496Pg2FCFLjIEhPNhVh6q9mgC537cnH0+aZ5wxHWc9s6fqu/aoJSMqBU4VBIYt9VA6QMQiE33metKV0AcXGCgXEQm4s7vY6+aloFWDHjqBhAcnF3E+mLGIQNrKUUcNOcIs1Lxc6k4UgTw0H9tSUtBbbOkTNCjFuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723504632; c=relaxed/simple;
	bh=SB5DZO+UTIuTz37YSDOWgvWSFK4XMgraW4XCItqSPpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2vFPyqXW2JvY7TuhUXOg/pTtoqWlmANsoFhFe/UFoCTqy/z8WL/zb2wvTVTUxEX0REPMRMpBW7FivdidxBEOI+Z1ZVFHQxojSmSvTRM0A6L0eqiVUeMdvsZIokrBD8wfxv+FtIcMSQV52infmsDoOHyVRoy1qej7ycjeiQZuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bicXCiH6; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-492a3fe7e72so1856832137.1
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723504629; x=1724109429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fpC/wRgHN4zuiSwITlbr+EHn6kbUFgZuj51Uk3vQvU=;
        b=bicXCiH652yLv9CaKWGGrj1ZXx2pqn+7rddMfENM3HWj6+qeiYJ3oe22mGAzJ5a5Q9
         IJ6x3hLJPgBfQCm79vgBgAeXIKFLXMfGu+LR6//lT/Ajp9fe47beP8mJpXa/kmjVhlQM
         71qi7x21AlfUQAHi6sQiNJ4ITvns4xY9oymtvhHb9Zcgmc5pqoqmF0iBHoujhC36FVy/
         VKeYF6ykL/ClZWqiuq9haVBUkSkEw+oOgYwKCEHjgt+A6nkTvFY+6f7FSB9z3sqfXhS0
         /3lxcrzHag2CF1CQhELK6/iFQodO1mE0vKF0skekI6sy1inZoBHuf1q/tVtNLGueV3O6
         Kgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723504629; x=1724109429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fpC/wRgHN4zuiSwITlbr+EHn6kbUFgZuj51Uk3vQvU=;
        b=rIjsqJU5nAiLV4c/AVJyHqbbHU264cf3WZ8TpRjV3JyAVc18TYxRcGMKxm83DLW1Ka
         YKRLSMJpcRPFBCJ3QMxfHXyIXX1D4rRNVBArxo9vbGFqG2lKeVZ69JCMOr5RK1Ykz142
         R6lu6JXv/itlu0B5j3CQ5ElNHfX39lY0+Vq7SmrJ0uJ32UEVAIFkO6UHdmCURi1FyrVl
         E87OqHbeoI26c3SZzXL9g7u/vKZPjOofKStooNCivfdbJYELOpkOfoCv4OLBM4zNyW+B
         z4tdGcsy1JRpR9LY4TrN859r/3Onl4d+e6nWqIKGXJXmYNU88S8WbzD6eusHgldm4CcO
         LtGg==
X-Forwarded-Encrypted: i=1; AJvYcCWTG/2LQibdP+8qLSkTICmO/XV0dwqDk72d++pM1kEUmDCdKVNayziZNRzKxATAmpvkfQWTJe/6lyfZn9G8xpZhI7zc1iwNaw==
X-Gm-Message-State: AOJu0YzaTu/q0q46aNjBBRsfZGcc8Ow4K5D7ZyzwA3Sah5MSeaoah0MD
	A8V6zg84lcVWK0UE0wGrc/uyQWeSYwSSOdRoyLpycsZdEfy0gqw8IMNDSxCM34w3sNkHzryTPAe
	KqllPZCw0HNzAI3iVj9ehylL/CYl2cjHt7f68
X-Google-Smtp-Source: AGHT+IHRrQUc+GE29xVTQFYP/zPfJYjLR5AJfs2rmjsJuT9Tdd3GXq2MWxY7SCSNR3UY9rhJI+Hn1mh/wxoW/OcT/AM=
X-Received: by 2002:a05:6102:cd1:b0:492:ac05:50e0 with SMTP id
 ada2fe7eead31-49743b181d4mr2119404137.26.1723504628747; Mon, 12 Aug 2024
 16:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812222907.2676698-1-kaiyang2@cs.cmu.edu>
In-Reply-To: <20240812222907.2676698-1-kaiyang2@cs.cmu.edu>
From: Wei Xu <weixugc@google.com>
Date: Mon, 12 Aug 2024 16:16:57 -0700
Message-ID: <CAAPL-u876HXxN7ZeS-Ruv51YPEKBYGtzo_CsfWhwLV8HF1733g@mail.gmail.com>
Subject: Re: [PATCH v2] mm,memcg: provide per-cgroup counters for NUMA
 balancing operations
To: kaiyang2@cs.cmu.edu
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	mhocko@kernel.org, nehagholkar@meta.com, abhishekd@meta.com, 
	hannes@cmpxchg.org, kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 3:29=E2=80=AFPM <kaiyang2@cs.cmu.edu> wrote:
>
> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
>
> v2:
> - fixed compilation error when CONFIG_NUMA_BALANCING is off
> - fixed doc warning due to missing parameter description in
> get_mem_cgroup_from_folio
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408110848.pqaWv5zD-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202408110708.gCHsUKRI-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202408110706.DZD0TOV3-lkp@i=
ntel.com/
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> The ability to observe the demotion and promotion decisions made by the
> kernel on a per-cgroup basis is important for monitoring and tuning
> containerized workloads on either NUMA machines or machines
> equipped with tiered memory.
>
> Different containers in the system may experience drastically different
> memory tiering actions that cannot be distinguished from the global
> counters alone.
>
> For example, a container running a workload that has a much hotter
> memory accesses will likely see more promotions and fewer demotions,
> potentially depriving a colocated container of top tier memory to such
> an extent that its performance degrades unacceptably.
>
> For another example, some containers may exhibit longer periods between
> data reuse, causing much more numa_hint_faults than numa_pages_migrated.
> In this case, tuning hot_threshold_ms may be appropriate, but the signal
> can easily be lost if only global counters are available.
>
> This patch set adds five counters to
> memory.stat in a cgroup: numa_pages_migrated, numa_pte_updates,
> numa_hint_faults, pgdemote_kswapd and pgdemote_direct.
>
> count_memcg_events_mm() is added to count multiple event occurrences at
> once, and get_mem_cgroup_from_folio() is added because we need to get a
> reference to the memcg of a folio before it's migrated to track
> numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
> shrink_inactive_list() before being changed to per-cgroup.
>
> Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
> ---
>  include/linux/memcontrol.h | 24 +++++++++++++++++++++---
>  include/linux/vmstat.h     |  1 +
>  mm/memcontrol.c            | 33 +++++++++++++++++++++++++++++++++
>  mm/memory.c                |  3 +++
>  mm/mempolicy.c             |  4 +++-
>  mm/migrate.c               |  3 +++
>  mm/vmscan.c                |  8 ++++----
>  7 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 44f7fb7dc0c8..90ecd2dbca06 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -768,6 +768,8 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_s=
truct *mm);
>
>  struct mem_cgroup *get_mem_cgroup_from_current(void);
>
> +struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio);
> +
>  struct lruvec *folio_lruvec_lock(struct folio *folio);
>  struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
>  struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
> @@ -1012,8 +1014,8 @@ static inline void count_memcg_folio_events(struct =
folio *folio,
>                 count_memcg_events(memcg, idx, nr);
>  }
>
> -static inline void count_memcg_event_mm(struct mm_struct *mm,
> -                                       enum vm_event_item idx)
> +static inline void count_memcg_events_mm(struct mm_struct *mm,
> +                                       enum vm_event_item idx, unsigned =
long count)
>  {
>         struct mem_cgroup *memcg;
>
> @@ -1023,10 +1025,16 @@ static inline void count_memcg_event_mm(struct mm=
_struct *mm,
>         rcu_read_lock();
>         memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
>         if (likely(memcg))
> -               count_memcg_events(memcg, idx, 1);
> +               count_memcg_events(memcg, idx, count);
>         rcu_read_unlock();
>  }
>
> +static inline void count_memcg_event_mm(struct mm_struct *mm,
> +                                       enum vm_event_item idx)
> +{
> +       count_memcg_events_mm(mm, idx, 1);
> +}
> +
>  static inline void memcg_memory_event(struct mem_cgroup *memcg,
>                                       enum memcg_memory_event event)
>  {
> @@ -1246,6 +1254,11 @@ static inline struct mem_cgroup *get_mem_cgroup_fr=
om_current(void)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio =
*folio)
> +{
> +       return NULL;
> +}
> +
>  static inline
>  struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
>  {
> @@ -1468,6 +1481,11 @@ static inline void count_memcg_folio_events(struct=
 folio *folio,
>  {
>  }
>
> +static inline void count_memcg_events_mm(struct mm_struct *mm,
> +                                       enum vm_event_item idx, unsigned =
long count)
> +{
> +}
> +
>  static inline
>  void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  {
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 596c050ed492..ff0b49f76ca4 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -32,6 +32,7 @@ struct reclaim_stat {
>         unsigned nr_ref_keep;
>         unsigned nr_unmap_fail;
>         unsigned nr_lazyfree_fail;
> +       unsigned nr_demoted;
>  };
>
>  /* Stat data for system wide items */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e1ffd2950393..fe7d057bbb67 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -307,6 +307,9 @@ static const unsigned int memcg_node_stat_items[] =3D=
 {
>  #ifdef CONFIG_SWAP
>         NR_SWAPCACHE,
>  #endif
> +       PGDEMOTE_KSWAPD,
> +       PGDEMOTE_DIRECT,
> +       PGDEMOTE_KHUGEPAGED,
>  };
>
>  static const unsigned int memcg_stat_items[] =3D {
> @@ -437,6 +440,11 @@ static const unsigned int memcg_vm_event_stat[] =3D =
{
>         THP_SWPOUT,
>         THP_SWPOUT_FALLBACK,
>  #endif
> +#ifdef CONFIG_NUMA_BALANCING
> +       NUMA_PAGE_MIGRATE,
> +       NUMA_PTE_UPDATES,
> +       NUMA_HINT_FAULTS,
> +#endif
>  };
>
>  #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
> @@ -978,6 +986,24 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>         return memcg;
>  }
>
> +/**
> + * get_mem_cgroup_from_folio - Obtain a reference on a given folio's mem=
cg.
> + * @folio: folio from which memcg should be extracted.
> + */
> +struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
> +{
> +       struct mem_cgroup *memcg =3D folio_memcg(folio);
> +
> +       if (mem_cgroup_disabled())
> +               return NULL;
> +
> +       rcu_read_lock();
> +       if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> +               memcg =3D root_mem_cgroup;
> +       rcu_read_unlock();
> +       return memcg;
> +}
> +
>  /**
>   * mem_cgroup_iter - iterate over memory cgroup hierarchy
>   * @root: hierarchy root
> @@ -1383,6 +1409,10 @@ static const struct memory_stat memory_stats[] =3D=
 {
>         { "workingset_restore_anon",    WORKINGSET_RESTORE_ANON         }=
,
>         { "workingset_restore_file",    WORKINGSET_RESTORE_FILE         }=
,
>         { "workingset_nodereclaim",     WORKINGSET_NODERECLAIM          }=
,
> +
> +       { "pgdemote_kswapd",            PGDEMOTE_KSWAPD         },
> +       { "pgdemote_direct",            PGDEMOTE_DIRECT         },
> +       { "pgdemote_khugepaged",        PGDEMOTE_KHUGEPAGED     },
>  };
>
>  /* The actual unit of the state item, not the same as the output unit */
> @@ -1416,6 +1446,9 @@ static int memcg_page_state_output_unit(int item)
>         case WORKINGSET_RESTORE_ANON:
>         case WORKINGSET_RESTORE_FILE:
>         case WORKINGSET_NODERECLAIM:
> +       case PGDEMOTE_KSWAPD:
> +       case PGDEMOTE_DIRECT:
> +       case PGDEMOTE_KHUGEPAGED:
>                 return 1;
>         default:
>                 return memcg_page_state_unit(item);
> diff --git a/mm/memory.c b/mm/memory.c
> index d6af095d255b..7b6a3619fcce 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5373,6 +5373,9 @@ int numa_migrate_prep(struct folio *folio, struct v=
m_fault *vmf,
>         vma_set_access_pid_bit(vma);
>
>         count_vm_numa_event(NUMA_HINT_FAULTS);
> +#ifdef CONFIG_NUMA_BALANCING
> +       count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
> +#endif
>         if (page_nid =3D=3D numa_node_id()) {
>                 count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
>                 *flags |=3D TNF_FAULT_LOCAL;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b3b5f376471f..b646fab3e45e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -676,8 +676,10 @@ unsigned long change_prot_numa(struct vm_area_struct=
 *vma,
>         tlb_gather_mmu(&tlb, vma->vm_mm);
>
>         nr_updated =3D change_protection(&tlb, vma, addr, end, MM_CP_PROT=
_NUMA);
> -       if (nr_updated > 0)
> +       if (nr_updated > 0) {
>                 count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
> +               count_memcg_events_mm(vma->vm_mm, NUMA_PTE_UPDATES, nr_up=
dated);
> +       }
>
>         tlb_finish_mmu(&tlb);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 66a5f73ebfdf..7e1267042a56 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2614,6 +2614,7 @@ int migrate_misplaced_folio(struct folio *folio, st=
ruct vm_area_struct *vma,
>         int nr_remaining;
>         unsigned int nr_succeeded;
>         LIST_HEAD(migratepages);
> +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_folio(folio);
>
>         list_add(&folio->lru, &migratepages);
>         nr_remaining =3D migrate_pages(&migratepages, alloc_misplaced_dst=
_folio,
> @@ -2623,12 +2624,14 @@ int migrate_misplaced_folio(struct folio *folio, =
struct vm_area_struct *vma,
>                 putback_movable_pages(&migratepages);
>         if (nr_succeeded) {
>                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> +               count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded=
);
>                 if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_T=
IERING)
>                     && !node_is_toptier(folio_nid(folio))
>                     && node_is_toptier(node))
>                         mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>                                             nr_succeeded);

Given that the motivating use case is for memory tiering, can we add
PGPROMOTE_SUCCESS to per-memcg stat here as well?

>         }
> +       mem_cgroup_put(memcg);
>         BUG_ON(!list_empty(&migratepages));
>         return nr_remaining ? -EAGAIN : 0;
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 25e43bb3b574..fd66789a413b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1008,9 +1008,6 @@ static unsigned int demote_folio_list(struct list_h=
ead *demote_folios,
>                       (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>                       &nr_succeeded);
>
> -       mod_node_page_state(pgdat, PGDEMOTE_KSWAPD + reclaimer_offset(),
> -                           nr_succeeded);
> -
>         return nr_succeeded;
>  }
>
> @@ -1518,7 +1515,8 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>         /* 'folio_list' is always empty here */
>
>         /* Migrate folios selected for demotion */
> -       nr_reclaimed +=3D demote_folio_list(&demote_folios, pgdat);
> +       stat->nr_demoted =3D demote_folio_list(&demote_folios, pgdat);
> +       nr_reclaimed +=3D stat->nr_demoted;
>         /* Folios that could not be demoted are still in @demote_folios *=
/
>         if (!list_empty(&demote_folios)) {
>                 /* Folios which weren't demoted go back on @folio_list */
> @@ -1984,6 +1982,8 @@ static unsigned long shrink_inactive_list(unsigned =
long nr_to_scan,
>         spin_lock_irq(&lruvec->lru_lock);
>         move_folios_to_lru(lruvec, &folio_list);
>
> +       __mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
> +                                       stat.nr_demoted);
>         __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>         item =3D PGSTEAL_KSWAPD + reclaimer_offset();
>         if (!cgroup_reclaim(sc))
> --
> 2.43.0
>
>

