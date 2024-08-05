Return-Path: <cgroups+bounces-4090-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492A947CC5
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2779F1C21BD2
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754813A40F;
	Mon,  5 Aug 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx/OyM4y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B25558A5;
	Mon,  5 Aug 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867839; cv=none; b=rUsZVrcP28MDUN35Z3ioudpMJaPyWX4SozoChLy1KbQi7GYj+wf5ibTMi8mKQeaIgmiU+hkHZlDYGEzS86IR+r+6BU5hfCrae5yTtW807imr/MQOdYIyz1Fb04EMu9Kfv4MOspaxafEdGdy9vzGxYfaIgC8anqBUl4QU36ABT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867839; c=relaxed/simple;
	bh=DldBq+rg0T7y4j2Mv+qFD/nrBR+rhA1J45Aia6sC++w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrM8kZMHoK6QFgOOITUgO7D64wx8N11yoPm/fOvL1hYYbennhsB1vsH6iLih+owP4lUHZh2fz9hwwEZsFTZKhGQuTQQNTX5HXDlwdbxQznd+ZbHKlHpSXZHP7SYVCwTvwq3HrvJKI107XtTI62Itv7bOG4bKw9Dkdvu0hItAedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx/OyM4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB109C32782;
	Mon,  5 Aug 2024 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722867838;
	bh=DldBq+rg0T7y4j2Mv+qFD/nrBR+rhA1J45Aia6sC++w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zx/OyM4yoNhc6o1KVXkqOdYImG+sJ0Lzdty+/PxVLVMKXl2LiiuQvOWr7uU42cAP/
	 /g73BK49Rdp1NsJR1mfwyERqWPPLWKuDFJc3eycCfnxRSps1mwpxZUYs8iaOOnRAH2
	 L8bMYrI+IH0PwJJ85JjbrVNfbqtDngcnDUPBW/8f2niZr6vprckwJ3Wel3tQ1fsyhK
	 aYUj+7of/RglZGOj7UxYBIC+TkUWGmS74AOL7MWNk4c9QbRf1ONLmdefXz28zq3/FL
	 qachyM5+6YIkNaa3KEEHmVNOiQ0WdHnhbpYV8QH9GpS5qj6aMHyTKoUd4Jvw5G6k0K
	 4LAlgyD/1Vfug==
Message-ID: <ef58d81c-6266-4999-ac1e-04d330196f9a@kernel.org>
Date: Mon, 5 Aug 2024 16:23:55 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
 <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org>
 <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
 <ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org>
 <CAJD7tkYL-az+bSXH-CYBLJS2FQ6WtNDOSsxnUZhkixHeBrBmbg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkYL-az+bSXH-CYBLJS2FQ6WtNDOSsxnUZhkixHeBrBmbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/08/2024 18.10, Yosry Ahmed wrote:
