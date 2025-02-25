Return-Path: <cgroups+bounces-6706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0BA43B03
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D263A313E
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278B126139E;
	Tue, 25 Feb 2025 10:09:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B01519A5;
	Tue, 25 Feb 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478181; cv=none; b=o8mXNBxYh36iMnYgSkPyHpNCEljO9qlCy78lz9mzToiwbhssZc6OanBRcyOM/g9VAFjeDuxHDUvpIjhWp/nalHyNojTf3eSh+lgIHtRuAAAYLGvvPJ9+r8BqNlNzWJN1IXDrZZKbeLUFSxbNemABz26qmRpS+DGSZpk97pqkd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478181; c=relaxed/simple;
	bh=bQ19GPyEpcj0UVq+Sl5IbDI1kfRuc1RHQHJ5d5vyfwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOjYi4XNwDE/jAdYO9gtH8B8To4itPmI2LZYPrCMuoJAYywiKgEvpUJaIlHuVAfgRXjfWDv2WUTMEIxJex0kzVDEWxSFqnCd+uRWJSiUGoCeCtt36T5RiHM7O7rbn6ZbndpQoQL2U5eazgfVr6yQInpLx7Mg5Y9dP8caj5xfGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEDF01516;
	Tue, 25 Feb 2025 02:09:54 -0800 (PST)
Received: from [10.1.35.64] (unknown [10.1.35.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C244C3F6A8;
	Tue, 25 Feb 2025 02:09:32 -0800 (PST)
Message-ID: <cbb364c8-5008-4fa4-b604-2d04e0095c9c@arm.com>
Date: Tue, 25 Feb 2025 10:09:30 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <20250216163340.ttwddti5pzuynsj5@airbuntu>
 <Z7NNHmGgrEF666W_@jlelli-thinkpadt14gen4.remote.csb>
 <20250222235936.jmyrfacutheqt5a2@airbuntu>
 <Z7w7g1zb0nfu9-C7@jlelli-thinkpadt14gen4.remote.csb>
 <20250225000237.nsgbibqigl6nhhdu@airbuntu>
 <Z72Rka_g1imcX5lt@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <Z72Rka_g1imcX5lt@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 09:46, Juri Lelli wrote:
> On 25/02/25 00:02, Qais Yousef wrote:
>> On 02/24/25 10:27, Juri Lelli wrote:
>>
>>>> Okay I see. The issue though is that for a DL system with power management
>>>> features on that warrant to wake up a sugov thread to update the frequency is
>>>> sort of half broken by design. I don't see the benefit over using RT in this
>>>> case. But I appreciate I could be misguided. So take it easy on me if it is
>>>> obviously wrong understanding :) I know in Android usage of DL has been
>>>> difficult, but many systems ship with slow switch hardware.
>>>>
>>>> How does DL handle the long softirqs from block and network layers by the way?
>>>> This has been in a practice a problem for RT tasks so they should be to DL.
>>>> sugov done in stopper should be handled similarly IMHO. I *think* it would be
>>>> simpler to masquerade sugov thread as irq pressure.
>>>
>>> Kind of a trick question :), as DL doesn't handle this kind of
>>
>> :-)
>>
>>> load/pressure explicitly. It is essentially agnostic about it. From a
>>> system design point of view though, I would say that one should take
>>> that into account and maybe convert sensible kthreads to DL, so that the
>>> overall bandwidth can be explicitly evaluated. If one doesn't do that
>>> probably a less sound approach is to treat anything not explicitly
>>> scheduled by DL, but still required from a system perspective, as
>>> overload and be more conservative when assigning bandwidth to DL tasks
>>> (i.e. reduce the maximum amount of available bandwidth, so that the
>>> system doesn't get saturated).
>>
>> Maybe I didn't understand your initial answer properly. But what I got is that
>> we set as DL to do what you just suggested of converting it kthread to DL to
>> take its bandwidth into account. But we have been lying about bandwidth so far
>> and it was ignored? (I saw early bailouts of SCHED_FLAG_SUGOV was set in
>> bandwidth related operations)
> 
> Ignored as to have something 'that works'. :)
> 
> But, it's definitely far from being good.
> 
>>>> You can use the rate_limit_us as a potential guide for how much bandwidth sugov
>>>> needs if moving it to another class really doesn't make sense instead?
>>>
>>> Or maybe try to estimate/measure how much utilization sugov threads are
>>> effectively using while running some kind of workload of interest and
>>> use that as an indication for DL runtime/period.
>>
>> I don't want to side track this thread. So maybe I should start a new thread to
>> discuss this. You might have seen my other series on consolidating cpufreq
>> updates. I'm not sure sugov can have a predictable period. Maybe runtime, but
>> it could run repeatedly, or it could be quite for a long time.
> 
> Doesn't need to have a predictable period. Sporadic (activations are not
> periodic) tasks work well with DEADLINE if one is able to come up with a
> sensible bandwidth allocation for them. So for sugov (and other
> kthreads) the system designer should be thinking about the amount of CPU
> to give to each kthread (runtime/period) and the granularity of such
> allocation (period).

The only really sensible choice I see is
rate_limit * some_constant_approximated_runtime
and on many systems that may yield >100% of the capacity.
Qais' proposed changes would even remove the theoretical rate_limit cap here.
A lot of complexity for something that is essentially a non-issue in practice
AFAICS...

