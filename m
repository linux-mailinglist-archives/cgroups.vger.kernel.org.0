Return-Path: <cgroups+bounces-3744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E241A93421D
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674EB1F23F93
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9201822D7;
	Wed, 17 Jul 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szdAXjv5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2E12E75;
	Wed, 17 Jul 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240248; cv=none; b=J24ugkzAc+KZOcR95AXl77FJQU6/H6Eo5O16twceWTGZQtiBnJ1W5dXD9GxWi40T8DEvML+s/+BzNvDJYiHJu2V8E3MpFh/O/F8Z8euIf07goJztzNo4y7ps87UvB0WXnzzlwnvJjGwmUIo3+0EdV0iPVOQi9WFzy0QrgVVV5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240248; c=relaxed/simple;
	bh=ZTFSFHVa74Qpc7Lg00HJshhlsORnGgG76Sgsi+XBF78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYZFYpX1RnzV+lVmBk3qyx7RkKEbvbs2TAjdnO6QXVvbL8rPivOrsO387HD/sI7vOaxwnPnzhjdrGuXLh1ecfBf8mWMH1qZ/CWCK6h/EqJ2QLbaWy4rHJvCHZGTSjtZ/Lv/BnZl7lfpcFGxq89vsPOLLOsk7visV1p/JFHl6NCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szdAXjv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5196C2BD10;
	Wed, 17 Jul 2024 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721240247;
	bh=ZTFSFHVa74Qpc7Lg00HJshhlsORnGgG76Sgsi+XBF78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=szdAXjv5fi/i4DOHqlamwvDCUeeYqWNv2lr0erw8xN1ES+6O7+BY4Jy312QA9wC8M
	 rS/cHl2Iankb2bEA3PoMV1pw3Y50rQx+xY3vShXy1MXMzf7HWWa/Jk7lRxo/kHUqu9
	 YXJ4BZ5ib7alkGQOkAy3tJ8MM0RT7/XuFgn1RD9fzJw4W5LHZdyUjp46gxEqakDB6X
	 1BO9QuSC/pBg6Jj/rZCAVyjp2dFQylOmfmbR3dqQ7AGoDS6Rg2Squrjfbi97ibdRYJ
	 Yzb9aOt4wYitqBxXM5HW5VyDyfcmYu+i//yVTHnrFbGkBhX+NA9UhByxliqkMtAXLr
	 YmiocExl4N7UA==
Message-ID: <de05ebf2-2baa-493e-a6a8-acf43702824b@kernel.org>
Date: Wed, 17 Jul 2024 20:17:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
 <8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org>
 <CAJD7tkbFPt-eTHkqtLxuOoV59eaqauodz008btEECT--x3VcBA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkbFPt-eTHkqtLxuOoV59eaqauodz008btEECT--x3VcBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 18.31, Yosry Ahmed wrote:
