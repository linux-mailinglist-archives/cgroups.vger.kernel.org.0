Return-Path: <cgroups+bounces-12805-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A6CE87E4
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 02:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 450E0301339A
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 01:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581D52877FE;
	Tue, 30 Dec 2025 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWyIptmy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0C1EEA31
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058610; cv=none; b=MEuIoejolFhIOLkxoI6HGOPzJNBPa+LvSoQy/g84Hj3J43NXl9l5liz0OgYdFWaW1/UFAD1K74OVygUyPyjr0PqeeKPosJapNGrMXkCLzmGBXy+iKkENYhSxZMH+UNZyM8/SWD4FOP50QlLqBDXwJ93Y6WTr02E7PasmhVupuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058610; c=relaxed/simple;
	bh=ECSng30ZKV8WM2MAMk597HqEICn/NtNNzpnnjoQiFrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LpqVQGf9LIxhbEpzsbw4wwl/7OfM8vgHL2joeN4E1+zr4ytdpZu8vjklYF/FmWLCk0D/gLR/ytxcvZHgW9pvZyxduK9v8BOJyHRxzSiFkUwkWk9aYnF0neT+gPAmgJ0muWHrjn70yB1+wVTgZzJpd3LmeEmN/4QvkptcJUHHwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWyIptmy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767058595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sI6COpy38PI6/XrNmbqGCTrUf4dEE7pm3FKsnpHWvvY=;
	b=gWyIptmynG7DFrFcn3erWOXRNJ1qoHCY6havEqdwo2YJw+v8kwl6TPvWxV98GfpmEL0oV4
	rLGJpcFWyoVat0ceG0dE3Q1ERldXD3oROo1zO/CbMXFB3iZv+ILeDUSQPTAgFgf6GZNgMQ
	Fli/Q4pSzlg+So5GWsOq7ml11U+m4M0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org,  hughd@google.com,  mhocko@suse.com,
  shakeel.butt@linux.dev,  muchun.song@linux.dev,  david@kernel.org,
  lorenzo.stoakes@oracle.com,  ziy@nvidia.com,  harry.yoo@oracle.com,
  imran.f.khan@oracle.com,  kamalesh.babulal@oracle.com,
  axelrasmussen@google.com,  yuanchu@google.com,  weixugc@google.com,
  chenridong@huaweicloud.com,  mkoutny@suse.com,
  akpm@linux-foundation.org,  hamzamahfooz@linux.microsoft.com,
  apais@linux.microsoft.com,  lance.yang@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,  Qi Zheng
 <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com> (Qi Zheng's
	message of "Wed, 17 Dec 2025 15:27:24 +0800")
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
Date: Tue, 30 Dec 2025 01:36:12 +0000
Message-ID: <7ia4ldikrbsj.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Qi Zheng <qi.zheng@linux.dev> writes:

Hey!

I ran this patchset through AI review and it found few regression (which
can of course be false positives). When you'll have time, can you,
please, take a look and comment on which are real and which are not?

Thank you!

--

