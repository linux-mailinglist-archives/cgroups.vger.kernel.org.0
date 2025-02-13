Return-Path: <cgroups+bounces-6548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C22A344D9
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C671722EC
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7F245009;
	Thu, 13 Feb 2025 14:57:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F71514F6;
	Thu, 13 Feb 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458661; cv=none; b=feFni6gyCvTFJmY5meVxdA6b2Avc0K8Zce6skNreawI7aOQQexonH7oYCW4H3FjD8KJH6ibGPzhcvBYGfFKRsJqOkyDWgr3t2eFKFpJiw31Ytsj1h6ZFw/Ka0UYnB0K7AqGh83PxeY25l6zIw7J9J81rFkBpcD1EC5+m8oljMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458661; c=relaxed/simple;
	bh=8IlDBEXcoBvI1XIyZRswCt/P+/n0c6RUPx6CCrMgBag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8eQc5zglMMeiU+FvWW4McyrHj2Xlf9bQOAnEEW9DkJk1n83edPcoVX5uPoWkOvs0JEGNNTdh8/lv+g2sfaTcAYP4vm65EzZgQYqr1ljACDfCorMdhmQN/Ec5GLnmOqYucFe1ieTVGrce8Tyb3zQUR81iT+XH/W/oqFNlk1dxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8634426AC;
	Thu, 13 Feb 2025 06:57:59 -0800 (PST)
Received: from [10.57.79.221] (unknown [10.57.79.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E53E3F58B;
	Thu, 13 Feb 2025 06:57:33 -0800 (PST)
Message-ID: <611a1604-b920-4963-8a1c-7e52bf8c81e5@arm.com>
Date: Thu, 13 Feb 2025 14:57:32 +0000
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
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
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
References: <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <c8f626ba-1be4-4c25-b283-d1e11a061aac@arm.com>
 <Z630nGN1IHhyYIYl@jlelli-thinkpadt14gen4.remote.csb>
 <9629f060-28f4-4743-9e60-688cba039f87@arm.com>
 <Z64HAYoBpu5jUUcb@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <Z64HAYoBpu5jUUcb@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 14:51, Juri Lelli wrote:
> On 13/02/25 13:38, Christian Loehle wrote:
>> On 2/13/25 13:33, Juri Lelli wrote:
> 
> ...
> 
>>> Not sure I get what your worry is, sorry. In my understanding when the
>>> last cpu of a policy/cluster gets offlined the corresponding sugov
>>> kthread gets stopped as well (sugov_exit)?
>>>
>>
>> The other way round.
>> We may have sugov kthread of cluster [6,7] affined to CPU1. Is it
>> guaranteed that we cannot offline CPU1 (while CPU6 or CPU7 are still
>> online)?
> 
> Uhu, is this a sane/desired setup? Anyway, I would say that if CPU1 is
> offlined sugov[6,7] will need to be migrated someplace else.

Sane? I guess that's to be discussed. It is definitely desirable
unfortunately.
As mentioned I experimented with having sugov DL tasks (as they cause
a lot of idle wakeups (which are expensive on the bigger CPUs)) both
always run locally and never IPI (but that means we have contention and
still run a double switch on an 'expensive' CPU) and run that on a little
CPU and the latter had much better results.

> 
>> Or without the affinity:
>> cluster [6,7] with isolcpu=6 (i.e. sugov kthread of that cluster can
>> only run on CPU7). Is offlining of CPU6 then prevented (as long as
>> CPU7 is online)?
>> I don't see how.
>> Anyway we probably want to change isolcpu and affinity to merely be 
>> a suggestion for the sugov DL case. Fundamentally it belongs to what
>> is run on that CPU anyway.
> 
> I would tend to agree.

I'll write something up.


