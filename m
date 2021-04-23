Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D9369B1C
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbhDWUHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 16:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhDWUHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Apr 2021 16:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619208390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QiJOyaRBjpj+Qp4w+e7694mCmNFhGls/eL4ztohU9Y=;
        b=KgF5KQpWtQ/LCHQk6CqWB1RD/xvN4tDzE2C499dTMecYMM/XXp1yq1dow3HPTAMoLKWwqO
        A6ganN8cKc525c8t+6rv7F5BWTJiEeFv1lofxVqNe3Pl/mYdo2fYaZAsWN9GEHdFc9/JpK
        uH7L98dlX9mElc7DmcFsprs8WCkdp2A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Z_aF2zvGNEynVlNJtOZcwg-1; Fri, 23 Apr 2021 16:06:29 -0400
X-MC-Unique: Z_aF2zvGNEynVlNJtOZcwg-1
Received: by mail-qt1-f199.google.com with SMTP id a11-20020ac85b8b0000b02901a69faebe0cso18349563qta.6
        for <cgroups@vger.kernel.org>; Fri, 23 Apr 2021 13:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4QiJOyaRBjpj+Qp4w+e7694mCmNFhGls/eL4ztohU9Y=;
        b=n6Y1E+4Iq/CESDMiI/v7XmYARlD/atRT9MEhw2CrbL6Rnx/qJaLDJjPuqWFWjFTuuD
         VJr88P4SorUAQVcGZaNpU2efWA1ZJ14bhfeGcSXKHK1qTBDlRG1MxrGEcPLmy4WorBOY
         KqnysexroYeedJD64j1Stm5OR/oqcaO5ydToLw6jt2rhqa4tOWAWFdrWwOjrnothkUeA
         FQ1LlcEDer4QbL0V9UW8kAUDs9c3iTtwi/a9yIxbuiM0wyW56tgSgwtWchmflGOTSzC7
         R1TW5bII9eKaqNWoNHZLgiBgzREWn8uOr7e/AnkGVa+p65Ix5wPFVjo0rnrX5MlYuDJm
         0Fqw==
X-Gm-Message-State: AOAM532lv+wjyL/ng1nh99TwNanwOLqcumBy94VwXbhtlbXibVEmzjBL
        BKiNrK9/LAC8j7A2crOcuSFbfMX+ntS40Wbat4VngJdGYLG5zOIoyJGmKMuoPuLHjru57Zzk0qY
        5Wkwt0Px5Lrl4TTBszg==
X-Received: by 2002:a0c:f04a:: with SMTP id b10mr6261766qvl.59.1619208388190;
        Fri, 23 Apr 2021 13:06:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgdtumIs7B0CTazXqadnVbV5Zu/bStO7szazOP/9Tj1DQ93qT3QIMbESYDUlPfIwa3ilxYSg==
X-Received: by 2002:a0c:f04a:: with SMTP id b10mr6261738qvl.59.1619208387658;
        Fri, 23 Apr 2021 13:06:27 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f2sm5109329qkh.76.2021.04.23.13.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 13:06:27 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-next v5 3/4] mm/memcg: Improve refill_obj_stock()
 performance
To:     Roman Gushchin <guro@fb.com>, Waiman Long <llong@redhat.com>
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
 <d17f1c19-fc1b-df92-8361-fa6b88170861@redhat.com> <YIIwsAk4RaJw5WCL@carbon>
Message-ID: <49715eb2-9ac4-8208-2c63-e432092c3ab2@redhat.com>
Date:   Fri, 23 Apr 2021 16:06:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIIwsAk4RaJw5WCL@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/22/21 10:28 PM, Roman Gushchin wrote:
> On Thu, Apr 22, 2021 at 01:26:08PM -0400, Waiman Long wrote:
>> On 4/21/21 7:55 PM, Roman Gushchin wrote:
>>> On Tue, Apr 20, 2021 at 03:29:06PM -0400, Waiman Long wrote:
>>>> There are two issues with the current refill_obj_stock() code. First of
>>>> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
>>>> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
>>>> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
>>>> be used again which leads to another call to drain_obj_stock() and
>>>> obj_cgroup_get() as well as atomically retrieve the available byte from
>>>> obj_cgroup. That is costly. Instead, we should just uncharge the excess
>>>> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
>>>> function should only be called when obj_cgroup changes.
>>> I really like this idea! Thanks!
>>>
>>> However, I wonder if it can implemented simpler by splitting drain_obj_stock()
>>> into two functions:
>>>        empty_obj_stock() will flush cached bytes, but not reset the objcg
>>>        drain_obj_stock() will call empty_obj_stock() and then reset objcg
>>>
>>> Then we simple can replace the second drain_obj_stock() in
>>> refill_obj_stock() with empty_obj_stock(). What do you think?
>> Actually the problem is the flushing cached bytes to objcg->nr_charged_bytes
>> that can become a performance bottleneck in a multithreaded testing
>> scenario. See my description in the latter half of my cover-letter.
>>
>> For cgroup v2, update the page charge will mostly update the per-cpu page
>> charge stock. Flushing the remaining byte charge, however, will cause the
>> obgcg to became the single contended cacheline for all the cpus that need to
>> flush the byte charge. That is why I only update the page charge and left
>> the remaining byte charge stayed put in the object stock.
>>
>>>> Secondly, when charging an object of size not less than a page in
>>>> obj_cgroup_charge(), it is possible that the remaining bytes to be
>>>> refilled to the stock will overflow a page and cause refill_obj_stock()
>>>> to uncharge 1 page. To avoid the additional uncharge in this case,
>>>> a new overfill flag is added to refill_obj_stock() which will be set
>>>> when called from obj_cgroup_charge().
>>>>
>>>> A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
>>>> 96-thread x86-64 system with 96 testing threads were run.  Before this
>>>> patch, the total number of kilo kmalloc+kfree operations done for a 4k
>>>> large object by all the testing threads per second were 4,304 kops/s
>>>> (cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
>>>> number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
>>>> represents a performance improvement of 1.10X (cgroup v1) and 49.3X
>>>> (cgroup v2).
>>> This part looks more controversial. Basically if there are N consequent
>>> allocations of size (PAGE_SIZE + x), the stock will end up with (N * x)
>>> cached bytes, right? It's not the end of the world, but do we really
>>> need it given that uncharging a page is also cached?
>> Actually the maximum charge that can be accumulated in (2*PAGE_SIZE + x - 1)
>> since a following consume_obj_stock() will use those bytes once the byte
>> charge is not less than (PAGE_SIZE + x).
> Got it, thank you for the explanation!
>
> Can you, please, add a comment explaining what the "overfill" parameter does
> and why it has different values on charge and uncharge paths?
> Personally, I'd revert it's meaning and rename it to something like "trim"
> or just plain "bool charge".
> I think the simple explanation is that during the charge we can't refill more
> than a PAGE_SIZE - 1 and the following allocation will likely use it or
> the following deallocation will trim it if necessarily.
> And on the uncharge path there are no bounds and the following deallocation
> can only increase the cached value.

Yes, that is the intention. I will make suggested change and put in a 
comment about it.

Thanks,
Longman

