Return-Path: <cgroups+bounces-15978-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMmlOFYlB2oEsQIAu9opvQ
	(envelope-from <cgroups+bounces-15978-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 15:53:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8AB550CF5
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 018BC3022BAF
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA05481A97;
	Fri, 15 May 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVgWIxs+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFE47ECFE
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852803; cv=none; b=TdqTOYOcIiiXmRfEgGzduXCZyzjZJMBBkPKkyCVxtyCv8GDhLrAg1c2bW5/VXo4N4PZpTA7qJpvJrvyRHpVYCBffZkDKBkkxRErwSj3AubRTLlN2aufglZcjtYvFXMJHwSo+DcHReTrAJ+QoMpQWV/DBbiV/FYIilHiKtwuwP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852803; c=relaxed/simple;
	bh=JmBp5Byszf4L6kKNFjnLTsmD9Zk1LUl3NxrOfhWZX+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFraFAHfGlhpqx1tVJRYyLh1nU0B0oCJnwDlp2GONxLguAykkE2qLjOWxjTqR/9Ono+Yk6XTJgvl0dQ8d0cdeyJOHxZUmL95E0jKbp+2qwbKRgVTBNUfMJStG2ng+42U3enFq3AvDTNwe3RGOVdAHwLQRz9R15k1ISgpnoQw3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVgWIxs+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c736261ee8dso4340667a12.1
        for <cgroups@vger.kernel.org>; Fri, 15 May 2026 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778852798; x=1779457598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQQlXEojFrhAWvISNt7oswBAwMsNYhE0qQ6ZhcIht6A=;
        b=MVgWIxs+1WklAMDXFNdHx4AGAbTHRiKubzPJGMfmDFFs6MPRdSDmxIVu70HTbqW17Y
         b06k/igxYsuS+21k8nMnNZyl97DqpfAmJRdWmPzMNjqwyUIpoux7VI7Ds1hFyaP4BKsV
         FGFgthV0O1pcS8bGvzRrpzXnxtXyU2AxDvOMzlI7FR0a8y4sFZxLfwLv8hlmr7rvBxZl
         UKtpl+86yhSctfFFUrokhY6nTvuL4VtsVTZB/PoOS3WYa52XFhulzmFCTODZvop/bAUA
         ZmgrY4owxSdGv5h4K2KQNsKYL2Kv8N9dLkxM/4TVEVzfoY4ZlDaHrVzo8JzOqI6oC5yt
         ejlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778852798; x=1779457598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQQlXEojFrhAWvISNt7oswBAwMsNYhE0qQ6ZhcIht6A=;
        b=gPmNIVQXdehUDF4rkh48tmqqM27wgmFQYFbfELCCuPmfzEysebFLsoB2AvVzzObNLo
         v+0e0HGWGUGZtSkwOMSZh/Hg+FFFKnp/imMDqiRk4QvQfHCvE8pSfR/7V5CfWXscP8XY
         97oc3DddckHyUfJBCAZckcesG60nQevLcU8FmeHatCR2xQ87Ny5wp+TsH70oOa4FFegP
         Gt9y1ey59cPV8/bSrRsHss+LiUupmb5SaRHlPhWypgDsS8Amq5zwNbKDWXiq/fj8H+IY
         y1do7/bsVVCkp362aro4uKn5urgqGOsmwzskUviEGqDD7gBaPQAyYfB0XppSLq4I+W+D
         1mNA==
X-Forwarded-Encrypted: i=1; AFNElJ8wM2qzl0yL8jizYMxCcG59Cllpc8JqITkCj4f0bd+ublmpk+we3FSwCvd/54nA2Gc/RiXCVFwn@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTA0Pj+I+Aqxag6zRi1LhiqXxeYGs44BtYXAGICCtLe+qSFXy
	YomkAvYtfEaFmb0FqKWM+UqBNNSEVmseEzcjJc0BgzBFbHT5RtCqVw9H
X-Gm-Gg: Acq92OGm/hR2lO5Hf8iwpWR9ktEUxH+ytdcMMz4rD/tnzldUWZAfUg6gZKvvZ523Bkg
	y8tmtYvwSO5XEJw0HhvtqLmiAXhVpXid2MgBTiizkA12RVN/3SQ3WC3bkRU/jB1IcnvvEf+gNTx
	K6YzJI2cCtUkJ2/DvVYeqKWp/QXELNo85sPwOGeAw24i09ZQgA2veP0RYruvJGLOFg2hEtUXV+f
	48FwFtiJT2aLvonNah90aoDUbypOpcSuwgDFShk+68xkdp5nxvTEnrGn6Iab1dWLMnVu0MQi6TR
	ICnsR7LXL8VJwkuzyouXx8yuFCKqsfb9pBcrFU6fzRvbRtfQ2bf568/ArrGSmsPkWpBYraGAuf4
	obsk/JHtwnsY9b4GBP+mW2QtV+jYX02H64CfjjJIiIn51o8a8Pg2EQ6Mb63PfJdvynfmthhl6tR
	fCFP9haPHfpXMbivfUYdmYXXl47r73NRb1Y+Hb9YOEqIrsHz4r8AjSQSdpuf0=
X-Received: by 2002:a05:6a20:748b:b0:3a2:edff:297c with SMTP id adf61e73a8af0-3b22e13754amr4680422637.0.1778852798288;
        Fri, 15 May 2026 06:46:38 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19776733sm6017763b3a.13.2026.05.15.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:46:37 -0700 (PDT)
Date: Fri, 15 May 2026 21:46:30 +0800
From: Kairui Song <ryncsn@gmail.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v4 04/12] mm, swap: add support for stable large
 allocation in swap cache directly
