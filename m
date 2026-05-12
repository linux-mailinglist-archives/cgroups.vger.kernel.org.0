Return-Path: <cgroups+bounces-15842-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MmKMIr3AmqvzAEAu9opvQ
	(envelope-from <cgroups+bounces-15842-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:48:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463951E096
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45943011BFB
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A03B95EC;
	Tue, 12 May 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aYCq6ula"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF63A872C;
	Tue, 12 May 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579335; cv=none; b=dxi53rYMdehBDdA4lAwfKPpQkbSUOQToeAygWaw36z3IBGv1Xlofsx6h+IGjDClHTbjd84PhIlaQ6H+/p3VaYuitmpEFkcX3jVgCX3DOuhl24Y5Eddge1SqZRXSmzdT8CTxNrwZlrEL6L4KAIySnJq0SvzkRVrJ26anHYJixdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579335; c=relaxed/simple;
	bh=YsmJAqnqKJHA9x754bPEmSHJoGNQT38WDGkZgtsfoAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjtvmcnZQQx68KToz+N6SypSyaMgSnKv1/xc08UbnZYW1fJCpo4ltDlMdUwz4sPQkPWdL8d3ZJCyOY2GS03EvKm6K2wV5ZdzwJeGFkz1xTgjLrU3AB8OrG3UXo24YJG3eNQ12BjBtmyP6NfyEok8SgxdgusESRenbtdUt7H6NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aYCq6ula; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778579330; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qOSvnW4q43Jy7mUga8b/+dx4UkykPG9Ly3eqFwVTzrs=;
	b=aYCq6ula2M823tPjOM9y2rmco3xregpUyBj1iMCc3rkJesgWJConQM6A+9bTEedyKb20E1SwZtkUjQ2UNYCDDYOedhdKUIX3o+e3+dxFbxuktHp/omnDq1Sqaz+7m7BbE6tMgrYeaDWLO62iUO0EEYO1NJMf9FAFfC/o4HLTtSw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X2q5IQS_1778579327;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X2q5IQS_1778579327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 17:48:48 +0800
Message-ID: <19f31906-d8fb-489b-8e2a-c4414c99f338@linux.alibaba.com>
Date: Tue, 12 May 2026 17:48:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] mm, swap: add support for stable large
 allocation in swap cache directly
To: kasong@tencent.com, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-4-2f23759a76bc@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260421-swap-table-p4-v3-4-2f23759a76bc@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2463951E096
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15842-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action



