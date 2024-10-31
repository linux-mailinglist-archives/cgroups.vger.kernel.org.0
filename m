Return-Path: <cgroups+bounces-5348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C727D9B7449
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 07:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60410285E35
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808C13D518;
	Thu, 31 Oct 2024 06:06:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614808C07;
	Thu, 31 Oct 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354813; cv=none; b=XXk6h3X06bhzXQAsYnDiHSvZJJ29Q7iCDEHAoOenhZurvh4K+YDe4qUX88gde1cymANRbJht/aKhgD7vFJqzS5JnunWAVbGc1ITnQ8PDU6ZFq5zL/Bs/r+cVHdyttFiGHD75PsDPEubfafe/iMEhZzqdIERqnRCjyI+b0J245h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354813; c=relaxed/simple;
	bh=cOonUoOz1wvEYQ4wtOC7E6+CvgnA0ZLhja7g1tUdtzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZDRPxOeSLXsv+ovy6Mie9rkx2miRPQ6dFOjtwbv0GX+gHbAbqHrM3zexjnu6am3y8Zecciunse0eKc7eNkuW4VUkJSE6Fo9Q/DpaS8mxJ2wEQ+DcirrQc3ULwOLs1q6EaD7yhRPH/NS47xdbZ0xHNkI5uZoC8HuU/f54zu8wmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfD4R4RTcz6JB0Y;
	Thu, 31 Oct 2024 14:05:27 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id BDC8D140155;
	Thu, 31 Oct 2024 14:06:47 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 09:06:47 +0300
Message-ID: <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
Date: Thu, 31 Oct 2024 09:06:47 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Michal Hocko <mhocko@suse.com>, Gutierrez Asier
	<gutierrez.asier@huawei-partners.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <ZyJNizBQ-h4feuJe@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 10/30/2024 6:15 PM, Michal Hocko wrote:
> On Wed 30-10-24 17:58:04, Gutierrez Asier wrote:
>>
>>
>> On 10/30/2024 4:27 PM, Michal Hocko wrote:
>>> On Wed 30-10-24 15:51:00, Gutierrez Asier wrote:
>>>>
>>>>
>>>> On 10/30/2024 11:38 AM, Michal Hocko wrote:
>>>>> On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
>>>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>>>>
>>>>>> Currently THP modes are set globally. It can be an overkill if only some
>>>>>> specific app/set of apps need to get benefits from THP usage. Moreover, various
>>>>>> apps might need different THP settings. Here we propose a cgroup-based THP
>>>>>> control mechanism.
>>>>>>
>>>>>> THP interface is added to memory cgroup subsystem. Existing global THP control
>>>>>> semantics is supported for backward compatibility. When THP modes are set
>>>>>> globally all the changes are propagated to memory cgroups. However, when a
>>>>>> particular cgroup changes its THP policy, the global THP policy in sysfs remains
>>>>>> the same.
>>>>>
>>>>> Do you have any specific examples where this would be benefitial?
>>>>
>>>> Now we're mostly focused on database scenarios (MySQL, Redis).  
>>>
>>> That seems to be more process than workload oriented. Why the existing
>>> per-process tuning doesn't work?
>>>
>>> [...]
>>
>> 1st Point
>>
>> We're trying to provide a transparent mechanism, but all the existing per-process
>> methods require to modify an app itself (MADV_HUGE, MADV_COLLAPSE, hugetlbfs)

>
> There is also prctl to define per-process policy. We currently have
> means to disable THP for the process to override the defeault behavior.
> That would be mostly transparent for the application. 
(Answering as a co-author of the feature)

As prctl(PR_SET_THP_DISABLE) can only be used from the calling thread,
it needs app. developer participation anyway.
In theory, kind of a launcher-process can be used, to utilize the inheritance
of the corresponding prctl THP setting, but this seems not transparent
for the user-space.

And what if we'd like to enable THP for a specific set of unrelated (in terms of parent-child)
tasks?

IMHO, an alternative approach would be changing per-process THP-mode by PID,
thus also avoiding any user app. changes.
But that kind of thing doesn't exist yet.
Anyway, it would require maintaining a set of PIDs for a specific group of processes,
that's also some extra-work for a sysadmin.

>
> You have not really answered a more fundamental question though. Why the
> THP behavior should be at the cgroup scope? From a practical POV that
> would represent containers which are a mixed bag of applications to
> support the workload. Why does the same THP policy apply to all of them?

For THP there're 3 possible levels of fine-control:
- global THP
  - THP per-group of processes
     - THP per-process

I agree, that in a container, different apps might have different
THP requirements. 
But it also depends on many factors, such as:
container "size"(tiny/huge container), diversity of apps/functions inside a container.
I mean, for some cases, we might not need to go below "per-group" level in terms of THP control.

>
> Doesn't this make the sub-optimal global behavior the same on the cgroup
> level when some parts will benefit while others will not?
>

I think the key idea for the sub-optimal behavior is "predictability",
so we know for sure which apps/services would consume THPs.
We observed a significant THP usage on almost idle Ubuntu server, with simple test running,
(some random system services consumed few hundreds Mb of THPs).
Of course, on other distros me might have different situation.
But with fine-grained per-group control it's a lot more predictable.

Am i got you question right? 


>> Moreover we're using file-backed THPs too (for .text mostly), which make it for
>> user-space developers even more complicated.
>>
>>>>>> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
>>>>>> cgroup mode changes aren't propagated to child cgroups.
>>>>>
>>>>> So this breaks hierarchical property, doesn't it? In other words if a
>>>>> parent cgroup would like to enforce a certain policy to all descendants
>>>>> then this is not really possible. 
>>>>
>>>> The first idea was to have some flexibility when changing THP policies. 
>>>>
>>>> I will submit a new patch set which will enforce the cgroup hierarchy and change all
>>>> the children recursively.
>>>
>>> What is the expected semantics then?
>>
>> 2nd point (on semantics)
>> 1. Children inherit the THP policy upon creation
>> 2. Parent's policy changes are propagated to all the children
>> 3. Children can set the policy independently

>
> So if the parent decides that none of the children should be using THP
> they can override that so the tuning at parent has no imperative
> control. This is breaking hierarchical property that is expected from
> cgroup control files.

Actually, i think we can solve this.
As we mostly need just a single children level,
"flat" case (root->child) is enough, interpreting root-memcg THP mode as "global THP setting",
where sub-children are forbidden to override an inherited THP-mode.

