Return-Path: <cgroups+bounces-5352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292C09B7D0A
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 15:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90A31F22516
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32071A0718;
	Thu, 31 Oct 2024 14:37:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2A1A254E;
	Thu, 31 Oct 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385441; cv=none; b=bv8g5JC5DYATezPSb9ZaGy0axC+Kt08WCamB5kqfIpSkdcd/iqlCoNIqmwYG2wyo/g3IkWnjXlsom+i+aW5IKa4M31yBlbjk2+6IORoJ3Q7WJifq7hXluW9c8PEBWhjolWCkXC/2b+Nihnzg6g5RplcLGLvfDqXlYhYdqnq1yC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385441; c=relaxed/simple;
	bh=6GoRtG2HGHof+Swg0uZodrtOJvo6tEr4XL/+WVpNDiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oqNCnOJRu/VfUrWjyiwzBZXDLZMNurJ6ql7W5IFN1YDDKOuF8UNt9aH8nRTurv4535BgWexMBUedIqychE/JjB+MFbZ3b7jfV66az1XrTq+GYiHbXiBB5K8llj4oIm+pPg9XHI+2cQpKEcPFm+d5k5Nc+pJipbeYLVfUpApB0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfRKK3h1Jz6GC0G;
	Thu, 31 Oct 2024 22:32:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id F0343140136;
	Thu, 31 Oct 2024 22:37:13 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 17:37:13 +0300
Message-ID: <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
Date: Thu, 31 Oct 2024 17:37:12 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Michal Hocko <mhocko@suse.com>
CC: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>, <nikita.panov@huawei-partners.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <ZyNAxnOqOfYvqxjc@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 10/31/2024 11:33 AM, Michal Hocko wrote:
> On Thu 31-10-24 09:06:47, Stepanov Anatoly wrote:
> [...]
>> As prctl(PR_SET_THP_DISABLE) can only be used from the calling thread,
>> it needs app. developer participation anyway.
>> In theory, kind of a launcher-process can be used, to utilize the inheritance
>> of the corresponding prctl THP setting, but this seems not transparent
>> for the user-space.

> 
> No, this is not in theaory. This is a very common usage pattern to allow
> changing the behavior for the target application transparently.
> 
>> And what if we'd like to enable THP for a specific set of unrelated (in terms of parent-child)
>> tasks?
> 
> This is what I've had in mind. Currently we only have THP disable
> option. If we really need an override to enforce THP on an application
> then this could be a more viable path.
> 
>> IMHO, an alternative approach would be changing per-process THP-mode by PID,
>> thus also avoiding any user app. changes.

> 
> We already have process_madvise. MADV_HUGEPAGE resp. MADV_COLLAPSE are
> not supported but we can discuss that option of course. This interface
> requires much more orchestration of course because it is VMA range
> based.
> 
If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
THP mode property for several tasks at once, in this case some batch-change approach needed.

if, for example, process_madvise() would support task recursive logic, coupled with kind of
MADV_HUGE + *ITERATE_ALL_VMA*, it would be helpful.
In this case, the orchestration will be much easier.

>>> You have not really answered a more fundamental question though. Why the
>>> THP behavior should be at the cgroup scope? From a practical POV that
>>> would represent containers which are a mixed bag of applications to
>>> support the workload. Why does the same THP policy apply to all of them?
>>
>> For THP there're 3 possible levels of fine-control:
>> - global THP
>>   - THP per-group of processes
>>      - THP per-process
>>
>> I agree, that in a container, different apps might have different
>> THP requirements. 
>> But it also depends on many factors, such as:
>> container "size"(tiny/huge container), diversity of apps/functions inside a container.
>> I mean, for some cases, we might not need to go below "per-group" level in terms of THP control.
> 
> I am sorry but I do not really see any argument why this should be
> per-memcg. Quite contrary. having that per memcg seems more muddy.
> 
>>> Doesn't this make the sub-optimal global behavior the same on the cgroup
>>> level when some parts will benefit while others will not?
>>>
>>
>> I think the key idea for the sub-optimal behavior is "predictability",
>> so we know for sure which apps/services would consume THPs.
> 
> OK, that seems fair.
> 
>> We observed a significant THP usage on almost idle Ubuntu server, with simple test running,
>> (some random system services consumed few hundreds Mb of THPs).
> 
> I assume that you are using Always as global default configuration,
> right? If that is the case then the high (in fact as high as feasible)
> THP utilization is a real goal. If you want more targeted THP use then
> madvise is what you are looking for. This will not help applications
> which are not THP aware of course but then we are back to the discussion
> whether the interface should be per a) per process b) per cgroup c)
> process_madvise.
> 
>> Of course, on other distros me might have different situation.
>> But with fine-grained per-group control it's a lot more predictable.
>>
>> Am i got you question right? 

> 
> Not really but at least I do understand (hopefully) that you are trying
> to workaround THP overuse by changing the global default to be more
> restrictive while some workloads to be less restrictive. The question
> why pushing that down to memcg scope makes the situation better is not
> answered AFAICT.
>
Don't get us wrong, we're not trying to push this into memcg specifically. 
We're just trying to find a proper/friendly way to control
THP mode for a group of processes (which can be tasks without common parent).

May be if the process grouping logic were decoupled from hierarchical resource control
logic, it could be possible to gather multiple process, and batch-control some task properties.
But it would require to build kind of task properties system, where
a given set of properties can be flexibly assigned to one or more tasks.

Anyway, i think we gonna try alternative
approaches first.(prctl, process_madvise).
 
> [...]
>>> So if the parent decides that none of the children should be using THP
>>> they can override that so the tuning at parent has no imperative
>>> control. This is breaking hierarchical property that is expected from
>>> cgroup control files.
>>
>> Actually, i think we can solve this.
>> As we mostly need just a single children level,
>> "flat" case (root->child) is enough, interpreting root-memcg THP mode as "global THP setting",
>> where sub-children are forbidden to override an inherited THP-mode.

> 
> This reduced case is not really sufficient to justify the non
> hiearchical semantic, I am afraid. There must be a _really_ strong case
> to break this property and even then I am rather skeptical to be honest.
> We have been burnt by introducing stuff like memcg.swappiness that
> seemed like a good idea initially but backfired with unexpected behavior
> to many users.
> 

-- 
Anatoly Stepanov, Huawei

