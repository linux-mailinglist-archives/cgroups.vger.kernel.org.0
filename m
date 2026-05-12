Return-Path: <cgroups+bounces-15844-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBLZJcL9AmqrzQEAu9opvQ
	(envelope-from <cgroups+bounces-15844-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 12:15:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E0151E5DB
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 12:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2403045029
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D444C6EFE;
	Tue, 12 May 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CLTBUa70"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C13ACF0F;
	Tue, 12 May 2026 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580643; cv=none; b=lgLYeRBZ36Mbx5G5BfmGh2BYQlRIEmv4b+djSbPEdRnCjRFRIV5rh8CYcaNY8SzghBQLw454oUiWvqhb/HV+50x4d3NYJNvjPGprUNg6XObdKk8CYLoi2Ih5wbXzeq8b4UpB2+FN5U9XjzHXR17JvcOqHtud8Ow2w4Qcxo/1yD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580643; c=relaxed/simple;
	bh=3JB5iePWwKENn5+7JQfI2uGogR65/kf8GGuwHaDWDvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw8TgyhKSLMtNGrijUOOQDDebACv3ftozS2GGqUVA6e3hos5J2keqJIO3rhomNBXkRElSbB7bexY/AgA1vvhtoCa7g8MnM/t9sJrBN0u4PStbbkK6r/0By90Mzgu8paDBEl8iD+bppREPA0lpL7HqeeaqQs5bt3mBReYs6dDkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CLTBUa70; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778580637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VhNXofBJzMZ4LJ0hPZudDkIz4qghFLBmis7XZf0b3lc=;
	b=CLTBUa70abtciVrBaCuWKtyv0llhvUvttZDSfQ3l1r2akWB88Wm0RuFuFbmrYMAOQrsF9BU9gkKha8EnPRR6F+JIi/5tG+QZahhPZMBvMCmMSHHe8GGqHvgxDuZGMcAekEEJTMMfVXR8COJUTlsHAw05ycwyCptHmuDW2DZ05xk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X2qAZik_1778580633;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X2qAZik_1778580633 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 18:10:34 +0800
Message-ID: <d5341d37-5644-4446-a406-9a7251b83399@linux.alibaba.com>
Date: Tue, 12 May 2026 18:10:31 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] mm, swap: unify large folio allocation
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
 <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E9E0151E5DB
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
	TAGGED_FROM(0.00)[bounces-15844-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,tencent.com:email]
X-Rspamd-Action: no action



