Return-Path: <cgroups+bounces-6501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B10A3083D
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F253163DC2
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7571F3FD3;
	Tue, 11 Feb 2025 10:15:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2E21F3FC2;
	Tue, 11 Feb 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268957; cv=none; b=KcUVL6wVqGDB8fLOwBqD4Z1Y+oZogDkILyrWcs87AtLrxuhahg001VX6QVWe5RqZGpYr1UOu0vlRNz7YDe/GM/Sh3Ny0WNpeJYBI6Dl+/8HniOLBbMMfQtMT695+6r2OaHCu6yWQKHqWdcUEZL8ZDswRqjA1fI+aZnJbbXetCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268957; c=relaxed/simple;
	bh=AANQ4doGqqYCs1ixTUngiq7Ybau1E1MR40bQLIYvdrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3yHpNqMOo/Ir6UfUq+WLTfpKaTHl1UoaMnRwbo8thpUvnkIHEi0J4XKoFsZzbQrD06inGeYP77EZfy0g5bMk4NP+CQQpwfsoKyn17dm7jNSsq1RvFF+xv6n3iIYbNWFegUmM8yJo2LxnqfC4XQULDNZEaIwelNBzQCOhHzDdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 720C61424;
	Tue, 11 Feb 2025 02:16:16 -0800 (PST)
Received: from [10.57.37.40] (unknown [10.57.37.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E763F6A8;
	Tue, 11 Feb 2025 02:15:49 -0800 (PST)
Message-ID: <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
Date: Tue, 11 Feb 2025 10:15:47 +0000
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
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 17:09, Juri Lelli wrote:
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
>> The issue only triggers with sugov DL threads (I guess that's obvious, but
>> just to mention it).
> 
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
> 
> Hummm, need to think more about it.

That is indeed tricky.
I would've found it super appealing to always just have sugov DL tasks activate
on this_cpu and not have to worry about all this, but then you have contention
amongst CPUs of a cluster and there are energy improvements from always
having little cores handle all sugov DL tasks, even for the big CPUs,
that's why I introduced
commit 93940fbdc468 ("cpufreq/schedutil: Only bind threads if needed")
but that really doesn't make this any easier.



