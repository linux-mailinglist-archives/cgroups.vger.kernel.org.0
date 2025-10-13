Return-Path: <cgroups+bounces-10654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A71BD1CDF
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66223189866F
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D92E92C0;
	Mon, 13 Oct 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BNutXIZ+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF692E92AD
	for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340580; cv=none; b=f+W2Hi5MCr6n/Tv27TsoD5J3hLIJPmMjuzFX+iUd683fGYOG0uNIamKTb3E1UnpIyuCQYoqIK9dIdzutziwU0sW5fLoqfpBhNjGs3Iydj68ChGU+ual2FMr2x4CFv8qlb7/ARcwIu+VHC6MFQ4g0t0xO/HG2lAtTAKSSzy4vDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340580; c=relaxed/simple;
	bh=lh1ojtXM+TO/pCbuzBlCz8MfGt6zSeQlY0BcDmXgxRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru7HgZUi7oaaoI1/uElBzncF+TKP7VMb05Q95Ygzo4yST87UjPqS2ds4W0rsVL0LYw69S+Kiw+N5gkLt/DjBigtHQ3pi2r1p+yE983utz2gDAy7oZelSfSrcp7lIaY1BwHjDMjGVW6p548tmmT6hsrVrZOAtSvTl3DsWTAl9LYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BNutXIZ+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab6edd99-30a3-486c-bc47-ffcac3d93b51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760340574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vZP9HpsjeKEWQ9ykCUaY7omAgoRs+k/b14bmmT76T0=;
	b=BNutXIZ+c4siKB0mcFGD5RRZLQ3PNEf4I+6qjrSKnIkaPg0w193ytJEFODM97FcOGAKkFr
	h3TfaalDIraRKKKPNhyRj0RIk99hSEnanM8rJMAFGpPqpQOTvpybOD19xKYlGgOqyxwCfP
	/U+6UvEP1XKa3jDhi3iMXOtrkadH7tE=
Date: Mon, 13 Oct 2025 15:29:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
 <sdpkprxqf43emy5sttfzxnv4aemlarimdybdva4xyywyndajtx@zyvckuxgujzm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <sdpkprxqf43emy5sttfzxnv4aemlarimdybdva4xyywyndajtx@zyvckuxgujzm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 10/8/25 1:56 AM, Shakeel Butt wrote:
> On Sat, Oct 04, 2025 at 12:53:18AM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to list_lru, the split queue is relatively independent and does
>> not need to be reparented along with objcg and LRU folios (holding
>> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
>> to reparent the split queue separately when memcg is offine.
>>
>> This is also a preparation for reparenting LRU folios.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/huge_mm.h |  4 +++
>>   mm/huge_memory.c        | 54 +++++++++++++++++++++++++++++++++++++++++
>>   mm/memcontrol.c         |  1 +
>>   3 files changed, 59 insertions(+)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index f327d62fc9852..0c211dcbb0ec1 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -417,6 +417,9 @@ static inline int split_huge_page(struct page *page)
>>   	return split_huge_page_to_list_to_order(page, NULL, ret);
>>   }
>>   void deferred_split_folio(struct folio *folio, bool partially_mapped);
>> +#ifdef CONFIG_MEMCG
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>> +#endif
>>   
>>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>   		unsigned long address, bool freeze);
>> @@ -611,6 +614,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>>   }
>>   
>>   static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>>   #define split_huge_pmd(__vma, __pmd, __address)	\
>>   	do { } while (0)
>>   
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 59ddebc9f3232..b5eea2091cdf6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1099,6 +1099,11 @@ static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memc
>>   {
>>   	return memcg ? &memcg->deferred_split_queue : split_queue_node(nid);
>>   }
>> +
>> +static bool memcg_is_dying(struct mem_cgroup *memcg)
>> +{
>> +	return memcg ? css_is_dying(&memcg->css) : false;
>> +}
> 
> Please move the above function to include/linux/memcontrol.h

OK, will do.

> 
> With that, please add:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

> 


