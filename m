Return-Path: <cgroups+bounces-12503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68982CCBE81
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B00030672E9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF333DEDF;
	Thu, 18 Dec 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SEdTet5h"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0A33D6C0
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062879; cv=none; b=W4sQtGPe/yV9jJ8u8OTD+UWQQI57J4IN+uUlHVWj99OeaAPaw2jZ4FerSEm6c+CED1zquxFywlyFDjIPBEZ5ue3Iop4NVI2xvPOYjft0KVu5s20hAJ4ZVZRQwJaEnfQOSKcy36axuq4Q7CzhhmNJwwKMVyYj9FVjOs5Nguo915c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062879; c=relaxed/simple;
	bh=eU1qFimDaJL7m1r28zyZqxlLWNZOWLRAxN6BjIRNxdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgkP1WAiEHtHVV/0OK10dVNTxUD/c03w1enHhffHlSW+LAAfT4229/npv/98mGSmHjtmY80clwnNO/s9hqwXSFTFjhpJFPOCFL54kYz5NytEO4/KzNjExmUDhOseXdbyGCGnDOQMAK74m4veVvanpXxqTlGmZhhuN3TIEU1gElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SEdTet5h; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c32d80a-ba0e-4ed2-87ae-fb80fc3374f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766062869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fhAxNBkZvzSd2fHbQh2tDrHQZkQx5sWn3l+p/o/E8Q=;
	b=SEdTet5hPnFsPgIW/3Ked4lMxNyGaR8bXywSfUqJ8il0v4bSoUw+RR4+SYdKpVn0eDCKe1
	vGGTrfKrIRypODY1FnZzLP6m3+ob7vnBehCZpZcY2GWy0V8nSWYIROMhcJB1zl0N5JNZ6H
	W5k9IvQQ0QkpOnvStZGedD0aFZuvlhw=
Date: Thu, 18 Dec 2025 21:00:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <11a60eba-3447-47de-9d59-af5842f5dc5e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 7:56 PM, David Hildenbrand (Red Hat) wrote:
> On 12/18/25 12:40, Qi Zheng wrote:
>>
>>
>> On 12/18/25 5:43 PM, David Hildenbrand (Red Hat) wrote:
>>> On 12/18/25 10:36, Qi Zheng wrote:
>>>>
>>>>
>>>> On 12/18/25 5:09 PM, David Hildenbrand (Red Hat) wrote:
>>>>> On 12/17/25 08:27, Qi Zheng wrote:
>>>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>>>
>>>>>> In the near future, a folio will no longer pin its corresponding
>>>>>> memory cgroup. To ensure safety, it will only be appropriate to
>>>>>> hold the rcu read lock or acquire a reference to the memory cgroup
>>>>>> returned by folio_memcg(), thereby preventing it from being released.
>>>>>>
>>>>>> In the current patch, the rcu read lock is employed to safeguard
>>>>>> against the release of the memory cgroup in folio_migrate_mapping().
>>>>>
>>>>> We usually avoid talking about "patches".
>>>>
>>>> Got it.
>>>>
>>>>>
>>>>> In __folio_migrate_mapping(), the rcu read lock ...
>>>>
>>>> Will do.
>>>>
>>>>>
>>>>>>
>>>>>> This serves as a preparatory measure for the reparenting of the
>>>>>> LRU pages.
>>>>>>
>>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>> ---
>>>>>>     mm/migrate.c | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>> index 5169f9717f606..8bcd588c083ca 100644
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct
>>>>>> address_space *mapping,
>>>>>>             struct lruvec *old_lruvec, *new_lruvec;
>>>>>>             struct mem_cgroup *memcg;
>>>>>> +        rcu_read_lock();
>>>>>>             memcg = folio_memcg(folio);
>>>>>
>>>>> In general, LGTM
>>>>>
>>>>> I wonder, though, whether we should embed that in the ABI.
>>>>>
>>>>> Like "lock RCU and get the memcg" in one operation, to the "return 
>>>>> memcg
>>>>> and unock rcu" in another operation.
>>>>
>>>> Do you mean adding a helper function like get_mem_cgroup_from_folio()?
>>>
>>> Right, something like
>>>
>>> memcg = folio_memcg_begin(folio);
>>> folio_memcg_end(memcg);
>>
>> For some longer or might-sleep critical sections (such as those pointed
>> by Johannes), perhaps it can be defined like this:
>>
>> struct mem_cgroup *folio_memcg_begin(struct folio *folio)
>> {
>>     return get_mem_cgroup_from_folio(folio);
>> }
>>
>> void folio_memcg_end(struct mem_cgroup *memcg)
>> {
>>     mem_cgroup_put(memcg);
>> }
>>
>> But for some short critical sections, using RCU lock directly might
>> be the most convention option?
>>
> 
> Then put the rcu read locking in there instead?

So for some longer or might-sleep critical sections, using:

memcg = folio_memcg_begin(folio);
do_some_thing(memcg);
folio_memcg_end(folio);

for some short critical sections, using:

rcu_read_lock();
memcg = folio_memcg(folio);
do_some_thing(memcg);
rcu_read_unlock();

Right?


> 


