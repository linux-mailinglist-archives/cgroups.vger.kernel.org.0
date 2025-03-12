Return-Path: <cgroups+bounces-7018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1FFA5E1D0
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867121778F1
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319DE23C367;
	Wed, 12 Mar 2025 16:29:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4211DB12D;
	Wed, 12 Mar 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796988; cv=none; b=O/kVSMhEo6jG+/dnVe3Tp1CrU5XACnfO4UYSHc6ZZzYegLFP7jdbN+dulhviBK+E6m7o8OSybrGNbpkfWK5C/atK4eXNYOCcwd7hJfZG/0J2ow4o/L80OgGtbv9fHfJVK7r8CAveOJDYd2HZLVZX00/0rE/dbEWd77ZqBr5kNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796988; c=relaxed/simple;
	bh=8nIEQw2kIR/hUK5MFQbGwUVMT7zzoKsY2rtqO689kv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMD5Zv8ONeeRi6zma+o1t9AgDH+8gqIav8MdsRtI6xxoRyfEs6Q9DUY0ObFkd23jvYSvCJHRC8kDDJz+wbUw+Qq1Q4KAg46UdwsgUonixDCPmeXMoue/CuTexyidx+p1i0eh0TLYhdTSWNl0jQSCAh8YaVfncD+eGPrUxdpUFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 652AD1515;
	Wed, 12 Mar 2025 09:29:54 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A115F3F694;
	Wed, 12 Mar 2025 09:29:40 -0700 (PDT)
Message-ID: <78bc0eda-7471-404d-a816-bd5f1a8d4b27@arm.com>
Date: Wed, 12 Mar 2025 17:29:39 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
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
References: <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
 <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
 <Z9GWAbxuddrTzCS9@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z9GWAbxuddrTzCS9@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2025 15:11, Juri Lelli wrote:
> On 12/03/25 09:55, Waiman Long wrote:
>> On 3/12/25 6:09 AM, Juri Lelli wrote:
>>> On 12/03/25 10:53, Dietmar Eggemann wrote:
>>>> On 11/03/2025 15:51, Waiman Long wrote:

[...]

>>> I unfortunately very much suspect !CPUSETS accounting is broken. But if
>>> that is indeed the case, it has been broken for a while. :(
>> Without CONFIG_CPUSETS, there will be one and only one global sched domain.
>> Will this still be a problem?
> 
> Still need to double check. But I have a feeling we don't restore
> accounting correctly (at all?!) without CPUSETS. Orthogonal to this
> issue though, as if we don't, we didn't so far. :/

As expected:

Since dl_rebuild_rd_accounting() is empty with !CONFIG_CPUSETS, the same
issue happens.

Testcase: suspend/resume

Test machine: Arm64 big.LITTLE cpumask=[LITTLE][big]=[0,3-5][1-2]
plus cmd line option 'isolcpus=3,4'.

...

[ 2250.898771] PM: suspend entry (deep)
[ 2250.902566] Filesystems sync: 0.000 seconds
[ 2250.908704] Freezing user space processes
[ 2250.914379] Freezing user space processes completed (elapsed 0.001
seconds)
[ 2250.921433] OOM killer disabled.
[ 2250.924702] Freezing remaining freezable tasks
[ 2250.930497] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
...
[ 2251.060052] Disabling non-boot CPUs ...
[ 2251.060426] CPU0 attaching NULL sched-domain.
[ 2251.060455] CPU1 attaching NULL sched-domain.
[ 2251.060478] CPU2 attaching NULL sched-domain.
[ 2251.060499] CPU5 attaching NULL sched-domain.
[ 2251.060712] CPU0 attaching sched-domain(s):
[ 2251.060723]  domain-0: span=0-2 level=PKG
[ 2251.060750]   groups: 0:{ span=0 cap=503 }, 1:{ span=1-2 cap=2048 }
[ 2251.060829] CPU1 attaching sched-domain(s):
[ 2251.060838]  domain-0: span=1-2 level=MC
[ 2251.060859]   groups: 1:{ span=1 }, 2:{ span=2 }
[ 2251.060906]   domain-1: span=0-2 level=PKG
[ 2251.060926]    groups: 1:{ span=1-2 cap=2048 }, 0:{ span=0 cap=503 }
[ 2251.061000] CPU2 attaching sched-domain(s):
[ 2251.061009]  domain-0: span=1-2 level=MC
[ 2251.061030]   groups: 2:{ span=2 }, 1:{ span=1 }
[ 2251.061077]   domain-1: span=0-2 level=PKG
[ 2251.061097]    groups: 1:{ span=1-2 cap=2048 }, 0:{ span=0 cap=503 }
[ 2251.061221] root domain span: 0-2
[ 2251.061270] root_domain 0-2: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
cpus=0,3-5 nr_pstate=5 }
[ 2251.064976] psci: CPU5 killed (polled 0 ms)
[ 2251.066211] Error taking CPU4 down: -16
[ 2251.066226] Non-boot CPUs are not disabled
[ 2251.066234] Enabling non-boot CPUs ...

[...]


