Return-Path: <cgroups+bounces-13721-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP1IGoM4hWlf+QMAu9opvQ
	(envelope-from <cgroups+bounces-13721-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 01:40:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0224F8B39
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 01:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BEA301983D
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 00:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793B1E3DCD;
	Fri,  6 Feb 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PBX6ioe2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6A222580
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770338411; cv=none; b=EjjOT0b9oosSluYeEHiWOYDbeU+tPY6+uYql1HxRNqrG5C7LQzhZG53RRcCPx3YDciWDnMRCW/F6qGRJNGbckBdMOKmzLPM7vxtoGgK6B3zBamnNMZ21A836inGkxo2mcxdLF7K837viuztBkIVH8n0aqPRecyTMPVtbc8QCK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770338411; c=relaxed/simple;
	bh=wg7C66KfUZMw+KAmdObeQ1o0Sk8H0a0r22F7oj+ulNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZLzKvzBH/tPzTzJF7ErbN7Sm2W7udt/vP1VOohpVPMEkjZPB5vMVzDemW3w3B1oJNfzAkUtPYIvutP5O0k/DqdqedHToqQ70Dtdb4djoBNLHJhJvlXqskIIuigAc7OuGzUhwjcvDyRToMcajSFPRHiwnVsOfk62sUHzZ9OyzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PBX6ioe2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Feb 2026 00:39:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770338399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9x8Oha2FCRFhdP6sFQHAlg53hGqhvSeJttZv66OvZ8=;
	b=PBX6ioe2oqYVg2VIrumnJ5LBuevyOQhXyW2HDSYuOkiAbnLGQKkZOnXszTzLZ3cAgq8/Tw
	by0miBErTtiCs3CQx/DwEYoCUFeEajenBetDIISemUatz6Z2UmyO5vpj2QPNtdJqHQCeAn
	pTn1Kb/cEEe1P4i9RX10dHJ5P695r2M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible pages
Message-ID: <hevovghpl2udhpof66oz26ulrpqcrtuwjxcakyskoeoil2wo6x@osbrncj7ifwz>
References: <20260205053013.25134-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205053013.25134-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13721-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kvack.org,shopee.com,cmpxchg.org,kernel.org,linux.dev,gmail.com,linux-foundation.org,fb.com,suse.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shopee.com:email,linux.dev:dkim]
X-Rspamd-Queue-Id: D0224F8B39
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:30:12PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> The global zswap_stored_incompressible_pages counter was added in commit
> dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is")
> to track how many pages are stored in raw (uncompressed) form in zswap.
> However, in containerized environments, knowing which cgroup is
> contributing incompressible pages is essential for effective resource
> management.
> 
> Add a new memcg stat 'zswpraw' to track incompressible pages per cgroup.
> This helps administrators and orchestrators to:
> 
> 1. Identify workloads that produce incompressible data (e.g., encrypted
>    data, already-compressed media, random data) and may not benefit from
>    zswap.
> 
> 2. Make informed decisions about workload placement - moving
>    incompressible workloads to nodes with larger swap backing devices
>    rather than relying on zswap.
> 
> 3. Debug zswap efficiency issues at the cgroup level without needing to
>    correlate global stats with individual cgroups.
> 
> While the compression ratio can be estimated from existing stats
> (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> "uniformly poor compression" and "a few completely incompressible pages
> mixed with highly compressible ones". The zswpraw stat provides direct
> visibility into the latter case.
> 
> Changes
> -------
> 
> 1. Add zswap_is_raw() helper (include/linux/zswap.h)
>    - Abstract the PAGE_SIZE comparison logic for identifying raw entries
>    - Keep the incompressible check in one place for maintainability
> 
> 2. Add MEMCG_ZSWAP_RAW stat definition (include/linux/memcontrol.h,
>    mm/memcontrol.c)
>    - Add MEMCG_ZSWAP_RAW to memcg_stat_item enum
>    - Register in memcg_stat_items[] and memory_stats[] arrays
>    - Export as "zswpraw" in memory.stat
> 
> 3. Update statistics accounting (mm/memcontrol.c, mm/zswap.c)
>    - Track MEMCG_ZSWAP_RAW in obj_cgroup_charge/uncharge_zswap()
>    - Use zswap_is_raw() helper in zswap.c for consistency
> 
> Test
> ----
> 
> I wrote a simple test program[1] that allocates memory and compresses it
> with zstd, so kernel zswap cannot compress further.
> 
>   $ cgcreate -g memory:test
>   $ cgexec -g memory:test ./test_zswpraw &
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 0
>   zswpin 0
>   zswpout 0
>   zswpwb 0
> 
>   $ echo "100M" > /sys/fs/cgroup/test/memory.reclaim
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 104800256
>   zswpin 0
>   zswpout 51222
>   zswpwb 0
> 
>   $ pkill test_zswpraw
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 0
>   zswpin 1
>   zswpout 51222
>   zswpwb 0
> 
> [1] https://gist.github.com/mrpre/00432c6154250326994fbeaf62e0e6f1
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  include/linux/memcontrol.h | 1 +
>  include/linux/zswap.h      | 9 +++++++++
>  mm/memcontrol.c            | 6 ++++++
>  mm/zswap.c                 | 6 +++---
>  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6c82c8f73e1..83d1328f81d1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +	MEMCG_ZSWAP_RAW,

Please change the name as Shakeel suggested.

>  	MEMCG_NR_STAT,
>  };
>  
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 30c193a1207e..94f84b154b71 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,6 +7,15 @@
>  
>  struct lruvec;
>  
> +/*
> + * Check if a zswap entry is stored in raw (uncompressed) form.
> + * This happens when compression doesn't reduce the size.
> + */
> +static inline bool zswap_is_raw(size_t size)

