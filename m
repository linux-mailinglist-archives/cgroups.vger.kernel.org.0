Return-Path: <cgroups+bounces-8209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02899AB8297
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375CA18939F4
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C97297119;
	Thu, 15 May 2025 09:28:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAD296FC8
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301323; cv=none; b=BSXRv7JYOTpP9dW52hax4QnMQaFnwIBkMRRhcyRdFbdlWy45jF1ihmeAYpPN+ct0rN74unTQjXgyuq3dPMlIYpyqeF9pTQZbUnu6+7jOBXRpgnyZOxx6yo5ikEp4xAw8Qa/UzEi+JQMJoj8mqFdSWrhHLA9zYlS3NmfM24zshPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301323; c=relaxed/simple;
	bh=hL4QAI/Md3yLhCWbRktYKz96TkNQ7TOlv4Yo/nvIkfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+s23MMZfn4a8mBoN85lhZ7CyfxIzO3f0nyGazWoWH+o65xU0qHSTGiWquWCY/tYCdROVJFmKnTCbNp18kfbKcaYkCV2Wghbyr8grjDFl3GWl9tVmh/QDv33nCwD4F2krTboJUaqJ2S6ag5yzQSorVazt7PlvOsGp57dgI7IQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <73355f59-5e40-4daa-b6bc-aeaa5e4ec31f@lankhorst.se>
Date: Thu, 15 May 2025 11:28:35 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [5/7] ttm: add initial memcg integration. (v4)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>, simona@ffwll.ch
References: <20250512061913.3522902-6-airlied@gmail.com>
 <ea70e6fa-22a1-4adc-927a-5e9c2563f784@lankhorst.se>
 <6a41fa3e-6ca7-4791-b491-4908971275a5@amd.com>
 <7a070692-c6e6-4dfa-aae8-5155988ca3eb@lankhorst.se>
 <f75bb69b-f5f5-4edb-86d5-792517fc6d3f@amd.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <f75bb69b-f5f5-4edb-86d5-792517fc6d3f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

On 2025-05-15 10:40, Christian König wrote:
> On 5/14/25 19:07, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 2025-05-14 13:55, Christian König wrote:
>>> On 5/14/25 13:41, Maarten Lankhorst wrote:
>>>> Hi Dave,
>>>>
>>>> We've had a small discussion on irc, so I wanted to summarize it here:
>>>>
>>>> All memory allocated should be accounted, even memory that is being
>>>> evicted from VRAM.
>>>
>>> That sounds like a really bad idea to me.
>>>
>>>> This may cause the process that originally allocated
>>>> the VRAM to go over the memcg limit, that should be solved by invoking
>>>> OOM condition on the original process, which may have ways to solve it
>>>> like purging purgeable memory, or as last resort OOM killing.
>>>
>>> You are basically suggesting to kill an application for something it never requested in the first place.
>>>
>>> In other words when an application requested a buffer to be placed in VRAM we can't make it responsible that the buffer had to be moved to system memory because of over allocation.
>>>
>>> As far as I can see and have discussed with others so far this approach is a clear no-go.
>> There is absolutely no need to kill an application. You can set dmem limits in such a way that a buffer will never be evicted.
>> Killing would be an absolute last resort, and only happens when maximum amount of memory is set.
> 
> Yeah, exactly that doesn't work. You kind of must kill it at that moment because you don't have any other chance to signal that this cgroup is OOM.
> 
> In other words when you have a cenario like application A causes eviction, application B is the victiom of that eviction who do you charge the system memory needed for the eviction to?
> 
> Application A caused the eviction but never asked for system memory in the first place. So letting that allocation fail because of some other application is OOM would result in basically not reproducible behavior.
> 
> Application B is now owning that memory, but you can only send a SIGKILL to that application and not an ENOMEM because it is currently not doing anything.
> 
> T.J. suggested that we charge but don't enforce a limit for application B. I would say that this is kind of ok for now until we have found a better solution, but it is clearly not the end of the story.
If I look at the cgroup-v2.rst documentation, specifically at "controller issues
and remedies; memory" it seems there are 2 knobs. memory.high and memory.max:

"The memory.high boundary[,] when hit, throttles allocations by forcing them
into direct reclaim to work off the excess, but it never invokes the
OOM killer. [...]

In extreme cases, with many concurrent allocations and a complete
breakdown of reclaim progress within the group, the high boundary can
be exceeded. [...] memory.max is there to limit this type of spillover
and ultimately contain buggy or even malicious applications."

So it should be acceptable for us to go above memory.high for eviction, as long
as we stay below memory.max

>> Alternatively we could count memory in VRAM similar to swapped out memory, since it's just another placement of allocated memory. :)
> 
> Yeah, that idea came to my mind as well. But there're problems with that approach as well.

I think this could potentially also be a correct solution, since VRAM is still memory . What are the
specific problems you see with this approach?

> Regards,
> Christian.

Best regards,
Maarten