# Task
Date: 2025-12-29 19:55:20
Model: gemini-3-pro-preview
Prompts SHA: 192922ae6bf4 ("bpf.md: adjust the documentation about bpf kfunc parameter validation")
Commits to review:
- e416d881eea4 ("mm: memcontrol: remove dead code of checking parent memory cgroup")
- 8e00ae594254 ("mm: workingset: use folio_lruvec() in workingset_refault()")
- a272ef87d5e7 ("mm: rename unlock_page_lruvec_irq and its variants")
- d57d548a3d6b ("mm: vmscan: prepare for the refactoring the move_folios_to_lru()")
- 9b02a45b6fc8 ("mm: vmscan: refactor move_folios_to_lru()")
- 057fca991b78 ("mm: memcontrol: allocate object cgroup for non-kmem case")
- 7c4110a3d8b6 ("mm: memcontrol: return root object cgroup for root memory cgroup")
- 8479f2eef536 ("mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()")
- c10b7e11fc09 ("buffer: prevent memory cgroup release in folio_alloc_buffers()")
- 65610d739afc ("writeback: prevent memory cgroup release in writeback module")
- f9b3cc3aed9f ("mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()")
- 91e4b3924291 ("mm: page_io: prevent memory cgroup release in page_io module")
- bb45e352bb34 ("mm: migrate: prevent memory cgroup release in folio_migrate_mapping()")
- a1189dd21a56 ("mm: mglru: prevent memory cgroup release in mglru")
- 4f41e0db1fd8 ("mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()")
- de63e2b7a03e ("mm: workingset: prevent memory cgroup release in lru_gen_eviction()")
- c0cce04fd4dc ("mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()")
- 555a447cb5f1 ("mm: zswap: prevent memory cgroup release in zswap_compress()")
- 80bbd804adde ("mm: workingset: prevent lruvec release in workingset_refault()")
- 9d232388a8e3 ("mm: zswap: prevent lruvec release in zswap_folio_swapin()")
- d7cb66b9350d ("mm: swap: prevent lruvec release in lru_gen_clear_refs()")
- 3e71e5543c8f ("mm: workingset: prevent lruvec release in workingset_activation()")
- e765ff303f13 ("mm: memcontrol: prepare for reparenting LRU pages for lruvec lock")
- d04921029e6d ("mm: vmscan: prepare for reparenting traditional LRU folios")
- dc3b4a08ad35 ("mm: vmscan: prepare for reparenting MGLRU folios")
- 18791acfe86b ("mm: memcontrol: refactor memcg_reparent_objcgs()")
- 19f79273a812 ("mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios")
- 44b8e8bca06e ("mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers")


# Commit e416d881eea4 ("mm: memcontrol: remove dead code of checking parent memory cgroup")
No detailed regression report generated.

# Commit 8e00ae594254 ("mm: workingset: use folio_lruvec() in workingset_refault()")
No detailed regression report generated.

# Commit a272ef87d5e7 ("mm: rename unlock_page_lruvec_irq and its variants")
No detailed regression report generated.

# Commit d57d548a3d6b ("mm: vmscan: prepare for the refactoring the move_folios_to_lru()")
No detailed regression report generated.

# Commit 9b02a45b6fc8 ("mm: vmscan: refactor move_folios_to_lru()")
commit 9b02a45b6fc8a2253e2edcccb24c8485d3dca672
Author: Muchun Song <muchun.song@linux.dev>

mm: vmscan: refactor move_folios_to_lru()

Refactors move_folios_to_lru() to handle its own locking via
folio_lruvec_relock_irq(), removing the requirement for the caller to hold
lruvec->lru_lock. Updates call sites to release the lock before calling.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 49e566174621..354b19f7365d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

[ ... ]

> @@ -4736,14 +4734,14 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  			set_mask_bits(&folio->flags.f, LRU_REFS_FLAGS, BIT(PG_active));
>  	}
>  
> -	spin_lock_irq(&lruvec->lru_lock);
> -
> -	move_folios_to_lru(lruvec, &list);
> +	move_folios_to_lru(&list);
>  
>  	walk = current->reclaim_state->mm_walk;
>  	if (walk && walk->batched) {
>  		walk->lruvec = lruvec;
> +		spin_lock(&lruvec->lru_lock);

move_folios_to_lru() drops the lock and enables interrupts via
lruvec_unlock_irq() (which calls spin_unlock_irq()). Since lru_lock is
an IRQ-safe lock (used elsewhere with spin_lock_irq()), is it safe to
use spin_lock() here with interrupts enabled? If an interrupt occurs
and tries to acquire lru_lock, could this lead to a deadlock?

>  		reset_batch_size(walk);
> +		spin_unlock(&lruvec->lru_lock);
>  	}
>  
>  	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),

[ ... ]

# Commit 057fca991b78 ("mm: memcontrol: allocate object cgroup for non-kmem case")
No detailed regression report generated.

# Commit 7c4110a3d8b6 ("mm: memcontrol: return root object cgroup for root memory cgroup")
No detailed regression report generated.

# Commit 8479f2eef536 ("mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()")
commit 8479f2eef5363fb93cc593038e9bc54dd5068ef2
Author: Muchun Song <muchun.song@linux.dev>

mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()

