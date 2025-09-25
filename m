Return-Path: <cgroups+bounces-10435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7745B9D8A2
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB7238003D
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 06:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33B2E8B8F;
	Thu, 25 Sep 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dck+FoKs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9E2E7F3C
	for <cgroups@vger.kernel.org>; Thu, 25 Sep 2025 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780725; cv=none; b=Nn3nNShbsZheU/jci/J42z96eZenYz+vpcBtWFlf9FEPztA+ymFMzzV/ZCl0l6SCUUTqeSHWoVVq4tEQjstAXuvno/w6e+a8NHkGV0ZsrJ9znisuaycJ7fGv1YbQIhKgewh4Y1+oq8rip14OEVXTK0QiiMIodhlrLMArl0qchZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780725; c=relaxed/simple;
	bh=2WWBoKOmTJ1w9/H0no6PrlJT+kcDR4H8VfA9NzWmlqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koeUV9De1Iq4rc+x3Ra7jHeV55xe1qKeYydX6yVHP6wIf8xLej5EZkJpO30ROY0vWMlL5ZNytkmMSb1bSk2PKfCiWceSJjKDLAgQEwMvfqsDKkdfi9vgKyq5zqgMXufQTWj8AjjXyfQcl9nKsQ/wJraoaC1dtQ/L2vCiNOpVl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dck+FoKs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244580523a0so6938645ad.1
        for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758780723; x=1759385523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBnESjrn7YE3VD1R8wLTisr50tXYLyvlq0Q7unAi83o=;
        b=dck+FoKsMNNEIL4YRAoZtFKmBwy6z3vF692FVwkvU4eONgKnl9R7HMlEjD3qJ5mNp1
         ZR5G6pLMgYVNdBm0JyrUjIlwF+ZX5BEo2Q/qt+9hySlIScvaB4rH2ooB8oYmox8TvtlZ
         hiD4o7ARLome2zDiTatBlEt6la//AbbXu7mR8qsKAvpHAGxBiDRscUtOC/MQKEe7S9id
         EEcABs19DMN5/cO/T6qGcL2ttLkO/yzt8aCBhxkdlpL5ELPSkYMJ2QPB19aUAoIsO2cD
         z4tdPI7wGVXwJJevTWdeSRisrC+ckOhxLIYjqyar7+kHy6Vq6POgI3OowQXf/g2+Dgjd
         AAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780723; x=1759385523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBnESjrn7YE3VD1R8wLTisr50tXYLyvlq0Q7unAi83o=;
        b=wzAs2eEt/t8iwgOyRSXU6mM1oDW7LWA1JHQgBbfeIisYD0v4uByruZPCTZsL+zqley
         0LGutezlS+lQTMMpu8ZIUCIOFBxycB4bzavJHcPCUzVANx/0wPVL+g2JYVPrCOBK3X7B
         fuNe/3X+90jL/2b49CGBBVhvZrAo6y4dA56G2EGMPmWkuibsLoY47qRZib7xSJ3vpMq1
         5avo5Dbm2xG6yYLcHE5JRdje3ESn/5P8NDiyrr+dBOjOPyozUo4u1GmewiU2VCuPCnwe
         Fl1+6JK7stDpcK8AY082Pqj/mhplsVAAypDsTN64NSy1yD+uFRIL4PFzjDL3XNgfdpg/
         u+9g==
X-Forwarded-Encrypted: i=1; AJvYcCU680zu4wMvfkLKjmw0HqEM2eIx83eVafMTI0j9mgpe58fZy9t8KvFgNHyh+RPKQkUcMS7LAwLX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlc/bpL4M8gNjQhtzEP+AayXB9wpK0GoCUjdorr13dDWn8pCUy
	39UFir3mBRySRhqVSGJTzsBuKc4L6eWSPWvgrpuFW4659Up1+BNpP9mMf0Wp6gXSeQQ=
X-Gm-Gg: ASbGncstOdvKNbQIxTeMQ6rCuXO1flgrCtYWY+rN+YhiMX8Zh2xBpRxp9b4ELXnTqJn
	wZsESmbg3Pr4WTd8iBivCBov8iXztwVUmFTFJoCXd0lvJyadJP3EOfTnRKHNKvHgDGTsvGcj0Pk
	TkpvwWF36bApmq5HJTI+BRg2YeAa06yt76WhKDy8LV2aWU2DnfK6LdsmFdTp1oLN4lcUcEuVc0h
	2Atyu35Oto2pxv+mZZcqgK4sB7w7zH5YLGVULpV9InXkThZy6O+rOxp5EJE9HJMAfKuPkipbqp6
	XYn7UjqT4F2DSol1wayKS9gFAhWnHO6spdhhcNjQ+T5DWNnAJBTztI1ZD75mrUA4Q6X+gfT7Gta
	f2cO2jiph3R+bp6V/U4LO7GwKes1t4+2zrR/PRt+YO/dVK8+QqQmA4GaXEac2l1La3Le9
