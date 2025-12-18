Return-Path: <cgroups+bounces-12489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B67CCB37D
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E9330A12C0
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFF331224;
	Thu, 18 Dec 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qF7ex1vz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638F33066A
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050588; cv=none; b=FHPk7ZH6yyDXnI2LiUFEbAeBc3xeRusOLSqw7IHv93pNruEJqlqcKXergguwlPMfCd8jyoezVwMrllIN6htfmaYaUp6t20ud+UBCniCqCsFped9lrj0Gg1Z3mMM8+GeEV+bMClpUThnTe8Xw3thW5EzF9oQB4zisMVvOpNhYOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050588; c=relaxed/simple;
	bh=ua1YjQwoGUxl1srrWu+EopWerUHaXBHmdI6tAD/TOWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EymQ7TNgDFCuUGXIItuSys9FL/qUqTj7u/MwzqqIVFigk2lQwgeD4puQ4PIwBUbHGLXgENDlKU1lrTGWDQxSOIly7VKrjCcddewgsLDFNfxWHW/F9FGCwqiVJqhAltNlHb8ORAI+g0uJ8T4zk5mydsKY1ddCdYnqQ9omZ/I/szY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qF7ex1vz; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02c3be32-4826-408d-8b96-1db51dcababf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766050574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXEVgSDfFQRZmqw91gtvqofxkpPFsKG1MF14J7844dQ=;
	b=qF7ex1vzVKMpqENmGb0AMh9twBFnr9nMf5mpXKR5++Gd6nWWWaAURqJCzsViZnil6yFo1B
	HOS+UAqUSEyN7ZMBZCH4sigL5pZfQDcy/5KZboawYghYgp/TmmRXe2/bnD2YFYp5F/RRRW
	EwT/AgFmuhPpXUU2TWiq2WzRFhdOpGY=
Date: Thu, 18 Dec 2025 17:36:00 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 5:09 PM, David Hildenbrand (Red Hat) wrote:
> On 12/17/25 08:27, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. To ensure safety, it will only be appropriate to
>> hold the rcu read lock or acquire a reference to the memory cgroup
>> returned by folio_memcg(), thereby preventing it from being released.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the memory cgroup in folio_migrate_mapping().
> 
> We usually avoid talking about "patches".

Got it.

> 
> In __folio_migrate_mapping(), the rcu read lock ...

Will do.

> 
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>>   mm/migrate.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 5169f9717f606..8bcd588c083ca 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct 
>> address_space *mapping,
>>           struct lruvec *old_lruvec, *new_lruvec;
>>           struct mem_cgroup *memcg;
>> +        rcu_read_lock();
>>           memcg = folio_memcg(folio);
> 
> In general, LGTM
> 
> I wonder, though, whether we should embed that in the ABI.
> 
> Like "lock RCU and get the memcg" in one operation, to the "return memcg 
> and unock rcu" in another operation.

Do you mean adding a helper function like get_mem_cgroup_from_folio()?

> 
> Something like "start / end" semantics.
> 
> -- 
> Cheers
> 
> David


