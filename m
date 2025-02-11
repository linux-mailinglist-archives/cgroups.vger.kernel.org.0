Return-Path: <cgroups+bounces-6498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CAA305E9
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487DC164FE0
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C01F03CC;
	Tue, 11 Feb 2025 08:36:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB926BDA8;
	Tue, 11 Feb 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262991; cv=none; b=Kr7OaIPAyHZc1+A5azCgpHsPfh14QCgz42hdt2zhlZYxFVGlfr2rtVwUqLdal93xNHgDPWykzI97l1pXfiYNbwV0m1UPhsmsHs2jA/Mmr6gE2SJJMQv0tX+TGI8lsGnVFMgItay6OZVmW0CEP41NR344aEYb41GVVOSLra1d62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262991; c=relaxed/simple;
	bh=3mb9hayIsyvxrq+UiLOv4MPGAR/NrjSFWRoNdg+bHUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5V7Mg2+hQQslk88n8L+FhUa6Qtja9osXhd+TDOt9TZJA6DseQnOQy9N69Qgsyv+gWp3rD45XX12/0gC1w/Wd3ZutTuVdtkcRtaiYYmdF2Q4RSeosxO3j82fVDxKVFafFc8XL/SpPv4G/TXSkHnTkuWNehR5o1L7jmP9oTUB95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF7A51477;
	Tue, 11 Feb 2025 00:36:43 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807C13F5A1;
	Tue, 11 Feb 2025 00:36:18 -0800 (PST)
Message-ID: <80ccec94-df27-4a99-8037-17165f6c5d8f@arm.com>
Date: Tue, 11 Feb 2025 09:36:10 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
References: <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2025 18:09, Juri Lelli wrote:
> Hi Christian,
> 
> Thanks for taking a look as well.
> 
> On 07/02/25 15:55, Christian Loehle wrote:
>> On 2/7/25 14:04, Jon Hunter wrote:
>>>
>>>
>>> On 07/02/2025 13:38, Dietmar Eggemann wrote:
>>>> On 07/02/2025 11:38, Jon Hunter wrote:
>>>>>
>>>>> On 06/02/2025 09:29, Juri Lelli wrote:
>>>>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>> Thanks! That did make it easier :-)
>>>>>>>
>>>>>>> Here is what I see ...
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> Still different from what I can repro over here, so, unfortunately, I
>>>>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>>>>
>>>>>> Could I ask for another run with it? Please also share the complete
>>>>>> dmesg from boot, as I would need to check debug output when CPUs are
>>>>>> first onlined.
>>>>
>>>> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
>>>> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
>>>> isol CPUs?
>>>
>>> I believe that 1-2 are the denvers (even thought they are listed as 0-1 in device-tree).
>>
>> Interesting, I have yet to reproduce this with equal capacities in isolcpus.
>> Maybe I didn't try hard enough yet.
>>
>>>
>>>> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]
>>>
>>> Yes I think it is similar to this.
>>>
>>> Thanks!
>>> Jon
>>>
>>
>> I could reproduce that on a different LLLLbb with isolcpus=3,4 (Lb) and
>> the offlining order:
>> echo 0 > /sys/devices/system/cpu/cpu5/online
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>> echo 0 > /sys/devices/system/cpu/cpu3/online
>> echo 0 > /sys/devices/system/cpu/cpu2/online
>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>
>> while the following offlining order succeeds:
>> echo 0 > /sys/devices/system/cpu/cpu5/online
>> echo 0 > /sys/devices/system/cpu/cpu4/online
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>> echo 0 > /sys/devices/system/cpu/cpu2/online
>> echo 0 > /sys/devices/system/cpu/cpu3/online
>> (Both offline an isolcpus last, both have CPU0 online)
>>

Could reproduce on Juno-r0:

0 1 2 3 4 5

L b b L L L

      ^^^
      isol = [3-4] so both L

