Return-Path: <cgroups+bounces-6464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E5A2C7FA
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6097E188530E
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB623C8C0;
	Fri,  7 Feb 2025 15:55:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594523C8B3;
	Fri,  7 Feb 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943719; cv=none; b=IwffoKWaugHaBIMu2rVekm6DbL2IWYIzA/35FDIj8WdPUHpxLhQIm9YW1uAlvJ42Tk15fPDiB/yQjeXtWWO3KXMXInuSc8EN12bB3HWmRsHmzR7KpUHjj/yloxTBCTawJ/VWet0ucSrvOQQ4+aZSnLwrPIoNuEy0FJh1yQQIw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943719; c=relaxed/simple;
	bh=C1Y5i+jCeqE0JJkwc82n6tEiYS+o7+FLCEjbuqFNNIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eio+MIHWblWqAao8v0SHAEZuAAmJBhiBBOxnq7d/nfQcnTE8c5zFAVrlSqoOA+r9pru4EAXw1hAwoksu70EaxWS0PLKFkGGiknhZjnHjuMYeCs1oIUxWnXV7ET73h4Cx8lYl6Q8TqtxBwXTL13nI46RgteOMynHSbpCYqpgb/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C618113E;
	Fri,  7 Feb 2025 07:55:40 -0800 (PST)
Received: from [10.1.25.32] (e127648.arm.com [10.1.25.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A67193F58B;
	Fri,  7 Feb 2025 07:55:12 -0800 (PST)
Message-ID: <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
Date: Fri, 7 Feb 2025 15:55:09 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Jon Hunter <jonathanh@nvidia.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
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
References: <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 14:04, Jon Hunter wrote:
> 
> 
> On 07/02/2025 13:38, Dietmar Eggemann wrote:
>> On 07/02/2025 11:38, Jon Hunter wrote:
>>>
>>> On 06/02/2025 09:29, Juri Lelli wrote:
>>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>>
>>>> ...
>>>>
>>>>> Thanks! That did make it easier :-)
>>>>>
>>>>> Here is what I see ...
>>>>
>>>> Thanks!
>>>>
>>>> Still different from what I can repro over here, so, unfortunately, I
>>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>>
>>>> Could I ask for another run with it? Please also share the complete
>>>> dmesg from boot, as I would need to check debug output when CPUs are
>>>> first onlined.
>>
>> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
>> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
>> isol CPUs?
> 
> I believe that 1-2 are the denvers (even thought they are listed as 0-1 in device-tree).

Interesting, I have yet to reproduce this with equal capacities in isolcpus.
Maybe I didn't try hard enough yet.

> 
>> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]
> 
> Yes I think it is similar to this.
> 
> Thanks!
> Jon
> 

I could reproduce that on a different LLLLbb with isolcpus=3,4 (Lb) and
the offlining order:
echo 0 > /sys/devices/system/cpu/cpu5/online
echo 0 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu3/online
echo 0 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu4/online

while the following offlining order succeeds:
echo 0 > /sys/devices/system/cpu/cpu5/online
echo 0 > /sys/devices/system/cpu/cpu4/online
echo 0 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu3/online
(Both offline an isolcpus last, both have CPU0 online)

The issue only triggers with sugov DL threads (I guess that's obvious, but
just to mention it).

I'll investigate some more later but wanted to share for now.
A log just to ensure we're looking at the same thing (this is just 6.14-rc1
with Juri's printk):

Successful offlining:
# echo 0 > /sys/devices/system/cpu/cpu5/online
[   37.063862] dl_bw_manage: cpu=5 cap=1143 fair_server_bw=52428 total_bw=314569 dl_bw_cpus=4
[   37.070925] CPU0 attaching NULL sched-domain.
[   37.071323] CPU1 attaching NULL sched-domain.
[   37.071743] CPU2 attaching NULL sched-domain.
[   37.072135] CPU5 attaching NULL sched-domain.
[   37.072618] CPU0 attaching sched-domain(s):
[   37.073008]  domain-0: span=0-2 level=MC
[   37.073370]   groups: 0:{ span=0 cap=379 }, 1:{ span=1 cap=380 }, 2:{ span=2 cap=381 }
[   37.074131] CPU1 attaching sched-domain(s):
[   37.074503]  domain-0: span=0-2 level=MC
[   37.074871]   groups: 1:{ span=1 cap=380 }, 2:{ span=2 cap=381 }, 0:{ span=0 cap=379 }
[   37.075614] CPU2 attaching sched-domain(s):
[   37.075998]  domain-0: span=0-2 level=MC
[   37.076354]   groups: 2:{ span=2 cap=381 }, 0:{ span=0 cap=379 }, 1:{ span=1 cap=380 }
[   37.077108] root domain span: 0-2
[   37.077425] rd 0-2: Checking EAS, CPUs do not have asymmetric capacities
[   37.078028] sched_energy_set: stopping EAS
[   37.086645] psci: CPU5 killed (polled 1 ms)
# echo 0 > /sys/devices/system/cpu/cpu4/online
[   40.357879] dl_bw_manage: cpu=4 cap=1024 fair_server_bw=52428 total_bw=209713 dl_bw_cpus=2
[   40.367705] rd 0-2: Checking EAS, CPUs do not have asymmetric capacities
[   40.379707] psci: CPU4 killed (polled 1 ms)
[   40.380449] rd 0-2: Checking EAS, CPUs do not have asymmetric capacities
# echo 0 > /sys/devices/system/cpu/cpu1/online
[   43.285829] dl_bw_manage: cpu=1 cap=762 fair_server_bw=52428 total_bw=262141 dl_bw_cpus=3
[   43.295728] CPU0 attaching NULL sched-domain.
[   43.296139] CPU1 attaching NULL sched-domain.
[   43.296535] CPU2 attaching NULL sched-domain.
[   43.297116] CPU0 attaching sched-domain(s):
[   43.297496]  domain-0: span=0,2 level=MC
[   43.297893]   groups: 0:{ span=0 cap=380 }, 2:{ span=2 cap=381 }
[   43.298491] CPU2 attaching sched-domain(s):
[   43.298891]  domain-0: span=0,2 level=MC
[   43.299257]   groups: 2:{ span=2 cap=381 }, 0:{ span=0 cap=380 }
[   43.299866] root domain span: 0,2
[   43.300203] rd 0,2: Checking EAS, CPUs do not have asymmetric capacities
[   43.315715] psci: CPU1 killed (polled 1 ms)
# echo 0 > /sys/devices/system/cpu/cpu2/online
[   46.975824] dl_bw_manage: cpu=2 cap=381 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
[   46.981728] CPU0 attaching NULL sched-domain.
[   46.982138] CPU2 attaching NULL sched-domain.
[   46.982649] CPU0 attaching NULL sched-domain.
[   46.983078] root domain span: 0
[   46.983399] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[   46.993699] psci: CPU2 killed (polled 1 ms)
# echo 0 > /sys/devices/system/cpu/cpu3/online
[   49.858842] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=52428 dl_bw_cpus=1
[   49.865730] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[   49.877688] psci: CPU3 killed (polled 2 ms)
# 

