Return-Path: <cgroups+bounces-12532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF32CCEA1A
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 07:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB06130141CA
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 06:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9496223A58B;
	Fri, 19 Dec 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqgGZDtI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045A1E5207;
	Fri, 19 Dec 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125114; cv=none; b=eNT2Kec9mhsgdxwP15gAuqCxV6lgsRfsMAdi/EIBgAlgWg7WJ8D8Q+nLTKjCtGQtzBleYslWdUAwT8qN6/0Y0LvC4CtovxoH368dOEzz40qhXOVPFX32SJMpcXXYhDGJRimMkbvV1+qx9kJD6iTQDWm56ZCV0N2D5Gzvsizh5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125114; c=relaxed/simple;
	bh=xMlIHS8RXqYBLJVVEzUZMFwENBOT//REo0D9YNRvPpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MI13eLjmYkaXGO45ZejUT3fV6TN3z/mrfRL3vsheFSwGi/haSHJrDNdZjh+NVCUD4f+q+F4VzcGKnat7kRvWBCWoD6e06yEDlY19QsPfMPcJo6GAmPU2VH7gSZ95Mi5xteoriqULkUlhZf+hb4Oc1CdzQdUhOLWyjV7tjUZiv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqgGZDtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32648C4CEF1;
	Fri, 19 Dec 2025 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766125113;
	bh=xMlIHS8RXqYBLJVVEzUZMFwENBOT//REo0D9YNRvPpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gqgGZDtI1zhIVleIDAu0xskWmE2Fgbb2lH2Cz0pdmMBcNwjk/LP2OLp6DR8sE/ncy
	 JtEBvuEw8OFnUCfpw+z7srVGdjs1qv3OQ1JkobH4OzPRQfbisNpbB05U3+sd8bOwI/
	 JcuuwoAMEzD3Svwp/O/KZ1rxsdZkIWAWzS4W5RQ+QwBUf6+rh5TEC6X2ivhlRod2cy
	 tWyT+yEe0d+uJ+WHQo415+9ft7U2x7LtPu22tFVp/1GYVihMOWQlepnAPcCAsJM70e
	 NOxy3x+GSmfieI7dfWpIOeUmfBv4H7puXAAU4YwJiJHg0gXzyKhS0Z7zqTCKPAtruT
	 ED/lw+zbKuf1w==
Message-ID: <1b87adbb-a34d-4c7e-98d4-664ccf71fc60@kernel.org>
Date: Fri, 19 Dec 2025 07:18:21 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
To: Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
 <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
 <02c3be32-4826-408d-8b96-1db51dcababf@linux.dev>
 <d62756d4-c249-474e-ae80-478d3c7cf34d@kernel.org>
 <4effa243-bae3-45e4-8662-dca86a7e5d12@linux.dev>
 <11a60eba-3447-47de-9d59-af5842f5dc5e@kernel.org>
 <3c32d80a-ba0e-4ed2-87ae-fb80fc3374f7@linux.dev>
 <49341ca3-1fc9-43d9-abbd-ecaabdda6ce0@kernel.org>
 <a35751e3-9c06-4e02-81f0-c211d4383e5f@linux.dev> <aUTQuyUV4_ed9tSU@hyeyoo>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUTQuyUV4_ed9tSU@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/19/25 05:12, Harry Yoo wrote:
