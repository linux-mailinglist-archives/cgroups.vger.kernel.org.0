Return-Path: <cgroups+bounces-12057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5712C6917B
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 12:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D810F2AED6
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9332E748;
	Tue, 18 Nov 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gspnzMPR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3A354701
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465388; cv=none; b=ByRpjzDYv75Qv5TSTAM/XbRhFWpnnMs5n2eNuX+rXvFxDOOF5+RJZWpSaosTNBEp9cBKDoYSlQqayKjIrN+DW3bDT+2Aj09/AytyDevnh0Af5grlkvEzHPrQ2WFOn0FCbpkDof29kuuxT96JddMOKuPGjALG7U4ms18DlVn4sHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465388; c=relaxed/simple;
	bh=4QPaVuGij+YWtrMatMbZh6NJpJ81rODLt0v3BCXr6cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFAcl4lQV5d0T1LxUepO+SpRWrZ574wrm/35CSXYNGocNbtlNq+3z3q9U/da5VG1abjEJeGr8vgeXsbCp1wi4fy30bKcZw4xZIpIFcaQJeeQAZR24+xsUfXCsaiaitu3Uf4qFnmPdc/1bW0fgkT66d8UEAzAjmuIFEm5fJtrytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gspnzMPR; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5edc1b6-4c63-42c7-91ab-f1a28cb0b50d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763465382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0v0oDcmCB5Zh0jXwX66CTwJWuRZAjcycr0+mPGx35yo=;
	b=gspnzMPRplkGC7z867QwFTewkyJ1jjD8SAY4+hZ5grMuKYL4z3vcftv20YsB7Tvuoklsnr
	lIldrY/eVYcS/1pcbbKqyyBzBTryTYFum5nsvx+FUvKU0xMCV+MjQZ3x65rVy2dTaKNs0g
	adrtIcsNfbPNmXZFG6gXMX4BVkJRCjc=
Date: Tue, 18 Nov 2025 19:28:41 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 06/26] mm: memcontrol: return root object cgroup for
 root memory cgroup
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
 <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
 <aRroO9ypxvHsAjug@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRroO9ypxvHsAjug@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry,

On 11/17/25 5:17 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:19PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Memory cgroup functions such as get_mem_cgroup_from_folio() and
>> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
>> even for the root memory cgroup. In contrast, the situation for
>> object cgroups has been different.
>>
>> Previously, the root object cgroup couldn't be returned because
>> it didn't exist. Now that a valid root object cgroup exists, for
>> the sake of consistency, it's necessary to align the behavior of
>> object-cgroup-related operations with that of memory cgroup APIs.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/memcontrol.h | 29 +++++++++++++++++-------
>>   mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
>>   mm/percpu.c                |  2 +-
>>   3 files changed, 46 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 6185d8399a54e..9fdbd4970021d 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -332,6 +332,7 @@ struct mem_cgroup {
>>   #define MEMCG_CHARGE_BATCH 64U
>>   
>>   extern struct mem_cgroup *root_mem_cgroup;
>> +extern struct obj_cgroup *root_obj_cgroup;
>>   
>>   enum page_memcg_data_flags {
>>   	/* page->memcg_data is a pointer to an slabobj_ext vector */
>> @@ -549,6 +550,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>>   	return (memcg == root_mem_cgroup);
>>   }
>>   
>> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>> +{
>> +	return objcg == root_obj_cgroup;
>> +}
> 
> After reparenting, an objcg may satisfy objcg->memcg == root_mem_cgroup
> while objcg != root_obj_cgroup. Should they be considered as
> root objcgs?

Indeed, it's pointless to charge to root_mem_cgroup (objcg->memcg).

So it should be:

static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
{
	return (objcg == root_obj_cgroup) || (objcg->memcg == root_mem_cgroup);
}

> 
>>   static inline bool mem_cgroup_disabled(void)
>>   {
>>   	return !cgroup_subsys_enabled(memory_cgrp_subsys);
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 2afd7f99ca101..d484b632c790f 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2871,7 +2865,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>>   	int ret = 0;
>>   
>>   	objcg = current_obj_cgroup();
>> -	if (objcg) {
>> +	if (!obj_cgroup_is_root(objcg)) {
> 
> Now that we support the page and slab allocators support allocating memory
> in NMI contexts (on some archs), current_obj_cgroup() can return NULL
> if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi()) returns true
> (then it leads to a NULL-pointer-deref bug).
> 
> But IIUC this is applied to kmem charging only (as they use this_cpu ops
> for stats update), and we don't have to apply the same restriction to
> charging LRU pages with objcg.
> 
> Maybe Shakeel has more insight on this.
> 
> Link: https://lore.kernel.org/all/20250519063142.111219-1-shakeel.butt@linux.dev

Thanks for this information, and it seems there's nothing wrong here.

Thanks,
Qi

> 


