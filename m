Return-Path: <cgroups+bounces-16389-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM9OAINFGGr5iAgAu9opvQ
	(envelope-from <cgroups+bounces-16389-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 15:39:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A725F2DCF
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464C6306296A
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFF3F20F4;
	Thu, 28 May 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MiU8TddY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D073AF677
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975153; cv=none; b=hIMv5sDkaZcDTKzDallrvSZuk5xc8an17Sk39mGIMY+X6NOTqI7C9Ib92F5rno1GI5hnN/o3FCGkF4c2NLIwNN1/QmJrVu0IX5ssjCSHH1kUf0PIaiqqZUq1TD7EYpgP2KRY3b+UmG7rX76PQRGpCKrD2ECH0x9fjNgthPHXrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975153; c=relaxed/simple;
	bh=boO5Pr7r8Ns7RLP2Bda22en1ccII9rcdpLXY3jloMBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzzbP6zGM3nAQZzdU5VJlO7GMtJgl/oAx45dIUjxJ0W3nGYx3/v0G6PLET74GSG88j3pWHVo/oaZColHDiAdH1oJ0zEou1P5XcmmAWDV+u4zGLZ/HVoWfZsUHBgwKapwE/t0b5d3H0fhLNqbX+CfHrJ5uvbRvsKhAj5PwlAraBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MiU8TddY; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f9c78b2-3846-4f75-bcc2-41bf91230513@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779975139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mK9p/d9INJUnJjRfPuNzLbC2SvilH/rgU+fuHkGUigQ=;
	b=MiU8TddYjqp0YAIW6vK65c2gTNAqz6sba9wwiZPfAp0DNVaVGgf9vBqL8/Y/aF1QY2Lx+v
	8i1v6Fs9OZ23Ha/H4jwGv+TCwXEvZj2aH13jAB4kcNqFRP5eBwWIwo9OXgpL+ZBSpnFDkH
	TE+tfrF66VN9lUdQeM2jyamvTO5NLDI=
Date: Thu, 28 May 2026 14:32:06 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Dave Chinner <david@fromorbit.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Zi Yan <ziy@nvidia.com>, "Liam R . Howlett" <liam@infradead.org>,
 Kiryl Shutsemau <kas@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Kairui Song <ryncsn@gmail.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-10-hannes@cmpxchg.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260527204757.2544958-10-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16389-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 54A725F2DCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 21:45, Johannes Weiner wrote:
> The deferred split queue handles cgroups in a suboptimal fashion. The
> queue is per-NUMA node or per-cgroup, not the intersection. That means
> on a cgrouped system, a node-restricted allocation entering reclaim
> can end up splitting large pages on other nodes:
> 
>         alloc/unmap
>           deferred_split_folio()
>             list_add_tail(memcg->split_queue)
>             set_shrinker_bit(memcg, node, deferred_shrinker_id)
> 
>         for_each_zone_zonelist_nodemask(restricted_nodes)
>           mem_cgroup_iter()
>             shrink_slab(node, memcg)
>               shrink_slab_memcg(node, memcg)
>                 if test_shrinker_bit(memcg, node, deferred_shrinker_id)
>                   deferred_split_scan()
>                     walks memcg->split_queue
> 
> The shrinker bit adds an imperfect guard rail. As soon as the cgroup
> has a single large page on the node of interest, all large pages owned
> by that memcg, including those on other nodes, will be split.
> 
> list_lru properly sets up per-node, per-cgroup lists. As a bonus, it
> streamlines a lot of the list operations and reclaim walks. It's used
> widely by other major shrinkers already. Convert the deferred split
> queue as well.
> 
> The list_lru per-memcg heads are instantiated on demand when the first
> object of interest is allocated for a cgroup, by calling
> folio_memcg_alloc_deferred(). Add calls to where splittable pages are
> created: anon faults, swapin faults, khugepaged collapse.
> 
> These calls create all possible node heads for the cgroup at once, so
> the migration code (between nodes) doesn't need any special care.
> 
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/huge_mm.h    |   7 +-
>  include/linux/memcontrol.h |   4 -
>  include/linux/mmzone.h     |  12 --
>  mm/huge_memory.c           | 364 +++++++++++++------------------------
>  mm/internal.h              |   2 +-
>  mm/khugepaged.c            |   5 +
>  mm/memcontrol.c            |  12 +-
>  mm/memory.c                |   4 +
>  mm/mm_init.c               |  15 --
>  mm/swap_state.c            |  10 +
>  10 files changed, 150 insertions(+), 285 deletions(-)
> 

[...]

> diff --git a/mm/memory.c b/mm/memory.c
> index 135f5c0f57bd..f22e61d8c8de 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5222,6 +5222,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  			folio_put(folio);
>  			goto next;
>  		}
> +		if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> +			folio_put(folio);

Ah sorry, should have caught this in the previous version, do we need

count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);

here?

or maybe we just goto next instead of goto fallback and trty next
viable order?


> +			goto fallback;
> +		}
>  		folio_throttle_swaprate(folio, gfp);
>  		/*
>  		 * When a folio is not zeroed during allocation

