Return-Path: <cgroups+bounces-12826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80380CEA953
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 21:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C5730198FD
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430962E6CBF;
	Tue, 30 Dec 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLovLiNP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302A233D85;
	Tue, 30 Dec 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767125287; cv=none; b=ECR8ktRmIM6xaiwyIPw8DQ7EYJMeGPkV0iHkwYalhRdXjDczZHF68DimB/i3xQBOu/kJZC3m8Oqe+XDR8JHV70TXqI2/kvSP42Hr2qkWvHqIXCxrOlmMoleY4x9ORDJMfiG3FQDum3xnLLegJy7JOurr0NgbSLGu/frnE7KmR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767125287; c=relaxed/simple;
	bh=Gb3nl2k2mMYjoNrD9TKrHGBidJzr3Us//djBQS573K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBhIDAV0sKQAP5Bv93q5e6B6L6T1Q1ikaAYsoupfeofvOEt0Kf6U2GCFaUPB1XmOITLLog4iJz3rNJLWd9O6zw9SWDuY8wRGEZT0q8NAuPxzYhAOXgHviK9WlXSJEWTHaSfDQeSCHmlENugU3yCS/SFbIKw239VFdKAdfHadXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLovLiNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D1BC4CEFB;
	Tue, 30 Dec 2025 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767125286;
	bh=Gb3nl2k2mMYjoNrD9TKrHGBidJzr3Us//djBQS573K0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iLovLiNPCvMP/uLHO4+F2zAyBaxy3X9l2QWJTUcIrKfLMtXjpyWvGSPorjoW56Sut
	 l4rDKX7F/I3Ge3K1t2dL9JDGTOKV2KbIb2xZoniVFD3Ld0qooRcZyIQMrpsjk5lpqD
	 RJedcE3rnD7Qh7ePCegYIpl3/htFc2X+GZaWonz8/Y70D/TOb1uFaOj+hdZD6DP2sT
	 k+OZAs2DghEx5ZVGc6Ihm6bAuUSfH4apRygmlWYbqTWhP2CeNcOzgaw+wdUSO7/cJo
	 LUXks7SWnpweExRT4udKqeJ6tp3phyqmSpfAc8x5sK0OULBKCWx4HneTvypSHGd36F
	 F5QuMcsqDqASg==
Message-ID: <88fdd0ac-45f2-4ec1-8a45-84310789c9c4@kernel.org>
Date: Tue, 30 Dec 2025 21:07:54 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
 <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
 <aUQPB0cUP9PXnrqh@cmpxchg.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUQPB0cUP9PXnrqh@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 15:26, Johannes Weiner wrote:
> On Thu, Dec 18, 2025 at 10:09:21AM +0100, David Hildenbrand (Red Hat) wrote:
>> On 12/17/25 08:27, Qi Zheng wrote:
>>> From: Muchun Song <songmuchun@bytedance.com>
>>>
>>> In the near future, a folio will no longer pin its corresponding
>>> memory cgroup. To ensure safety, it will only be appropriate to
>>> hold the rcu read lock or acquire a reference to the memory cgroup
>>> returned by folio_memcg(), thereby preventing it from being released.
>>>
>>> In the current patch, the rcu read lock is employed to safeguard
>>> against the release of the memory cgroup in folio_migrate_mapping().
>>
>> We usually avoid talking about "patches".
>>
>> In __folio_migrate_mapping(), the rcu read lock ...
>>
>>>
>>> This serves as a preparatory measure for the reparenting of the
>>> LRU pages.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>> ---
>>>    mm/migrate.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 5169f9717f606..8bcd588c083ca 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>>>    		struct lruvec *old_lruvec, *new_lruvec;
>>>    		struct mem_cgroup *memcg;
>>>    
>>> +		rcu_read_lock();
>>>    		memcg = folio_memcg(folio);
>>
>> In general, LGTM
>>
>> I wonder, though, whether we should embed that in the ABI.
>>
>> Like "lock RCU and get the memcg" in one operation, to the "return memcg
>> and unock rcu" in another operation.
>>
>> Something like "start / end" semantics.
> 
> The advantage of open-coding this particular one is that 1)
> rcu_read_lock() is something the caller could already be
> holding/using, implicitly or explicitly; and 2) it's immediately
> obvious that this is an atomic section (which was already useful in
> spotting a bug in the workingset patch of this series).
> 
> "start/end" terminology hides this. "lock" we can't use because it
> would suggest binding stability. The only other idea I'd have would be
> to spell it all out:
> 
> memcg = folio_memcg_rcu_read_lock(folio);
> stuff(memcg);
> otherstuff();
> rcu_read_unlock();
> 
> But that might not be worth it. Maybe somebody can think of a better
> name. But I'd be hesitant to trade off the obviousness of what's going
> on given how simple the locking + access scheme is.

I rather disagree that open-coding it is the better approach here, in 
particular when it comes to new users or code changes in the future -- 
just way, way easier to mess up.

Well, unless we have some other way to add safety-checks that the right 
locks are held when the memcg is getting used (e.g., passed into other 
functions). Maybe that is done already to minimize the chance for UAF etc.

I agree that naming is tricky, and that it needs some more thought, so 
I'm fine with keeping it as is.

-- 
Cheers

David

