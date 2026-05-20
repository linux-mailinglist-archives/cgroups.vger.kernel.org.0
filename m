Return-Path: <cgroups+bounces-16118-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMhTCiNiDWquwgUAu9opvQ
	(envelope-from <cgroups+bounces-16118-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:26:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D7588EDB
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6ED33059F9A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D99367B99;
	Wed, 20 May 2026 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XemDWMXv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7593537C7;
	Wed, 20 May 2026 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261942; cv=none; b=S+EBmAJLXNwb9SOM+EW3GOrgOydeRlSHXmzK/s09d+iEO2NuMzslZ/rMbMcDNpV1DypiF/7aiechW6BZqIn60ZrEXs8CJZWIc3+UFfpG6i5bTwHBpFTXglbU2nspx6Nszi1NVYQOOb4Ddk4FYdYLQA4H5npAmLnY9F5xekHGYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261942; c=relaxed/simple;
	bh=IKekUUC9iK0RkUsRYaDXwZOyLabo8lJEQMFCNywYvmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+Ptz/WBAbsTZckYnCMzfRQwBcalaRO7OrF68g0jbTVLmduzdN1PEhjZK/PYRV6dng+AoLNdeRieqdkCROdzFzue7lQfGWomzlz/tLRAIm+YtJ8ha8wuYJN0KsMJsM5cdo4ULvMVqwu0wOI1YCyA6lPrfhyqApMFZNR9of7tsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XemDWMXv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837541F00893;
	Wed, 20 May 2026 07:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779261941;
	bh=tDyqx151XYnh6CsWtMJuKL4bIM/vvrXsshPFIbTLDeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XemDWMXvAe0034jVFdHdnVxPz48ky+mESd2t2m7ebd9U8QHmdqkl914Mz7ddp5Qsm
	 bvdR6/Mh/QiRiFJ/kFM9mGAOz+ePgDbunbAoG6pLWDxURzAirzkWTFpho8Rf/K50Mw
	 KPjSqE4Xff7pmcJpEbEja/NxKmfTTz9H5SrqiYcjXuES/NmUIl71FYc01SeSKLQYIr
	 mRJBK1HJjdcuWA/RhdGQieC3sBxFp1IhrYkAlLFimJykGgnujVpBjcPFPhJ10Ec4z8
	 5oqVrGmdqnc/13c9zehqWH9A/9KUh2KXWs0FXYzRD0JBBk4hhpR/XxXh0eRwJDruip
	 VzKXa5e06RF0Q==
Message-ID: <dd058c86-35b7-4b95-a8ab-cb2f28237b6c@kernel.org>
Date: Wed, 20 May 2026 16:25:37 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] memcg: int16_t for cached slab stats
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-4-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260520053123.2709959-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16118-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D9D7588EDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 2:31 PM, Shakeel Butt wrote:
> Currently struct obj_stock_pcp stores cached slab stats in 'int' which
> is 4 bytes per counter on 64-bit machines. Switch them to int16_t to
> shrink the cached metadata.
> 
> The existing PAGE_SIZE flush in __account_obj_stock() bounds *bytes at
> PAGE_SIZE on 4KiB and 16KiB page archs, well within int16_t. On 64KiB
> pages PAGE_SIZE is well above S16_MAX so that flush never fires, and a
> sufficiently long run of accumulations would overflow the cache. Add
> an explicit S16_MAX guard before each add: when the next add would
> push abs(*bytes) past S16_MAX, fold the cached value into @nr and
> flush directly via mod_objcg_mlstate() before the accumulation.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---

So arches with 64KiB sizes won't benefit from

"Even for large object >= PAGE_SIZE, the vmstat data will still be 
cached locally at least once before pushing it out" case.

But its benefit is questionable (to me), might be ok.

>   mm/memcontrol.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b3d63d9f267c..1ed27fd06850 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3158,7 +3158,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
>   				struct obj_stock_pcp *stock, int nr,
>   				struct pglist_data *pgdat, enum node_stat_item idx)
>   {
> -	int *bytes;
> +	int16_t *bytes;
>   
>   	/*
>   	 * Though at the moment MAX_NUMNODES <= 1024 in all archs but let's make
> @@ -3195,6 +3195,16 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
>   
>   	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
>   					       : &stock->nr_slab_unreclaimable_b;
> +	/*
> +	 * To avoid overflow or underflow, flush directly if accumulating @nr
> +	 * would push the cached value past S16_MAX.
> +	 */
> +	if (abs(nr + *bytes) >= S16_MAX) {
nit: should be > S16_MAX?

> +		nr += *bytes;
> +		*bytes = 0;
> +		goto direct;
> +	}
> +
>   	/*
>   	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
>   	 * cached locally at least once before pushing it out.

FWIW:
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon


