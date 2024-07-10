Return-Path: <cgroups+bounces-3595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FBB92D184
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A755A1C23BA6
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DE19046D;
	Wed, 10 Jul 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6yyd6Dr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91246848E;
	Wed, 10 Jul 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614292; cv=none; b=FtjoCdsP3LA2Dnumcd78JVKHCPHKUZXKYHG9In462QHw+OltHuuSLmV8/5+v3rw5txPuz25bHc4SjNvibkNipIMepr0TyA41QtsslpmfHnmIiV97USMujF44gsIxABbCl5iEnoylDvRMa9uLFEzbmE5hhv0uDkTAUcvBtAe7uWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614292; c=relaxed/simple;
	bh=Z1iHW0xwjuUolgLlUVZ38XpPOyQpCRbkMMbxly+aDN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s59cH0pLql/mCXo9fce3Fc1a77sTrkltnUx6ID78xXTCW5yiqWnE7Ppu0sIeF1dEpzwbhHHL5UL2EEdAzu6xQhYDkwZ0axM1XfedYuiiTenQYeUWc6YY3IsGHpg6zaY9xST73lBFTsF65IlLhqpAHgUN01y1+MfOGWNmON31dJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6yyd6Dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FEAC32781;
	Wed, 10 Jul 2024 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720614292;
	bh=Z1iHW0xwjuUolgLlUVZ38XpPOyQpCRbkMMbxly+aDN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6yyd6Dr3eH/h9NOEcsOXE6RR+cYQo7q/p6k/uVgKwfpQFUiUqSRej7p9cQYDyEBm
	 5x2AGTV6CNyHRFFr1tTnYRKbvNreLNXXQQ6iOPQI1NzZOBYCJ/ufKeGyY/c63raVRh
	 wNouwbRtyeZugTFv8HGaRhQ+QLbEj1+mSxg3N0NQaSdgPnXukkgf3oODtpRNcznT91
	 hGCgzQQXC5JAGma2bWHmsFtcaXEN+HFDNbIvVtUy70wbd7U6vbb2lezmWfTPP2rm01
	 GubsmqSvmmF66LkP4RW3KiBY9DbmyTnGVKy+Ioug1+t+MSwPNRyuE8UmeNG42d3xOf
	 QqA2I6oFIqQsg==
Message-ID: <22d972e9-4abd-4990-9fc6-828f3300b34b@kernel.org>
Date: Wed, 10 Jul 2024 14:24:48 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172052399087.2357901.4955042377343593447.stgit@firesoul>
 <3oyf3p3xyhxxugucwsuhtuais6547rvzob5fkz3yc7jgocow2n@odqb6l2oweto>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <3oyf3p3xyhxxugucwsuhtuais6547rvzob5fkz3yc7jgocow2n@odqb6l2oweto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/07/2024 01.17, Shakeel Butt wrote:
> On Tue, Jul 09, 2024 at 01:20:48PM GMT, Jesper Dangaard Brouer wrote:
>> Avoid lock contention on the global cgroup rstat lock caused by kswapd
>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
>> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
>> call inlined in shrink_node, which takes the rstat lock.
>>
>> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
>> we noted severe lock contention on the rstat lock. This contention
>> causes 12 CPUs to waste cycles spinning every time kswapd runs.
>> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
>> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
>> due to spinning on the rstat lock.
>>
>> Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
>> causing all kswapdN threads to wake up simultaneously. The kswapd thread
>> invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
>> operation as part of its work. This results in kernel self-induced rstat
>> lock contention by waking up all kswapd threads simultaneously. Leveraging
>> this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
>> cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.
>>
>> To avoid this kind of thundering herd problem, kernel previously had a
>> "stats_flush_ongoing" concept, but this was removed as part of commit
>> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
>> reintroduce and generalized the concept to apply to all users of cgroup
>> rstat, not just memcg.
>>
>> If there is an ongoing rstat flush, and current cgroup is a descendant,
>> then it is unnecessary to do the flush. For callers to still see updated
>> stats, wait for ongoing flusher to complete before returning, but add
>> timeout as stats are already inaccurate given updaters keeps running.
>>
>> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
> 
> Does this version fixes the contention you are observing in production
> for v5?

No conclusions yet, as I'm still waiting for production servers to
reboot into my experimental kernel.

The V5 contention issue is observable via oneliner. That records lock
contention and records the process that observe this:

  sudo bpftrace -e '
        tracepoint:cgroup:cgroup_rstat_lock_contended { @cnt[comm]=count()}
        interval:s:1 {time("%H:%M:%S "); print(@cnt); clear(@cnt);}'

Example output:

11:52:34
11:52:35 @cnt[kswapd4]: 114
@cnt[kswapd5]: 115
11:52:36
11:52:37
11:52:38
11:52:39
11:52:40
11:52:41 @cnt[kswapd2]: 124
@cnt[kswapd1]: 125
@cnt[kswapd7]: 137
@cnt[kswapd0]: 137

As we can see above kswapd processes, that must be flushing root-cgroup
and should be waiting on cgrp_rstat_ongoing_flusher are seeing
lock_contended.  This indicate the race this patch address exists.

For the record without this patch prod server (same HW generation), 
looks like this (so there is a significant improvement):

12:08:59 @cnt[kswapd2]: 565
@cnt[kswapd8]: 574
@cnt[kswapd9]: 575
@cnt[kswapd5]: 576
@cnt[kswapd6]: 577
@cnt[kswapd11]: 577
@cnt[kswapd3]: 578
@cnt[kswapd0]: 578
@cnt[kswapd4]: 688
@cnt[kswapd10]: 758
@cnt[kswapd1]: 768
@cnt[kswapd7]: 875


I'm going to send a V7 patch, because this V6 have an issue with usage 
of tracepoints for trylock scheme, that breaks my bpftrace script[1].

Coding it up now... I'm also adding a tracepoint for the 
cgrp_rstat_ongoing_flusher wait, such that we can measure this. I'm also 
adding a race indicator that can we read from this new tracepoint, as it 
will be helpful to proof/measure if this race is happening, and needed 
to tell the race apart from normal cgroup_rstat_lock_contended case.


--Jesper


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt

