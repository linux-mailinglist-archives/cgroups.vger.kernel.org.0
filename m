Return-Path: <cgroups+bounces-3767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4949349A1
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 10:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76D1284ADA
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770A768EE;
	Thu, 18 Jul 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="topNe8KL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489778C71;
	Thu, 18 Jul 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290363; cv=none; b=fVsm+7eIWrMyGd63whV2Zt4knMQxzlXR+fnBD/UH+Q/HSw2sG1bgQd0j2bJr3c+jJ2+x0iUZzmIES9qcnk92zmXdyUEhQQnepFmKT7pcJst8GjZ6V6BAUl6KSc4nTpNOguCoZleTrv+oOWV/tEeGlfDJwH5cSJxAbTYKsGG69c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290363; c=relaxed/simple;
	bh=dk+iL5Q7Ym85T0WoUq3bMcJRKL94pL7/kW/Z6U4W7UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2j2gnGOR/cr+XrS2l87uknr1arTUwzCm17hTz5yv3p0ivronmgAJRHD+rzJLJGqDHWUlbjfBh0AiLNZ/nFQsrsCctdwD1r91+xA7R3fIRCHzjSYkirnSlC8nSLH25+ZC5suzxDnwDPRplPeOhFaNJt6bxkMVqh9JgByr56r+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=topNe8KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2683C4AF0C;
	Thu, 18 Jul 2024 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721290362;
	bh=dk+iL5Q7Ym85T0WoUq3bMcJRKL94pL7/kW/Z6U4W7UU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=topNe8KLbnhdMnyS1Zsd+GsWr55kpB3t63FkZY11mfQsZiJQpc4/h1w71u2ghO3mV
	 n4GwGgaSKEEl39J1YDrWtM+MLFtwbKhC2PowjaGNhlHJ1ZW2lOT7i6sJbJkpTpUhyg
	 mZ7yefndZj/FB3krYrd2kgzAThHd4Je1mlz0hkXT9nShdEgxnQmD41ZCRjH4+AHJ+8
	 eef4wEoARq2oWlJyg+Bdz9j01KEti83fmYayYEeUIKEOWT2hMRqQ4PRBZOPy3F0hqH
	 cZsQicVIBmCWaEpwvJi+OEIpJa9ZNfDiLZ+tvMWEBQZruivHsYpBuvsPZzn3PLkzG8
	 NFQl7EU3cqZYw==