> On Thu, Dec 18, 2025 at 09:16:11PM +0800, Qi Zheng wrote:
>>
>>
>> On 12/18/25 9:04 PM, David Hildenbrand (Red Hat) wrote:
>>> On 12/18/25 14:00, Qi Zheng wrote:
>>>>
>>>>
>>>> On 12/18/25 7:56 PM, David Hildenbrand (Red Hat) wrote:
>>>>> On 12/18/25 12:40, Qi Zheng wrote:
>>>>>>
>>>>>>
>>>>>> On 12/18/25 5:43 PM, David Hildenbrand (Red Hat) wrote:
>>>>>>> On 12/18/25 10:36, Qi Zheng wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/18/25 5:09 PM, David Hildenbrand (Red Hat) wrote:
>>>>>>>>> On 12/17/25 08:27, Qi Zheng wrote:
>>>>>>>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>>>>>>>
>>>>>>>>>> In the near future, a folio will no longer pin its corresponding
>>>>>>>>>> memory cgroup. To ensure safety, it will only be appropriate to
>>>>>>>>>> hold the rcu read lock or acquire a reference to the memory cgroup
>>>>>>>>>> returned by folio_memcg(), thereby
>>>>>>>>>> preventing it from being released.
>>>>>>>>>>
>>>>>>>>>> In the current patch, the rcu read lock is employed to safeguard
>>>>>>>>>> against the release of the memory cgroup in
>>>>>>>>>> folio_migrate_mapping().
>>>>>>>>>
>>>>>>>>> We usually avoid talking about "patches".
>>>>>>>>
>>>>>>>> Got it.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> In __folio_migrate_mapping(), the rcu read lock ...
>>>>>>>>
>>>>>>>> Will do.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This serves as a preparatory measure for the reparenting of the
>>>>>>>>>> LRU pages.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>>>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>>>>>> ---
>>>>>>>>>>       mm/migrate.c | 2 ++
>>>>>>>>>>       1 file changed, 2 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>>> index 5169f9717f606..8bcd588c083ca 100644
>>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>>> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct
>>>>>>>>>> address_space *mapping,
>>>>>>>>>>               struct lruvec *old_lruvec, *new_lruvec;
>>>>>>>>>>               struct mem_cgroup *memcg;
>>>>>>>>>> +        rcu_read_lock();
>>>>>>>>>>               memcg = folio_memcg(folio);
>>>>>>>>>
>>>>>>>>> In general, LGTM
>>>>>>>>>
>>>>>>>>> I wonder, though, whether we should embed that in the ABI.
>>>>>>>>>
>>>>>>>>> Like "lock RCU and get the memcg" in one operation, to the "return
>>>>>>>>> memcg
>>>>>>>>> and unock rcu" in another operation.
>>>>>>>>
>>>>>>>> Do you mean adding a helper function like
>>>>>>>> get_mem_cgroup_from_folio()?
>>>>>>>
>>>>>>> Right, something like
>>>>>>>
>>>>>>> memcg = folio_memcg_begin(folio);
>>>>>>> folio_memcg_end(memcg);
>>>>>>
>>>>>> For some longer or might-sleep critical sections (such as those pointed
>>>>>> by Johannes), perhaps it can be defined like this:
>>>>>>
>>>>>> struct mem_cgroup *folio_memcg_begin(struct folio *folio)
>>>>>> {
>>>>>>       return get_mem_cgroup_from_folio(folio);
>>>>>> }
>>>>>>
>>>>>> void folio_memcg_end(struct mem_cgroup *memcg)
>>>>>> {
>>>>>>       mem_cgroup_put(memcg);
>>>>>> }
>>>>>>
>>>>>> But for some short critical sections, using RCU lock directly might
>>>>>> be the most convention option?
>>>>>>
>>>>>
>>>>> Then put the rcu read locking in there instead?
>>>>
>>>> So for some longer or might-sleep critical sections, using:
>>>>
>>>> memcg = folio_memcg_begin(folio);
>>>> do_some_thing(memcg);
>>>> folio_memcg_end(folio);
>>>>
>>>> for some short critical sections, using:
>>>>
>>>> rcu_read_lock();
>>>> memcg = folio_memcg(folio);
>>>> do_some_thing(memcg);
>>>> rcu_read_unlock();
>>>>
>>>> Right?
>>>
>>> What I mean is:
>>>
>>> memcg = folio_memcg_begin(folio);
>>> do_some_thing(memcg);
>>> folio_memcg_end(folio);
>>>
>>> but do the rcu_read_lock() in folio_memcg_begin() and the
>>> rcu_read_unlock() in folio_memcg_end().
>>>
>>> You could also have (expensive) variants, as you describe, that mess
>>> with getting/dopping the memcg.
>>
>> Or simple use folio_memcg_begin(memcg)/folio_memcg_end(memcg) in all cases.
>>
>> Or add a parameter to them:
>>
>> struct mem_cgroup *folio_memcg_begin(struct folio *folio, bool get_refcnt)
>> {
>> 	struct mem_cgroup *memcg;
>>
>> 	if (get_refcnt)
>> 		memcg = get_mem_cgroup_from_folio(folio);
>> 	else {
>> 		rcu_read_lock();
>> 		memcg = folio_memcg(folio);
>> 	}
>>
>> 	return memcg;
>> }
>>
>> void folio_memcg_end(struct mem_cgroup *memcg, bool get_refcnt)
>> {
>> 	if (get_refcnt)
>> 		mem_cgroup_put(memcg);
>> 	else
>> 		rcu_read_unlock();
>> }
> 
> I would like to vote for open coding as we do now, because I think hiding
> the RCU lock / refcount acquisition into a less obvious API doesn't make
> it more readable.

I wouldn't do it in an API as proposed above.

I prefer to not have magical RCU locking in every caller. Easy to get wrong.

See how we did something similar in the pte_*map*() vs. pte_unmap() API, 
without requiring all callers to open-code this.

-- 
Cheers

David

