Return-Path: <cgroups+bounces-6656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F804A42221
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 14:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576341891464
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB724EF8C;
	Mon, 24 Feb 2025 13:53:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABBB24EF82;
	Mon, 24 Feb 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405207; cv=none; b=tU8I0kbkTk1YwUv/rAqTWf+UHnlEaVlj0l6pgCxn1HFF3v/z04SCqJLnPgKINbmxbRNidABBPuyKnj0A5ACCbtUuC/2fx8nOc0uSqTrOxhbQsnWxG5mkdI86/uuxR7H5ZKwLqKORkI+mnDfhzANYLiJlkIae4OGIXGJaL+JwFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405207; c=relaxed/simple;
	bh=mrMKNjm7xKjowNq2rZi5/6hqmUqQ9CYqs7eSZHaRlnE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sbyNeQWl92YCG6FWrEfQdEO6Fc3SFH4ev6XUKVq2UbkKgoG+oUUOMhJKoTrtmzBfCIvUpC5ev19vjO98IDpLrOLVJoiMuN/6KdEPUA70kgo6deeH5O8TKFUmC4eRTa0w7ffBkU0uwHO5Ty54Rm1H+ZpE2YbWIObCYbaTUpPcO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F95152B;
	Mon, 24 Feb 2025 05:53:40 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 058B63F5A1;
	Mon, 24 Feb 2025 05:53:19 -0800 (PST)
Message-ID: <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
Date: Mon, 24 Feb 2025 14:53:02 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Jon Hunter <jonathanh@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>
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
References: <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
Content-Language: en-US
In-Reply-To: <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/02/2025 15:45, Dietmar Eggemann wrote:
> On 21/02/2025 12:56, Jon Hunter wrote:
>>
>> On 20/02/2025 15:25, Juri Lelli wrote:
>>> On 20/02/25 11:40, Juri Lelli wrote:
>>>> On 19/02/25 19:14, Dietmar Eggemann wrote:
> 
> [...]
> 
>> Latest branch is not building for me ...
>>
>>   CC      kernel/time/hrtimer.o
>> In file included from kernel/sched/build_utility.c:88:
>> kernel/sched/topology.c: In function ‘partition_sched_domains’:
>> kernel/sched/topology.c:2817:9: error: implicit declaration of function
>> ‘dl_rebuild_rd_accounting’ [-Werror=implicit-function-declaration]
>>  2817 |         dl_rebuild_rd_accounting();
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> This should fix it for now:
> 
> -->8--
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52243dcc61ab..3484dda93a94 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,7 +954,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>         css_task_iter_end(&it);
>  }
>  
> -static void dl_rebuild_rd_accounting(void)
> +extern void dl_rebuild_rd_accounting(void);
> +
> +void dl_rebuild_rd_accounting(void)
>  {
>         struct cpuset *cs = NULL;
>         struct cgroup_subsys_state *pos_css;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9892e6fa3e57..60c9996ccf47 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2806,6 +2806,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>         update_sched_domain_debugfs();
>  }
>  
> +extern void dl_rebuild_rd_accounting(void);
> +
>  /*
>   * Call with hotplug lock held
>   */
> 
> 

Looks OK now for me.

So DL accounting in partition_and_rebuild_sched_domains() and
partition_sched_domains()!

This is a build from your branch:

https://github.com/jlelli/linux.git experimental/dl-debug

cpumask = [l B B l l l], isolcpus=3-4, no sugov tasks

---

[  464.034212] psci: CPU5 killed (polled 0 ms)
[  464.035211] dl_bw_manage: cpu=4 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DEF span=3-5
[  464.035294] dl_clear_root_domain: span=0-2 type=DYN
[  464.035306] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.035324] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.035341] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.035358] rd 0-2: Checking EAS, schedutil is mandatory
[  464.035369] dl_clear_root_domain_cpu: cpu=0
[  464.035375] dl_clear_root_domain: span=0-2 type=DYN
[  464.035384] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.035401] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.035418] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.035433] dl_clear_root_domain_cpu: cpu=3
[  464.035439] dl_clear_root_domain: span=3-5 type=DEF
[  464.035448] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=3-5 type=DEF
[  464.037088] psci: CPU4 killed (polled 0 ms)
[  464.037497] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=52428 dl_bw_cpus=1 type=DEF span=3-5
[  464.037576] dl_clear_root_domain: span=0-2 type=DYN
[  464.037588] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.037607] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.037624] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.037640] rd 0-2: Checking EAS, schedutil is mandatory
[  464.037651] dl_clear_root_domain_cpu: cpu=0
[  464.037658] dl_clear_root_domain: span=0-2 type=DYN
[  464.037667] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.037683] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.037700] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.037714] dl_clear_root_domain_cpu: cpu=3
[  464.037720] dl_clear_root_domain: span=3-5 type=DEF
[  464.038687] psci: CPU3 killed (polled 4 ms)