This patch modifies get_mem_cgroup_from_folio() to retry the lookup if
locking the memcg fails, serving as preparation for future changes where
folios may not pin their memcg.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 21b5aad34cae..431b3154c70c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>   */
>  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
>  {
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct mem_cgroup *memcg;
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	if (!folio_memcg_charged(folio))
> +		return root_mem_cgroup;
> +
>  	rcu_read_lock();
> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -		memcg = root_mem_cgroup;
> +retry:
> +	memcg = folio_memcg(folio);
> +	if (unlikely(!css_tryget(&memcg->css)))
> +		goto retry;

If css_tryget() fails (e.g. refcount is 0), this loop spins indefinitely
with the RCU read lock held. Is it guaranteed that folio_memcg() will
return a different, alive memcg in subsequent iterations?

If the folio is isolated (e.g. via migrate_misplaced_folio()), it might be
missed by reparenting logic that iterates LRU lists. In that case, the
folio would continue pointing to the dying memcg, leading to a hard lockup.

Also, folio_memcg() calls __folio_memcg(), which reads folio->memcg_data
without READ_ONCE(). Since this loop waits for memcg_data to be updated
by another CPU (reparenting), could the compiler hoist the load out of
the loop, preventing the update from being seen?

Finally, the previous code fell back to root_mem_cgroup on failure. Is it
safe to remove that fallback? If css_tryget() fails unexpectedly, hanging
seems more severe than the previous behavior of warning and falling back.

>  	rcu_read_unlock();
>  	return memcg;
>  }
# Commit c10b7e11fc09 ("buffer: prevent memory cgroup release in folio_alloc_buffers()")
No detailed regression report generated.

# Commit 65610d739afc ("writeback: prevent memory cgroup release in writeback module")

<regression>
  <description>
    Tight infinite loop in get_mem_cgroup_from_folio due to missing READ_ONCE and cpu_relax
  </description>
  <file>
    mm/memcontrol.c
  </file>
  <lines>
    991-993
  </lines>
  <reason>
    The retry loop in get_mem_cgroup_from_folio() continuously checks folio_memcg(folio)
    and tries to get a css reference. There are two issues:
    1. folio_memcg() reads folio->memcg_data without READ_ONCE(). The compiler may
       hoist this load out of the loop, leading to an infinite loop if the memcg
       is offlined and the loop condition depends on reparenting updating memcg_data.
    2. The loop does not contain cpu_relax(). If the update to folio->memcg_data
       is delayed (e.g., reparenting takes time), this creates a tight loop that
       burns CPU and stalls the RCU read-side critical section, potentially causing
       RCU stalls or soft lockups.
  </reason>
  <classification>
    Performance/Stability (Soft Lockup / Infinite Loop)
  </classification>
</regression>

<regression>
  <description>
    Removal of NULL check in mem_cgroup_track_foreign_dirty introduces potential crash
  </description>
  <file>
    include/linux/memcontrol.h
  </file>
  <lines>
    1557
  </lines>
  <reason>
    The check `if (unlikely(memcg && &memcg->css != wb->memcg_css))` was replaced with
    `if (unlikely(&memcg->css != wb->memcg_css))`.
    While folio_memcg_charged() is checked earlier, there is a race window between that check
    and the call to folio_memcg() where the folio could be uncharged (setting memcg_data to 0).
    If folio_memcg() returns NULL, accessing `&memcg->css` will dereference the NULL pointer
    (since css is at offset 0). The previous code safely handled NULL memcg.
  </reason>
  <classification>
    Robustness / Null Pointer Dereference
  </classification>
</regression>

# Commit f9b3cc3aed9f ("mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()")
No detailed regression report generated.

# Commit 91e4b3924291 ("mm: page_io: prevent memory cgroup release in page_io module")
No detailed regression report generated.

# Commit bb45e352bb34 ("mm: migrate: prevent memory cgroup release in folio_migrate_mapping()")
No detailed regression report generated.

# Commit a1189dd21a56 ("mm: mglru: prevent memory cgroup release in mglru")
commit a1189dd21a568b45eaddafc17b982f6200ba28c0
Author: Muchun Song <muchun.song@linux.dev>

mm: mglru: prevent memory cgroup release in mglru

