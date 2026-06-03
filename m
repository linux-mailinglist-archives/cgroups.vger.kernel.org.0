Return-Path: <cgroups+bounces-16591-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ff7nGXWZH2qbngAAu9opvQ
	(envelope-from <cgroups+bounces-16591-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 05:03:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C324D633C09
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 05:03:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rz3KQeHb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16591-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16591-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A80B33041B88
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 03:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D16376A07;
	Wed,  3 Jun 2026 03:03:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FB26E71E
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 03:03:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455791; cv=none; b=bVdHeNcH/pZbOwb0AwpKvAaNpPUsgzhnJ6Fmu4z76rZhnCy8/qWunpopN5bZ/7cwmcW5OkeBlZh0tvKV8nQEAdHMONN9TPpylIaGXeSjOhVkNuky4vMfMysljJnVxJsT2g9pVjMnci9jghDBUqegb8BNonk3IlxMicFd+Nm52hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455791; c=relaxed/simple;
	bh=4+IcMpw6wmNDWDflQAxNeyWQzxMBkOGm0XHg3YvB8os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5lS1zlM92XK+9AlC20zUaLl7CFPiLdzKxqZjxl7H939+0tpSemmj5P3LQ7bQ1f10XBWKo+HYQcvKYr/OUfYtGr5h5W+XsChtuOql6qrmSRvNEAVsUjG5aL36k/WlDFCtg9CTosLpLDoe9TO36j1jsaqALgap1BU2tn70zOmbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz3KQeHb; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so103272b3a.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 20:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780455789; x=1781060589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVn12Hvb9FGkLc5N/aP4mYm2YYdVU4vVM0uYVFz4Dq8=;
        b=Rz3KQeHbfHYc+f+dz9WllE5npaoV4yRRwryksIQA4CMHBRKyUNwKltgADuN4d2hpnM
         TVDCkK+C96ghE822BOWZ+SzKkZ/mVq8vYrhZoiyniGlh/OWlKbHCf2skXNmEJHngy2UF
         EFOb0Eqfyy8VlsmTS5vg6z8EKmZIhQdltO3dJYoM5ah1YOtQQpUcjpWa6pTWXjt78sET
         8FKGEM845dHDtwrtMOHCb4DpfpSK13lPiy5mIVlWNihmZZ+exHx681032NYVhEzj5w/q
         zDk4exGyZ65X8nWqD1V4D20S/NOU8s6D60OEXNWq4RfJd52H6mUNjwxGh3+1sGgIIycQ
         gmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455789; x=1781060589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVn12Hvb9FGkLc5N/aP4mYm2YYdVU4vVM0uYVFz4Dq8=;
        b=ip4B/wrYN6I4NxbqgtmLdLukG9FjYZCfzDAdP4kUSfG+LoGiFG+oZFNPST1qQ+CtLQ
         OJNPWTwI/k/wPCy8tKBgIujBJg3Ex9VSseiLLf2pfUjlw5SaQ6Ycbii5Aa267Xy/IwYw
         Wa7WNq6xNxi/0ntNS7BW9Df1vYMeEeXT3MMDe2JaFyi6rSKOFiikJcsQfJ18GxtJwr0L
         FTdQoMALYQEPbAYz5pq+vGAx6g4+cX4oHVi/6B96E0UAaMHPV2SzxDkKWM4flXUXuMl/
         HmwMADVy7jZA4Ew+TXw0vu0A5k/1zechtvDSFhx4MG8C88KUvJRj+OmfpkeXUGsOiW4/
         HTUw==
X-Forwarded-Encrypted: i=1; AFNElJ+7vl34EW2Z5inyBDlt7ujfXlUgfMZo4qW37dRP35WmAIH/34rhVMAvCuOFqA/JRLf3N6qCJhEK@vger.kernel.org
X-Gm-Message-State: AOJu0YwFek//agB0M1J6APoQUsNgHrVDS22eWylHfo41CBKuuDheX/Xx
	f8JoL+JZrWiNPdipjZ5louWhyMig1BfgQKWmbFDQoR4P+1TDj+pwc1Vv
X-Gm-Gg: Acq92OFU+zb176jZOrZ+HUFZ8a0ssa2it3P0iA7ps9BsI8c7iz34NYBXv4xiiq0dauw
	x8kUpqMXsfF1IbBGZ4nKJJrdF09HRQVfdkva0e4SygY+3b/kn70I3vU2PQ+nmDappmHDlvuieof
	86SkhxhhrqzHlMADyc6He3+gupyOnlRSgOtApDEtCkweAqqjYPyCsnNHXrzmsV0VuSuOdwKe4OA
	axq31d4WMQwB8jJrk8FQfb7KV9+/V4Je9kKwrJmK5+GqvD87OZ9i2ZzE9jbxbn6GB6RY5PqZlVc
	8Kt9b+ldnf/MUqCBAAlzP9Yw+9CKwMuumE70/1+jjzk4ysNVypO8MWH+9fOl/CHAozAOKI2rsa2
	OwfYJRues5r5QK+enTfCYH4tSyL0NKTz0b4bORpC603e2t+SBnsEgqhhRUO8hEdM2+36KR7i3Tg
	BX92MtL4kwkYx5mYpQnvYCgJALtgT7vOHa3DPYYTvmQqEHA1a0HUxPeRMYj/3LyE3f
X-Received: by 2002:a05:6a00:f08:b0:837:f111:b70 with SMTP id d2e1a72fcca58-84285975450mr1047918b3a.4.1780455788827;
        Tue, 02 Jun 2026 20:03:08 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428235006dsm1357752b3a.13.2026.06.02.20.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 20:03:07 -0700 (PDT)
Message-ID: <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com>
Date: Wed, 3 Jun 2026 11:02:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com>
 <ah9i3uhh3PFiS0Uk@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <ah9i3uhh3PFiS0Uk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16591-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C324D633C09



On 2026/6/3 07:19, Yosry Ahmed wrote:
>>>>>> Proactive writeback also wants a similar per-memcg cursor that is
>>>>>> scoped to the specified memcg, so that repeated invocations against
>>>>>> the same memcg make forward progress across its descendant memcgs
>>>>>> instead of restarting from the first child memcg each time.
>>>>>
>>>>> Is this a problem in practice?
>>>>>
>>>>> Is the concern the overhead of scanning memcgs repeatedly, or lack of
>>>>> fairness? I wonder if we should just do writeback in batches from all
>>>>> memcgs, similar to how reclaim does it, then evaluate at the end if we
>>>>> need to start over?
>>>>>
>>>>
>>>> Not using a per-cgroup cursor will cause issues for "repeated small-budget
>>>> calls" cases. For example, repeatedly triggering a 2MB writeback might
>>>> result in only writing back pages from the first few child memcgs every
>>>> time. In the worst-case scenario (where the writeback amount is less than
>>>> WB_BATCH), it might only ever write back from the first child memcg.
>>>
>>> Right, so a fairness concern?
>>>
>>> I wonder if we should just reclaim a batch from each memcg, then check
>>> if we reached the goal, otherwise start over. If the batch size is small
>>> enough that should work?
>>
>> Even with a small batch size, for small writeback requests triggered by
>> user-space (e.g., 2MB, which is batch size * N), it might still repeatedly
>> write back from only the first N child memcgs.
> 
> Yes, I understand, I am asking if this is a problem in practice. For
> this to be a problem we'd need to trigger small writeback requests and
> have many memcgs.
> 
>> This could cause the user-space agent to prematurely give up on zswap
>> writeback.
> 
> Why? The kernel should not return before trying to writeback from all
> memcgs. If we scan the first N child memcgs and did not writeback
> enough, we should keep going, right?
> 

Yes, this issue is not caused by the kernel, but rather by our 
user-space agent itself.

For instance, suppose a parent memcg has two children, memcg1 and 
memcg2, each with 200MB of zswap (100MB inactive). Triggering proactive 
writeback on the parent memcg will exhaust memcg1's inactive zswap 
pages. After that, even though memcg2 still has plenty of inactive zswap 
pages, it will continue to write back memcg1's active zswap pages. 
Writing back active zswap pages causes the user-space agent to 
prematurely abort the writeback because it detects that certain memcg 
metrics have exceeded predefined thresholds.

Of course, real-world scenarios are much more complex, and this kind of 
case is extremely rare in our environment.

That being said, your suggestion of using the global lock for the 
per-memcg cursors makes the writeback fairer and would resolve these 
corner cases.

>>> What if we do something like this (for the global cursor):
>>>
>>> 	do {
>>> 		memcg = xchg(zswap_next_shrink, NULL);
>>> 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
>>> 		/* If the cursor was advanced from under us, try again */
>>> 		if (!try_cmpxchg(zswap_next_shrink, NULL, memcg))
>>> 			continue;
>>> 	} while (..);
>>> 			
>>>
>>
>> Regarding the code above, IIRC, both the global and per-cgroup cursors
>> suffer from race conditions. This race can cause mem_cgroup_iter(NULL, NULL,
>> NULL) to return the root memcg or its descendants, leading zswap to write
>> back pages from the wrong memcg.
> 
> Not the wrong memcg, it will just go back to the first memcg again,
> which should be fine as I mentioned below.
> 
>>
>> Additionally, since mem_cgroup_iter() puts the prev memcg ref and gets the
>> next memcg ref, a try_cmpxchg() failure on CPU1 might also lead to a ref
>> leak for memcg1.
>>
>>
>> 	CPU1                                       CPU2
>> memcg1 = xchg(pos, NULL)
>>                                 memcg2 = xchg(pos, NULL) memcg2 = NULL;
>>
>> memcg1 = mem_cgroup_iter()
>>                         mem_cgroup_iter(NULL, **NULL**, NULL) error memcg
>>                                  try_cmpxchg(pos，NULL，memcg2） succeed
>> try_cmpxchg(pos，NULL，memcg1） **fail**
> 
> Yes, we can probably just take a ref on the memcg before calling
> mem_cgroup_iter(). That being said, I think we can just keep the lock,
> see below.
> 
>>
>> I took a stab at implementing a cmpxchg()-based zswap_mem_cgroup_iter()
>> modeled after mem_cgroup_iter(), and it actually doesn't look that complex
>> after all :)
> 
> I don't think we should re-implement mem_cgroup_iter() here.
> 
> [..]
>>> There is a window where a racing shrinker will see the cursor as NULL
>>> and start over, but that should be fine. We can generalize this for the
>>> per-memcg cursor.
>>>
>>> That being said..
>>>
>>>>
>>>> Currently, this lock is only used in shrink_memcg(), proactive writeback,
>>>> and mem_cgroup_css_offline(). Note that shrink_memcg() only acquires the
>>>> lock of the root cgroup, and mem_cgroup_css_offline() is unlikely to be a
>>>> hot path.
>>>
>>> ..this made me realize it's probably fine to just use a global lock for
>>> now?
>>>
>>> IIUC the only additional contention to the existing lock will be from
>>> userspace proactive writeback, and that shouldn't be a big deal
>>> especially with the critical section being short?
>>>
>>
>> In the current patch implementation, this lock protects the cgroup's own
>> cursor variable. During each writeback, we only acquire the spin_lock of the
>> target cgroup itself; we do not attempt to **spin on any child cgroup's lock
>> while iterating through the descendants**.
> 
> Oh, I did not say anything about the current patch adding contention. I
> am suggesting we just keep using the global lock for the per-memcg
> cursors, if we keep them.
> 
> Right now, without this series, the global lock protects against
> concurrent changes to the global cursor from concurrent shrinkers. After
> the series, the only added contenders are userspace proactive writeback
> threads. Unless you have 10s or 100s of those, it should be fine to keep
> a single global lock, right?
> 

Ah yes, sorry about that, I misunderstood what you meant. Thanks a lot 
for the suggestion and for taking the time to explain it so patiently. 
I'll switch to using the global lock in v4 patch.


> Yes, userspace can affect writeback efficiency, but we can split the
> lock when it actually causes a problem.

Agreed.

> 
>>
>>
>>>>
>>>> So, should we keep the spin_lock or go with the cmpxchg() approach?
>>>> Yosry and Nhat, what are your thoughts on this?
>>>
>>> I think we should experiment with the global lock first. See if you
>>> observe any regressions with workloads that put a lot of pressure on the
>>> lock (a lot of threads in reclaim doing writeback + a few userspace
>>> threads doing proactive writeback). See if the userspace threads
>>> actually cause a meaningful regression.
>>
>> Sorry, it seems there are some implementation issues with the global lock
>> approach.
>>
>> In practice, our user-space agent mostly operates in the following two
>> scenarios:
>>   - Triggering proactive writeback on the same cgroup at different times
>> (sequentially).
>>   - Triggering proactive writeback on different cgroups at the same time
>> (concurrently).
>>
>> In both cases, there is no lock contention. So, the current lock works
>> perfectly fine for us.
> 
> Would using the existing global lock work for your use case? How many
> different cgroups can you end up reclaiming from concurrently?


It should work fine. We typically only have a dozen or so user-space 
agents triggering zswap writeback, and the critical section is very 
short anyway. I will implement this next.


Thanks,
Hao


