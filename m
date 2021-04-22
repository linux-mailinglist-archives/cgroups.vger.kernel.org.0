Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0933685D4
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhDVR0s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 13:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhDVR0s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 13:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619112373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgrykvHsm4oUpPb5SrWHqatA+LCGse7E/iLZHkfS3uU=;
        b=AwHNFgejMr0/Q7ilnDby/UUL+2iacKZZbpVA7teD50COtXT76oP57VrNwNhUr5nJSgCIeR
        pD3YyDGZnDhjluXSIc4mhrbXzC1JRwul93baqWErdIDSbeXKYkOs0CZnF9S9iEiYMAXoUV
        b6Q03qbTYVU53p5EpDRXFcNTl42FqH8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-2dyfDCd6OjOV8pNZ6nNMpg-1; Thu, 22 Apr 2021 13:26:11 -0400
X-MC-Unique: 2dyfDCd6OjOV8pNZ6nNMpg-1
Received: by mail-qt1-f200.google.com with SMTP id p15-20020a05622a00cfb02901ae13813340so15825314qtw.15
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 10:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mgrykvHsm4oUpPb5SrWHqatA+LCGse7E/iLZHkfS3uU=;
        b=nBvZZ/bOEazpnARpscunfkjImg8tOHCDiuZ7tm7iu3DaoIS0oKBhOIYs0EkVpf8Up3
         CBxGGFn8mxrxICpyDG/J2nfqTijRka2ugjolF69TYwRap0GJXPlgUZeu6Y6WugAP/e1b
         bA7WEaPFC8svtVpw4jXKHkpQDQ9esHKOKFId/hMWpmKBZy0AFdoPpy0sOWHoPqbQIr/P
         r0amm0T5ig+c28wxNaVjaDzpJ8mnGy60lDZqNliT04vOh48XTpcnSsL3bJPmjpdB9N44
         LrSsuRWK8hVUz7W3vLfYkS11uaWaK53jMR6qOgoqzZSz0GpBPZfwdMOo8jD2ySfzmOvt
         UyXg==
X-Gm-Message-State: AOAM532EBvvZqLM2Z1Tp6mBTyZ64HEUQVwR1VcBi1eAyp6LHmIWPRATY
        a1iYF3Kzpft3Hh4WUE+FpFnuVeYU/A0AyzEd0Q/OdCcgMgLHve00KOV9yAFGP2TuOag6IjnHVRw
        lrYLF0154jEzmBwMMxw==
X-Received: by 2002:ac8:7c56:: with SMTP id o22mr4302557qtv.80.1619112370994;
        Thu, 22 Apr 2021 10:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkAIa2KVsCjc+o4m54OgLpYmLkfXn5KxqfvRsNce+1rON88VeWZ7f2X+FnoyZX0tyaFOleXA==
X-Received: by 2002:ac8:7c56:: with SMTP id o22mr4302510qtv.80.1619112370733;
        Thu, 22 Apr 2021 10:26:10 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id z11sm2504070qkz.84.2021.04.22.10.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:26:10 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-next v5 3/4] mm/memcg: Improve refill_obj_stock()
 performance
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-4-longman@redhat.com>
 <YIC7dh0+nQDFmU+T@carbon.dhcp.thefacebook.com>
Message-ID: <d17f1c19-fc1b-df92-8361-fa6b88170861@redhat.com>
Date:   Thu, 22 Apr 2021 13:26:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIC7dh0+nQDFmU+T@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/21/21 7:55 PM, Roman Gushchin wrote:
> On Tue, Apr 20, 2021 at 03:29:06PM -0400, Waiman Long wrote:
>> There are two issues with the current refill_obj_stock() code. First of
>> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
>> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
>> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
>> be used again which leads to another call to drain_obj_stock() and
>> obj_cgroup_get() as well as atomically retrieve the available byte from
>> obj_cgroup. That is costly. Instead, we should just uncharge the excess
>> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
>> function should only be called when obj_cgroup changes.
> I really like this idea! Thanks!
>
> However, I wonder if it can implemented simpler by splitting drain_obj_stock()
> into two functions:
>       empty_obj_stock() will flush cached bytes, but not reset the objcg
>       drain_obj_stock() will call empty_obj_stock() and then reset objcg
>
> Then we simple can replace the second drain_obj_stock() in
> refill_obj_stock() with empty_obj_stock(). What do you think?

Actually the problem is the flushing cached bytes to 
objcg->nr_charged_bytes that can become a performance bottleneck in a 
multithreaded testing scenario. See my description in the latter half of 
my cover-letter.

For cgroup v2, update the page charge will mostly update the per-cpu 
page charge stock. Flushing the remaining byte charge, however, will 
cause the obgcg to became the single contended cacheline for all the 
cpus that need to flush the byte charge. That is why I only update the 
page charge and left the remaining byte charge stayed put in the object 
stock.

>
>> Secondly, when charging an object of size not less than a page in
>> obj_cgroup_charge(), it is possible that the remaining bytes to be
>> refilled to the stock will overflow a page and cause refill_obj_stock()
>> to uncharge 1 page. To avoid the additional uncharge in this case,
>> a new overfill flag is added to refill_obj_stock() which will be set
>> when called from obj_cgroup_charge().
>>
>> A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
>> 96-thread x86-64 system with 96 testing threads were run.  Before this
>> patch, the total number of kilo kmalloc+kfree operations done for a 4k
>> large object by all the testing threads per second were 4,304 kops/s
>> (cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
>> number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
>> represents a performance improvement of 1.10X (cgroup v1) and 49.3X
>> (cgroup v2).
> This part looks more controversial. Basically if there are N consequent
> allocations of size (PAGE_SIZE + x), the stock will end up with (N * x)
> cached bytes, right? It's not the end of the world, but do we really
> need it given that uncharging a page is also cached?

Actually the maximum charge that can be accumulated in (2*PAGE_SIZE + x 
- 1) since a following consume_obj_stock() will use those bytes once the 
byte charge is not less than (PAGE_SIZE + x).

Yes, the page charge is cached for v2, but it is not the case for v1. 
See the benchmark data in the cover-letter.

Cheers,
Longman