On 4/21/26 2:16 PM, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Now that direct large order allocation is supported in the swap cache,
> both anon and shmem can use it instead of implementing their own methods.
> This unifies the fallback and swap cache check, which also reduces the
> TOCTOU race window of swap cache state: previously, high order swapin
> required checking swap cache states first, then allocating and falling
> back separately. Now all these steps happen in the same compact loop.
> 
> Order fallback and statistics are also unified, callers just need to
> check and pass the acceptable order bitmask.
> 
> There is basically no behavior change. This only makes things more
> unified and prepares for later commits. Cgroup and zero map checks can
> also be moved into the compact loop, further reducing race windows and
> redundancy
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/memory.c     |  77 ++++++------------------------
>   mm/shmem.c      |  94 +++++++++---------------------------
>   mm/swap.h       |  30 ++----------
>   mm/swap_state.c | 145 ++++++++++----------------------------------------------
>   mm/swapfile.c   |   3 +-
>   5 files changed, 67 insertions(+), 282 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ea6568571131..404734a5bcff 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4593,26 +4593,6 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>   	return VM_FAULT_SIGBUS;
>   }
>   
> -static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct folio *folio;
> -	softleaf_t entry;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address);
> -	if (!folio)
> -		return NULL;
> -
> -	entry = softleaf_from_pte(vmf->orig_pte);
> -	if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> -					   GFP_KERNEL, entry)) {
> -		folio_put(folio);
> -		return NULL;
> -	}
> -
> -	return folio;
> -}
> -
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   /*
>    * Check if the PTEs within a range are contiguous swap entries
> @@ -4642,8 +4622,6 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
>   	 */
>   	if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
>   		return false;
> -	if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
> -		return false;
>   
>   	return true;
>   }
> @@ -4671,16 +4649,14 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
>   	return orders;
>   }
>   
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	unsigned long orders;
> -	struct folio *folio;
>   	unsigned long addr;
>   	softleaf_t entry;
>   	spinlock_t *ptl;
>   	pte_t *pte;
> -	gfp_t gfp;
>   	int order;
>   
>   	/*
> @@ -4688,7 +4664,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>   	 * maintain the uffd semantics.
>   	 */
>   	if (unlikely(userfaultfd_armed(vma)))
> -		goto fallback;
> +		return 0;
>   
>   	/*
>   	 * A large swapped out folio could be partially or fully in zswap. We
> @@ -4696,7 +4672,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>   	 * folio.
>   	 */
>   	if (!zswap_never_enabled())
> -		goto fallback;
> +		return 0;
>   
>   	entry = softleaf_from_pte(vmf->orig_pte);
>   	/*
> @@ -4710,12 +4686,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>   					  vmf->address, orders);
>   
>   	if (!orders)
> -		goto fallback;
> +		return 0;
>   
>   	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>   				  vmf->address & PMD_MASK, &ptl);
>   	if (unlikely(!pte))
> -		goto fallback;
> +		return 0;
>   
>   	/*
>   	 * For do_swap_page, find the highest order where the aligned range is
> @@ -4731,29 +4707,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>   
>   	pte_unmap_unlock(pte, ptl);
>   
> -	/* Try allocating the highest of the remaining orders. */
> -	gfp = vma_thp_gfp_mask(vma);
> -	while (orders) {
> -		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -		folio = vma_alloc_folio(gfp, order, vma, addr);
> -		if (folio) {
> -			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> -							    gfp, entry))
> -				return folio;
> -			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
> -			folio_put(folio);
> -		}
> -		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> -		order = next_order(&orders, order);
> -	}
> -
> -fallback:
> -	return __alloc_swap_folio(vmf);
> +	return orders;
>   }
>   #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
>   {
> -	return __alloc_swap_folio(vmf);
> +	return 0;
>   }
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
> @@ -4859,21 +4818,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (folio)
>   		swap_update_readahead(folio, vma, vmf->address);
>   	if (!folio) {
> -		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> -			folio = alloc_swap_folio(vmf);
> -			if (folio) {
> -				/*
> -				 * folio is charged, so swapin can only fail due
> -				 * to raced swapin and return NULL.
> -				 */
> -				swapcache = swapin_folio(entry, folio);
> -				if (swapcache != folio)
> -					folio_put(folio);
> -				folio = swapcache;
> -			}
> -		} else {
> +		/* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devices */
> +		if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
> +			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> +					     thp_swapin_suitable_orders(vmf),
> +					     vmf, NULL, 0);
> +		else
>   			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
> -		}
>   
>   		if (!folio) {
>   			/*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5916acf594a8..17e3da11bb1d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -159,7 +159,7 @@ static unsigned long shmem_default_max_inodes(void)
>   
>   static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   			struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
> -			struct vm_area_struct *vma, vm_fault_t *fault_type);
> +			struct vm_fault *vmf, vm_fault_t *fault_type);
>   
>   static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
>   {
> @@ -2017,68 +2017,24 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   }
>   
>   static struct folio *shmem_swap_alloc_folio(struct inode *inode,
> -		struct vm_area_struct *vma, pgoff_t index,
> +		struct vm_fault *vmf, pgoff_t index,
>   		swp_entry_t entry, int order, gfp_t gfp)
>   {
> +	pgoff_t ilx;
> +	struct folio *folio;
> +	struct mempolicy *mpol;
> +	unsigned long orders = BIT(order);
>   	struct shmem_inode_info *info = SHMEM_I(inode);
> -	struct folio *new, *swapcache;
> -	int nr_pages = 1 << order;
> -	gfp_t alloc_gfp = gfp;
> -
> -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -		if (WARN_ON_ONCE(order))
> -			return ERR_PTR(-EINVAL);
> -	} else if (order) {
> -		/*
> -		 * If uffd is active for the vma, we need per-page fault
> -		 * fidelity to maintain the uffd semantics, then fallback
> -		 * to swapin order-0 folio, as well as for zswap case.
> -		 * Any existing sub folio in the swap cache also blocks
> -		 * mTHP swapin.
> -		 */
> -		if ((vma && unlikely(userfaultfd_armed(vma))) ||
> -		     !zswap_never_enabled() ||
> -		     non_swapcache_batch(entry, nr_pages) != nr_pages)
> -			goto fallback;
>   
> -		alloc_gfp = thp_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
> -	}
> -retry:
> -	new = shmem_alloc_folio(alloc_gfp, order, info, index);
> -	if (!new) {
> -		new = ERR_PTR(-ENOMEM);
> -		goto fallback;
> -	}
> +	if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||
> +	     !zswap_never_enabled())
> +		orders = 0;
>   
> -	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> -					   alloc_gfp, entry)) {
> -		folio_put(new);
> -		new = ERR_PTR(-ENOMEM);
> -		goto fallback;
> -	}
> +	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
> +	folio = swapin_entry(entry, gfp, orders, vmf, mpol, ilx);
> +	mpol_cond_put(mpol);
>   
> -	swapcache = swapin_folio(entry, new);
> -	if (swapcache != new) {
> -		folio_put(new);
> -		if (!swapcache) {
> -			/*
> -			 * The new folio is charged already, swapin can
> -			 * only fail due to another raced swapin.
> -			 */
> -			new = ERR_PTR(-EEXIST);
> -			goto fallback;
> -		}
> -	}
> -	return swapcache;
> -fallback:
> -	/* Order 0 swapin failed, nothing to fallback to, abort */
> -	if (!order)
> -		return new;
> -	entry.val += index - round_down(index, nr_pages);
> -	alloc_gfp = gfp;
> -	nr_pages = 1;
> -	order = 0;
> -	goto retry;
> +	return folio;
>   }

IIUC, in the __swap_cache_alloc() implementation in patch 4, when shmem 
swapin falls back to order 0, it doesn't adjust the swap entry value 
like here. Because the original swap entry may not correspond to the 
swap entry for the order 0 index.

Of course, I haven't tested this yet, just pointing it out for you to 
double check.

