Return-Path: <cgroups+bounces-6536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC05A33F1E
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 13:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5631B168CA5
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AC22154D;
	Thu, 13 Feb 2025 12:27:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5D21129D;
	Thu, 13 Feb 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449645; cv=none; b=noKhz9J4aZ+Miu3gtizgDCRITwd/UA1vb7Y3RAPPSeZWqIuacbCyjfO4hamKjjQXW5iF/Xy0F9iYTMW/9Uu6IMGLlFVK0eAk4uF6RNK26T3ZoS/ymLp9QVpohnS+nqk9EcqWef9YLDZ6XYTCyCNootgOrS8IPUMeAX8CvQsP4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449645; c=relaxed/simple;
	bh=+QmYuPAHABMX4vLH2TEKmNj4lBa4gxCiB0qbdz4loiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qn/d84kZnrvpEOuO3wwRf1CNeYFiWPEfn7ettAAH9OiZ6ExJeZSLB/NvXTwoxFtKzNkdQd3XeqhN8/hl4wp1iLsyKpijC0weYhQDQ0TWVLMO2EFlwj5rj2+Ky1fS2K74CzoH5gEHoEiyAlD/nqde8qGqv1uoszekmMynkWptz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2077616F3;
	Thu, 13 Feb 2025 04:27:42 -0800 (PST)
Received: from [10.1.30.41] (e127648.arm.com [10.1.30.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7841C3F6A8;
	Thu, 13 Feb 2025 04:27:16 -0800 (PST)
Message-ID: <c8f626ba-1be4-4c25-b283-d1e11a061aac@arm.com>
Date: Thu, 13 Feb 2025 12:27:14 +0000
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
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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
References: <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 06:20, Juri Lelli wrote:
> On 12/02/25 19:22, Dietmar Eggemann wrote:
>> On 11/02/2025 11:42, Juri Lelli wrote:
> 
> ...
> 
>>> What about we actually ignore them consistently? We already do that for
>>> admission control, so maybe we can do that when rebuilding domains as
>>> well (until we find maybe a better way to deal with them).
>>>
>>> Does the following make any difference?
>>
>> It at least seems to solve the issue. And like you mentioned on irc, we
>> don't know the bw req of sugov anyway.
>>
>> So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.
>>
>> dl_rq[0]:
>>   .dl_nr_running                 : 0
>>   .dl_bw->bw                     : 996147
>>   .dl_bw->total_bw               : 0       <-- !
>>
>> IMHO, people who want to run serious DL can always check whether there
>> are already these infrastructural DL tasks or even avoid schedutil.
> 
> It definitely not ideal and admittedly gross, but not worse than what we
> are doing already considering we ignore sugovs at AC and the current
> bandwidth allocation its there only to help with PI. So, duck tape. :/
> 
> A more proper way to work with this would entail coming up with sensible
> bandwidth allocation for sugovs, but that's most probably hardware
> specific, so I am not sure how we can make that general enough.
> 
> Anyway, looks like Jon was still seeing the issue. I asked him to verify
> he is using all the proposed changes. Let's see what he reports.

FWIW it also fixes my reproducer.

I agree that dummy numbers for sugov bw is futile, but real bw numbers
also don't make a lot of sense (what if we exceed them? The system
won't be able to change frequency, i.e. might not be able to provide
bw for other DL tasks then either?).
I'm slightly worried about now allowing the last legal CPU for a sugov
cluster to offline, which would lead to a cluster still being active
but sugov DL unable to run anywhere. I can't reproduce this currently
though. Is this an issue in theory? Or am I missing something?


