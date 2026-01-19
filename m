Return-Path: <cgroups+bounces-13304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE605D39CBF
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 04:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC3E930019F6
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B201EFFB7;
	Mon, 19 Jan 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdfhqaVd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EB1A3164
	for <cgroups@vger.kernel.org>; Mon, 19 Jan 2026 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768792839; cv=none; b=id3AdN0RgzOV8bf2lPsmFfemrvIsOUxmyIeIS5B0EP7QpDDpTibQfkMfvJE6TbI5IRCcCJsYZyX61DGUeAFJgcc8o69W8l4lxSx8IpUAuSuD2B8JHHMq5OoZKe0S5p7UUEAYvR8JXNq9wkELhDecbmOUWSC7imIvu0R7ts2n3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768792839; c=relaxed/simple;
	bh=6Ird/YJAGamQS9pATV0ibxkGqtnF/uRt/syENrfRcnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU66Nt02iTrMa3IKD91n1NaP2fW2U2QEO5fC1eKTCxGX+hF8n4H+DGGeM0gMBqztxeSazgq1393MEDq4jlxzg2HlzIZWdB1P9u/EWqSCT1n73SCmoJHKQGkb32k7bJ1YeZrIogLE1LGuVQEj5Vdk6xrWOa711RqHsDMe1Y9p8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdfhqaVd; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2b2d0e6-0690-41e5-9718-ef4a1985e50c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768792834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pd6kZGNbyNYE8tPLcAsqL3zBFM4wIaBCbTnO8h62LzA=;
	b=hdfhqaVdUy2hJ5povwHWvJH4g07Wa6Kmf/JVODLiU5Fp9De+Ho7k9WyFuc+U4pD1cqVdLB
	oeu4dSx2lKbMq72W34qHqDZEz/ZdAlRuDR0vJuFNUQR3WpiyyCsiD/7+7Rt73FiwhGNGvI
	yIRlAM+lX63AEX1QPjs39nfRRXxNHvY=
Date: Mon, 19 Jan 2026 11:20:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/30] mm: memcontrol: prevent memory cgroup release in
 get_mem_cgroup_from_folio()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <c5c8eba771ab90d03f4c024c2384b8342ec41452.1768389889.git.zhengqi.arch@bytedance.com>
 <qdfq2vxdma4qnt7pyfvuiyiib6ffuv46jyqsfgab643ihzttb6@h4hodwsqkmom>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <qdfq2vxdma4qnt7pyfvuiyiib6ffuv46jyqsfgab643ihzttb6@h4hodwsqkmom>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/18/26 8:31 AM, Shakeel Butt wrote:
> On Wed, Jan 14, 2026 at 07:32:35PM +0800, Qi Zheng wrote:
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
>>   mm/memcontrol.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 982c9f5cf72cb..0458fc2e810ff 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -991,14 +991,18 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
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
>> +	do {
>> +		memcg = folio_memcg(folio);
>> +	} while (unlikely(!css_tryget(&memcg->css)));
> 
> I went back to [1] where AI raised the following concern which I want to
> address:
> 
>> If css_tryget() fails (e.g. refcount is 0), this loop spins indefinitely
>> with the RCU read lock held. Is it guaranteed that folio_memcg() will
>> return a different, alive memcg in subsequent iterations?
> 
> Will css_tryget() ever fail for the memcg returned by folio_memcg()?
> Let's suppose memcg of a given folio is being offlined. The objcg
> reparenting happens in memcg_reparent_objcgs() which is called in
> offline_css() chain and we know that the offline context holds a
> reference on the css being offlined (see css_killed_work_fn()).
> 
> Also let's suppose the offline process has the last reference on the
> memcg's css. Now we have following two scenarios:
> 
> Scenario 1:
> 
> get_mem_cgroup_from_folio()		css_killed_work_fn()
>    memcg = folio_memcg(folio)		  offline_css(css)
>    					    memcg_reparent_objcgs()
>    css_tryget(memcg)
>    					  css_put(css)
> 
> In the above case css_tryget() will not fail.
> 
> 
> Scenario 2:
> 
> get_mem_cgroup_from_folio()		css_killed_work_fn()
>    memcg = folio_memcg(folio)		  offline_css(css)
>    					    memcg_reparent_objcgs()
>    					  css_put(css) // last reference
>    css_tryget(memcg)
>    // retry on failure
> 
> In the above case the context in get_mem_cgroup_from_folio() will retry
> and will get different memcg during reparenting happening before the
> last css_put(css).
> 
> So, I think we are good and AI is mistaken.
> 
> Folks, please check if I missed something.

LGTM, thank you for such a detailed analysis!

> 
>>
>> If the folio is isolated (e.g. via migrate_misplaced_folio()), it might be
>> missed by reparenting logic that iterates LRU lists.
> 
> LRU isolation will not impact reparenting logic, so we can discount this
> as well.
> 
>> In that case, the
>> folio would continue pointing to the dying memcg, leading to a hard lockup.
>>
>> Also, folio_memcg() calls __folio_memcg(), which reads folio->memcg_data
>> without READ_ONCE().
> 
> Oh I think I know why AI is confused. It is because it is looking at
> folio->memcg i.e. state with this patch only and not the state after the
> series. In the current state the folio holds the reference on memcg, so
> css_tryget() will never fail.
> 
>> Since this loop waits for memcg_data to be updated
>> by another CPU (reparenting), could the compiler hoist the load out of
>> the loop, preventing the update from being seen?
>>
>> Finally, the previous code fell back to root_mem_cgroup on failure. Is it
>> safe to remove that fallback? If css_tryget() fails unexpectedly, hanging
>> seems more severe than the previous behavior of warning and falling back.
> 
> [1] https://lore.kernel.org/all/7ia4ldikrbsj.fsf@castle.c.googlers.com/
> 
> 