> [..]
>>
>> I agree that description should be updated as patch have evolved, and
>> you suggestions make sense, thanks.
>>
>> But I'm not sure we are finished evolving this patch, because the scheme
>> of allowing all sub-cgroups to become the ongoing flusher (and only
>> avoiding lock-spinning when cgroup_is_descendant), is causing issues in
>> production.
> 
> Sure, I just wanted to point out the the commit log should be updated
> going forward, not implying that we are done here :)
> 
>>
>> We are using cadvisor in production for collecting metrics, which walks
>> all the cgroups reading stat files e.g. io.stat, cpu.stat , memory.stat
>> (doing 3 flushes of same cgroup in short timespan), but individual
>> cgroups don't overlap much to benefit from ongoing_flusher scheme.
>>
>> Below is (1 sec) production data, where cadvisor and kswapd collide:
>>
>>   > 02:01:33 @ongoing_flusher_cnt[kworker/u395:14]: 1
>>   > @ongoing_flusher_cnt[kswapd5]: 3
>>   > @ongoing_flusher_cnt[kswapd7]: 4
>>   > @ongoing_flusher_cnt[kswapd6]: 4
>>   > @ongoing_flusher_cnt[kswapd8]: 4
>>   > @ongoing_flusher_cnt[kswapd9]: 5
>>   > @ongoing_flusher_cnt[kswapd2]: 5
>>   > @ongoing_flusher_cnt[kswapd10]: 5
>>   > @ongoing_flusher_cnt[kswapd3]: 5
>>   > @ongoing_flusher_cnt[kswapd11]: 5
>>   > @ongoing_flusher_cnt[kswapd0]: 5
>>   > @ongoing_flusher_cnt[kswapd4]: 6
>>   > @ongoing_flusher_cnt[kswapd1]: 7
>>   > @ongoing_flusher_cnt[cadvisor]: 9
>>
>> For cadvisor ongoing_flusher only helps 9 times to avoid flush.
>>
>>   > @ongoing_flusher_cnt[handled_race]: 18
>>   > @ongoing_flusher_cnt[all]: 61
>>
>> Our ongoing_flusher scheme detects overlap and avoid 61 out of 462 flushes.
>>
>>   > @cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 61
>>   > @cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 462
>>   > @cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 9032
>>
>> This is bad: Lock is contended 9032 time within this 1 sec period.
>> Below, lock_contended cases is captured in more detail.
>>
>>   > @cnt[tracepoint:cgroup:cgroup_rstat_locked]: 9435
>>   > @lock_contended[normal, 4]: 1
>>   > @lock_contended[normal, 1]: 2
>>   > @lock_contended[normal, 3]: 6
>>   > @lock_contended[normal, 2]: 15
>>   > @lock_contended[yield, 4]: 49
>>   > @lock_contended[after_obtaining_lock, 4]: 49
>>   > @lock_contended[normal, 0]: 59
>>
>> The "normal" lock_contended for level 0,
>> meaning the cgroup root is contended 59 times within this 1 sec period.
>>
>>   > @lock_contended[after_obtaining_lock, 1]: 117
>>   > @lock_contended[yield, 1]: 118
>>   > @lock_contended[yield, 3]: 258
>>   > @lock_contended[after_obtaining_lock, 3]: 258
>>   > @lock_contended[after_obtaining_lock, 2]: 946
>>   > @lock_contended[yield, 2]: 946
>>
>> Lock contention for 'yielded' case for level 2.
>> Goes crazy with 946/sec.
>>
>>   > @lock_contended[yield, 0]: 7579
>>
>> Lock contention for 'yielded' case for level 0, the root.
>> Is really crazy with 7579/sec lock spin cases.
>>
>>   > @lock_contended[after_obtaining_lock, 0]: 7579
>>
>>
>> IMHO this shows that, due to lock yielding, the scheme of
>> ongoing_flusher for sub-trees only cause issues.
> 
> Just to make sure I understand correctly, allowing non-root to become
> ongoing_flushers is problematic because we only support a single
> ongoing_flusher, so if we have a subsequent root flush, it won't be
> the ongoing_flusher and we won't benefit from skipping other flushes.
> Correct?
> 

Yes, basically... keep in mind, what will happen is that subsequent root
flush will busy-wait/spin on getting lock, which in case of a yield from
ongoing-flusher, will result in multiple flushers being active, despite
our efforts to have a single ongoing-flusher.


> I honestly think the problem here is not that we support
> ongoing_flusher for subtrees, which imo is nice to have at a low
> additional cost, and does have its benefits (see below). I think the
> problem is that lock yielding means that we can have multiple ongoing
> flushers, while the current scheme only records one.
> 

Yes, the yielding is causing multiple flushers to be active the same time.


> What I think we should be doing is either supporting multiple
> ongoing_flushers (by replacing the global variable with a per-cgroup
> flag, perhaps), or biting the bullet and start using a mutex to drop
> lock yielding. If there aren't any concerns beyond priority inversion
> (raised by Shakeel), maybe adding a mutex_lock_timeout() variant as I
> suggested could fix this issue (and also put a bound on the flushing
> latency in general)?
> 

The mutex_lock_timeout is an interesting idea, but not a primitive we
have available today, right?

p.s. I have 5 prod machines running with mutex change, and I've not
gotten any SRE complaints.


> (I suppose the latter is preferrable)
> 
>>
>> IMHO we should go back to only doing ongoing_flusher for root-cgroup.
>> There is really low chance of sub-trees flushes being concurrent enough
>> to benefit from this, and it cause issues and needs (ugly) race handling.
>>
>> Further more sub-tree flushing doesn't take as long time as level 0
>> flushing, which further lower the chance of concurrent flushes.
> 
> I agree that the race handling is not pretty, and we can try to
> improve the implementation or handle the race in other ways. However,
> I think that skipping flushes for subtrees is valuable. I am not sure
> about the cgroup arrangement in your use case, but we do have cgroups
> with a lot of tasks in them (and/or child cgroups). If there is memory
> pressure (or hit the cgroup limit), they all may go into direct
> reclaim concurrently, so skipping flushes could really be beneficial.
> 
> Of course, if the difference in complexity is not justified, we can go
> back to only supporting root cgroups for ongoing_flusher for now. But
> as I mentioned in the v4 email thread, some of the complexity may
> still remain anyway as we have multiple root cgroups in v1.
> 

Having an incremental step with "only supporting root cgroups for
ongoing_flusher for now" is a good step forward IMHO.
As you could see in grafana plot, this would be a significant production
improvement on its own, as it avoids wasting CPU resources spinning on
the lock.

