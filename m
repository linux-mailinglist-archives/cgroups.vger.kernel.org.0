Return-Path: <cgroups+bounces-12568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B3CD4AB8
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21018300795E
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6343254B0;
	Mon, 22 Dec 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5bED2PI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E182FFFB7
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375733; cv=none; b=EsrZvgnVst0S+YOflYbCmL5qdlXt4ri4Ljrx2mP6ctdRPFln1/wClIIaopXDaQy5IYpF/kLliA77myvLBiN8TZKai6KzR25voYsvSlzh37pRw4ZCFvPkbmk4cM7FRJj+l8+Mw4lQ/0cyrqGmD7+Ydr+FFMAcm3dw5AdIyXZdei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375733; c=relaxed/simple;
	bh=nnyyMxSWT32A67WXcmIC2RNVzPXhPhejgXkyfW5jcHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9yjONvJwzFiTG6NFQAtF7oCTFodGl8/56Z4ZXHpgdep1c8LtruWlf9Ez6JSJc94a/ZIq8NZXNdPmNKyZ+SXLxPWePMdBBqlHXL4I17l3VvznynpN0cTMiQzDSV63mPctwGuWgYXNM4/BAEEuUeQZ+IV0vLrAoxxx9+lMyEwq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5bED2PI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00f47523-e458-4e9e-8354-1c33bf0591b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766375715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xqiag8fioZOe9NX9oHRHaDgP//h6CBY1O8QvNdZ/XU=;
	b=Y5bED2PIdjRswHhz5ri86a3xuzcsAPrgnCBsf4HQ2FgRrsukkrTd76VX+FYh4x8wwvB3mB
	Fp0g52FAQ4i9IXYKS3Wfsv3Z/gRuJqfBuAroC+gLllj/yblELd8z0vYQDuJxl3RR9vHMIb
	vIkXAJSjU0i86jfI3sXnHuPHndBX8mM=
Date: Mon, 22 Dec 2025 11:55:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 24/28] mm: vmscan: prepare for reparenting traditional
 LRU folios
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <800faf905149ee1e1699d9fd319842550d343f43.1765956026.git.zhengqi.arch@bytedance.com>
 <aUQCfdnoLQDLoVyg@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUQCfdnoLQDLoVyg@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 9:32 PM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:48PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> To reslove the dying memcg issue, we need to reparent LRU folios of child
> 
>       resolve

Got it.

> 
>> memcg to its parent memcg. For traditional LRU list, each lruvec of every
>> memcg comprises four LRU lists. Due to the symmetry of the LRU lists, it
>> is feasible to transfer the LRU lists from a memcg to its parent memcg
>> during the reparenting process.
>>
>> This commit implements the specific function, which will be used during
>> the reparenting process.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Overall looks sane to me. I have a few nits below, not nothing
> major. With those resolved, please feel free to add
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

> 
>> @@ -2648,6 +2648,44 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
>>   			  lruvec_memcg(lruvec));
>>   }
>>   
>> +#ifdef CONFIG_MEMCG
>> +static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
>> +				enum lru_list lru)
>> +{
>> +	int zid;
>> +	struct mem_cgroup_per_node *mz_src, *mz_dst;
>> +
>> +	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
>> +	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
>> +
>> +	if (lru != LRU_UNEVICTABLE)
>> +		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
>> +
>> +	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>> +		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
>> +		mz_src->lru_zone_size[zid][lru] = 0;
>> +	}
>> +}
>> +
>> +void lru_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
> 
> I can see why you want to pass both src and dst for convenience, but
> it makes the API look a lot more generic than it is. It can only
> safely move LRUs from a cgroup to its parent.
> 
> As such, I'd slightly prefer only passing one pointer and doing the
> parent lookup internally. It's dealer's choice.

Make sense, will do.

> 
> However, if you'd like to keep both pointers for a centralized lookup,
> can you please rename the parameters @child and @parent, and add
> 
> 	VM_WARN_ON(parent != parent_mem_cgroup(child));
> 
> Also please add a comment explaining the expected caller locking.

OK.

> 
> Lastly, vmscan.c is the reclaim policy. Mechanical LRU shuffling like
> this is better placed in mm/swap.c.

OK, will move it to mm/swap.c.