> On Fri, Aug 2, 2024 at 4:43 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>> On 30/07/2024 20.54, Yosry Ahmed wrote:
>>> [..]
>>>>
>>>> Well... I'm still not convinced that it makes sense to have level >= 2
>>>> be the ongoing flusher.
>>>>
>>>> E.g. if a level 2 cgroup becomes ongoing flusher, and kswapd starts 12
>>>> NUMA flushes at the same time, then the code will have these 12 kswapd
>>>> threads spin on the lock, until ongoing flusher finishes. That is likely
>>>> what happened above (for a level 1).  These 12 spinning (root) flushers
>>>> will not recheck ongoing_flusher and will all flush the root
>>>> (unnecessarily 11 times).
>>>
>>> Hmm regardless of whether or not the level-2 cgroup becomes the
>>> ongoing flusher, the kswapd threads will all spin on the lock anyway
>>> since none of them can be the ongoing flusher until the level-2 cgroup
>>> finishes. Right?
>>>
>>> Is the scenario you have in mind that the level-2 cgroup starts
>>> flushing at the same time as kswapd, so there is a race on who gets to
>>> be the ongoing flusher? In this case as well, whoever gets the lock
>>> will be the ongoing flusher anyway.
>>>
>>> Not allowing whoever is holding the lock to be the ongoing flusher
>>> based on level is only useful when we can have multiple ongoing
>>> flushers (with lock yielding). Right?
>>>
>>> Perhaps I am missing something here.
>>>
>>>>
>>>> So, I don't think it is a good idea to have anything else that the root
>>>> as the ongoing flusher.
>>>>
>>>> Can you explain/convince me why having sub-cgroups as ongoing flusher is
>>>> an advantage?
>>>
>>> I just don't see the benefit of the special casing here as I mentioned
>>> above. If I missed something please let me know.
>>>
>>
>> I do think you missed something. Let me try to explain this in another
>> way. (I hope my frustrations doesn't shine through).
>>
>> The main purpose of the patch is/was to stop the thundering herd of
>> kswapd thread flushing (root-cgrp) at exactly the same time, leading to
>> lock contention. This happens all-the-time/constantly in production.
>>
>> The first versions (where ongoing was limited to root/level=0) solved
>> this 100%.  The patches that generalized this to be all levels can
>> become ongoing flush, doesn't solve the problem any-longer!
>>
>> I hope it is clear what fails. E.g. When a level>0 becomes ongoing
>> flusher, and 12 kswapd simultaneously does a level=0/root-cgrp flush,
>> then we have 12 CPU cores spinning on the rstat lock. (These 12 kswapd
>> threads will all go-through completing the flush, as they do not
>> discover/recheck that ongoing flush was previously became their own level).
> 
> I think we may be speaking past one another, let me try to clarify :)
> 
> I agree with your assessment, all I am saying is that this restriction
> is only needed because of lock yielding, and can be removed after that
> IIUC.
> 
> The problem when we allow non-root ongoing flushers now is that when
> the kswapd thread are woken up and the first one of them gets the lock
> and does the flush, it may be find that the ongoing_flusher is already
> set by another non-root flusher that yielded the lock. In this case,
> the following kswapd flushers will spin on the lock instead of waiting
> for the first kswapd to finish.
> 
> If we remove lock yielding, then the above scenario cannot happen.

I think, this is where we disagree/talk-past-each-other.  Looking at the
code, I do believe the the situation *also* occurs without any lock
yielding involved.  Yes, the situation if far-worse when we have lock
yielding, but it also happens in the default case.

> When the lock/mutex is held by a flusher, it is guaranteed that
> ongoing_flusher is NULL and can be set by the flusher. In this case,
> we should allow any cgroup to be the ongoing_flusher because there can
> only be one anyway.
> 

With current patch proposal [V8 or V9].
Assuming we have no lock yielding.

Do we agree that 12 kswapd threads will be waiting on the lock, when a
level>0 were ongoing flusher when they were started?
Then level>0 finishes being ongoing flushed.
Then kswapd0 gets lock, observe NULL as ongoing, and becomes ongoing.
Then kswapd1 gets lock, observe NULL as ongoing, and becomes ongoing.
Then kswapd2 gets lock, observe NULL as ongoing, and becomes ongoing.
Then kswapd3 gets lock, observe NULL as ongoing, and becomes ongoing.
Then kswapd4 gets lock, observe NULL as ongoing, and becomes ongoing.
Then kswapd5 gets lock, observe NULL as ongoing, and becomes ongoing.
Then kswapd6 gets lock, observe NULL as ongoing, and becomes ongoing.
[etc]

Please, let me know if I misunderstood my own code, and you believe this
scenario cannot happen.

When above happens, then patch didn't solve the kswapd thundering herd
issue that we observe in production.

The point/problem is that once kswapd is waiting on the lock, then code
doesn't re-check the ongoing flusher, and every kswapd thread will be
spinning and every kswapd thread will need to go through the flush.
When a kswapd thread gets the lock, then it will observe ongoing as
NULL, so it cannot detect that another level=0 just were the ongoing.

--Jesper