This patch uses the rcu read lock to safeguard against the release of
the memory cgroup in mglru, as a preparatory measure for the reparenting
of the LRU pages.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 354b19f7365d..814498a2c1bd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
[ ... ]
> @@ -4242,6 +4244,13 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>  		}
>  	}
>  
> +	rcu_read_lock();
> +	memcg = folio_memcg(folio);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
> +	gen = lru_gen_from_seq(max_seq);
> +	mm_state = get_mm_state(lruvec);
> +
>  	arch_enter_lazy_mmu_mode();
>  
>  	pte -= (addr - start) / PAGE_SIZE;
[ ... ]
> @@ -4282,6 +4291,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>  	if (mm_state && suitable_to_scan(i, young))
>  		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
>  
> +	rcu_read_unlock();
> +
>  	return true;
>  }

This critical section appears to encompass calls to walk_update_folio(),
which calls folio_activate(), which eventually calls folio_lruvec_lock_irq()
to acquire lruvec->lru_lock.

Since lruvec->lru_lock is a spinlock_t, it becomes a sleeping lock on
PREEMPT_RT kernels. Is it safe to acquire a sleeping lock inside an RCU
read-side critical section on PREEMPT_RT?


# Commit 4f41e0db1fd8 ("mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()")
No detailed regression report generated.

# Commit de63e2b7a03e ("mm: workingset: prevent memory cgroup release in lru_gen_eviction()")
No detailed regression report generated.

# Commit c0cce04fd4dc ("mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()")
commit c0cce04fd4dca3a2b00e8846cbbeb52bd2f27625
Author: Qi Zheng <zhengqi.arch@bytedance.com>

mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()

This patch wraps the queue lookup in rcu_read_lock/unlock to safeguard
against memory cgroup release during the lookup, as folios may no longer
pin the memcg.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 12b46215b30c..b9e6855ec0b6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1154,13 +1154,25 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
>  
>  static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>  {
> -	return split_queue_lock(folio_nid(folio), folio_memcg(folio));
> +	struct deferred_split *queue;
> +
> +	rcu_read_lock();
> +	queue = split_queue_lock(folio_nid(folio), folio_memcg(folio));
> +	rcu_read_unlock();
> +
> +	return queue;
>  }

If the folio does not pin the memcg (as suggested by the commit message),
is it safe to return the queue pointer here? The queue is embedded in the
memcg, so if the memcg is freed after rcu_read_unlock(), wouldn't this
pointer become invalid while the caller still holds the lock?

>  
>  static struct deferred_split *
>  folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>  {
> -	return split_queue_lock_irqsave(folio_nid(folio), folio_memcg(folio), flags);
> +	struct deferred_split *queue;
> +
> +	rcu_read_lock();
> +	queue = split_queue_lock_irqsave(folio_nid(folio), folio_memcg(folio), flags);
> +	rcu_read_unlock();
> +
> +	return queue;
>  }

# Commit 555a447cb5f1 ("mm: zswap: prevent memory cgroup release in zswap_compress()")
No detailed regression report generated.

# Commit 80bbd804adde ("mm: workingset: prevent lruvec release in workingset_refault()")
commit 80bbd804adde7198f6c7c5fdf7b4349996586597
Author: Muchun Song <muchun.song@linux.dev>
mm: workingset: prevent lruvec release in workingset_refault()

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

> diff --git a/mm/workingset.c b/mm/workingset.c
> index 445fc634196d..427ca1a5625e 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -560,11 +560,12 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	 * locked to guarantee folio_memcg() stability throughout.
>  	 */
>  	nr = folio_nr_pages(folio);
> +	rcu_read_lock();
>  	lruvec = folio_lruvec(folio);
>  	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
>  
>  	if (!workingset_test_recent(shadow, file, &workingset, true))
> -		return;
> +		goto out;

Does calling workingset_test_recent() with flush=true while holding
rcu_read_lock() risk sleeping in atomic context?

workingset_test_recent() calls mem_cgroup_flush_stats_ratelimited() when
flush is true.  The flush path leads to css_rstat_flush(), which calls
might_sleep() and cond_resched().

