Return-Path: <cgroups+bounces-12796-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB375CE6504
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC44630065BF
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB627FD43;
	Mon, 29 Dec 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ep0ofLr6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80C2798F3
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001432; cv=none; b=ZckPx1Ua2mpaWtDC/PxR78QoaAJbJcr5ZNZf7roXY1Snlpk2DEEEXfUYSqW21zJ1El3hK4t0WafthDSCDuKDWmwB0o4Ltj0mEafXPCQN8AP/P3tV6wF0/BNVGOMnvJEbewfoE+Rq/QBMXlqlXmlr5qXk54ATBb9F+TWzK7CnMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001432; c=relaxed/simple;
	bh=BT4es7CHNbiqj/hBoyqhuJZ0er5JEKnWt2OS0n0lo9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+Er7b3aGqnMDRGpTLQWwEz+2tVS+hGj5Zb2bbwa5F/Ai8B+uNbX4tE2eQZgkAG3FCg+/GyZEXjt6NKPxiYlrIQ0CsySadnKWVR0/3ihLJ/io3P0G1dMs47xt3sECODionUID0glu95GK8Ik5SmGsl3N4MAUzOL1+fGp/uPvFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ep0ofLr6; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <63c958ae-9db2-4da8-935b-a596cc8535d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767001414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/8bkRxwLhm3ndKDh76WkE4jKqSh3LbyQvzuDAbsOlM=;
	b=ep0ofLr6pd8c8v1hSU8uzSTuUae86JeEgrGad/Usy5m+TaFg9AbILVCgricA9EQxhQztga
	hnQK8UO1IlUNKQigYM9mPWcp7oIRwo86HGXTdSPTzKWPSEfCWpPZhFFbey5eRatOTRc/xO
	nucjZrAolKE9xzD+8R8JxFysEuAPNxM=
Date: Mon, 29 Dec 2025 17:42:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
 <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
 <llwoiz4k5l44z2dyo6oubcflfarhep654cr5tvcrnkltbw4eni@kxywzukbgyha>
 <wvj4w7ifmrifnh5bvftdziudsj52fdnwlhbt2oifwmxmi4eore@ob3mrfahhnm5>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <wvj4w7ifmrifnh5bvftdziudsj52fdnwlhbt2oifwmxmi4eore@ob3mrfahhnm5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/24/25 8:58 AM, Shakeel Butt wrote:
> On Wed, Dec 24, 2025 at 12:43:00AM +0000, Yosry Ahmed wrote:
> [...]
>>>
>>> I think you meant child's memcg here.
>>
>> Yes, sorry.
>>
>>>
>>>> before
>>>> reparenting, and using it to update the stats after reparenting? A grace
>>>> period only works if the entire scope of using the memcg is within the
>>>> RCU critical section.
>>>
>>> Yeah this is an issue.
>>>
>>>>
>>>> For example, __mem_cgroup_try_charge_swap() currently does this when
>>>> incrementing MEMCG_SWAP. While this specific example isn't problematic
>>>> because the reference won't be dropped until MEMCG_SWAP is decremented
>>>> again, the pattern of grabbing a ref to the memcg then updating a stat
>>>> could generally cause the problem.
>>>>
>>>> Most stats are updated using lruvec_stat_mod_folio(), which updates the
>>>> stats in the same RCU critical section as obtaining the memcg pointer
>>>> from the folio, so it can be fixed with a grace period. However, I think
>>>> it can be easily missed in the future if other code paths update memcg
>>>> stats in a different way. We should try to enforce that stat updates
>>>> cannot only happen from the same RCU critical section where the memcg
>>>> pointer is acquired.
>>>
>>> The core stats update functions are mod_memcg_state() and
>>> mod_memcg_lruvec_state(). If for v1 only, we add additional check for
>>> CSS_DYING and go to parent if CSS_DYING is set then shouldn't we avoid
>>> this issue?
>>
>> But this is still racy, right? The cgroup could become dying right after
>> we check CSS_DYING, no?
> 
> We do reparenting in css_offline() callback and cgroup offlining
> happen somewhat like this:
> 
> 1. Set CSS_DYING
> 2. Trigger percpu ref kill
> 3. Kernel makes sure css ref killed is seen by all CPUs and then trigger
>     css_offline callback.

it seems that we can add the following to
mem_cgroup_css_free():

parent->vmstats->state_local += child->vmstats->state_local;

Right? I will continue to take a closer look.

Thanks,
Qi

> 
> So, if in the stats update function we check CSS_DYING flag and the
> actual stats update within rcu, I think we are good.