Message-ID: <c2ac13d7-f280-4be7-929a-d46c1dc7692c@kernel.org>
Date: Thu, 18 Jul 2024 10:12:39 +0200
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
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <CAJD7tkaBKTiMzSkXfaKO5EO58aN708L4XBS3cX85JvxVpcNkQQ@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaBKTiMzSkXfaKO5EO58aN708L4XBS3cX85JvxVpcNkQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/07/2024 18.49, Yosry Ahmed wrote:
> On Wed, Jul 17, 2024 at 9:36 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>> On 17/07/2024 02.35, Yosry Ahmed wrote:
>>> [..]
>>>>
>>>>
>>>> This is a clean (meaning no cadvisor interference) example of kswapd
>>>> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
>>>> hit the race (which is handled in V6 and V7).
>>>>
>>>> The BPF "cnt" maps are getting cleared every second, so this
>>>> approximates per sec numbers.  This patch reduce pressure on the lock,
>>>> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
>>>> flushes approx 37 per sec (every 27 ms). On the positive side
>>>> ongoing_flusher mitigation stopped 98 per sec of these.
>>>>
>>>> In this clean kswapd case the patch removes the lock contention issue
>>>> for kswapd. The lock_contended cases 27 seems to be all related to
>>>> handled_race cases 27.
>>>>
>>>> The remaning high flush rate should also be addressed, and we should
>>>> also work on aproaches to limit this like my ealier proposal[1].
>>>
>>> I honestly don't think a high number of flushes is a problem on its
>>> own as long as we are not spending too much time flushing, especially
>>> when we have magnitude-based thresholding so we know there is
>>> something to flush (although it may not be relevant to what we are
>>> doing).
>>>
>>
>> We are "spending too much time flushing" see below.
>>
>>> If we keep observing a lot of lock contention, one thing that I
>>> thought about is to have a variant of spin_lock with a timeout. This
>>> limits the flushing latency, instead of limiting the number of flushes
>>> (which I believe is the wrong metric to optimize).
>>>
>>> It also seems to me that we are doing a flush each 27ms, and your
>>> proposed threshold was once per 50ms. It doesn't seem like a
>>> fundamental difference.
>>>
>>
>>
>> Looking at the production numbers for the time the lock is held for level 0:
>>
>> @locked_time_level[0]:
>> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
>> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
>> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
>>
>> The time is in nanosec, so M corresponds to ms (milliseconds).
>>
>> With 36 flushes per second (as shown earlier) this is a flush every
>> 27.7ms.  It is not unreasonable (from above data) that the flush time
>> also spend 27ms, which means that we spend a full CPU second flushing.
>> That is spending too much time flushing.
>>
>> This around 1 sec CPU usage for kswapd is also quite clear in the
>> attached grafana graph for when server was rebooted into this V7 kernel.
>>
>> I choose 50ms because at the time I saw flush taking around 30ms, and I
>> view the flush time as queue service-time.  When arrival-rate is faster
>> than service-time, then a queue will form.  So, choosing 50ms as
>> arrival-rate gave me some headroom.  As I mentioned earlier, optimally
>> this threshold should be dynamically measured.
> 
> Thanks for the data. Yeah this doesn't look good.
> 
> Does it make sense to just throttle flushers at some point to increase
> the chances of coalescing multiple flushers?
> 
> Otherwise I think it makes sense in this case to ratelimit flushing in
> general. Although instead of just checking how much time elapsed since
> the last flush, can we use something like __ratelimit()?
> 
> This will make sure that we skip flushes when we actually have a high
> rate of flushing over a period of time, not because two flushes
> happened to be requested in close succession and the flushing rate is
> generally low.
> 

I really think "time elapsed since the last flush" is the right solution
here.  As, we *do* want to catch the case you describe "two flushes
happened to be requested in close succession and the flushing rate is
generally low."

(After this patch fixing the lock contention triggered by kswapd).
The remaining problem with kswapd is that those flushes that doesn't
"collide" on the lock, will be flushing in close succession.  And we
likely have a generally low flushing rate, until kswapd starts up.

Some production data from a "slow" period where only kswapd is active:

05:59:32 @ongoing_flusher_cnt[kswapd11]: 1
@ongoing_flusher_cnt[kswapd7]: 1
@ongoing_flusher_cnt[kswapd3]: 1
@ongoing_flusher_cnt[kswapd5]: 1
@ongoing_flusher_cnt[kswapd10]: 1
@ongoing_flusher_cnt[kswapd6]: 2
@ongoing_flusher_cnt[kswapd8]: 2
@ongoing_flusher_cnt[kswapd1]: 2
@ongoing_flusher_cnt[kswapd9]: 2
@ongoing_flusher_cnt[kswapd0]: 2
@ongoing_flusher_cnt[kswapd2]: 2
@ongoing_flusher_cnt[kswapd4]: 2
@ongoing_flusher_cnt[handled_race]: 2
@ongoing_flusher_cnt[all]: 14
@cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 2
@cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 10
@cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 43
@cnt[tracepoint:cgroup:cgroup_rstat_locked]: 51

We observe that ongoing_flusher scheme saves/avoids 14 of the flushes
great, but we still have 43 flushes in this period.  I think only kswapd
is doing the flushing here, so I claim 41 flushes are likely unnecessary
(as there are indication of 2 kswapd startups in the period).  Also
observe that some of the kswapdNN processes only have
ongoing_flusher_cnt 1, which indicate they didn't fully "collide" with
an ongoing flusher, while others have 2.

--Jesper






