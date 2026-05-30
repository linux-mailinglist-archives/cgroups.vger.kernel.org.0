Return-Path: <cgroups+bounces-16474-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONhNC14/GmrQ2QgAu9opvQ
	(envelope-from <cgroups+bounces-16474-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 03:37:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F060ACCB
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 03:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7AB3026A9C
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 01:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355E2F1FD0;
	Sat, 30 May 2026 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzsUAUVP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EF1A5BAE;
	Sat, 30 May 2026 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780105041; cv=none; b=SQHCWj3xrRTp4Wl+XLIfwzSro4037IOswB3+DvMVVCJs2Ud5kJePcqEgIhqYp0iCLDBQ/0jVIq8VLB0dhZWgnKfhrZsrUUhBD0Vn90MFQkTBMjo9ud2TBn2OJmERcWX0UyRNP2nqY59TIHXoeaQ0vqiN8zQavQq8C/P/lY8mAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780105041; c=relaxed/simple;
	bh=Nakagv1cWXtoKKPRUdH3GuaufcWVA+b7irqhBhk5ZRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0X+jQylxwBNhu2jQRmfl7nGNsl0hOxcTAaDxHJkp1hRWyn7vuIwaDB6eZIQnaqhuLolQOjqGdraBVWjJ8ilhLWjPGShxqEmfD7zdRr3Haz25QPCg8jmDryone2fSCq+RI640sHm9KD8kAEmGde7SQCj0ei76Zm2/fXcPD99q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzsUAUVP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706F51F00893;
	Sat, 30 May 2026 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780105040;
	bh=nO0cIl82wPxeZvS2+pe+To1HD6LqNrV1MR7nS3Y58H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AzsUAUVPsLR7I7C/g6G1sNgiaNwjyBjcx4VXK1rGDUE+KeFuH+qr9lt+QZoIftpGe
	 zDlTKF+/SrGarcqWMVsCqpPMdjfOtpS/HBQzr/LeAZ+yODO9O9apiCfsUGDxXn3kDK
	 ZhfgnoGOrdiQWy8mww3522kArTFMwMd9iEQDknvI4pLn6/XB2EfHmcMQjGqEwr5nFu
	 pC16ARFKIg63BifO/IJoQ4ABoEAT00o38Aj8xoh5rW/VJzSBHSlHteIjOd1DH1Fzl7
	 +pzohQWzrkPteaoygGwIFlpjTkFL5cRl9TUOWgSKOSY2feSmHw1/Dm9PC4vuWjVofQ
	 jnyVNGdWki0Ow==
Date: Sat, 30 May 2026 01:37:18 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Message-ID: <aho-Z6wshceTAYd9@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526114601.67041-3-jiahao.kernel@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16474-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: B62F060ACCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:45:59PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> Zswap currently writes back pages to backing swap reactively, triggered
> either by the shrinker or when the pool reaches its size limit. There is
> no mechanism to control the amount of writeback for a specific memory
> cgroup. However, users may want to proactively write back zswap pages,
> e.g., to free up memory for other applications or to prepare for
> memory-intensive workloads.
> 
> Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
> interface. When specified, this key bypasses standard memory reclaim
> and exclusively performs proactive zswap writeback up to the requested
> budget. If omitted, the default reclaim behavior remains unchanged.
> 
> Example usage:
>   # Write back 100MB of pages from zswap to the backing swap
>   echo "100M zswap_writeback_only" > memory.reclaim
> 
> Note that the actual amount written back may be less than requested due
> to the zswap second-chance algorithm: referenced entries are rotated on
> the LRU on the first encounter and only written back on a second pass.
> If fewer bytes are written back than requested, -EAGAIN is returned,
> matching the existing memory.reclaim semantics.
> 
> Internally, extend user_proactive_reclaim() to parse the new
> "zswap_writeback_only" token and invoke the dedicated handler. Add
> zswap_proactive_writeback() to walk the target memcg subtree via the
> per-memcg writeback cursor, draining per-node zswap LRUs through
> list_lru_walk_one() with the shrink_memcg_cb() callback.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  18 +++-
>  Documentation/admin-guide/mm/zswap.rst  |  11 +-
>  include/linux/zswap.h                   |   7 ++
>  mm/vmscan.c                             |  14 +++
>  mm/zswap.c                              | 138 ++++++++++++++++++++++++
>  5 files changed, 185 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 6efd0095ed99..6564abf0dec5 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1425,9 +1425,10 @@ PAGE_SIZE multiple when read back.
>  
>  The following nested keys are defined.
>  
> -	  ==========            ================================
> +	  ====================  ==================================================
>  	  swappiness            Swappiness value to reclaim with
> -	  ==========            ================================
> +	  zswap_writeback_only  Only perform proactive zswap writeback
> +	  ====================  ==================================================
>  
>  	Specifying a swappiness value instructs the kernel to perform
>  	the reclaim with that swappiness value. Note that this has the
> @@ -1437,6 +1438,19 @@ The following nested keys are defined.
>  	The valid range for swappiness is [0-200, max], setting
>  	swappiness=max exclusively reclaims anonymous memory.
>  
> +	The zswap_writeback_only key skips ordinary memory reclaim and
> +	writes back pages from zswap to the backing swap device until
> +	the requested amount has been written or no further candidates
> +	are found. This is useful to proactively offload cold pages from
> +	the zswap pool to the swap device. It is only available if
> +	zswap writeback is enabled. zswap_writeback_only cannot be combined
> +	with swappiness; specifying both returns -EINVAL.
> +
> +	Example::
> +
> +	  # Write back up to 100MB of pages from zswap to the backing swap
> +	  echo "100M zswap_writeback_only" > memory.reclaim


memcg folks need to chime in about the interface here. An alternative
would be a separate interface (e.g. memory.zswap.do_writeback or
memory.zswap.writeback.reclaim or sth).

> diff --git a/mm/zswap.c b/mm/zswap.c
> index 73e64a635690..7bcbf788f634 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1679,6 +1679,144 @@ int zswap_load(struct folio *folio)
>  	return 0;
>  }
>  
> +/*
> + * Maximum LRU scan limit:
> + * number of entries to scan per page of remaining budget.
> + */
> +#define ZSWAP_PROACTIVE_WB_SCAN_RATIO	16UL
> +/*
> + * Batch size for proactive writeback:
> + * - As the per-memcg writeback target in the outer memcg loop.
> + * - As the per-walk budget passed to list_lru_walk_one().
> + */
> +#define ZSWAP_PROACTIVE_WB_BATCH	128UL
> +
> +/*
> + * Walk the per-node LRUs of @memcg to write back up to @nr_to_write pages.
> + * Returns the number of pages written back, or -ENOENT if @memcg is a
> + * zombie or has writeback disabled.
> + */
> +static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
> +					 unsigned long nr_to_write)
> +{
> +	unsigned long nr_written = 0;
> +	int nid;
> +
> +	if (!mem_cgroup_zswap_writeback_enabled(memcg))
> +		return -ENOENT;
> +
> +	if (!mem_cgroup_online(memcg))
> +		return -ENOENT;
> +
> +	for_each_node_state(nid, N_NORMAL_MEMORY) {
> +		bool encountered_page_in_swapcache = false;
> +		unsigned long nr_to_scan, nr_scanned = 0;
> +
> +		/*
> +		 * Cap by LRU length: bounds rewalks when referenced
> +		 * entries keep rotating to the tail.
> +		 */
> +		nr_to_scan = list_lru_count_one(&zswap_list_lru, nid, memcg);
> +		if (!nr_to_scan)
> +			continue;
> +
> +		/*
> +		 * Cap by SCAN_RATIO * remaining budget: bounds scan cost
> +		 * to the remaining writeback budget.
> +		 */
> +		nr_to_scan = min(nr_to_scan,
> +				 (nr_to_write - nr_written) * ZSWAP_PROACTIVE_WB_SCAN_RATIO);
> +
> +		while (nr_scanned < nr_to_scan) {
> +			unsigned long nr_to_walk = min(ZSWAP_PROACTIVE_WB_BATCH,
> +						       nr_to_scan - nr_scanned);
> +
> +			if (signal_pending(current))
> +				return nr_written;
> +
> +			/*
> +			 * Account for the committed budget rather than the walker's
> +			 * actual delta. If the list is emptied concurrently, the
> +			 * walker visits nothing and nr_scanned would never advance.
> +			 */
> +			nr_scanned += nr_to_walk;
> +
> +			nr_written += list_lru_walk_one(&zswap_list_lru, nid, memcg,
> +							&shrink_memcg_cb,
> +							&encountered_page_in_swapcache,
> +							&nr_to_walk);
> +
> +			if (nr_written >= nr_to_write)
> +				return nr_written;
> +			if (encountered_page_in_swapcache)
> +				break;
> +
> +			cond_resched();
> +		}
> +	}
> +
> +	return nr_written;
> +}
> +
> +int zswap_proactive_writeback(struct mem_cgroup *memcg,
> +			      unsigned long nr_to_writeback)
> +{
> +	struct mem_cgroup *iter_memcg;
> +	unsigned long nr_written = 0;
> +	int failures = 0, attempts = 0;
> +
> +	if (!memcg)
> +		return -EINVAL;
> +	if (!nr_to_writeback)
> +		return 0;
> +
> +	/*
> +	 * Writeback will be aborted with -EAGAIN if we encounter
> +	 * the following MAX_RECLAIM_RETRIES times:
> +	 * - No writeback-candidate memcgs found in a subtree walk.
> +	 * - A writeback-candidate memcg wrote back zero pages.
> +	 */
> +	while (nr_written < nr_to_writeback) {
> +		unsigned long batch_size;
> +		long shrunk;
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		iter_memcg = zswap_mem_cgroup_iter(memcg);
> +
> +		if (!iter_memcg) {
> +			/*
> +			 * Continue without incrementing failures if we found
> +			 * candidate memcgs in the last subtree walk.
> +			 */
> +			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
> +				return -EAGAIN;
> +			attempts = 0;
> +			continue;
> +		}
> +
> +		batch_size = min(nr_to_writeback - nr_written,
> +				 ZSWAP_PROACTIVE_WB_BATCH);
> +		shrunk = zswap_proactive_shrink_memcg(iter_memcg, batch_size);
> +		mem_cgroup_put(iter_memcg);
> +
> +		/* Writeback-disabled or offline: skip without counting. */
> +		if (shrunk == -ENOENT)
> +			continue;
> +
> +		++attempts;
> +		if (shrunk > 0)
> +			nr_written += shrunk;
> +		else if (++failures == MAX_RECLAIM_RETRIES)
> +			return -EAGAIN;
> +
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}
> +

There is a lot of copy+paste from shrink_worker() and shrink_memcg()
here. We really should be able to reuse shrink_memcg().

Is the main difference that we are scanning in batches here? I think we
can have shrink_memcg() do that too. If anything, it might make the
shrinker more efficient. Over-reclaim is ofc a concern, and especially
in the zswap_store() path as the overhead can be noticeable. Maybe we
can parameterize the batch size based on the code path.

Nhat, what do you think?

