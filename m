Return-Path: <cgroups+bounces-12505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87375CCBE93
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6440300E927
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178CA33DEE3;
	Thu, 18 Dec 2025 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCE/KsJk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE552F83A2;
	Thu, 18 Dec 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063107; cv=none; b=Nh1nD75vsHo7QDHNXINJCE3pvSgnW8f0aGITBEzao36RNmL52EjWdYp51N2ZIxVjZhaFDrYofu26DZonZSthlto1pKc3A0jxyDmNk+WOAcMvPszuw0NIZEf8who1zYje/y2LsHDt0UqCc6eifvnqJ2NpCs3iMdRFixly9Y2f85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063107; c=relaxed/simple;
	bh=wlrGBAWuPnDkrqpZ3OpcV2IRiPY3keO1pBIgIrsLYXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z385aT1orOVZposaMhtN5uG/0hemamGt3wKODa4Fv61yX1hgBC+LHt2xJ77R7kcrpOX1jfGCtdBW+HWRYQFDLCZ4z3aDyKm5dE8tF9yF5GrDgagHmgBvMpp3mRaoblGvlBWafr/L/neVoF5EQdj/22bWxauu5B+87MT3SxxaiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCE/KsJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B91C4CEFB;
	Thu, 18 Dec 2025 13:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063106;
	bh=wlrGBAWuPnDkrqpZ3OpcV2IRiPY3keO1pBIgIrsLYXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MCE/KsJkd9f5ZrdGW1PLNun0XeCg+Xh8HbqQz+yv/3v0MYk96s7RrtTDXtLgPZ9RM
	 c4IWPMVpcydxnrnRdx7aYdEoDAOfXET6HnqQTCCg9k5OS0pXgNjVumFXVJWqaAPjC2
	 g1+GjcIaoltN5KwMKBW7WSQi41HH15lg09vE2q+vdNJKJYBkGeLGmiqPv13KWRpANB
	 /L+9U48s4svbJDE3vOEobqtgg/JwZ0N0WksL9xYxPjJzbl9vR/wjRjSv8KQLRyNKs6
	 MnEu8di+BbAhXRzd06agcIeS703vdtZ2osdRTfk7JpLtVsNMtsaUnQnpAmgXmUN3cs
	 QJ7UOuedxQ51Q==
Message-ID: <49341ca3-1fc9-43d9-abbd-ecaabdda6ce0@kernel.org>
Date: Thu, 18 Dec 2025 14:04:54 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
 <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
 <02c3be32-4826-408d-8b96-1db51dcababf@linux.dev>
 <d62756d4-c249-474e-ae80-478d3c7cf34d@kernel.org>
 <4effa243-bae3-45e4-8662-dca86a7e5d12@linux.dev>
 <11a60eba-3447-47de-9d59-af5842f5dc5e@kernel.org>
 <3c32d80a-ba0e-4ed2-87ae-fb80fc3374f7@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <3c32d80a-ba0e-4ed2-87ae-fb80fc3374f7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 14:00, Qi Zheng wrote:
> 
> 
> On 12/18/25 7:56 PM, David Hildenbrand (Red Hat) wrote:
>> On 12/18/25 12:40, Qi Zheng wrote:
>>>
>>>
>>> On 12/18/25 5:43 PM, David Hildenbrand (Red Hat) wrote:
>>>> On 12/18/25 10:36, Qi Zheng wrote:
>>>>>
>>>>>
>>>>> On 12/18/25 5:09 PM, David Hildenbrand (Red Hat) wrote:
>>>>>> On 12/17/25 08:27, Qi Zheng wrote:
>>>>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>>>>
>>>>>>> In the near future, a folio will no longer pin its corresponding
>>>>>>> memory cgroup. To ensure safety, it will only be appropriate to
>>>>>>> hold the rcu read lock or acquire a reference to the memory cgroup
>>>>>>> returned by folio_memcg(), thereby preventing it from being released.
>>>>>>>
>>>>>>> In the current patch, the rcu read lock is employed to safeguard
>>>>>>> against the release of the memory cgroup in folio_migrate_mapping().
>>>>>>
>>>>>> We usually avoid talking about "patches".
>>>>>
>>>>> Got it.
>>>>>
>>>>>>
>>>>>> In __folio_migrate_mapping(), the rcu read lock ...
>>>>>
>>>>> Will do.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> This serves as a preparatory measure for the reparenting of the
>>>>>>> LRU pages.
>>>>>>>
>>>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>>> ---
>>>>>>>      mm/migrate.c | 2 ++
>>>>>>>      1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>> index 5169f9717f606..8bcd588c083ca 100644
>>>>>>> --- a/mm/migrate.c
>>>>>>> +++ b/mm/migrate.c
>>>>>>> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct
>>>>>>> address_space *mapping,
>>>>>>>              struct lruvec *old_lruvec, *new_lruvec;
>>>>>>>              struct mem_cgroup *memcg;
>>>>>>> +        rcu_read_lock();
>>>>>>>              memcg = folio_memcg(folio);
>>>>>>
>>>>>> In general, LGTM
>>>>>>
>>>>>> I wonder, though, whether we should embed that in the ABI.
>>>>>>
>>>>>> Like "lock RCU and get the memcg" in one operation, to the "return
>>>>>> memcg
>>>>>> and unock rcu" in another operation.
>>>>>
>>>>> Do you mean adding a helper function like get_mem_cgroup_from_folio()?
>>>>
>>>> Right, something like
>>>>
>>>> memcg = folio_memcg_begin(folio);
>>>> folio_memcg_end(memcg);
>>>
>>> For some longer or might-sleep critical sections (such as those pointed
>>> by Johannes), perhaps it can be defined like this:
>>>
>>> struct mem_cgroup *folio_memcg_begin(struct folio *folio)
>>> {
>>>      return get_mem_cgroup_from_folio(folio);
>>> }
>>>
>>> void folio_memcg_end(struct mem_cgroup *memcg)
>>> {
>>>      mem_cgroup_put(memcg);
>>> }
>>>
>>> But for some short critical sections, using RCU lock directly might
>>> be the most convention option?
>>>
>>
>> Then put the rcu read locking in there instead?
> 
> So for some longer or might-sleep critical sections, using:
> 
> memcg = folio_memcg_begin(folio);
> do_some_thing(memcg);
> folio_memcg_end(folio);
> 
> for some short critical sections, using:
> 
> rcu_read_lock();
> memcg = folio_memcg(folio);
> do_some_thing(memcg);
> rcu_read_unlock();
> 
> Right?

What I mean is:

memcg = folio_memcg_begin(folio);
do_some_thing(memcg);
folio_memcg_end(folio);

but do the rcu_read_lock() in folio_memcg_begin() and the 
rcu_read_unlock() in folio_memcg_end().

You could also have (expensive) variants, as you describe, that mess 
with getting/dopping the memcg.

But my points was about hiding the rcu details in a set of helpers.

Sorry if what I say is confusing.

-- 
Cheers

David