>  
>  	folio_set_active(folio);
>  	workingset_age_nonresident(lruvec, nr);
> @@ -580,6 +581,8 @@ void workingset_refault(struct folio *folio, void *shadow)
>  		lru_note_cost_refault(folio);
>  		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
>  	}
> +out:
> +	rcu_read_unlock();
>  }
>  
>  /**

# Commit 9d232388a8e3 ("mm: zswap: prevent lruvec release in zswap_folio_swapin()")
No detailed regression report generated.

# Commit d7cb66b9350d ("mm: swap: prevent lruvec release in lru_gen_clear_refs()")
No detailed regression report generated.

# Commit 3e71e5543c8f ("mm: workingset: prevent lruvec release in workingset_activation()")
No detailed regression report generated.

# Commit e765ff303f13 ("mm: memcontrol: prepare for reparenting LRU pages for lruvec lock")
No detailed regression report generated.

# Commit d04921029e6d ("mm: vmscan: prepare for reparenting traditional LRU folios")
commit d04921029e6dc92824024356a9ed83a4f82d68dc
Author: Qi Zheng <zhengqi.arch@bytedance.com>

mm: vmscan: prepare for reparenting traditional LRU folios

This commit implements a specific function to reparent LRU folios of a
child memcg to its parent memcg during the reparenting process.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 814498a2c1bd..5fd0f97c3719 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2648,6 +2648,44 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
>  			  lruvec_memcg(lruvec));
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
> +				enum lru_list lru)
> +{
> +	int zid;
> +	struct mem_cgroup_per_node *mz_src, *mz_dst;
> +
> +	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
> +	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
> +
> +	if (lru != LRU_UNEVICTABLE)
> +		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);

Is it safe to modify src->lists and dst->lists here without holding
src->lru_lock or dst->lru_lock?  Since dst is the parent memcg, it is
likely live and subject to concurrent access by reclaim or allocation paths.

> +
> +	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> +		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
> +		mz_src->lru_zone_size[zid][lru] = 0;
> +	}

Also, lru_zone_size is typically protected by lru_lock.  Is it safe to
update these counters without locking?

> +}
> +
> +void lru_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		enum lru_list lru;
> +		struct lruvec *src_lruvec, *dst_lruvec;
> +
> +		src_lruvec = mem_cgroup_lruvec(src, NODE_DATA(nid));
> +		dst_lruvec = mem_cgroup_lruvec(dst, NODE_DATA(nid));
> +		dst_lruvec->anon_cost += src_lruvec->anon_cost;
> +		dst_lruvec->file_cost += src_lruvec->file_cost;
> +
> +		for_each_lru(lru)
> +			lruvec_reparent_lru(src_lruvec, dst_lruvec, lru);
> +	}
> +}
> +#endif

# Commit dc3b4a08ad35 ("mm: vmscan: prepare for reparenting MGLRU folios")
Here are the findings for the provided patch.

1.  **Missing locking in `lru_gen_reparent_memcg`**
    In `mm/vmscan.c`, the function `lru_gen_reparent_memcg` (and its helper `__lru_gen_reparent_memcg`) modifies the LRU lists and statistics of `lruvec` structures without holding the `lru_lock`.

    Specifically:
    - `__lru_gen_reparent_memcg` calls `__update_lru_size`.
    - `__update_lru_size` has a `lockdep_assert_held(&lruvec->lru_lock)`.
    - `__lru_gen_reparent_memcg` calls `list_splice_tail_init` to move folios from the source lruvec to the destination lruvec.

    The destination lruvec (`dst_lruvec`) belongs to the parent memcg, which is active and shared. Modifying its lists and counters without locking will lead to data corruption (list corruption) and statistics drift, as well as triggering lockdep warnings.

    ```c
    void lru_gen_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
    {
            int nid;

            for_each_node(nid) {
                    struct lruvec *src_lruvec, *dst_lruvec;
                    /* ... */
                    src_lruvec = get_lruvec(src, nid);
                    dst_lruvec = get_lruvec(dst, nid);

                    for (zone = 0; zone < MAX_NR_ZONES; zone++)
                            for (type = 0; type < ANON_AND_FILE; type++)
                                    __lru_gen_reparent_memcg(src_lruvec, dst_lruvec, zone, type);
            }
    }
    ```

    The `lruvec` lock must be acquired for each node before calling `__lru_gen_reparent_memcg`.

# Commit 18791acfe86b ("mm: memcontrol: refactor memcg_reparent_objcgs()")
No detailed regression report generated.

# Commit 19f79273a812 ("mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios")
file: mm/memcontrol.c
line: 224
type: Bug
category: Locking
description:
The `reparent_locks` function takes `lru_lock` for all NUMA nodes in a loop, utilizing `spin_lock_nested` with an incrementing `nest` counter. The `nest` counter increments for each lock taken (2 per node: src and dst). Since `MAX_LOCKDEP_SUBCLASSES` is 8, this code will trigger a Lockdep violation (and potential panic if `panic_on_warn` is set) on systems with more than 4 NUMA nodes (4 nodes * 2 locks = 8 subclasses). Furthermore, locking all nodes simultaneously is a scalability regression, blocking LRU operations globally during reparenting.

file: include/linux/memcontrol.h
line: 430
type: Risk
category: API
description:
The implementation of `folio_memcg` has changed to rely on `obj_cgroup_memcg`, which enforces that `rcu_read_lock` or `cgroup_mutex` is held via a lockdep assertion. Previously, for LRU folios, the memcg pointer was directly embedded and stable under the folio lock. Existing callers (e.g., in `mm/workingset.c`) relied on the folio lock for stability. While some callers may hold RCU, others might not, leading to lockdep warnings or races where `folio_memcg` returns a pointer to a memcg that is being reparented or freed. Additionally, the return value of `folio_memcg` is no longer constant for a locked folio; it can change if reparenting occurs, potentially breaking logic that assumes identity equality over time.

# Commit 44b8e8bca06e ("mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers")
No detailed regression report generated.

# Summary

| Commit                                                                                        | Regressions |
| :-------------------------------------------------------------------------------------------- | :---------- |
| e416d881eea4 ("mm: memcontrol: remove dead code of checking parent memory cgroup")            | 0           |
| 8e00ae594254 ("mm: workingset: use folio_lruvec() in workingset_refault()")                   | 0           |
| a272ef87d5e7 ("mm: rename unlock_page_lruvec_irq and its variants")                           | 0           |
| d57d548a3d6b ("mm: vmscan: prepare for the refactoring the move_folios_to_lru()")             | 0           |
| 9b02a45b6fc8 ("mm: vmscan: refactor move_folios_to_lru()")                                    | 1           |
| 057fca991b78 ("mm: memcontrol: allocate object cgroup for non-kmem case")                     | 0           |
| 7c4110a3d8b6 ("mm: memcontrol: return root object cgroup for root memory cgroup")             | 0           |
| 8479f2eef536 ("mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()") | 1           |
| c10b7e11fc09 ("buffer: prevent memory cgroup release in folio_alloc_buffers()")               | 0           |
| 65610d739afc ("writeback: prevent memory cgroup release in writeback module")                 | 2           |
| f9b3cc3aed9f ("mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()")  | 0           |
| 91e4b3924291 ("mm: page_io: prevent memory cgroup release in page_io module")                 | 0           |
| bb45e352bb34 ("mm: migrate: prevent memory cgroup release in folio_migrate_mapping()")        | 0           |
| a1189dd21a56 ("mm: mglru: prevent memory cgroup release in mglru")                            | 1           |
| 4f41e0db1fd8 ("mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()")      | 0           |
| de63e2b7a03e ("mm: workingset: prevent memory cgroup release in lru_gen_eviction()")          | 0           |
| c0cce04fd4dc ("mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()") | 1           |
| 555a447cb5f1 ("mm: zswap: prevent memory cgroup release in zswap_compress()")                 | 0           |
| 80bbd804adde ("mm: workingset: prevent lruvec release in workingset_refault()")               | 1           |
| 9d232388a8e3 ("mm: zswap: prevent lruvec release in zswap_folio_swapin()")                    | 0           |
| d7cb66b9350d ("mm: swap: prevent lruvec release in lru_gen_clear_refs()")                     | 0           |
| 3e71e5543c8f ("mm: workingset: prevent lruvec release in workingset_activation()")            | 0           |
| e765ff303f13 ("mm: memcontrol: prepare for reparenting LRU pages for lruvec lock")            | 0           |
| d04921029e6d ("mm: vmscan: prepare for reparenting traditional LRU folios")                   | 1           |
| dc3b4a08ad35 ("mm: vmscan: prepare for reparenting MGLRU folios")                             | 1           |
| 18791acfe86b ("mm: memcontrol: refactor memcg_reparent_objcgs()")                             | 0           |
| 19f79273a812 ("mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios")  | 2           |
| 44b8e8bca06e ("mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers")                | 0           |