---
 
full suspend/resume log:

 [  464.867592] PM: suspend entry (deep)
[  463.871388] Filesystems sync: 0.000 seconds
[  463.881593] Freezing user space processes
[  463.887017] Freezing user space processes completed (elapsed 0.005 seconds)
[  463.894039] OOM killer disabled.
[  463.897294] Freezing remaining freezable tasks
[  463.903019] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  463.910482] printk: Suspending console(s) (use no_console_suspend to debug)
[  464.029605] Disabling non-boot CPUs ...
[  464.029783] dl_bw_manage: cpu=5 cap=2494 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0-2,5
[  464.029943] CPU0 attaching NULL sched-domain.
[  464.029953] span=3-4
[  464.029979] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2,5 type=DYN
[  464.030000] __dl_server_detach_root: cpu=0 rd_span=0-2,5 total_bw=157284
[  464.030014] rq_attach_root: cpu=0 old_span=NULL new_span=3-4
[  464.030029] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-4 type=DEF
[  464.030046] __dl_server_attach_root: cpu=0 rd_span=0,3-4 total_bw=157284
[  464.030059] CPU1 attaching NULL sched-domain.
[  464.030065] span=0,3-4
[  464.030087] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2,5 type=DYN
[  464.030104] __dl_server_detach_root: cpu=1 rd_span=1-2,5 total_bw=104856
[  464.030115] rq_attach_root: cpu=1 old_span=NULL new_span=0,3-4
[  464.030128] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-1,3-4 type=DEF
[  464.030144] __dl_server_attach_root: cpu=1 rd_span=0-1,3-4 total_bw=209712
[  464.030156] CPU2 attaching NULL sched-domain.
[  464.030161] span=0-1,3-4
[  464.030182] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=2,5 type=DYN
[  464.030198] __dl_server_detach_root: cpu=2 rd_span=2,5 total_bw=52428
[  464.030210] rq_attach_root: cpu=2 old_span=NULL new_span=0-1,3-4
[  464.030222] __dl_add: cpus=5 tsk_bw=52428 total_bw=262140 span=0-4 type=DEF
[  464.030238] __dl_server_attach_root: cpu=2 rd_span=0-4 total_bw=262140
[  464.030249] CPU5 attaching NULL sched-domain.
[  464.030255] span=0-4
[  464.030264] rq_attach_root: cpu=5 old_span= new_span=0-4
[  464.030428] CPU0 attaching sched-domain(s):
[  464.030435]  domain-0: span=0-2 level=PKG
[  464.030452]   groups: 0:{ span=0 cap=445 }, 1:{ span=1-2 cap=2040 }
[  464.030505] __dl_sub: cpus=5 tsk_bw=52428 total_bw=209712 span=0-5 type=DEF
[  464.030523] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=209712
[  464.030534] rq_attach_root: cpu=0 old_span=NULL new_span=
[  464.030546] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  464.030562] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
[  464.030575] CPU1 attaching sched-domain(s):
[  464.030581]  domain-0: span=1-2 level=MC
[  464.030594]   groups: 1:{ span=1 cap=1019 }, 2:{ span=2 cap=1021 }
[  464.030684]   domain-1: span=0-2 level=PKG
[  464.030698]    groups: 1:{ span=1-2 cap=2040 }, 0:{ span=0 cap=445 }
[  464.030748] __dl_sub: cpus=4 tsk_bw=52428 total_bw=157284 span=1-5 type=DEF
[  464.030766] __dl_server_detach_root: cpu=1 rd_span=1-5 total_bw=157284
[  464.030778] rq_attach_root: cpu=1 old_span=NULL new_span=0
[  464.030790] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  464.030806] __dl_server_attach_root: cpu=1 rd_span=0-1 total_bw=104856
[  464.030819] CPU2 attaching sched-domain(s):
[  464.030826]  domain-0: span=1-2 level=MC
[  464.030839]   groups: 2:{ span=2 cap=1021 }, 1:{ span=1 cap=1019 }
[  464.030879]   domain-1: span=0-2 level=PKG
[  464.030892]    groups: 1:{ span=1-2 cap=2040 }, 0:{ span=0 cap=445 }
[  464.030943] __dl_sub: cpus=3 tsk_bw=52428 total_bw=104856 span=2-5 type=DEF
[  464.030960] __dl_server_detach_root: cpu=2 rd_span=2-5 total_bw=104856
[  464.030971] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
[  464.030984] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.030999] __dl_server_attach_root: cpu=2 rd_span=0-2 total_bw=157284
[  464.031055] root domain span: 0-2
[  464.031062] default domain span: 3-5
[  464.031092] rd 0-2: Checking EAS, schedutil is mandatory
[  464.032315] dl_clear_root_domain_cpu: cpu=0
[  464.032324] dl_clear_root_domain: span=0-2 type=DYN
[  464.032336] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.032354] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.032370] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.032385] dl_clear_root_domain_cpu: cpu=3
[  464.032392] dl_clear_root_domain: span=3-5 type=DEF
[  464.032401] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=3-5 type=DEF
[  464.032421] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DEF
[  464.034212] psci: CPU5 killed (polled 0 ms)
[  464.035211] dl_bw_manage: cpu=4 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DEF span=3-5
[  464.035294] dl_clear_root_domain: span=0-2 type=DYN
[  464.035306] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.035324] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.035341] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.035358] rd 0-2: Checking EAS, schedutil is mandatory
[  464.035369] dl_clear_root_domain_cpu: cpu=0
[  464.035375] dl_clear_root_domain: span=0-2 type=DYN
[  464.035384] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.035401] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.035418] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.035433] dl_clear_root_domain_cpu: cpu=3
[  464.035439] dl_clear_root_domain: span=3-5 type=DEF
[  464.035448] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=3-5 type=DEF
[  464.037088] psci: CPU4 killed (polled 0 ms)
[  464.037497] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=52428 dl_bw_cpus=1 type=DEF span=3-5
[  464.037576] dl_clear_root_domain: span=0-2 type=DYN
[  464.037588] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.037607] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.037624] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.037640] rd 0-2: Checking EAS, schedutil is mandatory
[  464.037651] dl_clear_root_domain_cpu: cpu=0
[  464.037658] dl_clear_root_domain: span=0-2 type=DYN
[  464.037667] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  464.037683] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.037700] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  464.037714] dl_clear_root_domain_cpu: cpu=3
[  464.037720] dl_clear_root_domain: span=3-5 type=DEF
[  464.038687] psci: CPU3 killed (polled 4 ms)
[  464.039106] dl_bw_manage: cpu=2 cap=1470 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3 type=DYN span=0-2
[  464.039317] CPU0 attaching NULL sched-domain.
[  464.039328] span=3-5
[  464.039358] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  464.039384] __dl_server_detach_root: cpu=0 rd_span=0-2 total_bw=104856
[  464.039401] rq_attach_root: cpu=0 old_span=NULL new_span=3-5
[  464.039419] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DEF
[  464.039439] __dl_server_attach_root: cpu=0 rd_span=0,3-5 total_bw=52428
[  464.039456] CPU1 attaching NULL sched-domain.
[  464.039465] span=0,3-5
[  464.039491] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=1-2 type=DYN
[  464.039512] __dl_server_detach_root: cpu=1 rd_span=1-2 total_bw=52428
[  464.039527] rq_attach_root: cpu=1 old_span=NULL new_span=0,3-5
[  464.039544] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1,3-5 type=DEF
[  464.039563] __dl_server_attach_root: cpu=1 rd_span=0-1,3-5 total_bw=104856
[  464.039578] CPU2 attaching NULL sched-domain.
[  464.039588] span=0-1,3-5
[  464.039602] rq_attach_root: cpu=2 old_span= new_span=0-1,3-5
[  464.039754] CPU0 attaching sched-domain(s):
[  464.039763]  domain-0: span=0-1 level=PKG
[  464.039786]   groups: 0:{ span=0 cap=444 }, 1:{ span=1 cap=1015 }
[  464.039869] __dl_sub: cpus=2 tsk_bw=52428 total_bw=52428 span=0-5 type=DEF
[  464.039892] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=52428
[  464.039906] rq_attach_root: cpu=0 old_span=NULL new_span=
[  464.039923] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  464.039942] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
[  464.039962] CPU1 attaching sched-domain(s):
[  464.039972]  domain-0: span=0-1 level=PKG
[  464.039992]   groups: 1:{ span=1 cap=1015 }, 0:{ span=0 cap=444 }
[  464.040071] __dl_sub: cpus=1 tsk_bw=52428 total_bw=0 span=1-5 type=DEF
[  464.040091] __dl_server_detach_root: cpu=1 rd_span=1-5 total_bw=0
[  464.040105] rq_attach_root: cpu=1 old_span=NULL new_span=0
[  464.040120] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  464.040139] __dl_server_attach_root: cpu=1 rd_span=0-1 total_bw=104856
[  464.040206] root domain span: 0-1
[  464.040217] default domain span: 2-5
[  464.040250] rd 0-1: Checking EAS, schedutil is mandatory
[  464.041269] dl_clear_root_domain_cpu: cpu=0
[  464.041279] dl_clear_root_domain: span=0-1 type=DYN
[  464.041294] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=0-1 type=DYN
[  464.041319] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  464.041339] dl_clear_root_domain_cpu: cpu=2
[  464.041347] dl_clear_root_domain: span=2-5 type=DEF
[  464.042683] psci: CPU2 killed (polled 4 ms)
[  464.043689] dl_bw_manage: cpu=1 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DYN span=0-1
[  464.043889] CPU0 attaching NULL sched-domain.
[  464.043901] span=2-5
[  464.043930] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=0-1 type=DYN
[  464.043957] __dl_server_detach_root: cpu=0 rd_span=0-1 total_bw=52428
[  464.043974] rq_attach_root: cpu=0 old_span=NULL new_span=2-5
[  464.043996] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0,2-5 type=DEF
[  464.044018] __dl_server_attach_root: cpu=0 rd_span=0,2-5 total_bw=52428
[  464.044034] CPU1 attaching NULL sched-domain.
[  464.044044] span=0,2-5
[  464.044058] rq_attach_root: cpu=1 old_span= new_span=0,2-5
[  464.044178] CPU0 attaching NULL sched-domain.
[  464.044188] span=0-5
[  464.044213] __dl_sub: cpus=1 tsk_bw=52428 total_bw=0 span=0-5 type=DEF
[  464.044236] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=0
[  464.044251] rq_attach_root: cpu=0 old_span=NULL new_span=
[  464.044267] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  464.044288] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
[  464.044303] root domain span: 0
[  464.044313] default domain span: 1-5
[  464.044343] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[  464.044677] dl_clear_root_domain_cpu: cpu=0
[  464.044688] dl_clear_root_domain: span=0 type=DYN
[  464.044701] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  464.044722] dl_clear_root_domain_cpu: cpu=1
[  464.044731] dl_clear_root_domain: span=1-5 type=DEF
[  464.081574] psci: CPU1 killed (polled 0 ms)
[  464.082786] PM: suspend debug: Waiting for 5 second(s).
[  469.083692] Enabling non-boot CPUs ...
[  469.085209] Detected PIPT I-cache on CPU1
[  469.085316] CPU1: Booted secondary processor 0x0000000000 [0x410fd070]
[  469.118495] SCMI Notifications - Failed to ENABLE events for key:13000000 !
[  469.118545] CPU0 attaching NULL sched-domain.
[  469.118555] span=1-5
[  469.118601] __dl_sub: cpus=1 tsk_bw=52428 total_bw=0 span=0 type=DYN
[  469.118630] __dl_server_detach_root: cpu=0 rd_span=0 total_bw=0
[  469.118647] rq_attach_root: cpu=0 old_span= new_span=1-5
[  469.118668] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=0-5 type=DEF
[  469.118689] __dl_server_attach_root: cpu=0 rd_span=0-5 total_bw=52428
[  469.118843] CPU0 attaching sched-domain(s):
[  469.118853]  domain-0: span=0-1 level=PKG
[  469.118876]   groups: 0:{ span=0 cap=445 }, 1:{ span=1 cap=1023 }
[  469.118961] __dl_sub: cpus=2 tsk_bw=52428 total_bw=0 span=0-5 type=DEF
[  469.118984] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=0
[  469.118998] rq_attach_root: cpu=0 old_span=NULL new_span=
[  469.119014] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  469.119033] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
[  469.119052] CPU1 attaching sched-domain(s):
[  469.119062]  domain-0: span=0-1 level=PKG
[  469.119082]   groups: 1:{ span=1 cap=1023 }, 0:{ span=0 cap=445 }
[  469.119148] rq_attach_root: cpu=1 old_span=NULL new_span=0
[  469.119165] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  469.119185] __dl_server_attach_root: cpu=1 rd_span=0-1 total_bw=104856
[  469.119254] root domain span: 0-1
[  469.119264] default domain span: 2-5
[  469.119297] rd 0-1: Checking EAS, schedutil is mandatory
[  469.119559] dl_clear_root_domain_cpu: cpu=0
[  469.119569] dl_clear_root_domain: span=0-1 type=DYN
[  469.119583] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=0-1 type=DYN
[  469.119604] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  469.119624] dl_clear_root_domain_cpu: cpu=2
[  469.119632] dl_clear_root_domain: span=2-5 type=DEF
[  469.119683] CPU1 is up
[  469.121171] Detected PIPT I-cache on CPU2
[  469.121260] CPU2: Booted secondary processor 0x0000000001 [0x410fd070]
[  469.121900] CPU0 attaching NULL sched-domain.
[  469.121913] span=2-5
[  469.121950] __dl_sub: cpus=2 tsk_bw=52428 total_bw=52428 span=0-1 type=DYN
[  469.121979] __dl_server_detach_root: cpu=0 rd_span=0-1 total_bw=52428
[  469.121996] rq_attach_root: cpu=0 old_span=NULL new_span=2-5
[  469.122014] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=0,2-5 type=DEF
[  469.122035] __dl_server_attach_root: cpu=0 rd_span=0,2-5 total_bw=52428
[  469.122051] CPU1 attaching NULL sched-domain.
[  469.122060] span=0,2-5
[  469.122088] __dl_sub: cpus=1 tsk_bw=52428 total_bw=0 span=1 type=DYN
[  469.122109] __dl_server_detach_root: cpu=1 rd_span=1 total_bw=0
[  469.122124] rq_attach_root: cpu=1 old_span= new_span=0,2-5
[  469.122143] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-5 type=DEF
[  469.122162] __dl_server_attach_root: cpu=1 rd_span=0-5 total_bw=104856
[  469.122344] CPU0 attaching sched-domain(s):
[  469.122354]  domain-0: span=0-2 level=PKG
[  469.122376]   groups: 0:{ span=0 cap=445 }, 1:{ span=1-2 cap=2046 }
[  469.122499] __dl_sub: cpus=3 tsk_bw=52428 total_bw=52428 span=0-5 type=DEF
[  469.122523] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=52428
[  469.122538] rq_attach_root: cpu=0 old_span=NULL new_span=
[  469.122554] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  469.122573] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
[  469.122592] CPU1 attaching sched-domain(s):
[  469.122601]  domain-0: span=1-2 level=MC
[  469.122621]   groups: 1:{ span=1 cap=1022 }, 2:{ span=2 }
[  469.122680]   domain-1: span=0-2 level=PKG
[  469.122699]    groups: 1:{ span=1-2 cap=2046 }, 0:{ span=0 cap=445 }
[  469.122778] __dl_sub: cpus=2 tsk_bw=52428 total_bw=0 span=1-5 type=DEF
[  469.122799] __dl_server_detach_root: cpu=1 rd_span=1-5 total_bw=0
[  469.122813] rq_attach_root: cpu=1 old_span=NULL new_span=0
[  469.122829] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  469.122848] __dl_server_attach_root: cpu=1 rd_span=0-1 total_bw=104856
[  469.122865] CPU2 attaching sched-domain(s):
[  469.122875]  domain-0: span=1-2 level=MC
[  469.122894]   groups: 2:{ span=2 }, 1:{ span=1 cap=1022 }
[  469.122951]   domain-1: span=0-2 level=PKG
[  469.122970]    groups: 1:{ span=1-2 cap=2046 }, 0:{ span=0 cap=445 }
[  469.123035] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
[  469.123052] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.123071] __dl_server_attach_root: cpu=2 rd_span=0-2 total_bw=157284
[  469.123139] root domain span: 0-2
[  469.123149] default domain span: 3-5
[  469.123184] rd 0-2: Checking EAS, schedutil is mandatory
[  469.124043] dl_clear_root_domain_cpu: cpu=0
[  469.124053] dl_clear_root_domain: span=0-2 type=DYN
[  469.124067] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  469.124089] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  469.124108] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.124126] dl_clear_root_domain_cpu: cpu=3
[  469.124134] dl_clear_root_domain: span=3-5 type=DEF
[  469.124188] CPU2 is up
[  469.125145] Detected VIPT I-cache on CPU3
[  469.125236] CPU3: Booted secondary processor 0x0000000101 [0x410fd030]
[  469.125804] dl_clear_root_domain: span=0-2 type=DYN
[  469.125821] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  469.125841] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  469.125859] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.125877] rd 0-2: Checking EAS, schedutil is mandatory
[  469.125887] dl_clear_root_domain_cpu: cpu=0
[  469.125894] dl_clear_root_domain: span=0-2 type=DYN
[  469.125904] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  469.125920] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  469.125936] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.125951] dl_clear_root_domain_cpu: cpu=3
[  469.125958] dl_clear_root_domain: span=3-5 type=DEF
[  469.125967] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=3-5 type=DEF
[  469.126017] CPU3 is up
[  469.126368] Detected VIPT I-cache on CPU4
[  469.126439] CPU4: Booted secondary processor 0x0000000102 [0x410fd030]
[  469.126950] dl_clear_root_domain: span=0-2 type=DYN
[  469.126966] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  469.126986] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  469.127003] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.127020] rd 0-2: Checking EAS, schedutil is mandatory
[  469.127030] dl_clear_root_domain_cpu: cpu=0
[  469.127037] dl_clear_root_domain: span=0-2 type=DYN
[  469.127047] __dl_add: cpus=3 tsk_bw=52428 total_bw=52428 span=0-2 type=DYN
[  469.127063] __dl_add: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  469.127079] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.127094] dl_clear_root_domain_cpu: cpu=3
[  469.127100] dl_clear_root_domain: span=3-5 type=DEF
[  469.127110] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=3-5 type=DEF
[  469.127126] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DEF
[  469.127175] CPU4 is up
[  469.127529] Detected VIPT I-cache on CPU5
[  469.127597] CPU5: Booted secondary processor 0x0000000103 [0x410fd030]
[  469.128253] CPU0 attaching NULL sched-domain.
[  469.128261] span=3-5
[  469.128294] __dl_sub: cpus=3 tsk_bw=52428 total_bw=104856 span=0-2 type=DYN
[  469.128314] __dl_server_detach_root: cpu=0 rd_span=0-2 total_bw=104856
[  469.128326] rq_attach_root: cpu=0 old_span=NULL new_span=3-5
[  469.128341] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DEF
[  469.128358] __dl_server_attach_root: cpu=0 rd_span=0,3-5 total_bw=157284
[  469.128370] CPU1 attaching NULL sched-domain.
[  469.128376] span=0,3-5
[  469.128395] __dl_sub: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DYN
[  469.128412] __dl_server_detach_root: cpu=1 rd_span=1-2 total_bw=52428
[  469.128423] rq_attach_root: cpu=1 old_span=NULL new_span=0,3-5
[  469.128436] __dl_add: cpus=5 tsk_bw=52428 total_bw=209712 span=0-1,3-5 type=DEF
[  469.128453] __dl_server_attach_root: cpu=1 rd_span=0-1,3-5 total_bw=209712
[  469.128465] CPU2 attaching NULL sched-domain.
[  469.128470] span=0-1,3-5
[  469.128490] __dl_sub: cpus=1 tsk_bw=52428 total_bw=0 span=2 type=DYN
[  469.128506] __dl_server_detach_root: cpu=2 rd_span=2 total_bw=0
[  469.128518] rq_attach_root: cpu=2 old_span= new_span=0-1,3-5
[  469.128531] __dl_add: cpus=6 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
[  469.128547] __dl_server_attach_root: cpu=2 rd_span=0-5 total_bw=262140
[  469.128739] CPU0 attaching sched-domain(s):
[  469.128747]  domain-0: span=0,5 level=MC
[  469.128763]   groups: 0:{ span=0 cap=445 }, 5:{ span=5 cap=446 }
[  469.128804]   domain-1: span=0-2,5 level=PKG
[  469.128818]    groups: 0:{ span=0,5 cap=891 }, 1:{ span=1-2 cap=2042 }
[  469.128871] __dl_sub: cpus=6 tsk_bw=52428 total_bw=209712 span=0-5 type=DEF
[  469.128888] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=209712
[  469.128899] rq_attach_root: cpu=0 old_span=NULL new_span=
[  469.128911] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
[  469.128928] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
[  469.128941] CPU1 attaching sched-domain(s):
[  469.128947]  domain-0: span=1-2 level=MC
[  469.128961]   groups: 1:{ span=1 cap=1019 }, 2:{ span=2 cap=1023 }
[  469.129001]   domain-1: span=0-2,5 level=PKG
[  469.129014]    groups: 1:{ span=1-2 cap=2042 }, 0:{ span=0,5 cap=891 }
[  469.129065] __dl_sub: cpus=5 tsk_bw=52428 total_bw=157284 span=1-5 type=DEF
[  469.129083] __dl_server_detach_root: cpu=1 rd_span=1-5 total_bw=157284
[  469.129094] rq_attach_root: cpu=1 old_span=NULL new_span=0
[  469.129106] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0-1 type=DYN
[  469.129122] __dl_server_attach_root: cpu=1 rd_span=0-1 total_bw=104856
[  469.129135] CPU2 attaching sched-domain(s):
[  469.129141]  domain-0: span=1-2 level=MC
[  469.129154]   groups: 2:{ span=2 cap=1023 }, 1:{ span=1 cap=1019 }
[  469.129194]   domain-1: span=0-2,5 level=PKG
[  469.129208]    groups: 1:{ span=1-2 cap=2042 }, 0:{ span=0,5 cap=891 }
[  469.129258] __dl_sub: cpus=4 tsk_bw=52428 total_bw=104856 span=2-5 type=DEF
[  469.129275] __dl_server_detach_root: cpu=2 rd_span=2-5 total_bw=104856
[  469.129286] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
[  469.129299] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DYN
[  469.129314] __dl_server_attach_root: cpu=2 rd_span=0-2 total_bw=157284
[  469.129327] CPU5 attaching sched-domain(s):
[  469.129333]  domain-0: span=0,5 level=MC
[  469.129347]   groups: 5:{ span=5 cap=446 }, 0:{ span=0 cap=445 }
[  469.129387]   domain-1: span=0-2,5 level=PKG
[  469.129400]    groups: 0:{ span=0,5 cap=891 }, 1:{ span=1-2 cap=2042 }
[  469.129442] rq_attach_root: cpu=5 old_span=NULL new_span=0-2
[  469.129455] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-2,5 type=DYN
[  469.129472] __dl_server_attach_root: cpu=5 rd_span=0-2,5 total_bw=209712
[  469.129528] root domain span: 0-2,5
[  469.129536] default domain span: 3-4
[  469.129565] rd 0-2,5: Checking EAS, schedutil is mandatory
[  469.130838] dl_clear_root_domain_cpu: cpu=0
[  469.130848] dl_clear_root_domain: span=0-2,5 type=DYN
[  469.130860] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0-2,5 type=DYN
[  469.130881] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0-2,5 type=DYN
[  469.130898] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0-2,5 type=DYN
[  469.130915] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-2,5 type=DYN
[  469.130930] dl_clear_root_domain_cpu: cpu=3
[  469.130936] dl_clear_root_domain: span=3-4 type=DEF
[  469.130945] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=3-4 type=DEF
[  469.130961] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=3-4 type=DEF
[  469.130986] dl_clear_root_domain: span=0-2,5 type=DYN
[  469.130996] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0-2,5 type=DYN
[  469.131012] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0-2,5 type=DYN
[  469.131029] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0-2,5 type=DYN
[  469.131045] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-2,5 type=DYN
[  469.131062] rd 0-2,5: Checking EAS, schedutil is mandatory
[  469.131072] dl_clear_root_domain_cpu: cpu=0
[  469.131078] dl_clear_root_domain: span=0-2,5 type=DYN
[  469.131088] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0-2,5 type=DYN
[  469.131105] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0-2,5 type=DYN
[  469.131122] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0-2,5 type=DYN
[  469.131138] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-2,5 type=DYN
[  469.131153] dl_clear_root_domain_cpu: cpu=3
[  469.131160] dl_clear_root_domain: span=3-4 type=DEF
[  469.131169] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=3-4 type=DEF
[  469.131185] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=3-4 type=DEF
[  469.131237] CPU5 is up
[  471.429916] OOM killer enabled.
[  471.433116] Restarting tasks ... done.
[  471.437876] random: crng reseeded on system resumption
[  471.443635] PM: suspend exit

