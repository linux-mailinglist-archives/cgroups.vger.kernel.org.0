Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A52374850
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhEES55 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhEES54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620241019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLt9keyCtnOhXLfxqmhiGEZ6r/sGiYdHdPIuhsn7KMg=;
        b=WEM9JBH5t8363HzEBQJImNrG8zCagRSxEdiQRTWQ0/EOLYnYtSbnZ0OjWEWbHSZNy3eCtJ
        4To1GpRu0LzEPeJYKYDnLldcfelpSv1BqhbrffKjKdsnmp1xNZprbAkjSkAcMH1sSAbGNa
        /oNRtYQkwUztIvdiO7CAHuyFt7ndt50=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-Y7uMv2EXPjON9V0ulmEVcA-1; Wed, 05 May 2021 14:56:58 -0400
X-MC-Unique: Y7uMv2EXPjON9V0ulmEVcA-1
Received: by mail-qk1-f200.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so1813443qkj.19
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 11:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RLt9keyCtnOhXLfxqmhiGEZ6r/sGiYdHdPIuhsn7KMg=;
        b=gl02UAMRcApNECLaJ+hdCHV1H7AK8gg1UmTKPJ61G9Ua6Gx1nF/zqwiu9tW8vi5h5F
         LFXD5Sw9AQCX6l2BeqoDToIMZlnkLE00gfcvA3Wka3xYGGvVZmi+vZsSKVWkJSMRcYSV
         KyYHn290GKD7KT6LMPq9z1WfrpmvMMYDRjYqCa3Vp8smKJkD7WmJ3Q8hmuN3Q5Os/4m2
         /KAD0Lvz3S/sLNDtWueVB/8CobQYs3rQVwgeUSGG+2N+693yNNxWRHfK1/8qEH1akMyC
         v8rGkSKjdgRRWiMFEtWCmT8li6OEGtrCp9V6OvzgPyyEcvX7BhpUfvI6TwlAiTQC6gQx
         Rijg==
X-Gm-Message-State: AOAM531yn8axvySbZuI5v9ZDlEI9yHqNRdY39O+Z+5ZIscdaT1c7TKtX
        PoKfKPLHS0TU5hk0kKKtV5p4Ys2yYxltMA2GBhZZkn8UhbHK7isxLq6gvf7kZDe4ZDU1YDv5vtk
        nIpF+6FjtLutO7wRbrg==
X-Received: by 2002:a37:745:: with SMTP id 66mr204372qkh.5.1620241017478;
        Wed, 05 May 2021 11:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzckruqTN3kXgcSr9qWxQj+MrQudiplS4IKJ4eXLo4TgviBYuj44Hisiiloy2k99iFmqoy/Ig==
X-Received: by 2002:a37:745:: with SMTP id 66mr204360qkh.5.1620241017317;
        Wed, 05 May 2021 11:56:57 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a195sm109640qkg.101.2021.05.05.11.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:56:56 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Roman Gushchin <guro@fb.com>, Waiman Long <llong@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
 <4e4b6903-2444-f4ed-f589-26d5beae3120@redhat.com>
 <YJLmGcGYLZwqehIX@carbon.dhcp.thefacebook.com>
Message-ID: <1b235531-e165-954a-74b1-d3477c2a4b87@redhat.com>
Date:   Wed, 5 May 2021 14:56:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YJLmGcGYLZwqehIX@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 2:38 PM, Roman Gushchin wrote:
> On Wed, May 05, 2021 at 02:31:28PM -0400, Waiman Long wrote:
>> On 5/5/21 2:02 PM, Vlastimil Babka wrote:
>>> On 5/5/21 7:30 PM, Roman Gushchin wrote:
>>>> On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
>>>>> With this change, all the objcg pointer array objects will come from
>>>>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>>>>> both the recursive kfree() problem and non-freeable slab problem are
>>>>> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>>>>> have mixed accounted and unaccounted objects, this will slightly reduce
>>>>> the number of objcg pointer arrays that need to be allocated and save
>>>>> a bit of memory.
>>>> Unfortunately the positive effect of this change will be likely
>>>> reversed by a lower utilization due to a larger number of caches.
>>>>
>>>> Btw, I wonder if we also need a change in the slab caches merging procedure?
>>>> KMALLOC_NORMAL caches should not be merged with caches which can potentially
>>>> include accounted objects.
>>> Good point. But looks like kmalloc* caches are extempt from all merging in
>>> create_boot_cache() via
>>>
>>> 	s->refcount = -1;       /* Exempt from merging for now */
>>>
>>> It wouldn't hurt though to create the kmalloc-cg-* caches with SLAB_ACCOUNT flag
>>> to prevent accidental merging in case the above is ever removed. It would also
>>> better reflect reality, and ensure that the array is allocated immediately with
>>> the page, AFAICS.
>>>
>> I am not sure if this is really true.
>>
>> struct kmem_cache *__init create_kmalloc_cache(const char *name,
>>                  unsigned int size, slab_flags_t flags,
>>                  unsigned int useroffset, unsigned int usersize)
>> {
>>          struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
>>
>>          if (!s)
>>                  panic("Out of memory when creating slab %s\n", name);
>>
>>          create_boot_cache(s, name, size, flags, useroffset, usersize);
>>          kasan_cache_create_kmalloc(s);
>>          list_add(&s->list, &slab_caches);
>>          s->refcount = 1;
>>          return s;
>> }
>>
>> Even though refcount is set to -1 initially, it is set back to 1 afterward.
>> So merging can still happen AFAICS.
> Right, thanks, I already noticed it. Then yeah, we should make sure we're not
> merging KMALLOC_NORMAL caches with any others.
>
That should be easy. We just set the refcount to -1 for the 
KMALLOC_NORMAL caches right after its creation then.

Cheers,
Longman

