Return-Path: <cgroups+bounces-2582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EF8A980B
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BA1F22428
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31415E1FC;
	Thu, 18 Apr 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6ip7dtK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4B15E1E4;
	Thu, 18 Apr 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438035; cv=none; b=kwjDyDK6D3W1HNPKD7DtsljEDbF8ups+0LLPOQKbwZuIsvWH2YxtT6VQbJfbMSZLDOHbj2rRbkXAsdQhQCIRHa6Hda/3jmDXswXxrWWvqetbtoF1vjRIWFOstWWC+xjIiREs4PvCFcItOpHLN9uUAS76X6+2MDxsIHAIFBPGB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438035; c=relaxed/simple;
	bh=4h5v9OO81NjzQxlsyJ2cFIRM5mqx39CLg3+LcKvwFH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk13x7VYa3ZQRXEnb344FJvqDxkq3uzjBluE2T6edGtYb3xoRCXOWuAscCZeJeDC6zd4tZWfgUSD+EHxglJf/D/WyBmpwBYo2r6zCweDaAw+gbBQcHRirZflKxaeVt6XDZxvZr3HGXVMz2a8Lb6ySz3FzsHaAKnXXE8eYyRU4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6ip7dtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BAAC32781;
	Thu, 18 Apr 2024 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713438034;
	bh=4h5v9OO81NjzQxlsyJ2cFIRM5mqx39CLg3+LcKvwFH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z6ip7dtK3MN/InqrV8vpt64q9inPO3FDln1IFe6XpUyoi0Uq9ItKx/iDVjvrEDfd6
	 LBrwNEoqeeWPKyA4NxkspkErOnWCdxcUuGYH+/J/MJijm1z7/bvqnNbPfQUa9koyRT
	 H/fVvLAgcxQUr6pzTUF3augzLjqBBuPPLWRK+9Q657atEjkKrqrUPnfbxpSxKG0r4M
	 r/iNJbiR28UnytvFu1xbZsvKjgIMSpCyPKh6P3SKjZBTHtbmEvDBbWVjpsis9PYrNO
	 jOGOuhRpMHJoQuzGPcaINNFD6+jNlv6hyPHQRzlJYsq3MZVzqYo1kdQ+s1BgFqvVlw
	 IudtuDtr/YBOg==
Message-ID: <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
Date: Thu, 18 Apr 2024 13:00:30 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/04/2024 04.21, Yosry Ahmed wrote:
> On Tue, Apr 16, 2024 at 10:51 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>> This patch aims to reduce userspace-triggered pressure on the global
>> cgroup_rstat_lock by introducing a mechanism to limit how often reading
>> stat files causes cgroup rstat flushing.
>>
>> In the memory cgroup subsystem, memcg_vmstats_needs_flush() combined with
>> mem_cgroup_flush_stats_ratelimited() already limits pressure on the
>> global lock (cgroup_rstat_lock). As a result, reading memory-related stat
>> files (such as memory.stat, memory.numa_stat, zswap.current) is already
>> a less userspace-triggerable issue.
>>
>> However, other userspace users of cgroup_rstat_flush(), such as when
>> reading io.stat (blk-cgroup.c) and cpu.stat, lack a similar system to
>> limit pressure on the global lock. Furthermore, userspace can easily
>> trigger this issue by reading those stat files.
>>
>> Typically, normal userspace stats tools (e.g., cadvisor, nomad, systemd)
>> spawn threads that read io.stat, cpu.stat, and memory.stat (even from the
>> same cgroup) without realizing that on the kernel side, they share the
>> same global lock. This limitation also helps prevent malicious userspace
>> applications from harming the kernel by reading these stat files in a
>> tight loop.
>>
>> To address this, the patch introduces cgroup_rstat_flush_ratelimited(),
>> similar to memcg's mem_cgroup_flush_stats_ratelimited().
>>
>> Flushing occurs per cgroup (even though the lock remains global) a
>> variable named rstat_flush_last_time is introduced to track when a given
>> cgroup was last flushed. This variable, which contains the jiffies of the
>> flush, shares properties and a cache line with rstat_flush_next and is
>> updated simultaneously.
>>
>> For cpu.stat, we need to acquire the lock (via cgroup_rstat_flush_hold)
>> because other data is read under the lock, but we skip the expensive
>> flushing if it occurred recently.
>>
>> Regarding io.stat, there is an opportunity outside the lock to skip the
>> flush, but inside the lock, we must recheck to handle races.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> As I mentioned in another thread, I really don't like time-based
> rate-limiting [1]. Would it be possible to generalize the
> magnitude-based rate-limiting instead? Have something like
> memcg_vmstats_needs_flush() in the core rstat code?
> 

I've taken a closer look at memcg_vmstats_needs_flush(). And I'm
concerned about overhead maintaining the stats (that is used as a filter).

   static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
   {
	return atomic64_read(&vmstats->stats_updates) >
		MEMCG_CHARGE_BATCH * num_online_cpus();
   }

I looked at `vmstats->stats_updates` to see how often this is getting 
updated.  It is updated in memcg_rstat_updated(), but it gets inlined 
into a number function (__mod_memcg_state, __mod_memcg_lruvec_state, 
__count_memcg_events), plus it calls cgroup_rstat_updated().
Counting invocations per sec (via funccount):

   10:28:09
   FUNC                                    COUNT
   __mod_memcg_state                      377553
   __count_memcg_events                   393078
   __mod_memcg_lruvec_state              1229673
   cgroup_rstat_updated                  2632389


I'm surprised to see how many time per sec this is getting invoked.
Originating from memcg_rstat_updated() = 2,000,304 times per sec.
(On a 128 CPU core machine with 39% idle CPU-load.)
Maintaining these stats seems excessive...

Then how often does the filter lower pressure on lock:

   MEMCG_CHARGE_BATCH(64) * 128 CPU = 8192
   2000304/(64*128) = 244 time per sec (every ~4ms)
   (assuming memcg_rstat_updated val=1)


> Also, why do we keep the memcg time rate-limiting with this patch? Is
> it because we use a much larger window there (2s)? Having two layers
> of time-based rate-limiting is not ideal imo.
>

I'm also not-a-fan of having two layer of time-based rate-limiting, but 
they do operate a different time scales *and* are not active at the same 
time with current patch, if you noticed the details, then I excluded 
memcg from using this as I commented "memcg have own ratelimit layer" 
(in do_flush_stats).

I would prefer removing the memcg time rate-limiting and use this more 
granular 50ms (20 timer/sec) for memcg also.  And I was planning to do 
that in a followup patchset.  The 50ms (20 timer/sec) limit will be per 
cgroup in the system, which then "scales"/increase with the number of 
cgroups, but better than unbounded read/access locks per sec.

--Jesper


> [1]https://lore.kernel.org/lkml/CAJD7tkYnSRwJTpXxSnGgo-i3-OdD7cdT-e3_S_yf7dSknPoRKw@mail.gmail.com/


sudo ./bcc/tools/funccount -Ti 1 -d 10 
'__mod_memcg_state|__mod_memcg_lruvec_state|__count_memcg_events|cgroup_rstat_updated'

