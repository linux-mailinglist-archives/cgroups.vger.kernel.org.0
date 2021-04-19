Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916993648FF
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhDSR1F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 13:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238921AbhDSR1E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 13:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618853194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bP0dgJylGUHZI2K8PCqLGYvIKzzqMKEmXpSiyAKkpRw=;
        b=PSiHeAbaxVPQma/FZ+9T798DGFnCxaTPBhfi6hacs5ZmVSBqtUT/ck7RpYZYDKO2z+O5zj
        Gq9mG28Fm4UbPHJEb0M3L3GBKh1y42sUmZ/MoZ4UDVxRObX6wzclE9ymazftXyY3L+8MbM
        QeD64N2c+rGMnmx7rfzpjPLrolRnM1c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-UfUWmmSpOESyHfL7cHNb1Q-1; Mon, 19 Apr 2021 13:26:32 -0400
X-MC-Unique: UfUWmmSpOESyHfL7cHNb1Q-1
Received: by mail-qk1-f197.google.com with SMTP id 14-20020a05620a078eb02902e3f1eae0f1so287514qka.22
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bP0dgJylGUHZI2K8PCqLGYvIKzzqMKEmXpSiyAKkpRw=;
        b=MINfIQj0V4B53Jy+w+6HnFFxwopBngREG1KcGR3so07NjD3Nd+ssH/Rzt9wthxkRXQ
         6FUaVEncMjSQ3Y1d3YigVIQC30ltni/F8US8r1Jb17U8cOXL9XiPlvRUX6TpCBnrIF9c
         xavq7q8q+p4yEJE3uS4iGN7fzpRTKWctDDje4fQNlMnIHBSge01JfU+AFlcUPczRKUyB
         FG9GdfA5kI1AKGGUrh4aby5iqf2FHSzEmHIcFJc2b80D9ADI0IDnvUT1AfWjtWBfg7Db
         03YqEu/VKvsSLQRjj9Xn9v5GWu6wdg80atk4Jt/vxFb547G7F87pCRjEZNWO0XBiZkoz
         dCvA==
X-Gm-Message-State: AOAM530K7NtBf8ouLLVeHR+ijhNHMuBZElcxKvbnF4SIgw0ZtDpkvGjX
        11LblXyPDUD3pHo9R21wp6n/oQDmEf/QochR1BQTQKR9LyEET1P3Wge1QKYUbFtzQ6Mq3N5BQBX
        kN64p1VhI58MfhT487A==
X-Received: by 2002:ac8:b45:: with SMTP id m5mr12675866qti.56.1618853191881;
        Mon, 19 Apr 2021 10:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIZTibzrz4kicze63i+d0ejCOInPjvw1tyWYei7C0LpWKnxlmJLHYVjQAc/5TcNHS8aZuk7Q==
X-Received: by 2002:ac8:b45:: with SMTP id m5mr12675845qti.56.1618853191705;
        Mon, 19 Apr 2021 10:26:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a187sm10080819qkd.69.2021.04.19.10.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:26:31 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Waiman Long <llong@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com> <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
 <YH26RrMBOxLaMg4l@cmpxchg.org>
 <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
Message-ID: <d1c36f26-b958-49e0-ae44-1cf6334fa4c5@redhat.com>
Date:   Mon, 19 Apr 2021 13:26:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 1:19 PM, Waiman Long wrote:
> On 4/19/21 1:13 PM, Johannes Weiner wrote:
>> On Mon, Apr 19, 2021 at 12:18:29PM -0400, Waiman Long wrote:
>>> On 4/19/21 11:21 AM, Waiman Long wrote:
>>>> On 4/19/21 11:14 AM, Johannes Weiner wrote:
>>>>> On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
>>>>>> The mod_objcg_state() function is moved from mm/slab.h to
>>>>>> mm/memcontrol.c
>>>>>> so that further optimization can be done to it in later patches 
>>>>>> without
>>>>>> exposing unnecessary details to other mm components.
>>>>>>
>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>> ---
>>>>>>    mm/memcontrol.c | 13 +++++++++++++
>>>>>>    mm/slab.h       | 16 ++--------------
>>>>>>    2 files changed, 15 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>>> index e064ac0d850a..dc9032f28f2e 100644
>>>>>> --- a/mm/memcontrol.c
>>>>>> +++ b/mm/memcontrol.c
>>>>>> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct
>>>>>> page *page, int order)
>>>>>>        css_put(&memcg->css);
>>>>>>    }
>>>>>>    +void mod_objcg_state(struct obj_cgroup *objcg, struct
>>>>>> pglist_data *pgdat,
>>>>>> +             enum node_stat_item idx, int nr)
>>>>>> +{
>>>>>> +    struct mem_cgroup *memcg;
>>>>>> +    struct lruvec *lruvec = NULL;
>>>>>> +
>>>>>> +    rcu_read_lock();
>>>>>> +    memcg = obj_cgroup_memcg(objcg);
>>>>>> +    lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>>>> +    mod_memcg_lruvec_state(lruvec, idx, nr);
>>>>>> +    rcu_read_unlock();
>>>>>> +}
>>>>> It would be more naturally placed next to the others, e.g. below
>>>>> __mod_lruvec_kmem_state().
>>>>>
>>>>> But no deal breaker if there isn't another revision.
>>>>>
>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>>
>>>> Yes, there will be another revision by rebasing patch series on the
>>>> linux-next. I will move the function then.
>>> OK, it turns out that mod_objcg_state() is only defined if
>>> CONFIG_MEMCG_KMEM. That was why I put it in the CONFIG_MEMCG_KMEM 
>>> block with
>>> the other obj_stock functions. I think I will keep it there.
>> The CONFIG_MEMCG_KMEM has become sort of useless now. It used to be
>> configurable, but now it just means CONFIG_MEMCG && !CONFIG_SLOB. And
>> even that doesn't make sense because while slob doesn't support slab
>> object tracking, we can still do all the other stuff we do under
>> KMEM. I have a patch in the works to remove the symbol and ifdefs.
>>
>> With that in mind, it's better to group the functions based on what
>> they do rather than based on CONFIG_MEMCG_KMEM. It's easier to just
>> remove another ifdef later than it is to reorder the functions.
>>
> OK, I will make the move then. Thanks for the explanation. 

BTW, have you ever thought of moving the cgroup-v1 specific functions 
out into a separate memcontrol-v1.c file just like 
kernel/cgroup/cgroup-v1.c?

I thought of that before, but memcontrol.c is a frequently changed file 
and so a bit hard to do.

Cheers,
Longman

