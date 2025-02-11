Return-Path: <cgroups+bounces-6503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9060A308F1
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331CB165B0A
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B141F1523;
	Tue, 11 Feb 2025 10:43:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581C1F4613;
	Tue, 11 Feb 2025 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270602; cv=none; b=Vg2N/OrLK856xf40aZGvXnUuaDgHkCR2cDC2tBcHbb9lXPPCZnIDA5Ji3pLujq6dJ7Poaz1+MaV4oCOSqVFVXlv81Z9UA5P5IpxLbJeTUu9NcQHG1HdL7xCbOb/G3hIHR4Tltvv1ZaY9kOFSsq2L8sRmm5Q0p+llzU29vI9ZUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270602; c=relaxed/simple;
	bh=oZTToYv2z/U8gQI88FyVRSzeqSEew3/8lqV62GL77Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqqVs7gtZN7cNj/6vJIL7NjLgU0NFjhCDqqu0aMGJlycB3ZlTbRw2oLbU6C1PcA1Agqqjd6+NUO9GgmfJosUrbX3I4EtP64FvHrrKYSVgezGyG8NWgSOlv87n2GdeAybg+QItfRQ81c80opY5cOAYFQm5mbZqb7VNSWzmtRE0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDDB413D5;
	Tue, 11 Feb 2025 02:43:41 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9DE43F6A8;
	Tue, 11 Feb 2025 02:43:16 -0800 (PST)
Message-ID: <8b5c29cd-7083-4815-bf73-7c93dfdebef8@arm.com>
Date: Tue, 11 Feb 2025 11:43:15 +0100
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
Cc: Christian Loehle <christian.loehle@arm.com>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
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
References: <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <80ccec94-df27-4a99-8037-17165f6c5d8f@arm.com>
 <Z6sWfsAqBlGhnkN_@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z6sWfsAqBlGhnkN_@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 10:21, Juri Lelli wrote:
> On 11/02/25 09:36, Dietmar Eggemann wrote:
>> On 10/02/2025 18:09, Juri Lelli wrote:
>>> Hi Christian,
>>>
>>> Thanks for taking a look as well.
>>>
>>> On 07/02/25 15:55, Christian Loehle wrote:
>>>> On 2/7/25 14:04, Jon Hunter wrote:
>>>>>
>>>>>
>>>>> On 07/02/2025 13:38, Dietmar Eggemann wrote:
>>>>>> On 07/02/2025 11:38, Jon Hunter wrote:
>>>>>>>
>>>>>>> On 06/02/2025 09:29, Juri Lelli wrote:
>>>>>>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>> Thanks! That did make it easier :-)
>>>>>>>>>
>>>>>>>>> Here is what I see ...
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>> Still different from what I can repro over here, so, unfortunately, I
>>>>>>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>>>>>>
>>>>>>>> Could I ask for another run with it? Please also share the complete
>>>>>>>> dmesg from boot, as I would need to check debug output when CPUs are
>>>>>>>> first onlined.
>>>>>>
>>>>>> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
>>>>>> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
>>>>>> isol CPUs?
>>>>>
>>>>> I believe that 1-2 are the denvers (even thought they are listed as 0-1 in device-tree).
>>>>
>>>> Interesting, I have yet to reproduce this with equal capacities in isolcpus.
>>>> Maybe I didn't try hard enough yet.
>>>>
>>>>>
>>>>>> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]
>>>>>
>>>>> Yes I think it is similar to this.
>>>>>
>>>>> Thanks!
>>>>> Jon
>>>>>
>>>>
>>>> I could reproduce that on a different LLLLbb with isolcpus=3,4 (Lb) and
>>>> the offlining order:
>>>> echo 0 > /sys/devices/system/cpu/cpu5/online
>>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>>>
>>>> while the following offlining order succeeds:
>>>> echo 0 > /sys/devices/system/cpu/cpu5/online
>>>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>>> (Both offline an isolcpus last, both have CPU0 online)
>>>>
>>
>> Could reproduce on Juno-r0:
>>
>> 0 1 2 3 4 5
>>
>> L b b L L L
>>
>>       ^^^
>>       isol = [3-4] so both L
>>
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>> echo 0 > /sys/devices/system/cpu/cpu4/online
>> echo 0 > /sys/devices/system/cpu/cpu5/online
>> echo 0 > /sys/devices/system/cpu/cpu2/online - isol
>> echo 0 > /sys/devices/system/cpu/cpu3/online - isol
>>
>>>> The issue only triggers with sugov DL threads (I guess that's obvious, but
>>>> just to mention it).
>>
>> IMHO, it doesn't have to be a sugov DL task. Any DL task will do.
> 
> OK, but in this case we actually want to fail. If we have allocated
> bandwidth for an actual DL task (not a dl server or a 'fake' sugov), we
> don't want to inadvertently leave it w/o bandwidth by turning CPUs off.

Obviously ... ;-)

Same platform w/ isol = [2-3] with slow switching CPUfreq driver to
force having 'sugov' tasks.

# ps2 | grep DLN
   95    95 S 140      0   - DLN sugov:0
   96    96 S 140      0   - DLN sugov:1

# taskset -p 95; taskset -p 96
pid 95's current affinity mask: 39
pid 96's current affinity mask: 6

offline order: CPU1 -> 4 -> 5 -> 3 -> 2

...

pid 95's current affinity mask: 1
pid 96's current affinity mask: 4

root@juno:~# echo 0 > /sys/devices/system/cpu/cpu2/online
[  227.673757] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,2 cpus=1
[  227.680329] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,2 cpus=1
[  227.686882] dl_bw_manage: cpu=2 cap=0 fair_server_bw=52428 total_bw=157285 dl_bw_cpus=1 type=DEF span=1-5
[  227.686900] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,2 cpus=1
[  227.703066] dl_bw_manage() cpu=2 cap=0 overflow=1 return=-16
-bash: echo: write error: Device or resource busy

So it seems 'sugov:1' getting in the way here.

pid 95's current affinity mask: 1
pid 96's current affinity mask: 5

Looks like it's not a 'bL' issue but rather one with '>=2 CPU frequency
policies' and slow-switching CPUfreq drivers.