Failed offlining:
# echo 0 > /sys/devices/system/cpu/cpu5/online
[   29.596992] dl_bw_manage: cpu=5 cap=1143 fair_server_bw=52428 total_bw=314569 dl_bw_cpus=4
[   29.607022] CPU0 attaching NULL sched-domain.
[   29.607419] CPU1 attaching NULL sched-domain.
[   29.607838] CPU2 attaching NULL sched-domain.
[   29.608228] CPU5 attaching NULL sched-domain.
[   29.608732] CPU0 attaching sched-domain(s):
[   29.609124]  domain-0: span=0-2 level=MC
[   29.609485]   groups: 0:{ span=0 cap=380 }, 1:{ span=1 cap=381 }, 2:{ span=2 cap=381 }
[   29.610245] CPU1 attaching sched-domain(s):
[   29.610617]  domain-0: span=0-2 level=MC
[   29.610986]   groups: 1:{ span=1 cap=381 }, 2:{ span=2 cap=381 }, 0:{ span=0 cap=380 }
[   29.611731] CPU2 attaching sched-domain(s):
[   29.612122]  domain-0: span=0-2 level=MC
[   29.612478]   groups: 2:{ span=2 cap=381 }, 0:{ span=0 cap=380 }, 1:{ span=1 cap=381 }
[   29.613230] root domain span: 0-2
[   29.613547] rd 0-2: Checking EAS, CPUs do not have asymmetric capacities
[   29.614152] sched_energy_set: stopping EAS
[   29.629987] psci: CPU5 killed (polled 0 ms)
# echo 0 > /sys/devices/system/cpu/cpu1/online
[   32.945954] dl_bw_manage: cpu=1 cap=762 fair_server_bw=52428 total_bw=262141 dl_bw_cpus=3
[   32.955858] CPU0 attaching NULL sched-domain.
[   32.956269] CPU1 attaching NULL sched-domain.
[   32.956662] CPU2 attaching NULL sched-domain.
[   32.957244] CPU0 attaching sched-domain(s):
[   32.957624]  domain-0: span=0,2 level=MC
[   32.958021]   groups: 0:{ span=0 cap=380 }, 2:{ span=2 cap=381 }
[   32.958617] CPU2 attaching sched-domain(s):
[   32.959015]  domain-0: span=0,2 level=MC
[   32.959381]   groups: 2:{ span=2 cap=381 }, 0:{ span=0 cap=380 }
[   32.959993] root domain span: 0,2
[   32.960330] rd 0,2: Checking EAS, CPUs do not have asymmetric capacities
[   32.972841] psci: CPU1 killed (polled 1 ms)
# echo 0 > /sys/devices/system/cpu/cpu3/online
[   35.921962] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=314570 dl_bw_cpus=2
[   35.927945] rd 0,2: Checking EAS, CPUs do not have asymmetric capacities
[   35.935828] psci: CPU3 killed (polled 1 ms)
# echo 0 > /sys/devices/system/cpu/cpu2/online
[   38.999952] dl_bw_manage: cpu=2 cap=381 fair_server_bw=52428 total_bw=209713 dl_bw_cpus=2
[   39.005003] CPU0 attaching NULL sched-domain.
[   39.005412] CPU2 attaching NULL sched-domain.
[   39.005969] CPU0 attaching NULL sched-domain.
[   39.006370] root domain span: 0
[   39.006687] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[   39.016825] psci: CPU2 killed (polled 1 ms)
# echo 0 > /sys/devices/system/cpu/cpu4/online
sh: write error: Device or resource busy
# [   42.936031] dl_bw_manage: cpu=4 cap=0 fair_server_bw=52428 total_bw=157285 dl_bw_cpus=1


cat /sys/devices/system/cpu/cpu*/cpu_capacity 
381
381
381
381
1024
1024