On 4/21/26 2:16 PM, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> To make it possible to allocate large folios directly in swap cache,
> provide a new infrastructure helper to handle the swap cache status
> check, allocation, and order fallback in the swap cache layer
> 
> The new helper replaces the existing swap_cache_alloc_folio. Based on
> this, all the separate swap folio allocation that is being done by anon
> / shmem before is converted to use this helper directly, unifying folio
> allocation for anon, shmem, and readahead.
> 
> This slightly consolidates how allocation is synchronized, making it
> more stable and less prone to errors. The slot-count and cache-conflict
> check is now always performed with the cluster lock held before
> allocation, and repeated under the same lock right before cache
> insertion. This double check produces a stable result compared to the
> previous anon and shmem mTHP allocation implementation,  avoids the
> false-negative conflict checks that the lockless path can return — large
> allocations no longer have to be unwound because the range turned out to
> be occupied — and aborts early for already-freed slots, which helps
> ordinary swapin and especially readahead, with only a marginal increase
> in cluster-lock contention (the lock is very lightly contended and stays
> local in the first place). Hence, callers of swap_cache_alloc_folio() no
> longer need to check the swap slot count or swap cache status
> themselves.
> 
> And now whoever first successfully allocates a folio in the swap cache
> will be the one who charges it and performs the swap-in. The race window
> of swapping is also reduced since the loop is much more compact.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/swap.h       |   3 +-
>   mm/swap_state.c | 222 +++++++++++++++++++++++++++++++++++++++++---------------
>   mm/zswap.c      |   2 +-
>   3 files changed, 165 insertions(+), 62 deletions(-)
> 
> diff --git a/mm/swap.h b/mm/swap.h
> index ad8b17a93758..6774af10a943 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -280,7 +280,8 @@ bool swap_cache_has_folio(swp_entry_t entry);
>   struct folio *swap_cache_get_folio(swp_entry_t entry);
>   void *swap_cache_get_shadow(swp_entry_t entry);
>   void swap_cache_del_folio(struct folio *folio);
> -struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
> +struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
> +				     unsigned long orders, struct vm_fault *vmf,
>   				     struct mempolicy *mpol, pgoff_t ilx);
>   /* Below helpers require the caller to lock and pass in the swap cluster. */
>   void __swap_cache_add_folio(struct swap_cluster_info *ci,
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3da285a891b2..f5c77f348bbd 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -139,10 +139,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>   
>   /**
>    * __swap_cache_add_check - Check if a range is suitable for adding a folio.
> - * @ci: The locked swap cluster.
> - * @ci_off: Range start offset.
> - * @nr: Number of slots to check.
> - * @shadow: Returns the shadow value if one exists in the range.
> + * @ci: The locked swap cluster
> + * @targ_entry: The target swap entry to check, will be rounded down by @nr
> + * @nr: Number of slots to check, must be a power of 2
> + * @shadowp: Returns the shadow value if one exists in the range.
>    *
>    * Check if all slots covered by given range have a swap count >= 1.
>    * Retrieves the shadow if there is one.
> @@ -150,22 +150,38 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>    * Context: Caller must lock the cluster.
>    */
>   static int __swap_cache_add_check(struct swap_cluster_info *ci,
> -				  unsigned int ci_off, unsigned int nr,
> -				  void **shadow)
> +				  swp_entry_t targ_entry,
> +				  unsigned long nr, void **shadowp)
>   {
> -	unsigned int ci_end = ci_off + nr;
> +	unsigned int ci_off, ci_end;
>   	unsigned long old_tb;
>   
> +	/*
> +	 * If the target slot is not swapped out, return
> +	 * -EEXIST or -ENOENT. If the batch is not suitable, could be a
> +	 * race with concurrent free or cache add, return -EBUSY.
> +	 */
>   	if (unlikely(!ci->table))
>   		return -ENOENT;
> +	ci_off = swp_cluster_offset(targ_entry);
> +	old_tb = __swap_table_get(ci, ci_off);
> +	if (swp_tb_is_folio(old_tb))
> +		return -EEXIST;
> +	if (!__swp_tb_get_count(old_tb))
> +		return -ENOENT;
> +	if (swp_tb_is_shadow(old_tb) && shadowp)
> +		*shadowp = swp_tb_to_shadow(old_tb);
> +
> +	if (nr == 1)
> +		return 0;
> +
> +	ci_off = round_down(ci_off, nr);
> +	ci_end = ci_off + nr;
>   	do {
>   		old_tb = __swap_table_get(ci, ci_off);
> -		if (unlikely(swp_tb_is_folio(old_tb)))
> -			return -EEXIST;
> -		if (unlikely(!__swp_tb_get_count(old_tb)))
> -			return -ENOENT;
> -		if (swp_tb_is_shadow(old_tb))
> -			*shadow = swp_tb_to_shadow(old_tb);
> +		if (unlikely(swp_tb_is_folio(old_tb) ||
> +			     !__swp_tb_get_count(old_tb)))
> +			return -EBUSY;
>   	} while (++ci_off < ci_end);
>   
>   	return 0;
> @@ -244,7 +260,7 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
>   	si = __swap_entry_to_info(entry);
>   	ci = swap_cluster_lock(si, swp_offset(entry));
>   	ci_off = swp_cluster_offset(entry);
> -	err = __swap_cache_add_check(ci, ci_off, nr_pages, &shadow);
> +	err = __swap_cache_add_check(ci, entry, nr_pages, &shadow);
>   	if (err) {
>   		swap_cluster_unlock(ci);
>   		return err;
> @@ -399,6 +415,137 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
>   	}
>   }
>   
> +/*
> + * Try to allocate a folio of given order in the swap cache.
> + *
> + * This helper resolves the potential races of swap allocation
> + * and prepares a folio to be used for swap IO. May return following
> + * value:
> + *
> + * -ENOMEM / -EBUSY: Order is too large or in conflict with sub slot,
> + *                   caller should shrink the order and retry
> + * -ENOENT / -EEXIST: Target swap entry is unavailable or cached, the caller
> + *                    should abort or try to use the cached folio instead
> + */
> +static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
> +					swp_entry_t targ_entry, gfp_t gfp,
> +					unsigned int order, struct vm_fault *vmf,
> +					struct mempolicy *mpol, pgoff_t ilx)
> +{
> +	int err;
> +	swp_entry_t entry;
> +	struct folio *folio;
> +	void *shadow = NULL;
> +	unsigned long address, nr_pages = 1 << order;
> +	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
> +
> +	entry.val = round_down(targ_entry.val, nr_pages);
> +
> +	/* Check if the slot and range are available, skip allocation if not */
> +	spin_lock(&ci->lock);
> +	err = __swap_cache_add_check(ci, targ_entry, nr_pages, NULL);
> +	spin_unlock(&ci->lock);
> +	if (unlikely(err))
> +		return ERR_PTR(err);
> +
> +	/*
> +	 * Limit THP gfp. The limitation is a no-op for typical
> +	 * GFP_HIGHUSER_MOVABLE but matters for shmem.
> +	 */
> +	if (order)
> +		gfp = thp_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
> +
> +	if (mpol || !vmf) {
> +		folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id());
> +	} else {
> +		address = round_down(vmf->address, PAGE_SIZE << order);
> +		folio = vma_alloc_folio(gfp, order, vmf->vma, address);
> +	}
> +	if (unlikely(!folio))
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Double check the range is still not in conflict */
> +	spin_lock(&ci->lock);
> +	err = __swap_cache_add_check(ci, targ_entry, nr_pages, &shadow);
> +	if (unlikely(err)) {
> +		spin_unlock(&ci->lock);
> +		folio_put(folio);
> +		return ERR_PTR(err);
> +	}
> +
> +	__folio_set_locked(folio);
> +	__folio_set_swapbacked(folio);
> +	__swap_cache_do_add_folio(ci, folio, entry);
> +	spin_unlock(&ci->lock);
> +
> +	if (mem_cgroup_swapin_charge_folio(folio, vmf ? vmf->vma->vm_mm : NULL,
> +					   gfp, entry)) {
> +		spin_lock(&ci->lock);
> +		__swap_cache_do_del_folio(ci, folio, entry, shadow);
> +		spin_unlock(&ci->lock);
> +		folio_unlock(folio);
> +		/* nr_pages refs from swap cache, 1 from allocation */
> +		folio_put_refs(folio, nr_pages + 1);
> +		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* For memsw accounting, swap is uncharged when folio is added to swap cache */
> +	memcg1_swapin(entry, 1 << order);
> +	if (shadow)
> +		workingset_refault(folio, shadow);
> +
> +	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> +	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> +
> +	/* Caller will initiate read into locked new_folio */
> +	folio_add_lru(folio);
> +	return folio;
> +}
> +
> +/**
> + * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
> + * @targ_entry: swap entry indicating the target slot
> + * @gfp: memory allocation flags
> + * @orders: allocation orders
> + * @vmf: fault information
> + * @mpol: NUMA memory allocation policy to be applied
> + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> + *
> + * Allocate a folio in the swap cache for one swap slot, typically before
> + * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
> + * @targ_entry must have a non-zero swap count (swapped out).
> + *
> + * Context: Caller must protect the swap device with reference count or locks.
> + * Return: Returns the folio if allocation succeeded and folio is added to
> + * swap cache. Returns error code if allocation failed due to race.
> + */
> +struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> +				     unsigned long orders, struct vm_fault *vmf,
> +				     struct mempolicy *mpol, pgoff_t ilx)
> +{
> +	int order, err;
> +	struct folio *ret;
> +	struct swap_cluster_info *ci;
> +
> +	/* Always allow order 0 so swap won't fail under pressure. */
> +	order = orders ? highest_order(orders |= BIT(0)) : 0;

This seems a bit odd here. In THP/mTHP operations, it's usually the 
callers' responsibility to determine the allowable orders. So I think we 
should not implicitly set order 0 here. Instead, we should let callers 
explicitly set it. What do you think?

diff --git a/mm/shmem.c b/mm/shmem.c
index f0da10054620..fb05daeab59a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2023,7 +2023,8 @@ static struct folio *shmem_swap_alloc_folio(struct 
inode *inode,
         pgoff_t ilx;
         struct folio *folio;
         struct mempolicy *mpol;
-       unsigned long orders = BIT(order);
+       /* Always allow order 0 so swap won't fail under pressure. */
+       unsigned long orders = BIT(order) | BIT(0);
         struct shmem_inode_info *info = SHMEM_I(inode);

         if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||

