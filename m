Return-Path: <cgroups+bounces-3130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583FB900B3B
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CADE1C21261
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095E19B3FF;
	Fri,  7 Jun 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyjAmEG1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C015ACB;
	Fri,  7 Jun 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781211; cv=none; b=WG+WMfkYEHsmF1Yv9mWLpNmb10VT37aGzapkwly9fq/Ss5IuQh7LO7lGezeMysQE6q1haydG4olXilT9aIZy/habhH0B7cptxL/1mi6IrlEQCDwXChQNDWv6iSOfVU4Mo5L1oEgZrQuaIL7KJCwVtZfr+L88/ZaetkjBg3bTLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781211; c=relaxed/simple;
	bh=t4eYmVKvDVi8V4oLcAvYetX8Ejzy2NF60PSbjvVWfKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrtW/R96Y+PvqYd/ycNLte7zUmfCruZDMMItKfLVYeKfDR0f1td8d+0T3YE7g4YTB5w5wfprnS+ThuLAQoNbu2r+WrDQj3obQP8dQBebB70io9VRYeBMH/2Ot2mNRBPpaIHSi9BRHWOKxFIM6zSvK4xZjUg8AaHQDQPkdC9irTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyjAmEG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE8FC2BBFC;
	Fri,  7 Jun 2024 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717781211;
	bh=t4eYmVKvDVi8V4oLcAvYetX8Ejzy2NF60PSbjvVWfKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EyjAmEG1mTlciR+Q3Pcu6rKB451iaUX1ubjjD75vg2cCz5MHYoxTG9ISioIvBP9vu
	 +9gtR0B7cdNs9zCQgLp7Dg/eonIRj075LWtGlj0+4VWRI+TJSoTN84IGAOVcYse93H
	 IiLPbaaqQg3j76996tOqOQe/iow8c1mE6A3NZRap1GBsWlWeQxxtoj4JF1EPWoAk5s
	 STZyiN6tQs/yhJ7cWa01+Hqi3xLTuakIZvDU1H+0xhxjSJZFhwhKtTQJo1nVg9azO5
	 s0CLYSZwBMS7kudRlamI8p64Q/01LBuLRit/MQrid92i7uLtL34SwTDFACJuOLMM4l
	 vdzeOqkD8mquA==
Message-ID: <6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org>
Date: Fri, 7 Jun 2024 19:26:47 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mm: ratelimit stat flush from workingset shrinker
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: stable@vger.kernel.org, yosryahmed@google.com, tj@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 longman@redhat.com, linux-mm@kvack.org, kernel-team@cloudflare.com
References: <171776806121.384105.7980809581420394573.stgit@firesoul>
 <tge6txvuepcu3iy7nz3cuafbd5x2hmeprbaz3d3fzawvvzg3xr@f4utxxs2egxl>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <tge6txvuepcu3iy7nz3cuafbd5x2hmeprbaz3d3fzawvvzg3xr@f4utxxs2egxl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/06/2024 16.32, Shakeel Butt wrote:
> On Fri, Jun 07, 2024 at 03:48:06PM GMT, Jesper Dangaard Brouer wrote:
>> From: Shakeel Butt <shakeelb@google.com>
>>
>> commit d4a5b369ad6d8aae552752ff438dddde653a72ec upstream.
>>
>> One of our workloads (Postgres 14 + sysbench OLTP) regressed on newer
>> upstream kernel and on further investigation, it seems like the cause is
>> the always synchronous rstat flush in the count_shadow_nodes() added by
>> the commit f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical
>> stats").  On further inspection it seems like we don't really need
>> accurate stats in this function as it was already approximating the amount
>> of appropriate shadow entries to keep for maintaining the refault
>> information.  Since there is already 2 sec periodic rstat flush, we don't
>> need exact stats here.  Let's ratelimit the rstat flush in this code path.
>>
>> Link: https://lkml.kernel.org/r/20231228073055.4046430-1-shakeelb@google.com
>> Fixes: f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical stats")
>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Yosry Ahmed <yosryahmed@google.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> ---
>> On production with kernel v6.6 we are observing issues with excessive
>> cgroup rstat flushing due to the extra call to mem_cgroup_flush_stats()
>> in count_shadow_nodes() introduced in commit f82e6bf9bb9b ("mm: memcg:
>> use rstat for non-hierarchical stats") that commit is part of v6.6.
>> We request backport of commit d4a5b369ad6d ("mm: ratelimit stat flush
>> from workingset shrinker") as it have a fixes tag for this commit.
>>
>> IMHO it is worth explaining call path that makes count_shadow_nodes()
>> cause excessive cgroup rstat flushing calls. Function shrink_node()
>> calls mem_cgroup_flush_stats() on its own first, and then invokes
>> shrink_node_memcgs(). Function shrink_node_memcgs() iterates over
>> cgroups via mem_cgroup_iter() for each calling shrink_slab(). The
>> shrink_slab() calls do_shrink_slab() that via shrinker->count_objects()
>> invoke count_shadow_nodes(), and count_shadow_nodes() does
>> a mem_cgroup_flush_stats() call, that seems unnecessary.
>>
> 
> Actually at Meta production we have also replaced
> mem_cgroup_flush_stats() in shrink_node() with
> mem_cgroup_flush_stats_ratelimited() as it was causing too much flushing
> issue. We have not observed any issue after the change. I will propose
> that patch to upstream as well.

(Please Cc me as I'm not subscribed on cgroups@vger.kernel.org)

Yes, we also see mem_cgroup_flush_stats() in shrink_node() cause issues.

So, I can confirm the issue. What we see is that it originates from
kswapd, which have a kthread per NUMA node that runs concurrently...  we
measure cgroup rstat lock contention happening due to call in shrink_node().

See call stacks I captured with bpftrace script[1]:

stack_wait[695, kswapd0, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[696, kswapd1, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[697, kswapd2, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[698, kswapd3, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[699, kswapd4, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[700, kswapd5, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[701, kswapd6, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27
@stack_wait[702, kswapd7, 1]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27

--Jesper


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency.bt