X-Google-Smtp-Source: AGHT+IFX3HNUWNSQugBFP4TDu56vU0SUrsp6NGoojXzrA0bsnO/JcgP+qt+1DH5//CMoXoVaCTunhQ==
X-Received: by 2002:a17:902:f602:b0:275:b1cf:6dd9 with SMTP id d9443c01a7336-27ed4a608c8mr25539195ad.52.1758780722685;
        Wed, 24 Sep 2025 23:12:02 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d2ffdsm12803605ad.18.2025.09.24.23.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 23:12:02 -0700 (PDT)
Message-ID: <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
Date: Thu, 25 Sep 2025 14:11:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: David Hildenbrand <david@redhat.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 9/24/25 8:38 PM, David Hildenbrand wrote:
> On 23.09.25 11:16, Qi Zheng wrote:
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split 
>> queue
>> to its parent.
>>
>> Similar to list_lru, the split queue is relatively independent and does
>> not need to be reparented along with objcg and LRU folios (holding
>> objcg lock and lru lock). So let's apply the same mechanism as list_lru
>> to reparent the split queue separately when memcg is offine.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/huge_mm.h |  2 ++
>>   include/linux/mmzone.h  |  1 +
>>   mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>>   mm/memcontrol.c         |  1 +
>>   mm/mm_init.c            |  1 +
>>   5 files changed, 44 insertions(+)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index f327d62fc9852..a0d4b751974d2 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
>>       return split_huge_page_to_list_to_order(page, NULL, ret);
>>   }
>>   void deferred_split_folio(struct folio *folio, bool partially_mapped);
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>           unsigned long address, bool freeze);
>> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio 
>> *folio, struct page *page,
>>   }
>>   static inline void deferred_split_folio(struct folio *folio, bool 
>> partially_mapped) {}
>> +static inline void reparent_deferred_split_queue(struct mem_cgroup 
>> *memcg) {}
>>   #define split_huge_pmd(__vma, __pmd, __address)    \
>>       do { } while (0)
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 7fb7331c57250..f3eb81fee056a 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1346,6 +1346,7 @@ struct deferred_split {
>>       spinlock_t split_queue_lock;
>>       struct list_head split_queue;
>>       unsigned long split_queue_len;
>> +    bool is_dying;
> 
> It's a bit weird to query whether the "struct deferred_split" is dying. 
> Shouldn't this be a memcg property? (and in particular, not exist for 

There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
the protection of the split_queue_lock, otherwise the folio may be added
back to the deferred_split of child memcg.

> the pglist_data part where it might not make sense at all?).

Maybe:

#ifdef CONFIG_MEMCG
     bool is_dying;
#endif

> 
>>   };
>>   #endif
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 48b51e6230a67..de7806f759cba 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1094,9 +1094,15 @@ static struct deferred_split 
>> *folio_split_queue_lock(struct folio *folio)
>>       struct deferred_split *queue;
>>       memcg = folio_memcg(folio);
>> +retry:
>>       queue = memcg ? &memcg->deferred_split_queue :
>>               &NODE_DATA(folio_nid(folio))->deferred_split_queue;
>>       spin_lock(&queue->split_queue_lock);
>> +    if (unlikely(queue->is_dying == true)) {
> 
> if (unlikely(queue->is_dying))

Will do.

> 
>> +        spin_unlock(&queue->split_queue_lock);
>> +        memcg = parent_mem_cgroup(memcg);
>> +        goto retry;
>> +    }
>>       return queue;
>>   }
>> @@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio 
>> *folio, unsigned long *flags)
>>       struct deferred_split *queue;
>>       memcg = folio_memcg(folio);
>> +retry:
>>       queue = memcg ? &memcg->deferred_split_queue :
>>               &NODE_DATA(folio_nid(folio))->deferred_split_queue;
>>       spin_lock_irqsave(&queue->split_queue_lock, *flags);
>> +    if (unlikely(queue->is_dying == true)) {
> 
> if (unlikely(queue->is_dying))

Will do.

> 
>> +        spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
>> +        memcg = parent_mem_cgroup(memcg);
>> +        goto retry;
>> +    }
>>       return queue;
>>   }
> 
> Nothing else jumped at me, but I am not a memcg expert :)

Thanks,
Qi

> 


