Return-Path: <cgroups+bounces-12127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDBC744AE
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA38735DB73
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811B33B6DF;
	Thu, 20 Nov 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MrvtAjUo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D02586CE
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645548; cv=none; b=V83NNivPWfwDAiVclp/hHlFenrAYNfmjoP9KcIjnIH3Y1eti59+gV7Xpi3LO9jPsBF3pV9koShXFL7sayyW51A4j+uIQzdeJLqMbcyVuf4AU2dWKJxr6+2MtgjT2mYoLy6Z62SsxWC/CICk8ulLbuzvo+cDvPnxOUNCP4PJVFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645548; c=relaxed/simple;
	bh=IJxh2M3vKGK5A0CnshNuqGDiwNQWoK5AMGJhGneIs6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8IxTaibDLJWtksI66/o5CP3dU9Z37Y8AZq9NKrzYYBhZE09A+JlVqUsCnpEB6ekf7NFl46Uy6nbViiuxf/TLOmpgJHkVFAIHVyyhYIebLoy1x8yUr9hPMwVFVNz/W670C9G/DbMBcTZhaaWnYZ342hL9u+vOc3stYmK3bFCy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MrvtAjUo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d372282-d443-4fe4-942b-998aa742eb0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763645543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybURcIVrz7mysPIWzBzQOyxvKWboFgst4pbQzAb0oQs=;
	b=MrvtAjUo07c82+yzmSH3h/kWt7CxnHcNiFmUBnzEiScilBeS3UAknDBBayZG72RaQ8b49Q
	WsAmvYaMaleu27E7PklGE0FVra3y9mswrhSRUNrvF0HZmdUAEY8r2jRI/jkyLrgiQttdNI
	kc5UbGFFwApLOHJkmNaZMpZXo4OaYmY=
Date: Thu, 20 Nov 2025 21:32:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 07/26] mm: memcontrol: prevent memory cgroup release in
 get_mem_cgroup_from_folio()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <9eca65dec044d4352bee84511fb58960a1402ddf.1761658310.git.zhengqi.arch@bytedance.com>
 <aR16bLuvj-W0AAM1@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aR16bLuvj-W0AAM1@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/19/25 4:06 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:20PM +0800, Qi Zheng wrote:
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
>> ---
> 
> This patch looks correct to me, so:
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> with a few side question on current implementation rather than
> this change...
> 
>>   mm/memcontrol.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d484b632c790f..1da3ad77054d3 100644
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
> 
> I have no idea why we're already calling rcu_read_lock() when a folio pins
> the memcg :)

+1, this was introduced by 
https://github.com/torvalds/linux/commit/f77f0c7514789577125c1b2df145703161736359,
may be some defensive programming.

> 
>> -		memcg = root_mem_cgroup;
>> +retry:
>> +	memcg = folio_memcg(folio);
>> +	if (unlikely(!css_tryget(&memcg->css)))
>> +		goto retry;
>>   	rcu_read_unlock();
>>   	return memcg;
>>   }
>> -- 
>> 2.20.1
> 


