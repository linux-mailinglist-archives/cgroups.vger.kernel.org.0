Return-Path: <cgroups+bounces-6527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4BA32E9C
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 19:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EA37A39C5
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877A25EF81;
	Wed, 12 Feb 2025 18:22:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599925D553;
	Wed, 12 Feb 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384569; cv=none; b=OBR4IofFfL3VJDKVaV3379crBOcCZtiLoxOPoSjDr+Yl6H3dyJo3GgrmLjLHzPF2idiE/HlW+a4YdzQLu9GSyi/T8kQNni97IA75HY5WKOOgTmPXiP59QCSaj2U1dt+RQK5+zFHC2zyE8JNeTffl+MGT1cutosgiSz76QyNjf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384569; c=relaxed/simple;
	bh=rY4r5GKMn7v/sgkD/QcMMkNOQLXMfFnAoQP1x9J6QR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1xWYK4enZMMPBJsbakIei8Cdo1++yolitJaa3nrMtPYjmgwqKC+2F0yrDJmCodauw25zkBVVOn5Zv6plkJQ4XQOitWJZa+5h+TKfJUhazXJ3nnfhoBHnycHu6J2wNshGF6GxTFjaseoOTG54mVgqeFj4SMNFG6OU1yxQPyVh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A8B212FC;
	Wed, 12 Feb 2025 10:23:07 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8AC3F58B;
	Wed, 12 Feb 2025 10:22:42 -0800 (PST)
Message-ID: <285a43db-c36d-400e-8041-0566f089a482@arm.com>
Date: Wed, 12 Feb 2025 19:22:35 +0100
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
References: <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 11:42, Juri Lelli wrote:
> On 11/02/25 10:15, Christian Loehle wrote:
>> On 2/10/25 17:09, Juri Lelli wrote:
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
>>>> The issue only triggers with sugov DL threads (I guess that's obvious, but
>>>> just to mention it).
>>>
>>> It wasn't obvious to me at first :). So thanks for confirming.
>>>
>>>> I'll investigate some more later but wanted to share for now.
>>>
>>> So, problem actually is that I am not yet sure what we should do with
>>> sugovs' bandwidth wrt root domain accounting. W/o isolation it's all
>>> good, as it gets accounted for correctly on the dynamic domains sugov
>>> tasks can run on. But with isolation and sugov affected_cpus that cross
>>> isolation domains (e.g., one BIG one little), we can get into troubles
>>> not knowing if sugov contribution should fall on the DEF or DYN domain.
>>>
>>> Hummm, need to think more about it.
>>
>> That is indeed tricky.
>> I would've found it super appealing to always just have sugov DL tasks activate
>> on this_cpu and not have to worry about all this, but then you have contention
>> amongst CPUs of a cluster and there are energy improvements from always
>> having little cores handle all sugov DL tasks, even for the big CPUs,
>> that's why I introduced
>> commit 93940fbdc468 ("cpufreq/schedutil: Only bind threads if needed")
>> but that really doesn't make this any easier.
> 
> What about we actually ignore them consistently? We already do that for
> admission control, so maybe we can do that when rebuilding domains as
> well (until we find maybe a better way to deal with them).
> 
> Does the following make any difference?

It at least seems to solve the issue. And like you mentioned on irc, we
don't know the bw req of sugov anyway.

So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.

dl_rq[0]:
  .dl_nr_running                 : 0
  .dl_bw->bw                     : 996147
  .dl_bw->total_bw               : 0       <-- !

IMHO, people who want to run serious DL can always check whether there
are already these infrastructural DL tasks or even avoid schedutil.

> 
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b254d878789d..8f7420e0c9d6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2995,7 +2995,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	struct dl_bw *dl_b;
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> -	if (!dl_task(p)) {
> +	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
>  		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  		return;
>  	}
> 


