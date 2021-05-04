Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC55373123
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhEDUDQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 16:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232627AbhEDUDQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 16:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620158538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VE7sisr51bWaASPhEsNZ/WxzuZMuCTfCXf9ed9Dm2Lw=;
        b=P9bdSKVD92RGMQWbFhkGmorsbIQWIw6CXJ6oF4UirhGOry3Bhv5whxq6bTXVwesnDu9i2Z
        PACBbnB7ZW/ZdfF9Z3P3apCuhZbjZ004W6G4JUvXi9+9aVD39PiVH8Axqb1ABLXppNg9pR
        M4wXUyYZcZcVsQ3K8VvAdTjaxyuSFu4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-ZpCGNZg6O0Sn-o77-IWx-w-1; Tue, 04 May 2021 16:02:17 -0400
X-MC-Unique: ZpCGNZg6O0Sn-o77-IWx-w-1
Received: by mail-qk1-f200.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso4306077qkg.10
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 13:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VE7sisr51bWaASPhEsNZ/WxzuZMuCTfCXf9ed9Dm2Lw=;
        b=FyRdRooUhc6rJwwZ9jPeh0bRshTXORYNXYV0aZkurD6eV7wZtY9u+BOu8+YkY2rBiA
         w3g1YUab2EKQzqAkuHb3865UEwYf5vo6Xs074x9CXyL6EmIySFbDmxyCjHGJipMEwdk2
         XaAQvAB7+tox0tkI8Y1LOycCFEpfYJhwEWCqHG8YM3CIqmardeJ+DRbiD81oODSfqSV6
         IYdtLd9xjiyMd3ct6ORB0CEhy0Y/TWjbzXrXEMzd+6a5BApCp09j3TPI8VRA7UZaqDSt
         xFw9THIaaYS4OGAjSHAxq2IOiS5hxKlyJVcPs6UOGF3rEFTk7BVrkQTGkS4rGGZ+zLaQ
         jLbQ==
X-Gm-Message-State: AOAM531+MKEolqExsQMcAsB3DMbEMMdGR9YWzRnen1AxgZz9MFOIUnAg
        GDDO8gTHjsNRjwYCvGFj8ygMvwguJr6wqCWH5UBhQYrxj7RvLnuiVZYMqDPqME4Scazt8aeawSm
        1zY9bi69xqdadr4gFPQ==
X-Received: by 2002:a37:8906:: with SMTP id l6mr27594725qkd.198.1620158536438;
        Tue, 04 May 2021 13:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzew9UQi58ZCeX2QWSS7d98RivIluTCwTthqw1aP/iQD40qJkD8jFbyDdr63EWdkEgiv7Xbpg==
X-Received: by 2002:a37:8906:: with SMTP id l6mr27594691qkd.198.1620158536155;
        Tue, 04 May 2021 13:02:16 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t6sm2442450qkh.29.2021.05.04.13.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:02:15 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
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
References: <20210504132350.4693-1-longman@redhat.com>
 <20210504132350.4693-2-longman@redhat.com>
 <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com>
Message-ID: <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
Date:   Tue, 4 May 2021 16:02:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/4/21 3:37 PM, Shakeel Butt wrote:
> On Tue, May 4, 2021 at 6:24 AM Waiman Long <longman@redhat.com> wrote:
>> Since the merging of the new slab memory controller in v5.9, the page
>> structure may store a pointer to obj_cgroup pointer array for slab pages.
>> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
>> is not readily reclaimable and doesn't need to come from the DMA buffer.
>> So those GFP bits should be masked off as well.
>>
>> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
>> that it is consistently applied no matter where it is called.
>>
>> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 8 ++++++++
>>   mm/slab.h       | 1 -
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c100265dc393..5e3b4f23b830 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>>   }
>>
>>   #ifdef CONFIG_MEMCG_KMEM
>> +/*
>> + * The allocated objcg pointers array is not accounted directly.
>> + * Moreover, it should not come from DMA buffer and is not readily
>> + * reclaimable. So those GFP bits should be masked off.
>> + */
>> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
> What about __GFP_DMA32? Does it matter? It seems like DMA32 requests
> go to normal caches.

I included __GFP_DMA32 in my first draft patch. However, __GFP_DMA32 is 
not considered in determining the right kmalloc_type() (patch 2), so I 
took it out to make it consistent. I can certainly add it back.

Cheers,
Longman

