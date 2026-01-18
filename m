Return-Path: <cgroups+bounces-13294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E1D39204
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 798813004EE1
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322DA1A9F93;
	Sun, 18 Jan 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6nSKZRg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612B11CA0
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768698694; cv=none; b=OgnlIj9nVXf+EHEekWzWcL6I+iK44iwXaS1nPsyKNPh6hBDaBPXuikbdc3zgB960sDQQaseUt5PpedGvhNcumjYowpbuDUKaNK9rWJKs5bk7DUDpHXAG+xKy6r9E8K63qRP1Mkl+8cH8a4fw20uXWTr1zjCa1JNdjaGoHBJc54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768698694; c=relaxed/simple;
	bh=6sqPSndnVEd4Wilq65Rtd6oebsHuE6sNVu6GfzfhDo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f470jFUzbT0j8KJ38x8ndFTO9AxeJ9O0V2oMWs/lsWR5YOsspTTTkU55F1uBQVOQlABDngQYunVnFbEu1NPEmtwK+AY+dc/fbsBax54gh4JKkCW/XQka2lV/5BYpRLM3alJ1CCAinPhASxp1dVuT8uDkqMv50AoMdaGUu50bpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6nSKZRg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 17:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768698689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ATfR8YVfkNshr8Vx8DFRMyrKCT4h6769biGe+QbhD4=;
	b=T6nSKZRgsQPtxFgBqXC5bItj4lyNJ6HaG8OAWffciX4Ho1toEGdb4pGd8lQ9qIAc18nVHY
	ki68L61BtU6+eidPp48tqIMZWerfeArj4OlgCw2swLxkcPE+EHexrF8DSg2dB9WoPnL2D0
	z7Jwu0CtzQ8wvuewBLyo0zl5htN14bY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 25/30] mm: vmscan: prepare for reparenting traditional
 LRU folios
Message-ID: <6hlbucao3tfp2bxyaekcrvhqclji4hyhq4wen4sccc2qcdr6x2@rtmqrfwfsy4s>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <3adb367000706f9ef681b34d0a2b0eb34c494c84.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adb367000706f9ef681b34d0a2b0eb34c494c84.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:52PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
[...]
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1090,6 +1090,43 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
>  	fbatch->nr = j;
>  }
>  

Why not define the following two functions in memcontrol.c?

> +#ifdef CONFIG_MEMCG
> +static void lruvec_reparent_lru(struct lruvec *child_lruvec,
> +				struct lruvec *parent_lruvec,
> +				enum lru_list lru, int nid)
> +{
> +	int zid;
> +	struct zone *zone;
> +
> +	if (lru != LRU_UNEVICTABLE)
> +		list_splice_tail_init(&child_lruvec->lists[lru], &parent_lruvec->lists[lru]);
> +
> +	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
> +		unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
> +
> +		mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
> +	}
> +}
> +
> +void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		enum lru_list lru;
> +		struct lruvec *child_lruvec, *parent_lruvec;
> +
> +		child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> +		parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
> +		parent_lruvec->anon_cost += child_lruvec->anon_cost;
> +		parent_lruvec->file_cost += child_lruvec->file_cost;
> +
> +		for_each_lru(lru)
> +			lruvec_reparent_lru(child_lruvec, parent_lruvec, lru, nid);
> +	}
> +}
> +#endif
> +



