Return-Path: <cgroups+bounces-6588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F2A39E6B
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75813A8BE7
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A18269CFA;
	Tue, 18 Feb 2025 14:12:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFEB269B02;
	Tue, 18 Feb 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887940; cv=none; b=qI3m0ky1/BgfbVvcSqlGuJuJWfs3rlXowpXbzXFC/tPH+aIqOaFW03VClPezscV0hZ02jJPCiic6TENrh0VWfn2HKtSnCVYAknrI1y0mS0G07/hrnIqha09BB38iWezaOcDHIsRKJrgQ/dkbO79m0VbLS1C1qwOA892vJpwhTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887940; c=relaxed/simple;
	bh=7UysL85pNfi7F1ySnLyZ0gEreBbjh5DtSMn7niFZ22I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOXJl3Vve1NlNnW5L+eL976WKxEV+i+R3sdk2ff53PVt2nWth3fLi/cBrZdwutSIROrcRWYBi0F1dNzrYtKcjgqFz6Njddhj28udL6CcBYUR8HAGKx81NUpT/iYpNZxbu86zosXeegeR8kol70elRnkfalJNTOcUSXJ4GMqKqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BFC9152B;
	Tue, 18 Feb 2025 06:12:36 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8D033F6A8;
	Tue, 18 Feb 2025 06:12:13 -0800 (PST)
Message-ID: <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
Date: Tue, 18 Feb 2025 15:12:12 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
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
References: <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 10:58, Juri Lelli wrote:
> Hi!
> 
> On 17/02/25 17:08, Juri Lelli wrote:
>> On 14/02/25 10:05, Jon Hunter wrote:
> 
> ...
> 
>> At this point I believe you triggered suspend.
>>
>>> [   57.290150] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>> [   57.335619] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
>>> [   57.353364] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
>>> [   57.397022] Disabling non-boot CPUs ...
>>
>> Offlining CPU5.
>>
>>> [   57.400904] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0,3-5
>>> [   57.400949] CPU0 attaching NULL sched-domain.
>>> [   57.415298] span=1-2
>>> [   57.417483] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
>>> [   57.417487] __dl_server_detach_root: cpu=0 rd_span=0,3-5 total_bw=157284
>>> [   57.417496] rq_attach_root: cpu=0 old_span=NULL new_span=1-2
>>> [   57.417501] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DEF
>>> [   57.417504] __dl_server_attach_root: cpu=0 rd_span=0-2 total_bw=157284
>>> [   57.417507] CPU3 attaching NULL sched-domain.
>>> [   57.454804] span=0-2
>>> [   57.456987] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DYN
>>> [   57.456990] __dl_server_detach_root: cpu=3 rd_span=3-5 total_bw=104856
>>> [   57.456998] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
>>> [   57.457000] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-3 type=DEF
>>> [   57.457003] __dl_server_attach_root: cpu=3 rd_span=0-3 total_bw=209712
>>> [   57.457006] CPU4 attaching NULL sched-domain.
>>> [   57.493964] span=0-3
>>> [   57.496152] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=4-5 type=DYN
>>> [   57.496156] __dl_server_detach_root: cpu=4 rd_span=4-5 total_bw=52428
>>> [   57.496162] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
>>> [   57.496165] __dl_add: cpus=5 tsk_bw=52428 total_bw=262140 span=0-4 type=DEF
>>> [   57.496168] __dl_server_attach_root: cpu=4 rd_span=0-4 total_bw=262140
>>> [   57.496171] CPU5 attaching NULL sched-domain.
>>> [   57.532952] span=0-4
>>> [   57.535143] rq_attach_root: cpu=5 old_span= new_span=0-4
>>> [   57.535147] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
>>
>> Maybe we shouldn't add the dl_server contribution of a CPU that is going
>> to be offline.
> 
> I tried to implement this idea and ended up with the following. As usual
> also pushed it to the branch on github. Could you please update and
> re-test?
> 
> Another thing that I noticed is that in my case an hotplug operation
> generating a sched/root domain rebuild ends up calling dl_rebuild_
> rd_accounting() (from partition_and_rebuild_sched_domains()) which
> resets accounting for def and dyn domains. In your case (looking again
> at the last dmesg you shared) I don't see this call, so I wonder if for
> some reason related to your setup we do the rebuild by calling partition_
> sched_domains() (instead of partition_and_rebuild_) and this doesn't
> call dl_rebuild_rd_accounting() after partition_sched_domains_locked() -
> maybe it should? Dietmar, Christian, Peter, what do you think?

Yeah, looks like suspend/resume behaves differently compared to CPU hotplug.

On my Juno [L b b L L L]
                ^^^
                isolcpus=[2,3]

# ps2 | grep DLN
   98    98 S 140      0   - DLN sugov:0
   99    99 S 140      0   - DLN sugov:1

# taskset -p 98; taskset -p 99
pid 98's current affinity mask: 39
pid 99's current affinity mask: 6


[   87.679282] partition_sched_domains() called
...
[   87.684013] partition_sched_domains() called
...
[   87.687961] partition_sched_domains() called
...
[   87.689419] psci: CPU3 killed (polled 0 ms)
[   87.689715] __dl_bw_capacity() mask=2-5 cap=1024
[   87.689739] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
[   87.689757] dl_bw_manage: cpu=2 cap=0 fair_server_bw=52428
total_bw=209712 dl_bw_cpus=1 type=DEF span=2-5
[   87.689775] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
[   87.689789] dl_bw_manage() cpu=2 cap=0 overflow=1 return=-16
[   87.689864] Error taking CPU2 down: -16                       <-- !!!
...
[   87.690674] partition_sched_domains() called
...
[   87.691496] partition_sched_domains() called
...
[   87.693702] partition_sched_domains() called
...
[   87.695819] partition_and_rebuild_sched_domains() called


