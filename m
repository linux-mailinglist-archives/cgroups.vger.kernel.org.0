Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD53646F7
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhDSPUK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 11:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233647AbhDSPUJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 11:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618845579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2yvjPSj/WyukvFAWpkfjx20IkLdkkzXTL7sCO1L7DLw=;
        b=bWgCAkzCjrv9KnyR0d4m3l9KkXWnQZZK6EI3SrG1EWLmmhtwhakubG708MbC5fGVxrW6rq
        gkT4MErSSWFgoVb9wX3xPLSbPIEg47gozzjHn0hBFRmWJ/TOtVRnRRhkPh82KZpKTF48Gi
        8+JADeJzaAJBxKn5ieQnYj8zCFS/1q8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-0HlP75I3M6ePChY4_AsYQA-1; Mon, 19 Apr 2021 11:19:37 -0400
X-MC-Unique: 0HlP75I3M6ePChY4_AsYQA-1
Received: by mail-qv1-f71.google.com with SMTP id l61-20020a0c84430000b02901a9a7e363edso1220844qva.16
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 08:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2yvjPSj/WyukvFAWpkfjx20IkLdkkzXTL7sCO1L7DLw=;
        b=Cohw7YX/MBrJXs1sTrnLs/5NBib01AUsyEPWU15NQZgl5femFy1zWMD7BDy8vHl40G
         NzYfs5g3yl3UKULs0qfghW6+jePNXCPMrvAdCI+vmEb7wRDzntNXvEx2MSj9Ck+Pisyi
         nM9miV+O1nLrChe8sa0sXezxwOin82ZTl2AzRxee5UYYaRhC6rbh1kggX3iLwJHeHwgf
         YQdycqiBjPIcWtuS8ju39bZ/yBteY07IC8itwpKEE5rrJRhr5QUuJcH+ZhrYxLvnPOrm
         8E6qKso+kZ4Jc4cUKFsIo634/DbSAaTGxI5/3IA85ZMESluqe9RMU0+6aeq5Vt7D2TqI
         H6kw==
X-Gm-Message-State: AOAM530xssdB8wpebPeh9A/cF/eZZ/oVNHtp+b5s/ggDwnaTZNSUtWDp
        MlwhhFBuPgKLHg4DmsgsynKpR3s8Ujj3Dd5jbY3iRXh1zeSBiUyf6BaPGVo++5+UqZ02bbiicsd
        Oo3KSkc/Ue86lNosxuA==
X-Received: by 2002:ae9:e015:: with SMTP id m21mr11885696qkk.420.1618845577014;
        Mon, 19 Apr 2021 08:19:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2YwZcRNUHjYxJNmq3jr7pmKRv0FT8z5DBqyMAE2VIkjgWcdRJCxjdxaHVNnbGoUIGDhI5fw==
X-Received: by 2002:ae9:e015:: with SMTP id m21mr11885665qkk.420.1618845576749;
        Mon, 19 Apr 2021 08:19:36 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j129sm9858703qkf.110.2021.04.19.08.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 08:19:36 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [External] [PATCH v4 5/5] mm/memcg: Improve refill_obj_stock()
 performance
To:     Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-6-longman@redhat.com>
 <CAMZfGtWX-Gik3i9_wmipuQZf0c-O-Yo_ejJYoN6-sf25vMLfog@mail.gmail.com>
 <CALvZod70htGEyUm0vfOMpufrW4b2c18U3wR8TxsErKpkn=+CGw@mail.gmail.com>
Message-ID: <d9c8bb88-0ec9-c40b-991f-64f32f08f0ed@redhat.com>
Date:   Mon, 19 Apr 2021 11:19:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod70htGEyUm0vfOMpufrW4b2c18U3wR8TxsErKpkn=+CGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 11:00 AM, Shakeel Butt wrote:
> On Sun, Apr 18, 2021 at 11:07 PM Muchun Song <songmuchun@bytedance.com> wrote:
>> On Mon, Apr 19, 2021 at 8:01 AM Waiman Long <longman@redhat.com> wrote:
>>> There are two issues with the current refill_obj_stock() code. First of
>>> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
>>> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
>>> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
>>> be used again which leads to another call to drain_obj_stock() and
>>> obj_cgroup_get() as well as atomically retrieve the available byte from
>>> obj_cgroup. That is costly. Instead, we should just uncharge the excess
>>> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
>>> function should only be called when obj_cgroup changes.
>>>
>>> Secondly, when charging an object of size not less than a page in
>>> obj_cgroup_charge(), it is possible that the remaining bytes to be
>>> refilled to the stock will overflow a page and cause refill_obj_stock()
>>> to uncharge 1 page. To avoid the additional uncharge in this case,
>>> a new overfill flag is added to refill_obj_stock() which will be set
>>> when called from obj_cgroup_charge().
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   mm/memcontrol.c | 23 +++++++++++++++++------
>>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index a6dd18f6d8a8..d13961352eef 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -3357,23 +3357,34 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>>>          return false;
>>>   }
>>>
>>> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>>> +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>>> +                            bool overfill)
>>>   {
>>>          unsigned long flags;
>>>          struct obj_stock *stock = get_obj_stock(&flags);
>>> +       unsigned int nr_pages = 0;
>>>
>>>          if (stock->cached_objcg != objcg) { /* reset if necessary */
>>> -               drain_obj_stock(stock);
>>> +               if (stock->cached_objcg)
>>> +                       drain_obj_stock(stock);
>>>                  obj_cgroup_get(objcg);
>>>                  stock->cached_objcg = objcg;
>>>                  stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
>>>          }
>>>          stock->nr_bytes += nr_bytes;
>>>
>>> -       if (stock->nr_bytes > PAGE_SIZE)
>>> -               drain_obj_stock(stock);
>>> +       if (!overfill && (stock->nr_bytes > PAGE_SIZE)) {
>>> +               nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>>> +               stock->nr_bytes &= (PAGE_SIZE - 1);
>>> +       }
>>>
>>>          put_obj_stock(flags);
>>> +
>>> +       if (nr_pages) {
>>> +               rcu_read_lock();
>>> +               __memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
>>> +               rcu_read_unlock();
>>> +       }
>> It is not safe to call __memcg_kmem_uncharge() under rcu lock
>> and without holding a reference to memcg. More details can refer
>> to the following link.
>>
>> https://lore.kernel.org/linux-mm/20210319163821.20704-2-songmuchun@bytedance.com/
>>
>> In the above patchset, we introduce obj_cgroup_uncharge_pages to
>> uncharge some pages from object cgroup. You can use this safe
>> API.
>>
> I would recommend just rebase the patch series over the latest mm tree.
>
I see, I will rebase it to the latest mm tree.

Thanks,
Longman

