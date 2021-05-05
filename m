Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3533747DD
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhEESMy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhEESMy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620238316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nw/NXWJf7YefMV4xFftmS9WnDS1NhKlaE8hzMyBIij0=;
        b=Ja9IWhvqR+R7g0HFM0Rot7+v4B9/Vnr+Q3gJqLhjodJ6G8kIhen2LvT4GL0QI2hdSp8Rrr
        fTmQrz1DXlygp4CVYbJp5hPze+BqWhQXsAvahBVgX3FGTexniw3YMBN5q6/dxsS9n9N+lN
        1FahD9MjAUzeAmYwtyahpSYNZVvP8tg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ZZrxdg_fMtODz4P1v88Xpw-1; Wed, 05 May 2021 14:11:55 -0400
X-MC-Unique: ZZrxdg_fMtODz4P1v88Xpw-1
Received: by mail-qv1-f70.google.com with SMTP id x6-20020a0cda060000b02901c4b3f7d3d9so2332635qvj.0
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 11:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nw/NXWJf7YefMV4xFftmS9WnDS1NhKlaE8hzMyBIij0=;
        b=nPJBMR4KkgfM5Syey3UeXMe+w6ahef9yWTWZabaEQFgYrYXhOIh0g3aBEjMO+tu1+H
         iLxIdxjN2e/ZV3iWi+vJaHfX9ggNSRUIyDkn/E970rO9pgMBxcpuVYhyKNyaGPbk+16i
         2ERROXOTnB5MRIk3THr3C3x9Dtlg4kM62pLYr0tT15gtfAzR0h88DrFvEV89dWIT1MvK
         vwWQG2nexD1iSPa+hqJvyGLWTJugKyt0BXbTPnZCIIb8TJDMJDuD1Kn5gP2K3hEMmtFV
         qGPVLX/FxBUmaE0uzfzKnirEs41PbZj9kXXyL8Hr3kwmXPZBHT3YbXg8Ls10QNNVGexJ
         EMSQ==
X-Gm-Message-State: AOAM532khL7M0RnTNy0uMh8PT8ATMtrVwtTUEiubZWdjYWxi4IkQ4JNM
        bs3kuGP12vrqf9BvKQbuMuqMzkWxh7MHTgBCYooApGopRc1zea1oU4iInzdijJlJWV2GnY8zTyn
        YHiiCW5UEfYD4CB3A3g==
X-Received: by 2002:a37:de14:: with SMTP id h20mr53717qkj.34.1620238314919;
        Wed, 05 May 2021 11:11:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwduF4OFPouA+pHzOJt58325444lPg2GI9Z612zESLQpE/ZW3x/CASG2csLuEiKir1BNl4LYg==
X-Received: by 2002:a37:de14:: with SMTP id h20mr53688qkj.34.1620238314589;
        Wed, 05 May 2021 11:11:54 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id z4sm5539059qtq.34.2021.05.05.11.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:11:54 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
Message-ID: <f14a263b-10ea-ef2b-eefa-066591a4b637@redhat.com>
Date:   Wed, 5 May 2021 14:11:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 1:30 PM, Roman Gushchin wrote:
> On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
>> There are currently two problems in the way the objcg pointer array
>> (memcg_data) in the page structure is being allocated and freed.
>>
>> On its allocation, it is possible that the allocated objcg pointer
>> array comes from the same slab that requires memory accounting. If this
>> happens, the slab will never become empty again as there is at least
>> one object left (the obj_cgroup array) in the slab.
>>
>> When it is freed, the objcg pointer array object may be the last one
>> in its slab and hence causes kfree() to be called again. With the
>> right workload, the slab cache may be set up in a way that allows the
>> recursive kfree() calling loop to nest deep enough to cause a kernel
>> stack overflow and panic the system.
>>
>> One way to solve this problem is to split the kmalloc-<n> caches
>> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
>> (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
>> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
>> the other caches can still allow a mix of accounted and non-accounted
>> objects.
> I agree that it's likely the best approach here. Thanks for discovering
> and fixing the problem!
>
>> With this change, all the objcg pointer array objects will come from
>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>> both the recursive kfree() problem and non-freeable slab problem are
>> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>> have mixed accounted and unaccounted objects, this will slightly reduce
>> the number of objcg pointer arrays that need to be allocated and save
>> a bit of memory.
> Unfortunately the positive effect of this change will be likely
> reversed by a lower utilization due to a larger number of caches.

That is also true, will mention that.

>
> Btw, I wonder if we also need a change in the slab caches merging procedure?
> KMALLOC_NORMAL caches should not be merged with caches which can potentially
> include accounted objects.

Thank for catching this omission.

I will take a look and modify the merging procedure in a new patch. 
Accounting is usually specified at kmem_cache_create() time. Though, I 
did find one instance of setting ACCOUNT flag in kmem_cache_alloc(), I 
will ignore this case and merge accounted, but unreclaimable caches to 
KMALLOC_CGROUP.

>
>> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
>> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
>> will include the newly added caches without change.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/slab.h | 42 ++++++++++++++++++++++++++++++++++--------
>>   mm/slab_common.c     | 23 +++++++++++++++--------
>>   2 files changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 0c97d788762c..f2d9ebc34f5c 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -305,9 +305,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>>   /*
>>    * Whenever changing this, take care of that kmalloc_type() and
>>    * create_kmalloc_caches() still work as intended.
>> + *
>> + * KMALLOC_NORMAL is for non-accounted objects only whereas KMALLOC_CGROUP
>> + * is for accounted objects only. All the other kmem caches can have both
>> + * accounted and non-accounted objects.
>>    */
>>   enum kmalloc_cache_type {
>>   	KMALLOC_NORMAL = 0,
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	KMALLOC_CGROUP,
>> +#endif
>>   	KMALLOC_RECLAIM,
>>   #ifdef CONFIG_ZONE_DMA
>>   	KMALLOC_DMA,
>> @@ -315,28 +322,47 @@ enum kmalloc_cache_type {
>>   	NR_KMALLOC_TYPES
>>   };
>>   
>> +#ifndef CONFIG_MEMCG_KMEM
>> +#define KMALLOC_CGROUP	KMALLOC_NORMAL
>> +#endif
>> +#ifndef CONFIG_ZONE_DMA
>> +#define KMALLOC_DMA	KMALLOC_NORMAL
>> +#endif
>> +
>>   #ifndef CONFIG_SLOB
>>   extern struct kmem_cache *
>>   kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>>   
>> +/*
>> + * Define gfp bits that should not be set for KMALLOC_NORMAL.
>> + */
>> +#define KMALLOC_NOT_NORMAL_BITS					\
>> +	(__GFP_RECLAIMABLE |					\
>> +	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
>> +	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
>> +
>>   static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>>   {
>> -#ifdef CONFIG_ZONE_DMA
>>   	/*
>>   	 * The most common case is KMALLOC_NORMAL, so test for it
>>   	 * with a single branch for both flags.
>>   	 */
>> -	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
>> +	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
>>   		return KMALLOC_NORMAL;
> Likely KMALLOC_CGROUP is also very popular, so maybe we want to change the
> optimization here a bit.

I doubt this optimization is really noticeable and whether 
KMALLOC_CGROUP is really popular will depend on the workloads. I am not 
planning to spend additional time to micro-optimize this part of the code.

Cheers,
Longman

