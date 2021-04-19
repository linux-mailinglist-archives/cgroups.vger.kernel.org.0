Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E0364816
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhDSQTF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 12:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233878AbhDSQTE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 12:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618849113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqJmgeuiMFVLhBvmQoDThETkhKCzy/6fbNKOoBifg+Y=;
        b=UznDFFsTEYnvnBOnCFKsIqvjyXMNfAYF0QsXUR0avcr4leLfCEczcuKSdNhFEIsgiZl2g5
        QOC8CnjSPA3fFzrQxdjY44AxF+dJjDxM9fFrCc9d7R46hu9ID1dKrksWGJQyBeGgU/h5pt
        YVNhZri1WLelV6XZURjZSWRQBduodJc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-ycfIGoOyPkqFBOsBLRuFhQ-1; Mon, 19 Apr 2021 12:18:32 -0400
X-MC-Unique: ycfIGoOyPkqFBOsBLRuFhQ-1
Received: by mail-qt1-f199.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so6549293qta.19
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 09:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fqJmgeuiMFVLhBvmQoDThETkhKCzy/6fbNKOoBifg+Y=;
        b=DeXqhmgGErxhXJCkH0AmlmncuNLqFHbl2TBHi7yXq9fLA4ueSaOV+JPACu/Gs7E3b6
         1FWKC74Ov0UWfaGA4/T6s6YrkWdnMYPt9TF3uw2bvFWJpK7XJjp5O7zNTEcI65jd5ti+
         6sSo6uFj0jrnd/FwWjJV02SOaA00TMqLWYK20fhHDf+wPsFwTfQhlNGFeKjoM+qm6oyA
         XVN39YzMK3krKcrNXMIGUvtN71AVRaH0PiwTE390/8tcdPen2OMJvpBtIESVwkTPWhSI
         xLb3NJzseG6R6JQFjEpJlB1KNbLuCb+iL2oVhun1dLoXlCsYD4TBb8q6PH0xkUnf+ygi
         zPUw==
X-Gm-Message-State: AOAM530NGgmODPRtXujUR6fmCnO8x6BLnLIJuQuHT7xnNNOnuSO4oJ9S
        gLRScEDcffpXspkV2plk/c8TXF5XKFtDqBQZbx6yglmkrRGqLXo81CZ2kLHnre/fqoxUrqZ0mLg
        /IOCOtLnPcsPEU+b5pw==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr5491941qkj.4.1618849111635;
        Mon, 19 Apr 2021 09:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJUxsMhOaiewnOvltNqxLcFgDmHVqmxsvQ037G7yq3H/F6qF/yWngPBHq6ZDy4Zx0BKbsUeQ==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr5491908qkj.4.1618849111409;
        Mon, 19 Apr 2021 09:18:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f16sm10296757qkl.25.2021.04.19.09.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 09:18:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
Date:   Mon, 19 Apr 2021 12:18:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 11:21 AM, Waiman Long wrote:
> On 4/19/21 11:14 AM, Johannes Weiner wrote:
>> On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
>>> The mod_objcg_state() function is moved from mm/slab.h to 
>>> mm/memcontrol.c
>>> so that further optimization can be done to it in later patches without
>>> exposing unnecessary details to other mm components.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   mm/memcontrol.c | 13 +++++++++++++
>>>   mm/slab.h       | 16 ++--------------
>>>   2 files changed, 15 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index e064ac0d850a..dc9032f28f2e 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct page 
>>> *page, int order)
>>>       css_put(&memcg->css);
>>>   }
>>>   +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data 
>>> *pgdat,
>>> +             enum node_stat_item idx, int nr)
>>> +{
>>> +    struct mem_cgroup *memcg;
>>> +    struct lruvec *lruvec = NULL;
>>> +
>>> +    rcu_read_lock();
>>> +    memcg = obj_cgroup_memcg(objcg);
>>> +    lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>> +    mod_memcg_lruvec_state(lruvec, idx, nr);
>>> +    rcu_read_unlock();
>>> +}
>> It would be more naturally placed next to the others, e.g. below
>> __mod_lruvec_kmem_state().
>>
>> But no deal breaker if there isn't another revision.
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>
> Yes, there will be another revision by rebasing patch series on the 
> linux-next. I will move the function then. 

OK, it turns out that mod_objcg_state() is only defined if 
CONFIG_MEMCG_KMEM. That was why I put it in the CONFIG_MEMCG_KMEM block 
with the other obj_stock functions. I think I will keep it there.

Thanks,
Longman

