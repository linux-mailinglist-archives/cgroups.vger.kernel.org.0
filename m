Return-Path: <cgroups+bounces-13743-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEiHJqIGhmkRJQQAu9opvQ
	(envelope-from <cgroups+bounces-13743-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 16:20:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EEFFA82
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 16:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2704C3007BB0
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB73A0B05;
	Fri,  6 Feb 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aywzXuhD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF32874FA
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391197; cv=none; b=EQqKSbPLfBUvwCBt40dMbhSqgDYoSWBTZHANZGv3Any67GjKEmrIthJ6YQx2sZc0mWA8wDV026hh5M9WsEezRTwVnxS+3dcyDeJ3Bs2DzmVl9n2RC0cUJxCcmrzT1AXD0zT6et8dyil3KalGHYGtL9z8f7lZxHWCcY+6aUTC75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391197; c=relaxed/simple;
	bh=AnolthdRwrDB3AfcOEmQl+aamqXR8J3J5EqMAqspUdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGg0gr/RcePopnSisy5jEIb4g/jHByAcUl9oHL+VcIuy0IDu/AC1SguYS0hfKTdHPn0Cd4pwyfGuyDt4dfV7oGSYWr8Eh3/XEEI1W9RP9DIJj8MVcyZenvmF/2eWMlurGbt72HaOqSJnGabunWyPJ1P1NLMyNzS+QWWeaXoR14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aywzXuhD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Feb 2026 15:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770391184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChC6m5WfVroGjS9ENqi35nDBudi2mtW1bc10jN5JpMM=;
	b=aywzXuhD3aIRl8d7DfaV1A4HZXwVjqvlCIQ3oXkRUMWqETv6Fnc28cJp0x4vYuQGoNZP7+
	COR3c6t8nqalS9d43VhLxDSGTWIjGkRXjKp/Wy5GOwnvvY+KVi+1+6FwRnBLRWb+V351o4
	FPmWoT/JsuNl2LGBhfueWqgH+YiY3nM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Nhat Pham <nphamcs@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: zswap: add per-memcg stat for incompressible
 pages
Message-ID: <iphymajz5xn6cbntby7z5s3eioraigs4doqylijoljfhzrexup@f23vxl2deyfr>
References: <20260206072220.144008-1-jiayuan.chen@linux.dev>
 <20260206072220.144008-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206072220.144008-2-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13743-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kvack.org,shopee.com,gmail.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linux.dev,linux-foundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,shopee.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 359EEFFA82
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:22:15PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> The global zswap_stored_incompressible_pages counter was added in commit
> dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is")
> to track how many pages are stored in raw (uncompressed) form in zswap.
> However, in containerized environments, knowing which cgroup is
> contributing incompressible pages is essential for effective resource
> management [1].
> 
> Add a new memcg stat 'zswap_incomp' to track incompressible pages per
> cgroup. This helps administrators and orchestrators to:
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
> mixed with highly compressible ones". The zswap_incomp stat provides
> direct visibility into the latter case.
> 
> [1]: https://lore.kernel.org/linux-mm/CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com/
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 5 +++++
>  include/linux/memcontrol.h              | 1 +
>  mm/memcontrol.c                         | 8 ++++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 7f5b59d95fce..78a329414615 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1737,6 +1737,11 @@ The following nested keys are defined.
>  	  zswpwb
>  		Number of pages written from zswap to swap.
>  
> +	  zswap_incomp
> +		Number of incompressible pages currently stored in zswap
> +		without compression. These pages could not be compressed to
> +		a size smaller than PAGE_SIZE, so they are stored as-is.
> +
>  	  thp_fault_alloc (npn)
>  		Number of transparent hugepages which were allocated to satisfy
>  		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6c82c8f73e1..d8ec05dd5d43 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +	MEMCG_ZSWAP_INCOMP,
>  	MEMCG_NR_STAT,
>  };
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 007413a53b45..a6b6cf5f1aeb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -341,6 +341,7 @@ static const unsigned int memcg_stat_items[] = {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +	MEMCG_ZSWAP_INCOMP,
>  };
>  
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[] = {
>  #ifdef CONFIG_ZSWAP
>  	{ "zswap",			MEMCG_ZSWAP_B			},
>  	{ "zswapped",			MEMCG_ZSWAPPED			},
> +	{ "zswap_incomp",		MEMCG_ZSWAP_INCOMP		},
>  #endif
>  	{ "file_mapped",		NR_FILE_MAPPED			},
>  	{ "file_dirty",			NR_FILE_DIRTY			},
> @@ -5458,6 +5460,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>  	memcg = obj_cgroup_memcg(objcg);
>  	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
>  	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> +	/* size == PAGE_SIZE means compression failed, page is incompressible */

I think the comment is not very useful, but maybe not worth sending a
new version. Otherwise LGTM:

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> +	if (size == PAGE_SIZE)
> +		mod_memcg_state(memcg, MEMCG_ZSWAP_INCOMP, 1);
>  	rcu_read_unlock();
>  }
>  
> @@ -5481,6 +5486,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
>  	memcg = obj_cgroup_memcg(objcg);
>  	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
>  	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
> +	/* size == PAGE_SIZE means compression failed, page is incompressible */
> +	if (size == PAGE_SIZE)
> +		mod_memcg_state(memcg, MEMCG_ZSWAP_INCOMP, -1);
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.43.0
> 

