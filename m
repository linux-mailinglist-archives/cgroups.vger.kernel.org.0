Return-Path: <cgroups+bounces-6604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB3A3BA51
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 10:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09DA3BAF7A
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D10B1DDA20;
	Wed, 19 Feb 2025 09:29:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD01D416E;
	Wed, 19 Feb 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957367; cv=none; b=KubZ5tXI7pC9kjcFSnhMYzNcwMoiYNn+ypQnFPpH8iTXPVtdzwpVwuiLIh4YRGRu1x7KorDS8WsZF+VS8gH4tyfjNrct3SMZs/nsmnpkA4iBaKWMtJcqpxghoveZlINW2y5w7GtsUVQ/Bjp3fDVtOwASFP3R5OLhtFiN15beCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957367; c=relaxed/simple;
	bh=TiX5hKFzn5cHW3dXI+eazWWgHEaso2Kv4HnEi0UzIJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4vDVNYTs9mDSJZhpEyg5ZJLYlYHJ4bwQm/m1NnmDqD9F3kNrtUKX3vrd7fLT5esfxaP14rrFHLXyz2hV/RAZ/nHCPS6tsVRrx2VAvKRAXBj3VkAlsuSDhf23M/SFQGxwRAwWen5+2m/Y7XMAG+Pi4udFXCHI22keO3rTuKZ0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13D371682;
	Wed, 19 Feb 2025 01:29:43 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0BED3F59E;
	Wed, 19 Feb 2025 01:29:20 -0800 (PST)
Message-ID: <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
Date: Wed, 19 Feb 2025 10:29:03 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 15:18, Juri Lelli wrote:
> On 18/02/25 15:12, Dietmar Eggemann wrote:
>> On 18/02/2025 10:58, Juri Lelli wrote:
>>> Hi!
>>>
>>> On 17/02/25 17:08, Juri Lelli wrote:
>>>> On 14/02/25 10:05, Jon Hunter wrote:

[...]

>> Yeah, looks like suspend/resume behaves differently compared to CPU hotplug.
>>
>> On my Juno [L b b L L L]
>>                 ^^^
>>                 isolcpus=[2,3]
>>
>> # ps2 | grep DLN
>>    98    98 S 140      0   - DLN sugov:0
>>    99    99 S 140      0   - DLN sugov:1
>>
>> # taskset -p 98; taskset -p 99
>> pid 98's current affinity mask: 39
>> pid 99's current affinity mask: 6
>>
>>
>> [   87.679282] partition_sched_domains() called
>> ...
>> [   87.684013] partition_sched_domains() called
>> ...
>> [   87.687961] partition_sched_domains() called
>> ...
>> [   87.689419] psci: CPU3 killed (polled 0 ms)
>> [   87.689715] __dl_bw_capacity() mask=2-5 cap=1024
>> [   87.689739] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
>> [   87.689757] dl_bw_manage: cpu=2 cap=0 fair_server_bw=52428
>> total_bw=209712 dl_bw_cpus=1 type=DEF span=2-5
>> [   87.689775] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
>> [   87.689789] dl_bw_manage() cpu=2 cap=0 overflow=1 return=-16
>> [   87.689864] Error taking CPU2 down: -16                       <-- !!!
>> ...
>> [   87.690674] partition_sched_domains() called
>> ...
>> [   87.691496] partition_sched_domains() called
>> ...
>> [   87.693702] partition_sched_domains() called
>> ...
>> [   87.695819] partition_and_rebuild_sched_domains() called
>>
> 
> Ah, OK. Did you try with my last proposed change?

I did now. 

Patch-wise I have:

(1) Putting 'fair_server's __dl_server_[de|at]tach_root() under if  
    '(cpumask_test_cpu(rq->cpu, [old_rd->online|cpu_active_mask))' in 
    rq_attach_root()

    https://lkml.kernel.org/r/Z7RhNmLpOb7SLImW@jlelli-thinkpadt14gen4.remote.csb

(2) Create __dl_server_detach_root() and call it in rq_attach_root()

    https://lkml.kernel.org/r/Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb

plus debug patch:

    https://lkml.kernel.org/r/Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb

plus additional debug.

The suspend issue still persists.

My hunch is that it's rather an issue with having 0 CPUs left in DEF
while deactivating the last isol CPU (CPU3) so we set overflow = 1 w/o
calling __dl_overflow(). We want to account fair_server_bw=52428
against 0 CPUs. 

l B B l l l

      ^^^
      isolcpus=[3,4]


cpumask_and(mask, rd->span, cpu_active_mask)

mask = [3-5] & [0-3] = [3] -> dl_bw_cpus(3) = 1

---

dl_bw_deactivate() called cpu=5

dl_bw_deactivate() called cpu=4

dl_bw_deactivate() called cpu=3

dl_bw_cpus() cpu=6 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
                   ^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^
  cpumask_subset(rd->span, cpu_active_mask) is false

  for_each_cpu_and(i, rd->span, cpu_active_mask)
    cpus++                                       <-- cpus is 1 !!!

dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5

  called w/ 'req = dl_bw_req_deactivate'

  dl_b->total_bw - fair_server_bw = 104856 - 52428 > 0

    dl_bw_cpus(cpu) - 1 = 0
   
      overflow = 1

So there is simply no capacity left in DEF for DL but
'dl_b->total_bw - old_bw + new_bw' = 52428 > 0

