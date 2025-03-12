Return-Path: <cgroups+bounces-7006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F51A5D9EB
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 10:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194B4167938
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3A23C8A5;
	Wed, 12 Mar 2025 09:53:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C541E3DFC;
	Wed, 12 Mar 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773215; cv=none; b=fZqntCRknm+hEYbyyPAjiK5PAHHvKLkzOuLGnfroCjwb376sPPBRqLXiQfEExzPm5IRBqbk+TVAZ1TDBUS4EstwnpOhqQ/gth1xvRsJhLfhrPO7yS0wEWgkBHss3mIIWLGVXcvlLRd1kE5spml8LUII8hJkCVsyik3OSOFMNshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773215; c=relaxed/simple;
	bh=WFOi1DBsVVjuQ0WjnTCWrENVLWLA6uv3mISED+ocbAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUAYPXNdAalqES1R1FJr9+/5O5xqnZzLtkZynnapW/k00Jc+x/kedUIDn0ML98gBGp00gFH73JCXqlzHLCjVNav9UouLorsJoFEX2gGCKJEbSvI8OXDJr+A21NZXWh0Mdw5Hi6/hb5LBZ5xuFfG8Tcj5vQQgMM9+Z8aredwFzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26968152B;
	Wed, 12 Mar 2025 02:53:43 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F213F5A1;
	Wed, 12 Mar 2025 02:53:29 -0700 (PDT)
Message-ID: <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
Date: Wed, 12 Mar 2025 10:53:22 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Waiman Long <llong@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/03/2025 15:51, Waiman Long wrote:
> On 3/11/25 9:29 AM, Dietmar Eggemann wrote:
>> On 11/03/2025 13:34, Waiman Long wrote:
>>> On 3/11/25 7:59 AM, Juri Lelli wrote:
>>>> On 10/03/25 20:16, Waiman Long wrote:
>>>>> On 3/10/25 3:18 PM, Waiman Long wrote:
>>>>>> On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
>>>>>>> On 10/03/2025 10:37, Juri Lelli wrote:

[...]

>> Testcase: suspend/resume
>>
>> on Arm64 big.LITTLE cpumask=[LITTLE][big]=[0,3-5][1-2]
>> plus cmd line option 'isolcpus=3,4'.
>>
>> with Waiman's snippet:
>> https://lkml.kernel.org/r/fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com
>>
>> ...
>> [  234.831675] --- > partition_sched_domains_locked() reset_domain=1
>> [  234.835966] psci: CPU4 killed (polled 0 ms)
>> [  234.838912] Error taking CPU3 down: -16
>> [  234.838952] Non-boot CPUs are not disabled
>> [  234.838986] Enabling non-boot CPUs ...
>> ...
>>
>> IIRC, that's the old DL accounting issue.
> 
> You are right. cpuhp_tasks_frozen will be set in the suspend/resume
> case. In that case, we do need to add a cpuset helper to acquire the
> cpuset_mutex. A test patch as follows (no testing done yet):
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index c414daa7d503..ef1ffb9c52b0 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -129,6 +129,7 @@ extern void dl_rebuild_rd_accounting(void);
>  extern void rebuild_sched_domains(void);
> 
>  extern void cpuset_print_current_mems_allowed(void);
> +extern void cpuset_reset_sched_domains(void)
> 
>  /*
>   * read_mems_allowed_begin is required when making decisions involving
> @@ -269,6 +270,11 @@ static inline void rebuild_sched_domains(void)
>         partition_sched_domains(1, NULL, NULL);
>  }
> 
> +static inline void cpuset_reset_sched_domains(void)
> +{
> +       partition_sched_domains(1, NULL, NULL);
> +}
> +
>  static inline void cpuset_print_current_mems_allowed(void)
>  {
>  }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7995cd58a01b..a51099e5d587 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1076,6 +1076,13 @@ void rebuild_sched_domains(void)
>         cpus_read_unlock();
>  }
> 
> +void cpuset_reset_sched_domains(void)
> +{
> +       mutex_lock(&cpuset_mutex);
> +       partition_sched_domains(1, NULL, NULL);
> +       mutex_unlock(&cpuset_mutex);
> +}
> +
>  /**
>   * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the
> cpuset.
>   * @cs: the cpuset in which each task's cpus_allowed mask needs to be
> changed
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 58593f4d09a1..dbf44ddbb6b4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8183,7 +8183,7 @@ static void cpuset_cpu_active(void)
>                  * operation in the resume sequence, just build a single
> sched
>                  * domain, ignoring cpusets.
>                  */
> -               partition_sched_domains(1, NULL, NULL);
> +               cpuset_reset_sched_domains();
>                 if (--num_cpus_frozen)
>                         return;
>                 /*
> @@ -8202,7 +8202,7 @@ static void cpuset_cpu_inactive(unsigned int cpu)
>                 cpuset_update_active_cpus();
>         } else {
>                 num_cpus_frozen++;
> -               partition_sched_domains(1, NULL, NULL);
> +               cpuset_reset_sched_domains();
>         }
>  }

This seems to work. But what about a !CONFIG_CPUSETS build. In this case
we won't have this DL accounting update during suspend/resume since
dl_rebuild_rd_accounting() is empty.

