Return-Path: <cgroups+bounces-15756-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA6pMlrUAWryjwEAu9opvQ
	(envelope-from <cgroups+bounces-15756-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 15:06:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D961B50E8CF
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 15:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BA0A3045920
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C533A3E70;
	Mon, 11 May 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7jqbSZF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2C3C3BF7;
	Mon, 11 May 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504268; cv=none; b=LdVz7bvFQjGevn0MQsv9HFQ+BRUH6SPs+ySt3Bfnb5WxH8RCjtPaUkxGujDRWMELCkjCArsKLxP5zJSw2lgG22WXcGn4CdsKd1e0qnuGSIpCq0U1vETprBaxwVJWfeI9LvCaRXp5SmzqGovKixgdBukaUm4G/VgXGlgMCoTmm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504268; c=relaxed/simple;
	bh=pnCvFrJE0VGOM9kfqQ8BIn8SlSghwRxC2pKIrOTqydY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZlkx6R1mC+ns/keXMylYT0gcetWPITIs150+yPKsvIzrXT5AMlyuEKaMCR7YxukvXUKjLqIQ6eIFkSMvA1FNcVla8b8ZbcZ6y63kFsui+hyyaUS3gxrfMMJ3Knk/zcrCWH/KwgcD+5U0L1/pvuMIazhJxLlb6OEvBLrFesB6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7jqbSZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E005C2BCB0;
	Mon, 11 May 2026 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778504267;
	bh=pnCvFrJE0VGOM9kfqQ8BIn8SlSghwRxC2pKIrOTqydY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t7jqbSZFr3aZel5TYWb7wvgfkOqbIuSCCQhv5vWBYMcitaFAZbPI7FjQuTUqGmnxc
	 GmvP3xbJd2VI26TGuyFvOj5PSqTIJPxFKwZEh0HFxEL73kWoi2q28+Ar67TttguY0A
	 0v32iA5RjBZ6mjT39FrQpF7U3MwoghIspc8gCCZSDBHIeOhbybrnCBHs6kE/grtGkP
	 46lx1Pwwy3tEQSDbkVIIxRc9LbSZ0ZPYHYFaOqwjp8b3vyYguudoggJTPlIxcGXUII
	 VGB2r0kdTa/gotgzy0upOOHUjAVW/m+zw5g9yAakxfxsxH3qpnmGMlimZ2DlMHBnOV
	 btNlhzCCupXCg==
Message-ID: <675e9027-9fb5-47b5-9a2d-c9a416a27d0d@kernel.org>
Date: Mon, 11 May 2026 14:57:41 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] mm, swap: unify large folio allocation
To: kasong@tencent.com, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Youngjun Park <youngjun.park@lge.com>,
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D961B50E8CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15756-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,linux.alibaba.com,kernel.org,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On 4/21/26 08:16, Kairui Song via B4 Relay wrote:
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

You should spell out the rename from swapin_folio() to swapin_entry() [and why
it is done].

swapin_readahead() vs. swapin_entry() looks a bit odd, fiven that both consume
an entry.

> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     |  77 ++++++------------------------
>  mm/shmem.c      |  94 +++++++++---------------------------
>  mm/swap.h       |  30 ++----------
>  mm/swap_state.c | 145 ++++++++++----------------------------------------------
>  mm/swapfile.c   |   3 +-
>  5 files changed, 67 insertions(+), 282 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ea6568571131..404734a5bcff 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4593,26 +4593,6 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>  	return VM_FAULT_SIGBUS;
>  }
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
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
>   * Check if the PTEs within a range are contiguous swap entries
> @@ -4642,8 +4622,6 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
>  	 */
>  	if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
>  		return false;
> -	if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
> -		return false;
>  

This should also be pointed out in the patch description. (and why it is ok)

>  	return true;
>  }
> @@ -4671,16 +4649,14 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
>  	return orders;
>  }
>  
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long orders;
> -	struct folio *folio;
>  	unsigned long addr;
>  	softleaf_t entry;
>  	spinlock_t *ptl;
>  	pte_t *pte;
> -	gfp_t gfp;
>  	int order;
>  
>  	/*
> @@ -4688,7 +4664,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	 * maintain the uffd semantics.
>  	 */
>  	if (unlikely(userfaultfd_armed(vma)))
> -		goto fallback;
> +		return 0;
>  
>  	/*
>  	 * A large swapped out folio could be partially or fully in zswap. We
> @@ -4696,7 +4672,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	 * folio.
>  	 */
>  	if (!zswap_never_enabled())
> -		goto fallback;
> +		return 0;
>  
>  	entry = softleaf_from_pte(vmf->orig_pte);
>  	/*
> @@ -4710,12 +4686,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  					  vmf->address, orders);
>  
>  	if (!orders)
> -		goto fallback;
> +		return 0;
>  
>  	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>  				  vmf->address & PMD_MASK, &ptl);
>  	if (unlikely(!pte))
> -		goto fallback;
> +		return 0;
>  
>  	/*
>  	 * For do_swap_page, find the highest order where the aligned range is
> @@ -4731,29 +4707,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  
>  	pte_unmap_unlock(pte, ptl);
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
>  }
>  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
>  {
> -	return __alloc_swap_folio(vmf);
> +	return 0;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> @@ -4859,21 +4818,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (folio)
>  		swap_update_readahead(folio, vma, vmf->address);
>  	if (!folio) {
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
>  			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
> -		}
>  
>  		if (!folio) {
>  			/*

Nothing else jumped at me in memory.c

-- 
Cheers,

David

