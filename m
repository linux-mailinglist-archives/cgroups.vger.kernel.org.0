Return-Path: <cgroups+bounces-12566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E0CD4A4F
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B073300163C
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55948325713;
	Mon, 22 Dec 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVmiX6uT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493317A2EA
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374982; cv=none; b=klY/EzLHPL4J/58OBfok6XYi5knerablwdpjBDyz4ULx66qVj2AaYq0nkVeVrMrAd+l244ulwVvFBxQjn1ZhhnlW1yv73QL7T/6e0MXh96GR5uv/DPOAIfaPTRPO982LgxMsbBV07DSB9K7owLnIPpktk+DOR3ZReeryh+X0k4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374982; c=relaxed/simple;
	bh=6OXjcEb1oFmKkCUODzH32erhSHCVKpgyCsrweISc5iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU++hJ52Mj6zRVSjAeWAdtonERGs/wafQSJrKSZCi42jeNP/oIbOlFoZRqOgeGxpEnRGJ6XPZH0PyfIy8afqzQN4OCJBVmqB3JSVIqGnBc/Xrvqp0j3qxdZvDyNo4J1qUAWjwd13oTyUoMPdE9vd1IepGxZQ90zcRfEphKlZszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVmiX6uT; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c998d9ef-5538-4ad2-9a95-a20ef299ce55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766374973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz1xuPsgdNZC4b636x1LrK4fMi9S/EGh27EdWq41RBA=;
	b=hVmiX6uTnWbBzcdQMwstWbBHDPWFlAHlSeClZfctafz8wzOcVHzyKB8XX1SNWtyuAQP6kv
	TuQWLWUGs84KFl8rDmsFxUq27C45eAxgWZGQm3bHTLBNKiLJJqEAwM6hh4jpBBslKOnFtW
	KCrikMCmmHQwn2YykjCeCfScSa6UH14=
Date: Mon, 22 Dec 2025 11:42:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
To: Johannes Weiner <hannes@cmpxchg.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
 <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
 <aUQPB0cUP9PXnrqh@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUQPB0cUP9PXnrqh@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 10:26 PM, Johannes Weiner wrote:
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

Agree. I also prefer to keep the open-coding method for now, and if a
better helper is available later, a cleanup patch can be added to
accomplish this.

Thanks,
Qi




