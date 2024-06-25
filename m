Return-Path: <cgroups+bounces-3344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C833915F97
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CB71F21D8B
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FE1482E9;
	Tue, 25 Jun 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bnaAdpyg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBA1482FC
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299249; cv=none; b=iCt0WuotJ1HhombTI2o7A8B1oKm5pOZXrceT4amURSpQPnAOvtPLrIWDfA3HYNbIkFdvPZTpwfa8PY4NvAQ50RH/YGtOwZfqaX0WncJFZ2BGK/tmL+gi2ewI64MvRaFLwPS5zc3439Amwr4MeKEQNY9ZkHLv2zUakVA1lOJm7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299249; c=relaxed/simple;
	bh=KMrFWSSyUirJwj38+tRZsBYf49RHNp+aUGgKqhf0UYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHZNuGnpQ3L4f5jp5RbbS2k2KGNtNPFRBcsHz+ACIWRUH+Z23XFvZxQebF1TXACvjZMixyozfDzabQTlfp3orC/U/2L3O46dGkES15CEARLp40tuV1ZFWeVD0Et1mAntFv83mCIswH8zhK4ikeCNdkfMqKEo1Ze5oNBwi8UJdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bnaAdpyg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72477a60fbso249112266b.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299243; x=1719904043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ySyAlPVq9mjhrRsAxWLWoa8K3gH72ah98m/C4BbgL4=;
        b=bnaAdpygUDh2KeV5cC+9tO1yHeJKrcS6oniGrthxbk5KPLimjWA+1e7Ltw04a0dkbU
         JqYhIQWN5gtFDgu2CrIdFEP9Sqo1BP0vBIdPpw4vdTix3Xkov8538rX+vPKQLMKGjcgh
         Jougg1IRx/xNyxdu9QlX11wexAqfoGELEGcMDV6jygYNaSs4RYzc5Og7FatgM5gD5yS9
         4/lyppZeW0CQwO1tsUYTrRYImICs6tGYY3xngrO21+R2c4V8WI1Twe/rg4NHZq/aRAB+
         WUUxB1Wc9va/nj9e1ks0HooMIp3jXHfIqC7K8VHUHnSwq6dUx8QKC6CWn7HNf2UYiGID
         Ao9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299243; x=1719904043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ySyAlPVq9mjhrRsAxWLWoa8K3gH72ah98m/C4BbgL4=;
        b=P9LwoTXA1K3kZIMABZ8DbborUUVWFW8ujlMNFA/i5SdmQ7FfyZpmxNFcSicTUdI1D1
         u/14ZIbdOJze4y+FFkrH+dT6AEgDzB/x8L559SR8XkOZq57aNV2STZ8eYqHrIDwR3yPt
         sXPHvhhEViXxGlfpjYJ9JV2Mg5+0sjiG2KYrbKQt+QHv/AIPT72oJ+XJERdZxPOKN7IB
         i+jIjmhY3dZmEIFyLEg32vXheBczpFD4+pUwaxkZDU7I6aRAUnC8V2UD6u/qpK21wxla
         uRbL6jIuKbwfWQxLsJwXV8U9CpV1AXkxsGg1XSE1NebzxE5tvs0LZttXl4TyMHyvyD7s
         Av9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeL6NKoHxJWeGdAJ7PYvgslG9reD1rCZPJyI54AZg9nfbaF/ZXHWRcEA7wBIGYedcP1Gw6aYVOeRV1ebfGwFX85xWXOyUOZQ==
X-Gm-Message-State: AOJu0YzQ7t7UGTMyWqD4OAGc+omMZp2K9e8pLXVhGkZnUuVzKZKCUQhe
	h6YcOzj7EE6+ynNuPEl41ovxrQ22y+Jd5lkzwlNX1RnTE1BPTbspGVOcmRleBZ0=
X-Google-Smtp-Source: AGHT+IEI+FpZu/SObV+PmT8HnFWW1zVxThUdfXowu4j/cFF/mJeyZto6Il7J/G+oHZTOBGi8eQ/0Iw==
X-Received: by 2002:a17:906:9c91:b0:a72:690d:a177 with SMTP id a640c23a62f3a-a72690da6a3mr112539366b.17.1719299241677;
        Tue, 25 Jun 2024 00:07:21 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7244cbce5bsm290020766b.79.2024.06.25.00.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:07:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:07:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/14] mm: memcg: move charge migration code to
 memcontrol-v1.c