echo 0 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu4/online
echo 0 > /sys/devices/system/cpu/cpu5/online
echo 0 > /sys/devices/system/cpu/cpu2/online - isol
echo 0 > /sys/devices/system/cpu/cpu3/online - isol

>> The issue only triggers with sugov DL threads (I guess that's obvious, but
>> just to mention it).

IMHO, it doesn't have to be a sugov DL task. Any DL task will do.

// on a 2. shell:
# chrt -d -T 5000000 -D 10000000 -P 16666666 -p 0 $$

# ps -eTo comm,pid,class | grep DLN
bash             1243 DLN

5000000/16666666 = 0.3, 0.3 << 10 = 307 (task util, bandwidth requirement)

> It wasn't obvious to me at first :). So thanks for confirming.
> 
>> I'll investigate some more later but wanted to share for now.
> 
> So, problem actually is that I am not yet sure what we should do with
> sugovs' bandwidth wrt root domain accounting. W/o isolation it's all
> good, as it gets accounted for correctly on the dynamic domains sugov
> tasks can run on. But with isolation and sugov affected_cpus that cross
> isolation domains (e.g., one BIG one little), we can get into troubles
> not knowing if sugov contribution should fall on the DEF or DYN domain.

# echo 0 > /sys/devices/system/cpu/cpu1/online
[   87.402722] __dl_bw_capacity() mask=0-2,5 cap=2940
[   87.407551] dl_bw_cpus() cpu=1 rd->span=0-2,5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4
[   87.416019] dl_bw_manage: cpu=1 cap=1916 fair_server_bw=52428 total_bw=524284 dl_bw_cpus=4 type=DYN span=0-2,5

# echo 0 > /sys/devices/system/cpu/cpu2/online
[   95.562270] __dl_bw_capacity() mask=0,2,5 cap=1916
[   95.567091] dl_bw_cpus() cpu=2 rd->span=0,2,5 cpu_active_mask=0,2-5 cpumask_weight(rd->span)=3
[   95.575735] dl_bw_manage: cpu=2 cap=892 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3 type=DYN span=0,2,5

# echo 0 > /sys/devices/system/cpu/cpu5/online
[  100.573131] __dl_bw_capacity() mask=0,5 cap=892
[  100.577713] dl_bw_cpus() cpu=5 rd->span=0,5 cpu_active_mask=0,3-5 cpumask_weight(rd->span)=2
[  100.586186] dl_bw_manage: cpu=5 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DYN span=0,5

# echo 0 > /sys/devices/system/cpu/cpu3/online
[  110.232755] __dl_bw_capacity() mask=1-5 cap=892
[  110.237333] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,3-4 cpus=2
[  110.244064] dl_bw_manage: cpu=3 cap=446 fair_server_bw=52428 total_bw=419428 dl_bw_cpus=2 type=DEF span=1-5


# echo 0 > /sys/devices/system/cpu/cpu4/online
[  175.870273] __dl_bw_capacity() mask=1-5 cap=446
[  175.874850] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,4 cpus=1
[  175.881407] dl_bw_manage: cpu=4 cap=0 fair_server_bw=52428 total_bw=367000 dl_bw_cpus=1 type=DEF span=1-5
                                   ^^^^^                                                            ^^^^^^^^
                                   w/o/ cpu4 cap is 0!                                              cpu0 is not part of it                                                                                                     
...
[  175.897600] dl_bw_manage() cpu=4 cap=0 overflow=1 return=-16
                                          ^^^^^^^^^^ -EBUSY
                                          
-bash: echo: write error: Device or resource busy

sched_cpu_deactivate()

  dl_bw_deactivate(cpu)

    dl_bw_manage(dl_bw_req_deactivate, cpu, 0);

      return overflow ? -EBUSY : 0;

Looks like in DEF there is no CPU capacity left but we still have 1 DLN
task with a bandwidth requirement of 307.

