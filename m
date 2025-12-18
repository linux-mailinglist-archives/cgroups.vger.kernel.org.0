Return-Path: <cgroups+bounces-12475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E13CCA7C4
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26005309CF65
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B332721A;
	Thu, 18 Dec 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KFBee5nT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D521DF256
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039540; cv=none; b=eHjaX/0jnDCysYnxmfCiRanuNwBO6PwEsGzQM6IpQ3FUfk8Y7t39BC32GoHn7vETozLY9ujyt+E8ysr2iNM3z4YJcCW1zFqXDFiUgHRL8JOgWEu7aZpj4oUtgv9v+twJpUYreS7zz+pvadJlb9+0sbaC9VHZsKh+1v3bIhhGHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039540; c=relaxed/simple;
	bh=IFVb0VYPAm/lxtp0/AMZ5EIN8RU8AHWjPFxrAK0q8YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsbxpUVpOGX2/F3ywiPv53oHJ1CjpYCLzpYUL6fksBDo7GCZ+L27X1dQgS6DZ5TOZEfbCLZOHsJ7xI2E9yd7BoLOy728d5nPaUtBds97ofXJin4BR0vDjDI5zOfNkbUGYbfrrbFO/+YLxIt+icUBJ2CprPPlghh+diCm1raqNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KFBee5nT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f59a7a6d-2685-4c90-a02b-33dce49898cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766039526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuMAIMAxghdct3aJXfk8ti9XZUSoxcVspsnX7srcGqs=;
	b=KFBee5nTIhzoI9YEZNoVUIkAkpAX+95cyo5ZbyznMbVg80cFiduvqe3iOLSyfH1F7yrANX
	BC9xI2JhDTlys1R/SarHKY2E12ETA0eO9YYcKBcmlJ6QozfDzcVEvwLaxCSkXX31/2xxTL
	gfQN/eSKa8XVV4ZxKZwfH7DlY53ijd8=
Date: Thu, 18 Dec 2025 14:31:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 08/28] mm: memcontrol: prevent memory cgroup release in
 get_mem_cgroup_from_folio()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <29e5c116de15e55be082a544e3f24d8ddb6b3476.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMkYlK1KhtD5ky6@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUMkYlK1KhtD5ky6@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 5:45 AM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:32PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. To ensure safety, it will only be appropriate to
>> hold the rcu read lock or acquire a reference to the memory cgroup
>> returned by folio_memcg(), thereby preventing it from being released.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the memory cgroup in get_mem_cgroup_from_folio().
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>>   mm/memcontrol.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 21b5aad34cae7..431b3154c70c5 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>>    */
>>   struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
>>   {
>> -	struct mem_cgroup *memcg = folio_memcg(folio);
>> +	struct mem_cgroup *memcg;
>>   
>>   	if (mem_cgroup_disabled())
>>   		return NULL;
>>   
>> +	if (!folio_memcg_charged(folio))
>> +		return root_mem_cgroup;
>> +
>>   	rcu_read_lock();
>> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
>> -		memcg = root_mem_cgroup;
>> +retry:
>> +	memcg = folio_memcg(folio);
>> +	if (unlikely(!css_tryget(&memcg->css)))
>> +		goto retry;
> 
> So starting in patch 27, the tryget can fail if the memcg is offlined,
> and the folio's objcg is reparented concurrently. We'll retry until we
> find a memcg that isn't dead yet. There's always root_mem_cgroup.
> 
> It makes sense, but a loop like this begs the question of how it is
> bounded. I pieced it together looking ahead. Since this is a small
> diff, it would be nicer to fold it into 27. I didn't see anything in
> between depending on it, but correct me if I'm wrong.

Right, will fold it into #27 in the next version.

> 
> Minor style preference:
> 
> 	/* Comment explaining the above */
> 	do {
> 		memcg = folio_memcg(folio);
> 	} while (!css_tryget(&memcg->css));

OK, will do.

Thanks,
Qi



