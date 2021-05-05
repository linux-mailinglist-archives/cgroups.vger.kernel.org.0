Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBE374040
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhEEQdf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234320AbhEEQc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 12:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620232322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zS3Ldg5vG9J3xehl8TqywjLJpgOH5ZU3rYG0PyHSqeM=;
        b=POFJ/gQjEBY1xU5bQA9R8vDQ7GOZ16bUx230ImEqE7xjy45GMQvtRZ2lTSmGZgeCeJustK
        lKiW++kMj0CWpZtMc8r8JfXg5vP/fPnnYCRS7ojU2USXj3BxY7vnzuVHSTJtDXh4GAb/1J
        ZrkQ4xK9OeWpL0Vpzc1YRx6VNTakxAM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-f4NGcCk3MvmSc2zqzmAdEw-1; Wed, 05 May 2021 12:32:00 -0400
X-MC-Unique: f4NGcCk3MvmSc2zqzmAdEw-1
Received: by mail-qv1-f69.google.com with SMTP id l5-20020a0ce0850000b02901c37c281207so2057976qvk.11
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 09:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zS3Ldg5vG9J3xehl8TqywjLJpgOH5ZU3rYG0PyHSqeM=;
        b=Wa3273X/Vg8PEegngCnSwb86Tkv+/EtUWT77GL1Gxl2m9T/e8T0Zh5jd2gamjuwLb6
         g1IOqnIOX3Qub1CR27BK56OHfThONwta5Z9ls5BDr/i0T24cSBgLqVpqaLAIOyKFPr+X
         zTTl38arVAMF2ANTUpnM9SZiHxw0wUmjFUKUhMulvHVk+nhlbfuTXhD4ORqYFcB8mKcR
         aLbU0hCe666o+k5pVxhdvDp06X+Zuox+6GgOgjpjGV79J2upq9lmjGbl5+L/nzIgmxDa
         HXhDMychbvliIKJjl5zq2H85bGQdngl8hD4wZCtmY8qOfUM1egkJDUi9L1EoFLS6649z
         l8Sg==
X-Gm-Message-State: AOAM530Wg7Ob83/R2iSh/Bem0I8icsm2iQG4T8hUrmqf5DP/rv9nVIIl
        gT0G1yCipDmk50DWjxo1YaD84dbPyIxEAGMjTbOE2cfx7Ws59FwcESUsM926yjK4ho6QghVHinz
        FcwchGu+8GraqZSgR3w==
X-Received: by 2002:a37:ae04:: with SMTP id x4mr30811420qke.245.1620232319469;
        Wed, 05 May 2021 09:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzapoUleiXdFkf8r1cnEmwbpWr9agCgZfPPLWunF6QFzhEPni5JL8P9LUWVyMAcGIOFvgnxQ==
X-Received: by 2002:a37:ae04:: with SMTP id x4mr30811377qke.245.1620232318969;
        Wed, 05 May 2021 09:31:58 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j9sm6455868qtl.15.2021.05.05.09.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 09:31:58 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <CALvZod7TzBVdwdCMChFNEZqYHxQUWBVfvWwtuAH-4rh_b4XRKw@mail.gmail.com>
Message-ID: <dbeb319b-81bb-ac4f-25f4-dd275834cd98@redhat.com>
Date:   Wed, 5 May 2021 12:31:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7TzBVdwdCMChFNEZqYHxQUWBVfvWwtuAH-4rh_b4XRKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 12:17 PM, Shakeel Butt wrote:
> On Wed, May 5, 2021 at 8:47 AM Waiman Long <longman@redhat.com> wrote:
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
> One nit below and after incorporating Vlastimil's suggestions:
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
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
>> + * is for accounted objects only.
> I think you can say "KMALLOC_CGROUP is for accounted and unreclaimable
> objects only".
>
Thanks for the suggestion. Will incorporate that.

Cheers,
Longman

