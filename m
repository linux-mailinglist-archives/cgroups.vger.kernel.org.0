Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7D35D4A2
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 03:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhDMBDY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 21:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237386AbhDMBDX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 21:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618275784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NsnOZhfDDmNX8NdBm3yb2Qi8vpH9UqjQP9RovkzcARY=;
        b=SNEQzAlAPT+aQ60YxDF9A1iBUUmr1sXHtAEsrfNdGhf2loB6+6ib5wrjICqvnBCidFZDFb
        1tHCXoFy+IsBn4JlE4ACf4KLKCJpbDRxWHucGfM5+9GVc84Z/VvKKNT/Q/ZJ8klY10wpRz
        zRNow3guhdZmrLhoNxCPXKnPu0rH4MY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-9U7C8qyIMYGFXGzfgD5jIA-1; Mon, 12 Apr 2021 21:03:03 -0400
X-MC-Unique: 9U7C8qyIMYGFXGzfgD5jIA-1
Received: by mail-qk1-f198.google.com with SMTP id h19so10142317qkk.4
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 18:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NsnOZhfDDmNX8NdBm3yb2Qi8vpH9UqjQP9RovkzcARY=;
        b=puGKowkg0TfUYy43ix8Mfkh6iOUddDzUgw2f+acutmyed/Yz1nBzdMUtI2DaTB/dw5
         +XbnCvG+iquxoc8NPn4mRpG5yOlV8TJACYNnS4fozjNNYCEDRlsNDgqJAU1KvGHAHInS
         oFv+Ug5lDiQ4erX3Poh+tAokdDCXWUiGe3ht0HVeFua8iiD5NmmlQtfFoQma1JU6wXma
         +1OVEM9aXFawRbd6bvPa4JWb3eZt3XL5g+jxrA9cG+6Pmh8z6R4HWfmo/o9bwzIB5+6t
         9lAyWV8pEonvaGKan5awXNpfQIQ/9+hqV+xc+LSg6fP24hK1C6Q53OBFmVFQX499d59E
         g9yg==
X-Gm-Message-State: AOAM5332wTMUAjq+Ys7XdcyvyD4niuCyQ5Ke/Z7ZEoNnvMFMhWpjY/AK
        ZucIABoqDNqyM2d6RtY6eTzaxNUpj5w8opbOvvPgc0WJseG+WR8KeMDjKRMoqqajr2Rc8NE/0Y9
        q545kiPjL9DkFSTrQjw==
X-Received: by 2002:ac8:40d9:: with SMTP id f25mr27965021qtm.323.1618275782805;
        Mon, 12 Apr 2021 18:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf+ajxx6gJ8y8Xb7tFiweNA1lCZ4uIyKIj/PrrD1+GTjvm+6qf5Zxe9z4kJ2aMGZUg27GXLw==
X-Received: by 2002:ac8:40d9:: with SMTP id f25mr27964989qtm.323.1618275782525;
        Mon, 12 Apr 2021 18:03:02 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f9sm9097847qkk.115.2021.04.12.18.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 18:03:01 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 5/5] mm/memcg: Optimize user context object stock
 access
To:     Shakeel Butt <shakeelb@google.com>
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
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210412225503.15119-1-longman@redhat.com>
 <20210412225503.15119-6-longman@redhat.com>
 <CALvZod6_dOKfnhprpzoFNmC2cLu1F35dNZvnu-DHTNOxYmeq2g@mail.gmail.com>
