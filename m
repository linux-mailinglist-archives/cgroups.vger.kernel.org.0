Return-Path: <cgroups+bounces-12491-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D4CCB3AD
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 162243027C99
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1F3016E7;
	Thu, 18 Dec 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlt0+kyk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642192F49F6;
	Thu, 18 Dec 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051015; cv=none; b=fOPGtrOiyZl7wEv4B0dT9Gqu860pQ3RS3+MPuSRRoig12+3NjO1dCGMZMYfG4P2kcmv4W2YQNs+Pn6pXyEphyJwnxiJWsqwClvie2zUGZhfLu8XxD1JhguHGdVVeKTBgiYmFTgmg8pVpebsIlwdnTiu6oY6JzPkqEuI0/jlBog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051015; c=relaxed/simple;
	bh=W/qmYeDxG0g6wORIz29Z78deE874oJ9pDVm2KieOcss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeDVjAaH9wgtjTILrLgQSqXxUKZgewjswoas9gR9st5ISdSBx9W57HjPVYhVn0cjlqcwCHqx2T0ae2xliDNPNw6FZMUtiWu3PZ5DGP7XwukacAe1wdfR8YTfpaXLVZ816uk5DneujRIszwCKrIqgj2hxnwexcogGl6t95RFK6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlt0+kyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A44C4CEFB;
	Thu, 18 Dec 2025 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766051015;
	bh=W/qmYeDxG0g6wORIz29Z78deE874oJ9pDVm2KieOcss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tlt0+kykzbzNIp2VLjkAWLd8XB2fRlfNJebkBDgtbtPLc+fvA1vLkUg/zJDXt/TLD
	 QI9RUNoB4lF6pvQHRDeHFH5HJg1+IzLMk7ze3bNCPy3zJy9sSSF8LrKTXtCM2rsexN
	 kuGb+KZDBWSktM4WisGBulWXNxViRzSowPPYmfEXlmZFqP+YAdjNdKoeMDblYvIVOq
	 FJXO1MUyvyRz5L30D+5VvFGm1hfRYsRo5JyitC5OcF0vKcKhi+yPWOx7uK19zkMlmL
	 opi8nNkCdB2lBMri+A2x17UXa3kofOQbirzivRvlvxMF3UV0MkWq0sv+9Uhx7VqoJj
	 Rk/Kdz1JGTutw==
Message-ID: <d62756d4-c249-474e-ae80-478d3c7cf34d@kernel.org>
Date: Thu, 18 Dec 2025 10:43:27 +0100
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <02c3be32-4826-408d-8b96-1db51dcababf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 10:36, Qi Zheng wrote:
> 
> 
> On 12/18/25 5:09 PM, David Hildenbrand (Red Hat) wrote:
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
> 
> Got it.
> 
>>
>> In __folio_migrate_mapping(), the rcu read lock ...
> 
> Will do.
> 
>>
>>>
>>> This serves as a preparatory measure for the reparenting of the
>>> LRU pages.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>> ---
>>>    mm/migrate.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 5169f9717f606..8bcd588c083ca 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct
>>> address_space *mapping,
>>>            struct lruvec *old_lruvec, *new_lruvec;
>>>            struct mem_cgroup *memcg;
>>> +        rcu_read_lock();
>>>            memcg = folio_memcg(folio);
>>
>> In general, LGTM
>>
>> I wonder, though, whether we should embed that in the ABI.
>>
>> Like "lock RCU and get the memcg" in one operation, to the "return memcg
>> and unock rcu" in another operation.
> 
> Do you mean adding a helper function like get_mem_cgroup_from_folio()?

Right, something like

memcg = folio_memcg_begin(folio);
folio_memcg_end(memcg);

Maybe someone reading along has a better idea. Then you can nicely 
document the requirements in the kerneldocs, and it is clear why the RCU 
lock is used (internally).

-- 
Cheers

David