Message-ID: <agcdxIFQ8QBI9R6z@KASONG-MC4>
References: <20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com>
 <20260515-swap-table-p4-v4-4-f1b49e845a8d@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515-swap-table-p4-v4-4-f1b49e845a8d@tencent.com>
X-Rspamd-Queue-Id: 9C8AB550CF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15978-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:54:17PM +0800, Kairui Song via B4 Relay wrote:
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
>  mm/swap.h       |   3 +-
>  mm/swap_state.c | 234 +++++++++++++++++++++++++++++++++++++++-----------------
>  mm/zswap.c      |   2 +-
>  3 files changed, 168 insertions(+), 71 deletions(-)
> 
> diff --git a/mm/swap.h b/mm/swap.h
> index ad8b17a93758..6774af10a943 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -280,7 +280,8 @@ bool swap_cache_has_folio(swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_del_folio(struct folio *folio);
> -struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
> +struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
> +				     unsigned long orders, struct vm_fault *vmf,
>  				     struct mempolicy *mpol, pgoff_t ilx);
>  /* Below helpers require the caller to lock and pass in the swap cluster. */
>  void __swap_cache_add_folio(struct swap_cluster_info *ci,
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 89fa19ec13f6..cd4543ff5e47 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -139,10 +139,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>  
>  /**
>   * __swap_cache_add_check - Check if a range is suitable for adding a folio.
> - * @ci: The locked swap cluster.
> - * @ci_off: Range start offset.
> - * @nr: Number of slots to check.
> - * @shadow: Returns the shadow value if one exists in the range.
> + * @ci: The locked swap cluster
> + * @targ_entry: The target swap entry to check, will be rounded down by @nr
> + * @nr: Number of slots to check, must be a power of 2
> + * @shadowp: Returns the shadow value if one exists in the range.
>   *
>   * Check if all slots covered by given range have a swap count >= 1.
>   * Retrieves the shadow if there is one.
> @@ -151,26 +151,40 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>   * Return: 0 if success, error code if failed.
>   */
>  static int __swap_cache_add_check(struct swap_cluster_info *ci,
> -				  unsigned int ci_off, unsigned int nr,
> -				  void **shadow)
> +				  swp_entry_t targ_entry,
> +				  unsigned long nr, void **shadowp)
>  {
> -	unsigned int ci_end = ci_off + nr;
> +	unsigned int ci_off, ci_end;
>  	unsigned long old_tb;
>  
>  	lockdep_assert_held(&ci->lock);
> -	if (WARN_ON_ONCE(ci_off >= SWAPFILE_CLUSTER))
> -		return -EINVAL;
>  
> +	/*
> +	 * If the target slot is not swapped out or already cached, return
> +	 * -ENOENT or -EEXIST. If the batch is not suitable, could be a
> +	 * race with concurrent free or cache add, return -EBUSY.
> +	 */
>  	if (unlikely(!ci->table))
>  		return -ENOENT;
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
>  	do {
>  		old_tb = __swap_table_get(ci, ci_off);
> -		if (unlikely(swp_tb_is_folio(old_tb)))
> -			return -EEXIST;
> -		if (unlikely(!__swp_tb_get_count(old_tb)))
> -			return -ENOENT;
> -		if (swp_tb_is_shadow(old_tb))
> -			*shadow = swp_tb_to_shadow(old_tb);
> +		if (unlikely(swp_tb_is_folio(old_tb) ||
> +			     !__swp_tb_get_count(old_tb)))
> +			return -EBUSY;
>  	} while (++ci_off < ci_end);
>  
>  	return 0;
> @@ -241,15 +255,13 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
>  {
>  	int err;
>  	void *shadow = NULL;
> -	unsigned int ci_off;
>  	struct swap_info_struct *si;
>  	struct swap_cluster_info *ci;
>  	unsigned long nr_pages = folio_nr_pages(folio);
>  
>  	si = __swap_entry_to_info(entry);
>  	ci = swap_cluster_lock(si, swp_offset(entry));
> -	ci_off = swp_cluster_offset(entry);
> -	err = __swap_cache_add_check(ci, ci_off, nr_pages, &shadow);
> +	err = __swap_cache_add_check(ci, entry, nr_pages, &shadow);
>  	if (err) {
>  		swap_cluster_unlock(ci);
>  		return err;
> @@ -404,6 +416,140 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
>  	}
>  }
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
> +	unsigned long address, nr_pages = 1UL << order;
> +	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
> +
> +	VM_WARN_ON_ONCE(nr_pages > SWAPFILE_CLUSTER);
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
> +		gfp = thp_shmem_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
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
> + * @orders: allocation orders, must be non zero
> + * @vmf: fault information
> + * @mpol: NUMA memory allocation policy to be applied
> + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> + *
> + * Allocate a folio in the swap cache for one swap slot, typically before
> + * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
> + * @targ_entry must have a non-zero swap count (swapped out).
> + *
> + * Context: Caller must protect the swap device with reference count or locks.
> + * Return: Returns the folio if allocation succeeded and folio is in the swap
> + * cache. Returns error code if failed due to race, OOM or invalid arguments.
> + */
> +struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> +				     unsigned long orders, struct vm_fault *vmf,
> +				     struct mempolicy *mpol, pgoff_t ilx)
> +{
> +	int order, err;
> +	struct folio *ret;
> +	struct swap_cluster_info *ci;
> +
> +	if (WARN_ON_ONCE(!orders))
> +		return ERR_PTR(-EINVAL);
> +
> +	ci = __swap_entry_to_cluster(targ_entry);
> +	order = highest_order(orders);
> +	while (orders) {
> +		ret = __swap_cache_alloc(ci, targ_entry, gfp, order,
> +					 vmf, mpol, ilx);
> +		if (!IS_ERR(ret))
> +			break;
> +		err = PTR_ERR(ret);
> +		if (err && err != -EBUSY && err != -ENOMEM)
> +			break;
> +		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> +		order = next_order(&orders, order);
> +	}

I just realized that with !CONFIG_TRANSPARENT_HUGEPAGE,
next_order(&orders, order) won't modify orders so this loop won't
break properly for !CONFIG_TRANSPARENT_HUGEPAGE build.

So V4 is not correct here. I did a "cleanup" since V4 removed
the forced order 0 fallback. The cleanup is wrong. We need to revert
this loop part back to V3 by squashing this:

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7701fa4b981c..60f93995e492 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -508,13 +508,13 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
 
        ci = __swap_entry_to_cluster(targ_entry);
        order = highest_order(orders);
-       while (orders) {
+       for (;;) {
                ret = __swap_cache_alloc(ci, targ_entry, gfp, order,
                                         vmf, mpol, ilx);
                if (!IS_ERR(ret))
                        break;
                err = PTR_ERR(ret);
-               if (err && err != -EBUSY && err != -ENOMEM)
+               if (!order || (err && err != -EBUSY && err != -ENOMEM))
                        break;
                count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
                order = next_order(&orders, order);

---

Other than that this should be good.