Message-ID: <507e199e-963c-b7e2-958a-6cc61b55ca5d@redhat.com>
Date:   Mon, 12 Apr 2021 21:03:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6_dOKfnhprpzoFNmC2cLu1F35dNZvnu-DHTNOxYmeq2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/12/21 7:10 PM, Shakeel Butt wrote:
> On Mon, Apr 12, 2021 at 3:55 PM Waiman Long <longman@redhat.com> wrote:
>> Most kmem_cache_alloc() calls are from user context. With instrumentation
>> enabled, the measured amount of kmem_cache_alloc() calls from non-task
>> context was about 0.01% of the total.
>>
>> The irq disable/enable sequence used in this case to access content
>> from object stock is slow.  To optimize for user context access, there
>> are now two object stocks for task context and interrupt context access
>> respectively.
>>
>> The task context object stock can be accessed after disabling preemption
>> which is cheap in non-preempt kernel. The interrupt context object stock
>> can only be accessed after disabling interrupt. User context code can
>> access interrupt object stock, but not vice versa.
>>
>> The mod_objcg_state() function is also modified to make sure that memcg
>> and lruvec stat updates are done with interrupted disabled.
>>
>> The downside of this change is that there are more data stored in local
>> object stocks and not reflected in the charge counter and the vmstat
>> arrays.  However, this is a small price to pay for better performance.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Acked-by: Roman Gushchin <guro@fb.com>
>> ---
>>   mm/memcontrol.c | 73 +++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 59 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 69f728383efe..29f2df76644a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2229,7 +2229,8 @@ struct obj_stock {
>>   struct memcg_stock_pcp {
>>          struct mem_cgroup *cached; /* this never be root cgroup */
>>          unsigned int nr_pages;
>> -       struct obj_stock obj;
>> +       struct obj_stock task_obj;
>> +       struct obj_stock irq_obj;
>>
>>          struct work_struct work;
>>          unsigned long flags;
>> @@ -2254,11 +2255,48 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>>   }
>>   #endif
>>
>> +/*
>> + * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
>> + * sequence used in this case to access content from object stock is slow.
>> + * To optimize for user context access, there are now two object stocks for
>> + * task context and interrupt context access respectively.
>> + *
>> + * The task context object stock can be accessed by disabling preemption only
>> + * which is cheap in non-preempt kernel. The interrupt context object stock
>> + * can only be accessed after disabling interrupt. User context code can
>> + * access interrupt object stock, but not vice versa.
>> + */
>>   static inline struct obj_stock *current_obj_stock(void)
>>   {
>>          struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
>>
>> -       return &stock->obj;
>> +       return in_task() ? &stock->task_obj : &stock->irq_obj;
>> +}
>> +
>> +#define get_obj_stock(flags)                           \
>> +({                                                     \
>> +       struct memcg_stock_pcp *stock;                  \
>> +       struct obj_stock *obj_stock;                    \
>> +                                                       \
>> +       if (in_task()) {                                \
>> +               preempt_disable();                      \
>> +               (flags) = -1L;                          \
>> +               stock = this_cpu_ptr(&memcg_stock);     \
> The above line was missing in the previous version.
>
>> +               obj_stock = &stock->task_obj;           \
>> +       } else {                                        \
>> +               local_irq_save(flags);                  \
>> +               stock = this_cpu_ptr(&memcg_stock);     \
>> +               obj_stock = &stock->irq_obj;            \
>> +       }                                               \
>> +       obj_stock;                                      \
>> +})
>> +
>> +static inline void put_obj_stock(unsigned long flags)
>> +{
>> +       if (flags == -1L)
>> +               preempt_enable();
>> +       else
>> +               local_irq_restore(flags);
>>   }
>>
>>   /**
>> @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
>>          local_irq_save(flags);
>>
>>          stock = this_cpu_ptr(&memcg_stock);
>> -       drain_obj_stock(&stock->obj);
>> +       drain_obj_stock(&stock->irq_obj);
>> +       if (in_task())
>> +               drain_obj_stock(&stock->task_obj);
>>          drain_stock(stock);
>>          clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>>
>> @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>>          memcg = obj_cgroup_memcg(objcg);
>>          if (pgdat)
>>                  lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> -       __mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>> +       mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>>          rcu_read_unlock();
>>   }
>>
>> @@ -3193,7 +3233,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>>          unsigned long flags;
>>          bool ret = false;
>>
>> -       local_irq_save(flags);
>> +       stock = get_obj_stock(flags);
>>
>>          stock = current_obj_stock();
> The above is redundant.

Right. I should check the patch carefully. Will remove it.

Thanks,
Longman