Internall as well, please rename this to zswap_is_incompressible() or
zswap_is_incomp(). Not a big fan of the helper because it doesn't add
much, but I don't feel strongly either way.

> +{
> +	return size == PAGE_SIZE;
> +}
> +
>  extern atomic_long_t zswap_stored_pages;
>  
>  #ifdef CONFIG_ZSWAP
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 007413a53b45..32fb801530a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -341,6 +341,7 @@ static const unsigned int memcg_stat_items[] = {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +	MEMCG_ZSWAP_RAW,
>  };
>  
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[] = {
>  #ifdef CONFIG_ZSWAP
>  	{ "zswap",			MEMCG_ZSWAP_B			},
>  	{ "zswapped",			MEMCG_ZSWAPPED			},
> +	{ "zswpraw",			MEMCG_ZSWAP_RAW			},

Here as well: zswap_incompressible or zswap_incomp?

Other than the renames and doc, LGTM.

>  #endif
>  	{ "file_mapped",		NR_FILE_MAPPED			},
>  	{ "file_dirty",			NR_FILE_DIRTY			},
> @@ -5458,6 +5460,8 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>  	memcg = obj_cgroup_memcg(objcg);
>  	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
>  	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> +	if (zswap_is_raw(size))
> +		mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, 1);
>  	rcu_read_unlock();
>  }
>  
> @@ -5481,6 +5485,8 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
>  	memcg = obj_cgroup_memcg(objcg);
>  	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
>  	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
> +	if (zswap_is_raw(size))
> +		mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, -1);
>  	rcu_read_unlock();
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3d2d59ac3f9c..54ab4d126f64 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -723,7 +723,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>  		obj_cgroup_put(entry->objcg);
>  	}
> -	if (entry->length == PAGE_SIZE)
> +	if (zswap_is_raw(entry->length))
>  		atomic_long_dec(&zswap_stored_incompressible_pages);
>  	zswap_entry_cache_free(entry);
>  	atomic_long_dec(&zswap_stored_pages);
> @@ -941,7 +941,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	zs_obj_read_sg_begin(pool->zs_pool, entry->handle, input, entry->length);
>  
>  	/* zswap entries of length PAGE_SIZE are not compressed. */
> -	if (entry->length == PAGE_SIZE) {
> +	if (zswap_is_raw(entry->length)) {
>  		WARN_ON_ONCE(input->length != PAGE_SIZE);
>  		memcpy_from_sglist(kmap_local_folio(folio, 0), input, 0, PAGE_SIZE);
>  		dlen = PAGE_SIZE;
> @@ -1448,7 +1448,7 @@ static bool zswap_store_page(struct page *page,
>  		obj_cgroup_charge_zswap(objcg, entry->length);
>  	}
>  	atomic_long_inc(&zswap_stored_pages);
> -	if (entry->length == PAGE_SIZE)
> +	if (zswap_is_raw(entry->length))
>  		atomic_long_inc(&zswap_stored_incompressible_pages);
>  
>  	/*
> -- 
> 2.43.0
> 