Message-ID: <Znpsp-wkLmaV4Phj@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-5-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:56, Roman Gushchin wrote:
> Unlike the legacy cgroup v1 memory controller, cgroup v2 memory
> controller doesn't support moving charged pages between cgroups.
> 
> It's a fairly large and complicated code which created a number
> of problems in the past. Let's move this code into memcontrol-v1.c.
> It shaves off 1k lines from memcontrol.c. It's also another step
> towards making the legacy memory controller code optionally compiled.

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/memcontrol-v1.c |  981 +++++++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol-v1.h |   30 ++
>  mm/memcontrol.c    | 1004 +-------------------------------------------
>  3 files changed, 1019 insertions(+), 996 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 68e2f1a718d3..f4c8bec5ae1b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -3,7 +3,12 @@
>  #include <linux/memcontrol.h>
>  #include <linux/swap.h>
>  #include <linux/mm_inline.h>
> +#include <linux/pagewalk.h>
> +#include <linux/backing-dev.h>
> +#include <linux/swap_cgroup.h>
>  
> +#include "internal.h"
> +#include "swap.h"
>  #include "memcontrol-v1.h"
>  
>  /*
> @@ -30,6 +35,31 @@ static struct mem_cgroup_tree soft_limit_tree __read_mostly;
>  #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
>  #define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
>  
> +/* Stuffs for move charges at task migration. */
> +/*
> + * Types of charges to be moved.
> + */
> +#define MOVE_ANON	0x1U
> +#define MOVE_FILE	0x2U
> +#define MOVE_MASK	(MOVE_ANON | MOVE_FILE)
> +
> +/* "mc" and its members are protected by cgroup_mutex */
> +static struct move_charge_struct {
> +	spinlock_t	  lock; /* for from, to */
> +	struct mm_struct  *mm;
> +	struct mem_cgroup *from;
> +	struct mem_cgroup *to;
> +	unsigned long flags;
> +	unsigned long precharge;
> +	unsigned long moved_charge;
> +	unsigned long moved_swap;
> +	struct task_struct *moving_task;	/* a task moving charges */
> +	wait_queue_head_t waitq;		/* a waitq for other context */
> +} mc = {
> +	.lock = __SPIN_LOCK_UNLOCKED(mc.lock),
> +	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
> +};
> +
>  static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
>  					 struct mem_cgroup_tree_per_node *mctz,
>  					 unsigned long new_usage_in_excess)
> @@ -325,6 +355,957 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	return nr_reclaimed;
>  }
>  
> +/*
> + * A routine for checking "mem" is under move_account() or not.
> + *
> + * Checking a cgroup is mc.from or mc.to or under hierarchy of
> + * moving cgroups. This is for waiting at high-memory pressure
> + * caused by "move".
> + */
> +static bool mem_cgroup_under_move(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *from;
> +	struct mem_cgroup *to;
> +	bool ret = false;
> +	/*
> +	 * Unlike task_move routines, we access mc.to, mc.from not under
> +	 * mutual exclusion by cgroup_mutex. Here, we take spinlock instead.
> +	 */
> +	spin_lock(&mc.lock);
> +	from = mc.from;
> +	to = mc.to;
> +	if (!from)
> +		goto unlock;
> +
> +	ret = mem_cgroup_is_descendant(from, memcg) ||
> +		mem_cgroup_is_descendant(to, memcg);
> +unlock:
> +	spin_unlock(&mc.lock);
> +	return ret;
> +}
> +
> +bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> +{
> +	if (mc.moving_task && current != mc.moving_task) {
> +		if (mem_cgroup_under_move(memcg)) {
> +			DEFINE_WAIT(wait);
> +			prepare_to_wait(&mc.waitq, &wait, TASK_INTERRUPTIBLE);
> +			/* moving charge context might have finished. */
> +			if (mc.moving_task)
> +				schedule();
> +			finish_wait(&mc.waitq, &wait);
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +/**
> + * folio_memcg_lock - Bind a folio to its memcg.
> + * @folio: The folio.
> + *
> + * This function prevents unlocked LRU folios from being moved to
> + * another cgroup.
> + *
> + * It ensures lifetime of the bound memcg.  The caller is responsible
> + * for the lifetime of the folio.
> + */
> +void folio_memcg_lock(struct folio *folio)
> +{
> +	struct mem_cgroup *memcg;
> +	unsigned long flags;
> +
> +	/*
> +	 * The RCU lock is held throughout the transaction.  The fast
> +	 * path can get away without acquiring the memcg->move_lock
> +	 * because page moving starts with an RCU grace period.
> +         */
> +	rcu_read_lock();
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +again:
> +	memcg = folio_memcg(folio);
> +	if (unlikely(!memcg))
> +		return;
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +	local_irq_save(flags);
> +	might_lock(&memcg->move_lock);
> +	local_irq_restore(flags);
> +#endif
> +
> +	if (atomic_read(&memcg->moving_account) <= 0)
> +		return;
> +
> +	spin_lock_irqsave(&memcg->move_lock, flags);
> +	if (memcg != folio_memcg(folio)) {
> +		spin_unlock_irqrestore(&memcg->move_lock, flags);
> +		goto again;
> +	}
> +
> +	/*
> +	 * When charge migration first begins, we can have multiple
> +	 * critical sections holding the fast-path RCU lock and one
> +	 * holding the slowpath move_lock. Track the task who has the
> +	 * move_lock for folio_memcg_unlock().
> +	 */
> +	memcg->move_lock_task = current;
> +	memcg->move_lock_flags = flags;
> +}
> +
> +static void __folio_memcg_unlock(struct mem_cgroup *memcg)
> +{
> +	if (memcg && memcg->move_lock_task == current) {
> +		unsigned long flags = memcg->move_lock_flags;
> +
> +		memcg->move_lock_task = NULL;
> +		memcg->move_lock_flags = 0;
> +
> +		spin_unlock_irqrestore(&memcg->move_lock, flags);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
> +/**
> + * folio_memcg_unlock - Release the binding between a folio and its memcg.
> + * @folio: The folio.
> + *
> + * This releases the binding created by folio_memcg_lock().  This does
> + * not change the accounting of this folio to its memcg, but it does
> + * permit others to change it.
> + */
> +void folio_memcg_unlock(struct folio *folio)
> +{
> +	__folio_memcg_unlock(folio_memcg(folio));
> +}
> +
> +#ifdef CONFIG_SWAP
> +/**
> + * mem_cgroup_move_swap_account - move swap charge and swap_cgroup's record.
> + * @entry: swap entry to be moved
> + * @from:  mem_cgroup which the entry is moved from
> + * @to:  mem_cgroup which the entry is moved to
> + *
> + * It succeeds only when the swap_cgroup's record for this entry is the same
> + * as the mem_cgroup's id of @from.
> + *
> + * Returns 0 on success, -EINVAL on failure.
> + *
> + * The caller must have charged to @to, IOW, called page_counter_charge() about
> + * both res and memsw, and called css_get().
> + */
> +static int mem_cgroup_move_swap_account(swp_entry_t entry,
> +				struct mem_cgroup *from, struct mem_cgroup *to)
> +{
> +	unsigned short old_id, new_id;
> +
> +	old_id = mem_cgroup_id(from);
> +	new_id = mem_cgroup_id(to);
> +
> +	if (swap_cgroup_cmpxchg(entry, old_id, new_id) == old_id) {
> +		mod_memcg_state(from, MEMCG_SWAP, -1);
> +		mod_memcg_state(to, MEMCG_SWAP, 1);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +#else
> +static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
> +				struct mem_cgroup *from, struct mem_cgroup *to)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
> +				struct cftype *cft)
> +{
> +	return mem_cgroup_from_css(css)->move_charge_at_immigrate;
> +}
> +
> +#ifdef CONFIG_MMU
> +int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> +				 struct cftype *cft, u64 val)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +
> +	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
> +		     "Please report your usecase to linux-mm@kvack.org if you "
> +		     "depend on this functionality.\n");
> +
> +	if (val & ~MOVE_MASK)
> +		return -EINVAL;
> +
> +	/*
> +	 * No kind of locking is needed in here, because ->can_attach() will
> +	 * check this value once in the beginning of the process, and then carry
> +	 * on with stale data. This means that changes to this value will only
> +	 * affect task migrations starting after the change.
> +	 */
> +	memcg->move_charge_at_immigrate = val;
> +	return 0;
> +}
> +#else
> +int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> +				 struct cftype *cft, u64 val)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
> +#ifdef CONFIG_MMU
> +/* Handlers for move charge at task migration. */
> +static int mem_cgroup_do_precharge(unsigned long count)
> +{
> +	int ret;
> +
> +	/* Try a single bulk charge without reclaim first, kswapd may wake */
> +	ret = try_charge(mc.to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM, count);
> +	if (!ret) {
> +		mc.precharge += count;
> +		return ret;
> +	}
> +
> +	/* Try charges one by one with reclaim, but do not retry */
> +	while (count--) {
> +		ret = try_charge(mc.to, GFP_KERNEL | __GFP_NORETRY, 1);
> +		if (ret)
> +			return ret;
> +		mc.precharge++;
> +		cond_resched();
> +	}
> +	return 0;
> +}
> +
> +union mc_target {
> +	struct folio	*folio;
> +	swp_entry_t	ent;
> +};
> +
> +enum mc_target_type {
> +	MC_TARGET_NONE = 0,
> +	MC_TARGET_PAGE,
> +	MC_TARGET_SWAP,
> +	MC_TARGET_DEVICE,
> +};
> +
> +static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
> +						unsigned long addr, pte_t ptent)
> +{
> +	struct page *page = vm_normal_page(vma, addr, ptent);
> +
> +	if (!page)
> +		return NULL;
> +	if (PageAnon(page)) {
> +		if (!(mc.flags & MOVE_ANON))
> +			return NULL;
> +	} else {
> +		if (!(mc.flags & MOVE_FILE))
> +			return NULL;
> +	}
> +	get_page(page);
> +
> +	return page;
> +}
> +
> +#if defined(CONFIG_SWAP) || defined(CONFIG_DEVICE_PRIVATE)
> +static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
> +			pte_t ptent, swp_entry_t *entry)
> +{
> +	struct page *page = NULL;
> +	swp_entry_t ent = pte_to_swp_entry(ptent);
> +
> +	if (!(mc.flags & MOVE_ANON))
> +		return NULL;
> +
> +	/*
> +	 * Handle device private pages that are not accessible by the CPU, but
> +	 * stored as special swap entries in the page table.
> +	 */
> +	if (is_device_private_entry(ent)) {
> +		page = pfn_swap_entry_to_page(ent);
> +		if (!get_page_unless_zero(page))
> +			return NULL;
> +		return page;
> +	}
> +
> +	if (non_swap_entry(ent))
> +		return NULL;
> +
> +	/*
> +	 * Because swap_cache_get_folio() updates some statistics counter,
> +	 * we call find_get_page() with swapper_space directly.
> +	 */
> +	page = find_get_page(swap_address_space(ent), swap_cache_index(ent));
> +	entry->val = ent.val;
> +
> +	return page;
> +}
> +#else
> +static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
> +			pte_t ptent, swp_entry_t *entry)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
> +			unsigned long addr, pte_t ptent)
> +{
> +	unsigned long index;
> +	struct folio *folio;
> +
> +	if (!vma->vm_file) /* anonymous vma */
> +		return NULL;
> +	if (!(mc.flags & MOVE_FILE))
> +		return NULL;
> +
> +	/* folio is moved even if it's not RSS of this task(page-faulted). */
> +	/* shmem/tmpfs may report page out on swap: account for that too. */
> +	index = linear_page_index(vma, addr);
> +	folio = filemap_get_incore_folio(vma->vm_file->f_mapping, index);
> +	if (IS_ERR(folio))
> +		return NULL;
> +	return folio_file_page(folio, index);
> +}
> +
> +/**
> + * mem_cgroup_move_account - move account of the folio
> + * @folio: The folio.
> + * @compound: charge the page as compound or small page
> + * @from: mem_cgroup which the folio is moved from.
> + * @to:	mem_cgroup which the folio is moved to. @from != @to.
> + *
> + * The folio must be locked and not on the LRU.
> + *
> + * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
> + * from old cgroup.
> + */
> +static int mem_cgroup_move_account(struct folio *folio,
> +				   bool compound,
> +				   struct mem_cgroup *from,
> +				   struct mem_cgroup *to)
> +{
> +	struct lruvec *from_vec, *to_vec;
> +	struct pglist_data *pgdat;
> +	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
> +	int nid, ret;
> +
> +	VM_BUG_ON(from == to);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> +	VM_BUG_ON(compound && !folio_test_large(folio));
> +
> +	ret = -EINVAL;
> +	if (folio_memcg(folio) != from)
> +		goto out;
> +
> +	pgdat = folio_pgdat(folio);
> +	from_vec = mem_cgroup_lruvec(from, pgdat);
> +	to_vec = mem_cgroup_lruvec(to, pgdat);
> +
> +	folio_memcg_lock(folio);
> +
> +	if (folio_test_anon(folio)) {
> +		if (folio_mapped(folio)) {
> +			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> +			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> +			if (folio_test_pmd_mappable(folio)) {
> +				__mod_lruvec_state(from_vec, NR_ANON_THPS,
> +						   -nr_pages);
> +				__mod_lruvec_state(to_vec, NR_ANON_THPS,
> +						   nr_pages);
> +			}
> +		}
> +	} else {
> +		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
> +
> +		if (folio_test_swapbacked(folio)) {
> +			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
> +			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
> +		}
> +
> +		if (folio_mapped(folio)) {
> +			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
> +			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
> +		}
> +
> +		if (folio_test_dirty(folio)) {
> +			struct address_space *mapping = folio_mapping(folio);
> +
> +			if (mapping_can_writeback(mapping)) {
> +				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
> +						   -nr_pages);
> +				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
> +						   nr_pages);
> +			}
> +		}
> +	}
> +
> +#ifdef CONFIG_SWAP
> +	if (folio_test_swapcache(folio)) {
> +		__mod_lruvec_state(from_vec, NR_SWAPCACHE, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_SWAPCACHE, nr_pages);
> +	}
> +#endif
> +	if (folio_test_writeback(folio)) {
> +		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
> +	}
> +
> +	/*
> +	 * All state has been migrated, let's switch to the new memcg.
> +	 *
> +	 * It is safe to change page's memcg here because the page
> +	 * is referenced, charged, isolated, and locked: we can't race
> +	 * with (un)charging, migration, LRU putback, or anything else
> +	 * that would rely on a stable page's memory cgroup.
> +	 *
> +	 * Note that folio_memcg_lock is a memcg lock, not a page lock,
> +	 * to save space. As soon as we switch page's memory cgroup to a
> +	 * new memcg that isn't locked, the above state can change
> +	 * concurrently again. Make sure we're truly done with it.
> +	 */
> +	smp_mb();
> +
> +	css_get(&to->css);
> +	css_put(&from->css);
> +
> +	folio->memcg_data = (unsigned long)to;
> +
> +	__folio_memcg_unlock(from);
> +
> +	ret = 0;
> +	nid = folio_nid(folio);
> +
> +	local_irq_disable();
> +	mem_cgroup_charge_statistics(to, nr_pages);
> +	memcg_check_events(to, nid);
> +	mem_cgroup_charge_statistics(from, -nr_pages);
> +	memcg_check_events(from, nid);
> +	local_irq_enable();
> +out:
> +	return ret;
> +}
> +
> +/**
> + * get_mctgt_type - get target type of moving charge
> + * @vma: the vma the pte to be checked belongs
> + * @addr: the address corresponding to the pte to be checked
> + * @ptent: the pte to be checked
> + * @target: the pointer the target page or swap ent will be stored(can be NULL)
> + *
> + * Context: Called with pte lock held.
> + * Return:
> + * * MC_TARGET_NONE - If the pte is not a target for move charge.
> + * * MC_TARGET_PAGE - If the page corresponding to this pte is a target for
> + *   move charge. If @target is not NULL, the folio is stored in target->folio
> + *   with extra refcnt taken (Caller should release it).
> + * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
> + *   target for charge migration.  If @target is not NULL, the entry is
> + *   stored in target->ent.
> + * * MC_TARGET_DEVICE - Like MC_TARGET_PAGE but page is device memory and
> + *   thus not on the lru.  For now such page is charged like a regular page
> + *   would be as it is just special memory taking the place of a regular page.
> + *   See Documentations/vm/hmm.txt and include/linux/hmm.h
> + */
> +static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t ptent, union mc_target *target)
> +{
> +	struct page *page = NULL;
> +	struct folio *folio;
> +	enum mc_target_type ret = MC_TARGET_NONE;
> +	swp_entry_t ent = { .val = 0 };
> +
> +	if (pte_present(ptent))
> +		page = mc_handle_present_pte(vma, addr, ptent);
> +	else if (pte_none_mostly(ptent))
> +		/*
> +		 * PTE markers should be treated as a none pte here, separated
> +		 * from other swap handling below.
> +		 */
> +		page = mc_handle_file_pte(vma, addr, ptent);
> +	else if (is_swap_pte(ptent))
> +		page = mc_handle_swap_pte(vma, ptent, &ent);
> +
> +	if (page)
> +		folio = page_folio(page);
> +	if (target && page) {
> +		if (!folio_trylock(folio)) {
> +			folio_put(folio);
> +			return ret;
> +		}
> +		/*
> +		 * page_mapped() must be stable during the move. This
> +		 * pte is locked, so if it's present, the page cannot
> +		 * become unmapped. If it isn't, we have only partial
> +		 * control over the mapped state: the page lock will
> +		 * prevent new faults against pagecache and swapcache,
> +		 * so an unmapped page cannot become mapped. However,
> +		 * if the page is already mapped elsewhere, it can
> +		 * unmap, and there is nothing we can do about it.
> +		 * Alas, skip moving the page in this case.
> +		 */
> +		if (!pte_present(ptent) && page_mapped(page)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			return ret;
> +		}
> +	}
> +
> +	if (!page && !ent.val)
> +		return ret;
> +	if (page) {
> +		/*
> +		 * Do only loose check w/o serialization.
> +		 * mem_cgroup_move_account() checks the page is valid or
> +		 * not under LRU exclusion.
> +		 */
> +		if (folio_memcg(folio) == mc.from) {
> +			ret = MC_TARGET_PAGE;
> +			if (folio_is_device_private(folio) ||
> +			    folio_is_device_coherent(folio))
> +				ret = MC_TARGET_DEVICE;
> +			if (target)
> +				target->folio = folio;
> +		}
> +		if (!ret || !target) {
> +			if (target)
> +				folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +	}
> +	/*
> +	 * There is a swap entry and a page doesn't exist or isn't charged.
> +	 * But we cannot move a tail-page in a THP.
> +	 */
> +	if (ent.val && !ret && (!page || !PageTransCompound(page)) &&
> +	    mem_cgroup_id(mc.from) == lookup_swap_cgroup_id(ent)) {
> +		ret = MC_TARGET_SWAP;
> +		if (target)
> +			target->ent = ent;
> +	}
> +	return ret;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/*
> + * We don't consider PMD mapped swapping or file mapped pages because THP does
> + * not support them for now.
> + * Caller should make sure that pmd_trans_huge(pmd) is true.
> + */
> +static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
> +		unsigned long addr, pmd_t pmd, union mc_target *target)
> +{
> +	struct page *page = NULL;
> +	struct folio *folio;
> +	enum mc_target_type ret = MC_TARGET_NONE;
> +
> +	if (unlikely(is_swap_pmd(pmd))) {
> +		VM_BUG_ON(thp_migration_supported() &&
> +				  !is_pmd_migration_entry(pmd));
> +		return ret;
> +	}
> +	page = pmd_page(pmd);
> +	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
> +	folio = page_folio(page);
> +	if (!(mc.flags & MOVE_ANON))
> +		return ret;
> +	if (folio_memcg(folio) == mc.from) {
> +		ret = MC_TARGET_PAGE;
> +		if (target) {
> +			folio_get(folio);
> +			if (!folio_trylock(folio)) {
> +				folio_put(folio);
> +				return MC_TARGET_NONE;
> +			}
> +			target->folio = folio;
> +		}
> +	}
> +	return ret;
> +}
> +#else
> +static inline enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
> +		unsigned long addr, pmd_t pmd, union mc_target *target)
> +{
> +	return MC_TARGET_NONE;
> +}
> +#endif
> +
> +static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
> +					unsigned long addr, unsigned long end,
> +					struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		/*
> +		 * Note their can not be MC_TARGET_DEVICE for now as we do not
> +		 * support transparent huge page with MEMORY_DEVICE_PRIVATE but
> +		 * this might change.
> +		 */
> +		if (get_mctgt_type_thp(vma, addr, *pmd, NULL) == MC_TARGET_PAGE)
> +			mc.precharge += HPAGE_PMD_NR;
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return 0;
> +	for (; addr != end; pte++, addr += PAGE_SIZE)
> +		if (get_mctgt_type(vma, addr, ptep_get(pte), NULL))
> +			mc.precharge++;	/* increment precharge temporarily */
> +	pte_unmap_unlock(pte - 1, ptl);
> +	cond_resched();
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops precharge_walk_ops = {
> +	.pmd_entry	= mem_cgroup_count_precharge_pte_range,
> +	.walk_lock	= PGWALK_RDLOCK,
> +};
> +
> +static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
> +{
> +	unsigned long precharge;
> +
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
> +	mmap_read_unlock(mm);
> +
> +	precharge = mc.precharge;
> +	mc.precharge = 0;
> +
> +	return precharge;
> +}
> +
> +static int mem_cgroup_precharge_mc(struct mm_struct *mm)
> +{
> +	unsigned long precharge = mem_cgroup_count_precharge(mm);
> +
> +	VM_BUG_ON(mc.moving_task);
> +	mc.moving_task = current;
> +	return mem_cgroup_do_precharge(precharge);
> +}
> +
> +/* cancels all extra charges on mc.from and mc.to, and wakes up all waiters. */
> +static void __mem_cgroup_clear_mc(void)
> +{
> +	struct mem_cgroup *from = mc.from;
> +	struct mem_cgroup *to = mc.to;
> +
> +	/* we must uncharge all the leftover precharges from mc.to */
> +	if (mc.precharge) {
> +		mem_cgroup_cancel_charge(mc.to, mc.precharge);
> +		mc.precharge = 0;
> +	}
> +	/*
> +	 * we didn't uncharge from mc.from at mem_cgroup_move_account(), so
> +	 * we must uncharge here.
> +	 */
> +	if (mc.moved_charge) {
> +		mem_cgroup_cancel_charge(mc.from, mc.moved_charge);
> +		mc.moved_charge = 0;
> +	}
> +	/* we must fixup refcnts and charges */
> +	if (mc.moved_swap) {
> +		/* uncharge swap account from the old cgroup */
> +		if (!mem_cgroup_is_root(mc.from))
> +			page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
> +
> +		mem_cgroup_id_put_many(mc.from, mc.moved_swap);
> +
> +		/*
> +		 * we charged both to->memory and to->memsw, so we
> +		 * should uncharge to->memory.
> +		 */
> +		if (!mem_cgroup_is_root(mc.to))
> +			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
> +
> +		mc.moved_swap = 0;
> +	}
> +	memcg_oom_recover(from);
> +	memcg_oom_recover(to);
> +	wake_up_all(&mc.waitq);
> +}
> +
> +static void mem_cgroup_clear_mc(void)
> +{
> +	struct mm_struct *mm = mc.mm;
> +
> +	/*
> +	 * we must clear moving_task before waking up waiters at the end of
> +	 * task migration.
> +	 */
> +	mc.moving_task = NULL;
> +	__mem_cgroup_clear_mc();
> +	spin_lock(&mc.lock);
> +	mc.from = NULL;
> +	mc.to = NULL;
> +	mc.mm = NULL;
> +	spin_unlock(&mc.lock);
> +
> +	mmput(mm);
> +}
> +
> +int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
> +	struct mem_cgroup *from;
> +	struct task_struct *leader, *p;
> +	struct mm_struct *mm;
> +	unsigned long move_flags;
> +	int ret = 0;
> +
> +	/* charge immigration isn't supported on the default hierarchy */
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return 0;
> +
> +	/*
> +	 * Multi-process migrations only happen on the default hierarchy
> +	 * where charge immigration is not used.  Perform charge
> +	 * immigration if @tset contains a leader and whine if there are
> +	 * multiple.
> +	 */
> +	p = NULL;
> +	cgroup_taskset_for_each_leader(leader, css, tset) {
> +		WARN_ON_ONCE(p);
> +		p = leader;
> +		memcg = mem_cgroup_from_css(css);
> +	}
> +	if (!p)
> +		return 0;
> +
> +	/*
> +	 * We are now committed to this value whatever it is. Changes in this
> +	 * tunable will only affect upcoming migrations, not the current one.
> +	 * So we need to save it, and keep it going.
> +	 */
> +	move_flags = READ_ONCE(memcg->move_charge_at_immigrate);
> +	if (!move_flags)
> +		return 0;
> +
> +	from = mem_cgroup_from_task(p);
> +
> +	VM_BUG_ON(from == memcg);
> +
> +	mm = get_task_mm(p);
> +	if (!mm)
> +		return 0;
> +	/* We move charges only when we move a owner of the mm */
> +	if (mm->owner == p) {
> +		VM_BUG_ON(mc.from);
> +		VM_BUG_ON(mc.to);
> +		VM_BUG_ON(mc.precharge);
> +		VM_BUG_ON(mc.moved_charge);
> +		VM_BUG_ON(mc.moved_swap);
> +
> +		spin_lock(&mc.lock);
> +		mc.mm = mm;
> +		mc.from = from;
> +		mc.to = memcg;
> +		mc.flags = move_flags;
> +		spin_unlock(&mc.lock);
> +		/* We set mc.moving_task later */
> +
> +		ret = mem_cgroup_precharge_mc(mm);
> +		if (ret)
> +			mem_cgroup_clear_mc();
> +	} else {
> +		mmput(mm);
> +	}
> +	return ret;
> +}
> +
> +void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
> +{
> +	if (mc.to)
> +		mem_cgroup_clear_mc();
> +}
> +
> +static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
> +				unsigned long addr, unsigned long end,
> +				struct mm_walk *walk)
> +{
> +	int ret = 0;
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +	enum mc_target_type target_type;
> +	union mc_target target;
> +	struct folio *folio;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		if (mc.precharge < HPAGE_PMD_NR) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
> +		if (target_type == MC_TARGET_PAGE) {
> +			folio = target.folio;
> +			if (folio_isolate_lru(folio)) {
> +				if (!mem_cgroup_move_account(folio, true,
> +							     mc.from, mc.to)) {
> +					mc.precharge -= HPAGE_PMD_NR;
> +					mc.moved_charge += HPAGE_PMD_NR;
> +				}
> +				folio_putback_lru(folio);
> +			}
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		} else if (target_type == MC_TARGET_DEVICE) {
> +			folio = target.folio;
> +			if (!mem_cgroup_move_account(folio, true,
> +						     mc.from, mc.to)) {
> +				mc.precharge -= HPAGE_PMD_NR;
> +				mc.moved_charge += HPAGE_PMD_NR;
> +			}
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +retry:
> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return 0;
> +	for (; addr != end; addr += PAGE_SIZE) {
> +		pte_t ptent = ptep_get(pte++);
> +		bool device = false;
> +		swp_entry_t ent;
> +
> +		if (!mc.precharge)
> +			break;
> +
> +		switch (get_mctgt_type(vma, addr, ptent, &target)) {
> +		case MC_TARGET_DEVICE:
> +			device = true;
> +			fallthrough;
> +		case MC_TARGET_PAGE:
> +			folio = target.folio;
> +			/*
> +			 * We can have a part of the split pmd here. Moving it
> +			 * can be done but it would be too convoluted so simply
> +			 * ignore such a partial THP and keep it in original
> +			 * memcg. There should be somebody mapping the head.
> +			 */
> +			if (folio_test_large(folio))
> +				goto put;
> +			if (!device && !folio_isolate_lru(folio))
> +				goto put;
> +			if (!mem_cgroup_move_account(folio, false,
> +						mc.from, mc.to)) {
> +				mc.precharge--;
> +				/* we uncharge from mc.from later. */
> +				mc.moved_charge++;
> +			}
> +			if (!device)
> +				folio_putback_lru(folio);
> +put:			/* get_mctgt_type() gets & locks the page */
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			break;
> +		case MC_TARGET_SWAP:
> +			ent = target.ent;
> +			if (!mem_cgroup_move_swap_account(ent, mc.from, mc.to)) {
> +				mc.precharge--;
> +				mem_cgroup_id_get_many(mc.to, 1);
> +				/* we fixup other refcnts and charges later. */
> +				mc.moved_swap++;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	pte_unmap_unlock(pte - 1, ptl);
> +	cond_resched();
> +
> +	if (addr != end) {
> +		/*
> +		 * We have consumed all precharges we got in can_attach().
> +		 * We try charge one by one, but don't do any additional
> +		 * charges to mc.to if we have failed in charge once in attach()
> +		 * phase.
> +		 */
> +		ret = mem_cgroup_do_precharge(1);
> +		if (!ret)
> +			goto retry;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct mm_walk_ops charge_walk_ops = {
> +	.pmd_entry	= mem_cgroup_move_charge_pte_range,
> +	.walk_lock	= PGWALK_RDLOCK,
> +};
> +
> +static void mem_cgroup_move_charge(void)
> +{
> +	lru_add_drain_all();
> +	/*
> +	 * Signal folio_memcg_lock() to take the memcg's move_lock
> +	 * while we're moving its pages to another memcg. Then wait
> +	 * for already started RCU-only updates to finish.
> +	 */
> +	atomic_inc(&mc.from->moving_account);
> +	synchronize_rcu();
> +retry:
> +	if (unlikely(!mmap_read_trylock(mc.mm))) {
> +		/*
> +		 * Someone who are holding the mmap_lock might be waiting in
> +		 * waitq. So we cancel all extra charges, wake up all waiters,
> +		 * and retry. Because we cancel precharges, we might not be able
> +		 * to move enough charges, but moving charge is a best-effort
> +		 * feature anyway, so it wouldn't be a big problem.
> +		 */
> +		__mem_cgroup_clear_mc();
> +		cond_resched();
> +		goto retry;
> +	}
> +	/*
> +	 * When we have consumed all precharges and failed in doing
> +	 * additional charge, the page walk just aborts.
> +	 */
> +	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
> +	mmap_read_unlock(mc.mm);
> +	atomic_dec(&mc.from->moving_account);
> +}
> +
> +void mem_cgroup_move_task(void)
> +{
> +	if (mc.to) {
> +		mem_cgroup_move_charge();
> +		mem_cgroup_clear_mc();
> +	}
> +}
> +
> +#else	/* !CONFIG_MMU */
> +static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> +{
> +	return 0;
> +}
> +static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
> +{
> +}
> +static void mem_cgroup_move_task(void)
> +{
> +}
> +#endif
> +
>  static int __init memcg1_init(void)
>  {
>  	int node;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index e37bc7e8d955..55e7c4f90c39 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -11,4 +11,34 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
>  	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
>  }
>  
> +void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
> +void memcg_check_events(struct mem_cgroup *memcg, int nid);
> +void memcg_oom_recover(struct mem_cgroup *memcg);
> +int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +		     unsigned int nr_pages);
> +
> +static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			     unsigned int nr_pages)
> +{
> +	if (mem_cgroup_is_root(memcg))
> +		return 0;
> +
> +	return try_charge_memcg(memcg, gfp_mask, nr_pages);
> +}
> +
> +void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
> +void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
> +
> +bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg);
> +struct cgroup_taskset;
> +int mem_cgroup_can_attach(struct cgroup_taskset *tset);
> +void mem_cgroup_cancel_attach(struct cgroup_taskset *tset);
> +void mem_cgroup_move_task(void);
> +
> +struct cftype;
> +u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
> +				struct cftype *cft);
> +int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> +				 struct cftype *cft, u64 val);
> +
>  #endif	/* __MM_MEMCONTROL_V1_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3479e1af12d5..3332c89cae2e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -28,7 +28,6 @@
>  #include <linux/page_counter.h>
>  #include <linux/memcontrol.h>
>  #include <linux/cgroup.h>
> -#include <linux/pagewalk.h>
>  #include <linux/sched/mm.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/hugetlb.h>
> @@ -45,7 +44,6 @@
>  #include <linux/mutex.h>
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
> -#include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/spinlock.h>
>  #include <linux/eventfd.h>
> @@ -71,7 +69,6 @@
>  #include <net/sock.h>
>  #include <net/ip.h>
>  #include "slab.h"
> -#include "swap.h"
>  #include "memcontrol-v1.h"
>  
>  #include <linux/uaccess.h>
> @@ -158,31 +155,6 @@ struct mem_cgroup_event {
>  static void mem_cgroup_threshold(struct mem_cgroup *memcg);
>  static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
>  
> -/* Stuffs for move charges at task migration. */
> -/*
> - * Types of charges to be moved.
> - */
> -#define MOVE_ANON	0x1U
> -#define MOVE_FILE	0x2U
> -#define MOVE_MASK	(MOVE_ANON | MOVE_FILE)
> -
> -/* "mc" and its members are protected by cgroup_mutex */
> -static struct move_charge_struct {
> -	spinlock_t	  lock; /* for from, to */
> -	struct mm_struct  *mm;
> -	struct mem_cgroup *from;
> -	struct mem_cgroup *to;
> -	unsigned long flags;
> -	unsigned long precharge;
> -	unsigned long moved_charge;
> -	unsigned long moved_swap;
> -	struct task_struct *moving_task;	/* a task moving charges */
> -	wait_queue_head_t waitq;		/* a waitq for other context */
> -} mc = {
> -	.lock = __SPIN_LOCK_UNLOCKED(mc.lock),
> -	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
> -};
> -
>  /* for encoding cft->private value on file */
>  enum res_type {
>  	_MEM,
> @@ -955,8 +927,7 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  	return READ_ONCE(memcg->vmstats->events_local[i]);
>  }
>  
> -static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
> -					 int nr_pages)
> +void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
>  {
>  	/* pagein of a big page is an event. So, ignore page size */
>  	if (nr_pages > 0)
> @@ -998,7 +969,7 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>   * Check events in order.
>   *
>   */
> -static void memcg_check_events(struct mem_cgroup *memcg, int nid)
> +void memcg_check_events(struct mem_cgroup *memcg, int nid)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		return;
> @@ -1467,51 +1438,6 @@ static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
>  	return margin;
>  }
>  
> -/*
> - * A routine for checking "mem" is under move_account() or not.
> - *
> - * Checking a cgroup is mc.from or mc.to or under hierarchy of
> - * moving cgroups. This is for waiting at high-memory pressure
> - * caused by "move".
> - */
> -static bool mem_cgroup_under_move(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *from;
> -	struct mem_cgroup *to;
> -	bool ret = false;
> -	/*
> -	 * Unlike task_move routines, we access mc.to, mc.from not under
> -	 * mutual exclusion by cgroup_mutex. Here, we take spinlock instead.
> -	 */
> -	spin_lock(&mc.lock);
> -	from = mc.from;
> -	to = mc.to;
> -	if (!from)
> -		goto unlock;
> -
> -	ret = mem_cgroup_is_descendant(from, memcg) ||
> -		mem_cgroup_is_descendant(to, memcg);
> -unlock:
> -	spin_unlock(&mc.lock);
> -	return ret;
> -}
> -
> -static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> -{
> -	if (mc.moving_task && current != mc.moving_task) {
> -		if (mem_cgroup_under_move(memcg)) {
> -			DEFINE_WAIT(wait);
> -			prepare_to_wait(&mc.waitq, &wait, TASK_INTERRUPTIBLE);
> -			/* moving charge context might have finished. */
> -			if (mc.moving_task)
> -				schedule();
> -			finish_wait(&mc.waitq, &wait);
> -			return true;
> -		}
> -	}
> -	return false;
> -}
> -
>  struct memory_stat {
>  	const char *name;
>  	unsigned int idx;
> @@ -1904,7 +1830,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
>  	return autoremove_wake_function(wait, mode, sync, arg);
>  }
>  
> -static void memcg_oom_recover(struct mem_cgroup *memcg)
> +void memcg_oom_recover(struct mem_cgroup *memcg)
>  {
>  	/*
>  	 * For the following lockless ->under_oom test, the only required
> @@ -2093,87 +2019,6 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
>  	pr_cont(" are going to be killed due to memory.oom.group set\n");
>  }
>  
> -/**
> - * folio_memcg_lock - Bind a folio to its memcg.
> - * @folio: The folio.
> - *
> - * This function prevents unlocked LRU folios from being moved to
> - * another cgroup.
> - *
> - * It ensures lifetime of the bound memcg.  The caller is responsible
> - * for the lifetime of the folio.
> - */
> -void folio_memcg_lock(struct folio *folio)
> -{
> -	struct mem_cgroup *memcg;
> -	unsigned long flags;
> -
> -	/*
> -	 * The RCU lock is held throughout the transaction.  The fast
> -	 * path can get away without acquiring the memcg->move_lock
> -	 * because page moving starts with an RCU grace period.
> -         */
> -	rcu_read_lock();
> -
> -	if (mem_cgroup_disabled())
> -		return;
> -again:
> -	memcg = folio_memcg(folio);
> -	if (unlikely(!memcg))
> -		return;
> -
> -#ifdef CONFIG_PROVE_LOCKING
> -	local_irq_save(flags);
> -	might_lock(&memcg->move_lock);
> -	local_irq_restore(flags);
> -#endif
> -
> -	if (atomic_read(&memcg->moving_account) <= 0)
> -		return;
> -
> -	spin_lock_irqsave(&memcg->move_lock, flags);
> -	if (memcg != folio_memcg(folio)) {
> -		spin_unlock_irqrestore(&memcg->move_lock, flags);
> -		goto again;
> -	}
> -
> -	/*
> -	 * When charge migration first begins, we can have multiple
> -	 * critical sections holding the fast-path RCU lock and one
> -	 * holding the slowpath move_lock. Track the task who has the
> -	 * move_lock for folio_memcg_unlock().
> -	 */
> -	memcg->move_lock_task = current;
> -	memcg->move_lock_flags = flags;
> -}
> -
> -static void __folio_memcg_unlock(struct mem_cgroup *memcg)
> -{
> -	if (memcg && memcg->move_lock_task == current) {
> -		unsigned long flags = memcg->move_lock_flags;
> -
> -		memcg->move_lock_task = NULL;
> -		memcg->move_lock_flags = 0;
> -
> -		spin_unlock_irqrestore(&memcg->move_lock, flags);
> -	}
> -
> -	rcu_read_unlock();
> -}
> -
> -/**
> - * folio_memcg_unlock - Release the binding between a folio and its memcg.
> - * @folio: The folio.
> - *
> - * This releases the binding created by folio_memcg_lock().  This does
> - * not change the accounting of this folio to its memcg, but it does
> - * permit others to change it.
> - */
> -void folio_memcg_unlock(struct folio *folio)
> -{
> -	__folio_memcg_unlock(folio_memcg(folio));
> -}
> -
>  struct memcg_stock_pcp {
>  	local_lock_t stock_lock;
>  	struct mem_cgroup *cached; /* this never be root cgroup */
> @@ -2653,8 +2498,8 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  	css_put(&memcg->css);
>  }
>  
> -static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -			unsigned int nr_pages)
> +int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +		     unsigned int nr_pages)
>  {
>  	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
>  	int nr_retries = MAX_RECLAIM_RETRIES;
> @@ -2849,15 +2694,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return 0;
>  }
>  
> -static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -			     unsigned int nr_pages)
> -{
> -	if (mem_cgroup_is_root(memcg))
> -		return 0;
> -
> -	return try_charge_memcg(memcg, gfp_mask, nr_pages);
> -}
> -
>  /**
>   * mem_cgroup_cancel_charge() - cancel an uncommitted try_charge() call.
>   * @memcg: memcg previously charged.
> @@ -3595,43 +3431,6 @@ void split_page_memcg(struct page *head, int old_order, int new_order)
>  		css_get_many(&memcg->css, old_nr / new_nr - 1);
>  }
>  
> -#ifdef CONFIG_SWAP
> -/**
> - * mem_cgroup_move_swap_account - move swap charge and swap_cgroup's record.
> - * @entry: swap entry to be moved
> - * @from:  mem_cgroup which the entry is moved from
> - * @to:  mem_cgroup which the entry is moved to
> - *
> - * It succeeds only when the swap_cgroup's record for this entry is the same
> - * as the mem_cgroup's id of @from.
> - *
> - * Returns 0 on success, -EINVAL on failure.
> - *
> - * The caller must have charged to @to, IOW, called page_counter_charge() about
> - * both res and memsw, and called css_get().
> - */
> -static int mem_cgroup_move_swap_account(swp_entry_t entry,
> -				struct mem_cgroup *from, struct mem_cgroup *to)
> -{
> -	unsigned short old_id, new_id;
> -
> -	old_id = mem_cgroup_id(from);
> -	new_id = mem_cgroup_id(to);
> -
> -	if (swap_cgroup_cmpxchg(entry, old_id, new_id) == old_id) {
> -		mod_memcg_state(from, MEMCG_SWAP, -1);
> -		mod_memcg_state(to, MEMCG_SWAP, 1);
> -		return 0;
> -	}
> -	return -EINVAL;
> -}
> -#else
> -static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
> -				struct mem_cgroup *from, struct mem_cgroup *to)
> -{
> -	return -EINVAL;
> -}
> -#endif
>  
>  static DEFINE_MUTEX(memcg_max_mutex);
>  
> @@ -4015,42 +3814,6 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
>  	return nbytes;
>  }
>  
> -static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
> -					struct cftype *cft)
> -{
> -	return mem_cgroup_from_css(css)->move_charge_at_immigrate;
> -}
> -
> -#ifdef CONFIG_MMU
> -static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> -					struct cftype *cft, u64 val)
> -{
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> -
> -	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
> -		     "Please report your usecase to linux-mm@kvack.org if you "
> -		     "depend on this functionality.\n");
> -
> -	if (val & ~MOVE_MASK)
> -		return -EINVAL;
> -
> -	/*
> -	 * No kind of locking is needed in here, because ->can_attach() will
> -	 * check this value once in the beginning of the process, and then carry
> -	 * on with stale data. This means that changes to this value will only
> -	 * affect task migrations starting after the change.
> -	 */
> -	memcg->move_charge_at_immigrate = val;
> -	return 0;
> -}
> -#else
> -static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
> -					struct cftype *cft, u64 val)
> -{
> -	return -ENOSYS;
> -}
> -#endif
> -
>  #ifdef CONFIG_NUMA
>  
>  #define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
> @@ -5261,13 +5024,13 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
> -						  unsigned int n)
> +void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
> +					   unsigned int n)
>  {
>  	refcount_add(n, &memcg->id.ref);
>  }
>  
> -static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
> +void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  {
>  	if (refcount_sub_and_test(n, &memcg->id.ref)) {
>  		mem_cgroup_id_remove(memcg);
> @@ -5747,757 +5510,6 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  		atomic64_set(&memcg->vmstats->stats_updates, 0);
>  }
>  
> -#ifdef CONFIG_MMU
> -/* Handlers for move charge at task migration. */
> -static int mem_cgroup_do_precharge(unsigned long count)
> -{
> -	int ret;
> -
> -	/* Try a single bulk charge without reclaim first, kswapd may wake */
> -	ret = try_charge(mc.to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM, count);
> -	if (!ret) {
> -		mc.precharge += count;
> -		return ret;
> -	}
> -
> -	/* Try charges one by one with reclaim, but do not retry */
> -	while (count--) {
> -		ret = try_charge(mc.to, GFP_KERNEL | __GFP_NORETRY, 1);
> -		if (ret)
> -			return ret;
> -		mc.precharge++;
> -		cond_resched();
> -	}
> -	return 0;
> -}
> -
> -union mc_target {
> -	struct folio	*folio;
> -	swp_entry_t	ent;
> -};
> -
> -enum mc_target_type {
> -	MC_TARGET_NONE = 0,
> -	MC_TARGET_PAGE,
> -	MC_TARGET_SWAP,
> -	MC_TARGET_DEVICE,
> -};
> -
> -static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
> -						unsigned long addr, pte_t ptent)
> -{
> -	struct page *page = vm_normal_page(vma, addr, ptent);
> -
> -	if (!page)
> -		return NULL;
> -	if (PageAnon(page)) {
> -		if (!(mc.flags & MOVE_ANON))
> -			return NULL;
> -	} else {
> -		if (!(mc.flags & MOVE_FILE))
> -			return NULL;
> -	}
> -	get_page(page);
> -
> -	return page;
> -}
> -
> -#if defined(CONFIG_SWAP) || defined(CONFIG_DEVICE_PRIVATE)
> -static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
> -			pte_t ptent, swp_entry_t *entry)
> -{
> -	struct page *page = NULL;
> -	swp_entry_t ent = pte_to_swp_entry(ptent);
> -
> -	if (!(mc.flags & MOVE_ANON))
> -		return NULL;
> -
> -	/*
> -	 * Handle device private pages that are not accessible by the CPU, but
> -	 * stored as special swap entries in the page table.
> -	 */
> -	if (is_device_private_entry(ent)) {
> -		page = pfn_swap_entry_to_page(ent);
> -		if (!get_page_unless_zero(page))
> -			return NULL;
> -		return page;
> -	}
> -
> -	if (non_swap_entry(ent))
> -		return NULL;
> -
> -	/*
> -	 * Because swap_cache_get_folio() updates some statistics counter,
> -	 * we call find_get_page() with swapper_space directly.
> -	 */
> -	page = find_get_page(swap_address_space(ent), swap_cache_index(ent));
> -	entry->val = ent.val;
> -
> -	return page;
> -}
> -#else
> -static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
> -			pte_t ptent, swp_entry_t *entry)
> -{
> -	return NULL;
> -}
> -#endif
> -
> -static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
> -			unsigned long addr, pte_t ptent)
> -{
> -	unsigned long index;
> -	struct folio *folio;
> -
> -	if (!vma->vm_file) /* anonymous vma */
> -		return NULL;
> -	if (!(mc.flags & MOVE_FILE))
> -		return NULL;
> -
> -	/* folio is moved even if it's not RSS of this task(page-faulted). */
> -	/* shmem/tmpfs may report page out on swap: account for that too. */
> -	index = linear_page_index(vma, addr);
> -	folio = filemap_get_incore_folio(vma->vm_file->f_mapping, index);
> -	if (IS_ERR(folio))
> -		return NULL;
> -	return folio_file_page(folio, index);
> -}
> -
> -/**
> - * mem_cgroup_move_account - move account of the folio
> - * @folio: The folio.
> - * @compound: charge the page as compound or small page
> - * @from: mem_cgroup which the folio is moved from.
> - * @to:	mem_cgroup which the folio is moved to. @from != @to.
> - *
> - * The folio must be locked and not on the LRU.
> - *
> - * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
> - * from old cgroup.
> - */
> -static int mem_cgroup_move_account(struct folio *folio,
> -				   bool compound,
> -				   struct mem_cgroup *from,
> -				   struct mem_cgroup *to)
> -{
> -	struct lruvec *from_vec, *to_vec;
> -	struct pglist_data *pgdat;
> -	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
> -	int nid, ret;
> -
> -	VM_BUG_ON(from == to);
> -	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> -	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> -	VM_BUG_ON(compound && !folio_test_large(folio));
> -
> -	ret = -EINVAL;
> -	if (folio_memcg(folio) != from)
> -		goto out;
> -
> -	pgdat = folio_pgdat(folio);
> -	from_vec = mem_cgroup_lruvec(from, pgdat);
> -	to_vec = mem_cgroup_lruvec(to, pgdat);
> -
> -	folio_memcg_lock(folio);
> -
> -	if (folio_test_anon(folio)) {
> -		if (folio_mapped(folio)) {
> -			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> -			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> -			if (folio_test_pmd_mappable(folio)) {
> -				__mod_lruvec_state(from_vec, NR_ANON_THPS,
> -						   -nr_pages);
> -				__mod_lruvec_state(to_vec, NR_ANON_THPS,
> -						   nr_pages);
> -			}
> -		}
> -	} else {
> -		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
> -		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
> -
> -		if (folio_test_swapbacked(folio)) {
> -			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
> -			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
> -		}
> -
> -		if (folio_mapped(folio)) {
> -			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
> -			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
> -		}
> -
> -		if (folio_test_dirty(folio)) {
> -			struct address_space *mapping = folio_mapping(folio);
> -
> -			if (mapping_can_writeback(mapping)) {
> -				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
> -						   -nr_pages);
> -				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
> -						   nr_pages);
> -			}
> -		}
> -	}
> -
> -#ifdef CONFIG_SWAP
> -	if (folio_test_swapcache(folio)) {
> -		__mod_lruvec_state(from_vec, NR_SWAPCACHE, -nr_pages);
> -		__mod_lruvec_state(to_vec, NR_SWAPCACHE, nr_pages);
> -	}
> -#endif
> -	if (folio_test_writeback(folio)) {
> -		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
> -		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
> -	}
> -
> -	/*
> -	 * All state has been migrated, let's switch to the new memcg.
> -	 *
> -	 * It is safe to change page's memcg here because the page
> -	 * is referenced, charged, isolated, and locked: we can't race
> -	 * with (un)charging, migration, LRU putback, or anything else
> -	 * that would rely on a stable page's memory cgroup.
> -	 *
> -	 * Note that folio_memcg_lock is a memcg lock, not a page lock,
> -	 * to save space. As soon as we switch page's memory cgroup to a
> -	 * new memcg that isn't locked, the above state can change
> -	 * concurrently again. Make sure we're truly done with it.
> -	 */
> -	smp_mb();
> -
> -	css_get(&to->css);
> -	css_put(&from->css);
> -
> -	folio->memcg_data = (unsigned long)to;
> -
> -	__folio_memcg_unlock(from);
> -
> -	ret = 0;
> -	nid = folio_nid(folio);
> -
> -	local_irq_disable();
> -	mem_cgroup_charge_statistics(to, nr_pages);
> -	memcg_check_events(to, nid);
> -	mem_cgroup_charge_statistics(from, -nr_pages);
> -	memcg_check_events(from, nid);
> -	local_irq_enable();
> -out:
> -	return ret;
> -}
> -
> -/**
> - * get_mctgt_type - get target type of moving charge
> - * @vma: the vma the pte to be checked belongs
> - * @addr: the address corresponding to the pte to be checked
> - * @ptent: the pte to be checked
> - * @target: the pointer the target page or swap ent will be stored(can be NULL)
> - *
> - * Context: Called with pte lock held.
> - * Return:
> - * * MC_TARGET_NONE - If the pte is not a target for move charge.
> - * * MC_TARGET_PAGE - If the page corresponding to this pte is a target for
> - *   move charge. If @target is not NULL, the folio is stored in target->folio
> - *   with extra refcnt taken (Caller should release it).
> - * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
> - *   target for charge migration.  If @target is not NULL, the entry is
> - *   stored in target->ent.
> - * * MC_TARGET_DEVICE - Like MC_TARGET_PAGE but page is device memory and
> - *   thus not on the lru.  For now such page is charged like a regular page
> - *   would be as it is just special memory taking the place of a regular page.
> - *   See Documentations/vm/hmm.txt and include/linux/hmm.h
> - */
> -static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t ptent, union mc_target *target)
> -{
> -	struct page *page = NULL;
> -	struct folio *folio;
> -	enum mc_target_type ret = MC_TARGET_NONE;
> -	swp_entry_t ent = { .val = 0 };
> -
> -	if (pte_present(ptent))
> -		page = mc_handle_present_pte(vma, addr, ptent);
> -	else if (pte_none_mostly(ptent))
> -		/*
> -		 * PTE markers should be treated as a none pte here, separated
> -		 * from other swap handling below.
> -		 */
> -		page = mc_handle_file_pte(vma, addr, ptent);
> -	else if (is_swap_pte(ptent))
> -		page = mc_handle_swap_pte(vma, ptent, &ent);
> -
> -	if (page)
> -		folio = page_folio(page);
> -	if (target && page) {
> -		if (!folio_trylock(folio)) {
> -			folio_put(folio);
> -			return ret;
> -		}
> -		/*
> -		 * page_mapped() must be stable during the move. This
> -		 * pte is locked, so if it's present, the page cannot
> -		 * become unmapped. If it isn't, we have only partial
> -		 * control over the mapped state: the page lock will
> -		 * prevent new faults against pagecache and swapcache,
> -		 * so an unmapped page cannot become mapped. However,
> -		 * if the page is already mapped elsewhere, it can
> -		 * unmap, and there is nothing we can do about it.
> -		 * Alas, skip moving the page in this case.
> -		 */
> -		if (!pte_present(ptent) && page_mapped(page)) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			return ret;
> -		}
> -	}
> -
> -	if (!page && !ent.val)
> -		return ret;
> -	if (page) {
> -		/*
> -		 * Do only loose check w/o serialization.
> -		 * mem_cgroup_move_account() checks the page is valid or
> -		 * not under LRU exclusion.
> -		 */
> -		if (folio_memcg(folio) == mc.from) {
> -			ret = MC_TARGET_PAGE;
> -			if (folio_is_device_private(folio) ||
> -			    folio_is_device_coherent(folio))
> -				ret = MC_TARGET_DEVICE;
> -			if (target)
> -				target->folio = folio;
> -		}
> -		if (!ret || !target) {
> -			if (target)
> -				folio_unlock(folio);
> -			folio_put(folio);
> -		}
> -	}
> -	/*
> -	 * There is a swap entry and a page doesn't exist or isn't charged.
> -	 * But we cannot move a tail-page in a THP.
> -	 */
> -	if (ent.val && !ret && (!page || !PageTransCompound(page)) &&
> -	    mem_cgroup_id(mc.from) == lookup_swap_cgroup_id(ent)) {
> -		ret = MC_TARGET_SWAP;
> -		if (target)
> -			target->ent = ent;
> -	}
> -	return ret;
> -}
> -
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -/*
> - * We don't consider PMD mapped swapping or file mapped pages because THP does
> - * not support them for now.
> - * Caller should make sure that pmd_trans_huge(pmd) is true.
> - */
> -static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
> -		unsigned long addr, pmd_t pmd, union mc_target *target)
> -{
> -	struct page *page = NULL;
> -	struct folio *folio;
> -	enum mc_target_type ret = MC_TARGET_NONE;
> -
> -	if (unlikely(is_swap_pmd(pmd))) {
> -		VM_BUG_ON(thp_migration_supported() &&
> -				  !is_pmd_migration_entry(pmd));
> -		return ret;
> -	}
> -	page = pmd_page(pmd);
> -	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
> -	folio = page_folio(page);
> -	if (!(mc.flags & MOVE_ANON))
> -		return ret;
> -	if (folio_memcg(folio) == mc.from) {
> -		ret = MC_TARGET_PAGE;
> -		if (target) {
> -			folio_get(folio);
> -			if (!folio_trylock(folio)) {
> -				folio_put(folio);
> -				return MC_TARGET_NONE;
> -			}
> -			target->folio = folio;
> -		}
> -	}
> -	return ret;
> -}
> -#else
> -static inline enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
> -		unsigned long addr, pmd_t pmd, union mc_target *target)
> -{
> -	return MC_TARGET_NONE;
> -}
> -#endif
> -
> -static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
> -					unsigned long addr, unsigned long end,
> -					struct mm_walk *walk)
> -{
> -	struct vm_area_struct *vma = walk->vma;
> -	pte_t *pte;
> -	spinlock_t *ptl;
> -
> -	ptl = pmd_trans_huge_lock(pmd, vma);
> -	if (ptl) {
> -		/*
> -		 * Note their can not be MC_TARGET_DEVICE for now as we do not
> -		 * support transparent huge page with MEMORY_DEVICE_PRIVATE but
> -		 * this might change.
> -		 */
> -		if (get_mctgt_type_thp(vma, addr, *pmd, NULL) == MC_TARGET_PAGE)
> -			mc.precharge += HPAGE_PMD_NR;
> -		spin_unlock(ptl);
> -		return 0;
> -	}
> -
> -	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> -	if (!pte)
> -		return 0;
> -	for (; addr != end; pte++, addr += PAGE_SIZE)
> -		if (get_mctgt_type(vma, addr, ptep_get(pte), NULL))
> -			mc.precharge++;	/* increment precharge temporarily */
> -	pte_unmap_unlock(pte - 1, ptl);
> -	cond_resched();
> -
> -	return 0;
> -}
> -
> -static const struct mm_walk_ops precharge_walk_ops = {
> -	.pmd_entry	= mem_cgroup_count_precharge_pte_range,
> -	.walk_lock	= PGWALK_RDLOCK,
> -};
> -
> -static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
> -{
> -	unsigned long precharge;
> -
> -	mmap_read_lock(mm);
> -	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
> -	mmap_read_unlock(mm);
> -
> -	precharge = mc.precharge;
> -	mc.precharge = 0;
> -
> -	return precharge;
> -}
> -
> -static int mem_cgroup_precharge_mc(struct mm_struct *mm)
> -{
> -	unsigned long precharge = mem_cgroup_count_precharge(mm);
> -
> -	VM_BUG_ON(mc.moving_task);
> -	mc.moving_task = current;
> -	return mem_cgroup_do_precharge(precharge);
> -}
> -
> -/* cancels all extra charges on mc.from and mc.to, and wakes up all waiters. */
> -static void __mem_cgroup_clear_mc(void)
> -{
> -	struct mem_cgroup *from = mc.from;
> -	struct mem_cgroup *to = mc.to;
> -
> -	/* we must uncharge all the leftover precharges from mc.to */
> -	if (mc.precharge) {
> -		mem_cgroup_cancel_charge(mc.to, mc.precharge);
> -		mc.precharge = 0;
> -	}
> -	/*
> -	 * we didn't uncharge from mc.from at mem_cgroup_move_account(), so
> -	 * we must uncharge here.
> -	 */
> -	if (mc.moved_charge) {
> -		mem_cgroup_cancel_charge(mc.from, mc.moved_charge);
> -		mc.moved_charge = 0;
> -	}
> -	/* we must fixup refcnts and charges */
> -	if (mc.moved_swap) {
> -		/* uncharge swap account from the old cgroup */
> -		if (!mem_cgroup_is_root(mc.from))
> -			page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
> -
> -		mem_cgroup_id_put_many(mc.from, mc.moved_swap);
> -
> -		/*
> -		 * we charged both to->memory and to->memsw, so we
> -		 * should uncharge to->memory.
> -		 */
> -		if (!mem_cgroup_is_root(mc.to))
> -			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
> -
> -		mc.moved_swap = 0;
> -	}
> -	memcg_oom_recover(from);
> -	memcg_oom_recover(to);
> -	wake_up_all(&mc.waitq);
> -}
> -
> -static void mem_cgroup_clear_mc(void)
> -{
> -	struct mm_struct *mm = mc.mm;
> -
> -	/*
> -	 * we must clear moving_task before waking up waiters at the end of
> -	 * task migration.
> -	 */
> -	mc.moving_task = NULL;
> -	__mem_cgroup_clear_mc();
> -	spin_lock(&mc.lock);
> -	mc.from = NULL;
> -	mc.to = NULL;
> -	mc.mm = NULL;
> -	spin_unlock(&mc.lock);
> -
> -	mmput(mm);
> -}
> -
> -static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> -{
> -	struct cgroup_subsys_state *css;
> -	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
> -	struct mem_cgroup *from;
> -	struct task_struct *leader, *p;
> -	struct mm_struct *mm;
> -	unsigned long move_flags;
> -	int ret = 0;
> -
> -	/* charge immigration isn't supported on the default hierarchy */
> -	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -		return 0;
> -
> -	/*
> -	 * Multi-process migrations only happen on the default hierarchy
> -	 * where charge immigration is not used.  Perform charge
> -	 * immigration if @tset contains a leader and whine if there are
> -	 * multiple.
> -	 */
> -	p = NULL;
> -	cgroup_taskset_for_each_leader(leader, css, tset) {
> -		WARN_ON_ONCE(p);
> -		p = leader;
> -		memcg = mem_cgroup_from_css(css);
> -	}
> -	if (!p)
> -		return 0;
> -
> -	/*
> -	 * We are now committed to this value whatever it is. Changes in this
> -	 * tunable will only affect upcoming migrations, not the current one.
> -	 * So we need to save it, and keep it going.
> -	 */
> -	move_flags = READ_ONCE(memcg->move_charge_at_immigrate);
> -	if (!move_flags)
> -		return 0;
> -
> -	from = mem_cgroup_from_task(p);
> -
> -	VM_BUG_ON(from == memcg);
> -
> -	mm = get_task_mm(p);
> -	if (!mm)
> -		return 0;
> -	/* We move charges only when we move a owner of the mm */
> -	if (mm->owner == p) {
> -		VM_BUG_ON(mc.from);
> -		VM_BUG_ON(mc.to);
> -		VM_BUG_ON(mc.precharge);
> -		VM_BUG_ON(mc.moved_charge);
> -		VM_BUG_ON(mc.moved_swap);
> -
> -		spin_lock(&mc.lock);
> -		mc.mm = mm;
> -		mc.from = from;
> -		mc.to = memcg;
> -		mc.flags = move_flags;
> -		spin_unlock(&mc.lock);
> -		/* We set mc.moving_task later */
> -
> -		ret = mem_cgroup_precharge_mc(mm);
> -		if (ret)
> -			mem_cgroup_clear_mc();
> -	} else {
> -		mmput(mm);
> -	}
> -	return ret;
> -}
> -
> -static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
> -{
> -	if (mc.to)
> -		mem_cgroup_clear_mc();
> -}
> -
> -static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
> -				unsigned long addr, unsigned long end,
> -				struct mm_walk *walk)
> -{
> -	int ret = 0;
> -	struct vm_area_struct *vma = walk->vma;
> -	pte_t *pte;
> -	spinlock_t *ptl;
> -	enum mc_target_type target_type;
> -	union mc_target target;
> -	struct folio *folio;
> -
> -	ptl = pmd_trans_huge_lock(pmd, vma);
> -	if (ptl) {
> -		if (mc.precharge < HPAGE_PMD_NR) {
> -			spin_unlock(ptl);
> -			return 0;
> -		}
> -		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
> -		if (target_type == MC_TARGET_PAGE) {
> -			folio = target.folio;
> -			if (folio_isolate_lru(folio)) {
> -				if (!mem_cgroup_move_account(folio, true,
> -							     mc.from, mc.to)) {
> -					mc.precharge -= HPAGE_PMD_NR;
> -					mc.moved_charge += HPAGE_PMD_NR;
> -				}
> -				folio_putback_lru(folio);
> -			}
> -			folio_unlock(folio);
> -			folio_put(folio);
> -		} else if (target_type == MC_TARGET_DEVICE) {
> -			folio = target.folio;
> -			if (!mem_cgroup_move_account(folio, true,
> -						     mc.from, mc.to)) {
> -				mc.precharge -= HPAGE_PMD_NR;
> -				mc.moved_charge += HPAGE_PMD_NR;
> -			}
> -			folio_unlock(folio);
> -			folio_put(folio);
> -		}
> -		spin_unlock(ptl);
> -		return 0;
> -	}
> -
> -retry:
> -	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> -	if (!pte)
> -		return 0;
> -	for (; addr != end; addr += PAGE_SIZE) {
> -		pte_t ptent = ptep_get(pte++);
> -		bool device = false;
> -		swp_entry_t ent;
> -
> -		if (!mc.precharge)
> -			break;
> -
> -		switch (get_mctgt_type(vma, addr, ptent, &target)) {
> -		case MC_TARGET_DEVICE:
> -			device = true;
> -			fallthrough;
> -		case MC_TARGET_PAGE:
> -			folio = target.folio;
> -			/*
> -			 * We can have a part of the split pmd here. Moving it
> -			 * can be done but it would be too convoluted so simply
> -			 * ignore such a partial THP and keep it in original
> -			 * memcg. There should be somebody mapping the head.
> -			 */
> -			if (folio_test_large(folio))
> -				goto put;
> -			if (!device && !folio_isolate_lru(folio))
> -				goto put;
> -			if (!mem_cgroup_move_account(folio, false,
> -						mc.from, mc.to)) {
> -				mc.precharge--;
> -				/* we uncharge from mc.from later. */
> -				mc.moved_charge++;
> -			}
> -			if (!device)
> -				folio_putback_lru(folio);
> -put:			/* get_mctgt_type() gets & locks the page */
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			break;
> -		case MC_TARGET_SWAP:
> -			ent = target.ent;
> -			if (!mem_cgroup_move_swap_account(ent, mc.from, mc.to)) {
> -				mc.precharge--;
> -				mem_cgroup_id_get_many(mc.to, 1);
> -				/* we fixup other refcnts and charges later. */
> -				mc.moved_swap++;
> -			}
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> -	pte_unmap_unlock(pte - 1, ptl);
> -	cond_resched();
> -
> -	if (addr != end) {
> -		/*
> -		 * We have consumed all precharges we got in can_attach().
> -		 * We try charge one by one, but don't do any additional
> -		 * charges to mc.to if we have failed in charge once in attach()
> -		 * phase.
> -		 */
> -		ret = mem_cgroup_do_precharge(1);
> -		if (!ret)
> -			goto retry;
> -	}
> -
> -	return ret;
> -}
> -
> -static const struct mm_walk_ops charge_walk_ops = {
> -	.pmd_entry	= mem_cgroup_move_charge_pte_range,
> -	.walk_lock	= PGWALK_RDLOCK,
> -};
> -
> -static void mem_cgroup_move_charge(void)
> -{
> -	lru_add_drain_all();
> -	/*
> -	 * Signal folio_memcg_lock() to take the memcg's move_lock
> -	 * while we're moving its pages to another memcg. Then wait
> -	 * for already started RCU-only updates to finish.
> -	 */
> -	atomic_inc(&mc.from->moving_account);
> -	synchronize_rcu();
> -retry:
> -	if (unlikely(!mmap_read_trylock(mc.mm))) {
> -		/*
> -		 * Someone who are holding the mmap_lock might be waiting in
> -		 * waitq. So we cancel all extra charges, wake up all waiters,
> -		 * and retry. Because we cancel precharges, we might not be able
> -		 * to move enough charges, but moving charge is a best-effort
> -		 * feature anyway, so it wouldn't be a big problem.
> -		 */
> -		__mem_cgroup_clear_mc();
> -		cond_resched();
> -		goto retry;
> -	}
> -	/*
> -	 * When we have consumed all precharges and failed in doing
> -	 * additional charge, the page walk just aborts.
> -	 */
> -	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
> -	mmap_read_unlock(mc.mm);
> -	atomic_dec(&mc.from->moving_account);
> -}
> -
> -static void mem_cgroup_move_task(void)
> -{
> -	if (mc.to) {
> -		mem_cgroup_move_charge();
> -		mem_cgroup_clear_mc();
> -	}
> -}
> -
> -#else	/* !CONFIG_MMU */
> -static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> -{
> -	return 0;
> -}
> -static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
> -{
> -}
> -static void mem_cgroup_move_task(void)
> -{
> -}
> -#endif
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static void mem_cgroup_fork(struct task_struct *task)
>  {
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