Being able to have multiple root cgroups, due to in v1, does pose an
implementation problem.  Only having a single root, would allow to have 
a race-free cmpxchg scheme.
Would it be reasonable to only support v2?
If so, how can I match on this?

>>
>> Let's get some quick data on flush times from production, to support my
>> claim:
> 
> Thanks for the data. I agree that in general root flushes will be a
> lot more expensive than subtree flushes, but keep in mind that the
> data may look really different depends on the cgroup setup. As I
> mentioned, I think we should still support subtree flushes unless the
> difference in complexity is not justified.
> 

It would be really valuable if you could provide production data on the 
lock-hold times, just like I did with below bpftrace script...
Is that possible, please?

>>
>> The bpftrace onliner:
>>    sudo bpftrace -e '
>>     tracepoint:cgroup:cgroup_rstat_locked {
>>      if (args->cpu == -1) { @start[tid]=nsecs; }
>>      @cnt[probe]=count();
>>      if (args->contended) {
>>        @lock_contended["after_obtaining_lock", args->level]=count();
>>      }}
>>     tracepoint:cgroup:cgroup_rstat_unlock {
>>      if (args->cpu == -1) {
>>       $now=nsecs; $start=@start[tid]; $diff=$now-$start;
>>       @locked_time_level[args->level]=hist($diff);
>>      }
>>      @cnt[probe]=count()}
>>     kfunc:cgroup_rstat_flush_locked {@cnt[probe]=count()}
>>     interval:s:1 {time("%H:%M:%S ");
>>      print(@cnt);
>>      print(@lock_contended);
>>      print(@locked_time_level);
>>      clear (@cnt);
>>      clear (@lock_contended); }
>>     END {clear(@start)}'
>>
>> Time below is in nanosec.
>>
>> @locked_time_level[0]:
>> [4M, 8M)             623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>        |
>> [8M, 16M)            860
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [16M, 32M)           295 |@@@@@@@@@@@@@@@@@
>>        |
>> [32M, 64M)           275 |@@@@@@@@@@@@@@@@
>>        |
>>
>>
>> @locked_time_level[1]:
>> [4K, 8K)               6 |@@@@
>>        |
>> [8K, 16K)             65
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [16K, 32K)            52 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>        |
>> [32K, 64K)            23 |@@@@@@@@@@@@@@@@@@
>>        |
>> [64K, 128K)           15 |@@@@@@@@@@@@
>>        |
>> [128K, 256K)          10 |@@@@@@@@
>>        |
>> [256K, 512K)           6 |@@@@
>>        |
>> [512K, 1M)            15 |@@@@@@@@@@@@
>>        |
>> [1M, 2M)               2 |@
>>        |
>> [2M, 4M)              14 |@@@@@@@@@@@
>>        |
>> [4M, 8M)               6 |@@@@
>>        |
>> [8M, 16M)              7 |@@@@@
>>        |
>> [16M, 32M)             1 |
>>        |
>>
>>
>> @locked_time_level[2]:
>> [2K, 4K)               1 |
>>        |
>> [4K, 8K)             160 |@@@@@@@@@
>>        |
>> [8K, 16K)            733 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>        |
>> [16K, 32K)           901
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [32K, 64K)           191 |@@@@@@@@@@@
>>        |
>> [64K, 128K)          115 |@@@@@@
>>        |
>> [128K, 256K)          61 |@@@
>>        |
>> [256K, 512K)          70 |@@@@
>>        |
>> [512K, 1M)            59 |@@@
>>        |
>> [1M, 2M)              27 |@
>>        |
>> [2M, 4M)               9 |
>>        |
>>
>>
>> @locked_time_level[3]:
>> [1K, 2K)               3 |
>>        |
>> [2K, 4K)               2 |
>>        |
>> [4K, 8K)               5 |
>>        |
>> [8K, 16K)            147 |@@@@@@
>>        |
>> [16K, 32K)          1222
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [32K, 64K)           266 |@@@@@@@@@@@
>>        |
>> [64K, 128K)          199 |@@@@@@@@
>>        |
>> [128K, 256K)         146 |@@@@@@
>>        |
>> [256K, 512K)         124 |@@@@@
>>        |
>> [512K, 1M)            17 |
>>        |
>> [1M, 2M)               0 |
>>        |
>> [2M, 4M)               0 |
>>        |
>> [4M, 8M)               1 |
>>        |
>>
>>
>> @locked_time_level[4]:
>> [4K, 8K)               2 |@@
>>        |
>> [8K, 16K)             17 |@@@@@@@@@@@@@@@@@@@@@@
>>        |
>> [16K, 32K)            40
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [32K, 64K)             4 |@@@@@
>>        |
>>
>> --Jesper
>>

