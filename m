Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D9373FDC
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhEEQcM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234102AbhEEQcL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 12:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620232274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81DdwLuppEsne8dGMXcwRqVz38oxfrnLdDs7rg3uPgM=;
        b=a65U/VOdhBbIQB/m3vpi+3wT15YOxGG0dzzRtZZfhBxSfaVgDcoAUOlb1pS/O8+Mr5gZhJ
        qzbT2w/eKZAStnpSXcpZ+lEQl9KlnOQjbX3WjHYnd/Ux0Rjz/3eoHwXeKadh0o3CnMAuUe
        MSzJtk2VTlPGq135IPYOqx0BuCQu9ao=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-CXa1jO9dNdu9DeIMZ4CkLA-1; Wed, 05 May 2021 12:31:12 -0400
X-MC-Unique: CXa1jO9dNdu9DeIMZ4CkLA-1
Received: by mail-qt1-f199.google.com with SMTP id d10-20020a05622a100ab02901b8224bae03so1443125qte.2
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 09:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=81DdwLuppEsne8dGMXcwRqVz38oxfrnLdDs7rg3uPgM=;
        b=Qi1TZ1YJ6yYuW10PPJcvK3d1/aWIYb9QA/RySMSjVyNHOaC9nRMzKK+hXvksYHg2oN
         ULEvX26jETE4ozz2y8FxwmyGr3KboxGJ5ZBoyGP8emZMZdzIOiVQ0XIWNoNzNmDZq9RT
         50w6avaJdAjjTEjX3OHKZdKMgIKZRsF8AJHbRYuFc18ebPacXtHeCYXtHbJX6pNMj4fO
         JVAglVCzmCCsVZ84L712HQ+N4aLWTHVSybS7VJdyPFbJzQZFs0/RpgklYHpdhhAUP/wz
         MaoqGfYLEDsUzVA4jAcywEk//c7XJtdwrpJXbG4S9F64SYhbD3YEtY9LEpcOOcEMn+Fo
         4aTQ==
X-Gm-Message-State: AOAM533i4goZe4f8PYYDb/xLqDqlcdTXHfFD6XZVODkcIiSLqZFNkTae
        hooL5EGy0Jj1CbCAh42gTwG2QnGK3outFQF8qkqBm0Xy2QChwE13FGedInzoPOHL1S3liZN/9sJ
        UtPnWBwIXo1gj8XtHdA==
X-Received: by 2002:a05:620a:15ca:: with SMTP id o10mr3168437qkm.448.1620232272343;
        Wed, 05 May 2021 09:31:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTBEKFUN7wXglaJUYSMmAOxWOuFIgMxOXBXNY/vFjUujrx4c1jniCEPsD1GaLRm8BV6S4gDA==
X-Received: by 2002:a05:620a:15ca:: with SMTP id o10mr3168418qkm.448.1620232272090;
        Wed, 05 May 2021 09:31:12 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c23sm5338915qtm.46.2021.05.05.09.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 09:31:11 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <4c1a0436-2d46-d23a-2eef-d558e37373bf@suse.cz>
Message-ID: <a93ee868-24ed-73ad-543c-5fba19c934e8@redhat.com>
Date:   Wed, 5 May 2021 12:31:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <4c1a0436-2d46-d23a-2eef-d558e37373bf@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 12:06 PM, Vlastimil Babka wrote:
> On 5/5/21 5:46 PM, Waiman Long wrote:
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
>>
>> With this change, all the objcg pointer array objects will come from
>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>> both the recursive kfree() problem and non-freeable slab problem are
>> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>> have mixed accounted and unaccounted objects, this will slightly reduce
>> the number of objcg pointer arrays that need to be allocated and save
>> a bit of memory.
>>
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
> You could move this to the enum definition itself? E.g.:
>
> #ifdef CONFIG_MEMCG_KMEM
> 	KMALLOC_CGROUP,
> #else
> 	KMALLOC_CGROUP = KMALLOC_NORMAL,
> #endif
>
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
> Not "both flags" anymore. Something like "so test with a single branch that
> there are none of the flags that would select a different type"
Right. I just left the comment there without taking a deeper look. My bad.

Cheers,
Longman

