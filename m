Return-Path: <cgroups+bounces-6607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1ABA3BF85
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 14:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C363A6610
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B671E5203;
	Wed, 19 Feb 2025 13:10:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006612B73;
	Wed, 19 Feb 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970605; cv=none; b=kkgx8H4BRlxjmqcYhZoymKoc4quCTKCEcCy3elMHOmnHP1Lg9MPDmemQDpYVpZ0+s8JqSKhFBWP6XxYKcyeAqeuRXYPmvK6qgKEjUM4EFRF8vGEZiZ85LhLmqAqqfXoCOXKyHkSqIu7d+OF00mQHXdj6xNLi7jBQVeJLFy//8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970605; c=relaxed/simple;
	bh=DepBL+EcutslP3WvrFiAmM/2fFO9PYbE7cwE7cuP0dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNHnzSVik/tATlQFQVTe79poiRc1NeTxAxUw2bPu7v4Ha3NvcpIe4Ct2AiYUk8lzqpLTyPCapjoQ5wPrtiOdxBLLX73aMopv/xKJ0bFNA2sWrF1t4glzZGxd4msP4RI9UoimyvoPqdLsfctpDe4s9gsKH2jAYnnDwkyqcJn9+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9943912FC;
	Wed, 19 Feb 2025 05:10:20 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5713F59E;
	Wed, 19 Feb 2025 05:09:58 -0800 (PST)
Message-ID: <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
Date: Wed, 19 Feb 2025 14:09:48 +0100
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
References: <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 11:02, Juri Lelli wrote:
> On 19/02/25 10:29, Dietmar Eggemann wrote:

[...]

> So you don't have the one with which we ignore special tasks while
> rebuilding domains?
> 
> https://lore.kernel.org/all/Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb/
> 
> Could you please double check again against
> 
> git@github.com:jlelli/linux.git experimental/dl-debug

Sorry, I forgot this one. Yes, I have it as well.

2993 void dl_add_task_root_domain(struct task_struct *p)
2994 {
2995         struct rq_flags rf;
2996         struct rq *rq;
2997         struct dl_bw *dl_b;
2998
2999         raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
3000         if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
3001                 raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
3002                 return;
3003         }

>> The suspend issue still persists.
>>
>> My hunch is that it's rather an issue with having 0 CPUs left in DEF
>> while deactivating the last isol CPU (CPU3) so we set overflow = 1 w/o
>> calling __dl_overflow(). We want to account fair_server_bw=52428
>> against 0 CPUs. 
>>
>> l B B l l l
>>
>>       ^^^
>>       isolcpus=[3,4]
>>
>>
>> cpumask_and(mask, rd->span, cpu_active_mask)
>>
>> mask = [3-5] & [0-3] = [3] -> dl_bw_cpus(3) = 1
>>
>> ---
>>
>> dl_bw_deactivate() called cpu=5
>>
>> dl_bw_deactivate() called cpu=4
>>
>> dl_bw_deactivate() called cpu=3
>>
>> dl_bw_cpus() cpu=6 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
>>                    ^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^
>>   cpumask_subset(rd->span, cpu_active_mask) is false
>>
>>   for_each_cpu_and(i, rd->span, cpu_active_mask)
>>     cpus++                                       <-- cpus is 1 !!!
>>
>> dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
>                                                           ^^^^^^
> This still looks wrong: with a single cpu remaining we should only have
> the corresponding dl server bandwidth present (unless there is some
> other DL task running.

That's true. '104856 - 52428 = 52428' so util of 51 ? Which is 50% of a
sugov task? Or exactly the fair_server_bw.

But the bw numbers don't matter here since we go straight into the else
path since dl_bw_cpus(3) = 1.

3587    if (dl_bw_cpus(cpu) - 1)
3588        overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
3589    else
3590        overflow = 1;

> If you already had the patch ignoring sugovs bandwidth in your set, could
> you please share the full dmesg?

Will do later today ... busy with other stuff right now ;-(

BTW, I just saw that this issue also happens for me w/o sugov threads
(running with Performance CPUfreq governor)! So the remaining
'total_bw=104856' must be the contribution from 2 CPUs of DEF. Maybe we
just have a CPU-offset in this accounting somewhere during suspend?

