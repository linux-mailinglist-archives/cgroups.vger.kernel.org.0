Return-Path: <cgroups+bounces-6973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B153A5C2AA
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 14:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D513B2D28
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45B1C1F07;
	Tue, 11 Mar 2025 13:29:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA2156880;
	Tue, 11 Mar 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699768; cv=none; b=ERG0HSyyHTMLi/kcT09n4pwlvFZ9eur+8krDr90bKg3DWXeyn9hiQrHO2DxvCeaPBL90l2ckKWCqbADyijAdXosFpX8BEf1dkO9IVqazV07IIG/S7gNys6rfic7mAZ09VTESG2waXyAqRwdUblJ1hw/3LyWheTuT4GNmzQGQpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699768; c=relaxed/simple;
	bh=gqeqJ0qwfHmM8KEVQQJqOUAcSknDweM1L7QmLhmF25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+SmWDm+B0BKSE8xTQZvtFDepCSX4qalxELlcQ64X5PJxrVUaUy9OzleF/RG1JTJn4JSlo5hnxrlWZVzYBvGlfWQkJcEW93J/bvRl3MabHpbZCrzxC33HWWa6ogs9F+5/F6n+zrom7iT1/liFrGXEE0526VmoIpqGHTX525+Uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA4511424;
	Tue, 11 Mar 2025 06:29:36 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9309E3F694;
	Tue, 11 Mar 2025 06:29:22 -0700 (PDT)
Message-ID: <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
Date: Tue, 11 Mar 2025 14:29:12 +0100
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
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/03/2025 13:34, Waiman Long wrote:
> On 3/11/25 7:59 AM, Juri Lelli wrote:
>> On 10/03/25 20:16, Waiman Long wrote:
>>> On 3/10/25 3:18 PM, Waiman Long wrote:
>>>> On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
>>>>> On 10/03/2025 10:37, Juri Lelli wrote:
>>>>>> Rebuilding of root domains accounting information (total_bw) is
>>>>>> currently broken on some cases, e.g. suspend/resume on aarch64.
>>>>>> Problem
>>>>> Nit: Couldn't spot any arch dependency here. I guess it was just
>>>>> tested
>>>>> on Arm64 platforms so far.
>>>>>
>>>>> [...]
>>>>>
>>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>>> index 44093339761c..363ad268a25b 100644
>>>>>> --- a/kernel/sched/topology.c
>>>>>> +++ b/kernel/sched/topology.c
>>>>>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int
>>>>>> ndoms_new, cpumask_var_t doms_new[],
>>>>>>        ndoms_cur = ndoms_new;
>>>>>>          update_sched_domain_debugfs();
>>>>>> +    dl_rebuild_rd_accounting();
>>>>> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
>>>>> barf when called via cpuhp's:
>>>>>
>>>>> sched_cpu_deactivate()
>>>>>
>>>>>     cpuset_cpu_inactive()
>>>>>
>>>>>       partition_sched_domains()
>>>>>
>>>>>         partition_sched_domains_locked()
>>>>>
>>>>>           dl_rebuild_rd_accounting()
>>>>>
>>>>> ?
>> Good catch. Guess I didn't notice while testing with LOCKDEP as I was
>> never able to hit this call path on my systems.
>>
>>>> Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be
>>>> called without holding cpuset mutex.
>>>>
>>>> Well, I think we will need an additional wrapper in cpuset.c that
>>>> acquires the cpuset_mutex first before calling
>>>> partition_sched_domains()
>>>> and use the new wrapper in these cases.
>>> Actually, partition_sched_domains() is called with the special
>>> arguments (1,
>>> NULL, NULL) to reset the domain to a single one. So perhaps something
>>> like
>>> the following will be enough to avoid this problem.
>> I think this would work, as we will still rebuild the accounting after
>> last CPU comes back from suspend. The thing I am still not sure about is
>> what we want to do in case we have DEADLINE tasks around, since with
>> this I belive we would be ignoring them and let suspend proceed.
> 
> That is the current behavior. You can certainly create a test case to
> trigger such condition and see what to do about it. Alternatively, you
> can document that and come up with a follow-up patch later on.

But don't we rely on that partition_sched_domains_locked() calls
dl_rebuild_rd_accounting() even in the reset_domain=1 case?

Testcase: suspend/resume

on Arm64 big.LITTLE cpumask=[LITTLE][big]=[0,3-5][1-2]
plus cmd line option 'isolcpus=3,4'.

with Waiman's snippet:
https://lkml.kernel.org/r/fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com

...
[  234.831675] --- > partition_sched_domains_locked() reset_domain=1
[  234.835966] psci: CPU4 killed (polled 0 ms)
[  234.838912] Error taking CPU3 down: -16
[  234.838952] Non-boot CPUs are not disabled
[  234.838986] Enabling non-boot CPUs ...
...

IIRC, that's the old DL accounting issue.

