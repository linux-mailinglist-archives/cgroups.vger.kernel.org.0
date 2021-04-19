Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6A364790
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbhDSP5d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 11:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240241AbhDSP5d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 11:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618847823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMDl/lLdep1N0/um0AmnQLaDki5aIWjkuWZjHPmQpqY=;
        b=I8PqGz6B/fQF/ZiXZcKgR+JAu5bhka6LHGQdvPWYAfOtevynUtcOi3LMV1sONd6sLcz8BR
        j9hquDtpZFBqXMbkyghy087gFgUpYRRm90u2Q1XlFF9AAHZUl/llXU62PkGip9CEfFw8tk
        +OS1X+Z3a0I3RmWRn9Xyr5nrXrmN2yI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-daNLMwWfOPmxkD1dXI9igA-1; Mon, 19 Apr 2021 11:57:01 -0400
X-MC-Unique: daNLMwWfOPmxkD1dXI9igA-1
Received: by mail-qt1-f199.google.com with SMTP id o15-20020ac872cf0000b02901b358afcd96so9224668qtp.1
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 08:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cMDl/lLdep1N0/um0AmnQLaDki5aIWjkuWZjHPmQpqY=;
        b=VUcWlc5wZe0NgPO3wyo8JS5Z09XjNvZTECcRZ97kUNyBr4hovE3FknoqEF7UkybUx9
         zXGtytcYMdXbTZqawMhy1JLh5gJWBwsWNhNR4gfvrFNrPh5b/dNrxU9S5HRNxQTjf7lP
         KKl8bvW/k1OLnH2byGGOwFw5uhvfHyUWjK+u26i7poabBJ14j/teBNyToVOOqpUZdIdN
         siWoanPeIPxDjxBQpjoUSoKuo1nktP7PmiW05nZ8ryhLo1R6yYakeUKQxXwhL2npFNY1
         w5sn8ZLAxTxIwa1lXfU1X9FV300awncgQH7fB9JEyBuk7QMLbZLfxVw/NsvtM4LTE18s
         66Lw==
X-Gm-Message-State: AOAM530vpA0myEhAAXeStUWHDvEbue2XH2nps+c3pF5ux4RoIYBRoqk/
        6TCYNpRJ4cV+e7MZ/FsLPUFluo8s5jRVPQjQ51bePLVn8FJw8LFUxWf3aENpJN2U/eMvd9T8ZA9
        B0M+KjD/YpNG6ARkoUw==
X-Received: by 2002:a05:620a:d5e:: with SMTP id o30mr12416012qkl.288.1618847820855;
        Mon, 19 Apr 2021 08:57:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCUXH+Qh1JrQB39fMDOdO1NkpZZqYz8SyTMXanP4rBFDGLrAYf2Gco03W/tyV9+hCZSBA2YQ==
X-Received: by 2002:a05:620a:d5e:: with SMTP id o30mr12415992qkl.288.1618847820631;
        Mon, 19 Apr 2021 08:57:00 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id w4sm10077790qkd.94.2021.04.19.08.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 08:57:00 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [External] [PATCH v4 5/5] mm/memcg: Improve refill_obj_stock()
 performance
To:     Muchun Song <songmuchun@bytedance.com>
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
        Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <da2e607f-995f-0b7d-b384-49c6ba5427a8@redhat.com>
Date:   Mon, 19 Apr 2021 11:56:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWX-Gik3i9_wmipuQZf0c-O-Yo_ejJYoN6-sf25vMLfog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 2:06 AM, Muchun Song wrote:
> On Mon, Apr 19, 2021 at 8:01 AM Waiman Long <longman@redhat.com> wrote:
>> There are two issues with the current refill_obj_stock() code. First of
>> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
>> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
>> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
>> be used again which leads to another call to drain_obj_stock() and
>> obj_cgroup_get() as well as atomically retrieve the available byte from
>> obj_cgroup. That is costly. Instead, we should just uncharge the excess
>> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
>> function should only be called when obj_cgroup changes.
>>
>> Secondly, when charging an object of size not less than a page in
>> obj_cgroup_charge(), it is possible that the remaining bytes to be
>> refilled to the stock will overflow a page and cause refill_obj_stock()
>> to uncharge 1 page. To avoid the additional uncharge in this case,
>> a new overfill flag is added to refill_obj_stock() which will be set
>> when called from obj_cgroup_charge().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index a6dd18f6d8a8..d13961352eef 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3357,23 +3357,34 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>>          return false;
>>   }
>>
>> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>> +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>> +                            bool overfill)
>>   {
>>          unsigned long flags;
>>          struct obj_stock *stock = get_obj_stock(&flags);
>> +       unsigned int nr_pages = 0;
>>
>>          if (stock->cached_objcg != objcg) { /* reset if necessary */
>> -               drain_obj_stock(stock);
>> +               if (stock->cached_objcg)
>> +                       drain_obj_stock(stock);
>>                  obj_cgroup_get(objcg);
>>                  stock->cached_objcg = objcg;
>>                  stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
>>          }
>>          stock->nr_bytes += nr_bytes;
>>
>> -       if (stock->nr_bytes > PAGE_SIZE)
>> -               drain_obj_stock(stock);
>> +       if (!overfill && (stock->nr_bytes > PAGE_SIZE)) {
>> +               nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>> +               stock->nr_bytes &= (PAGE_SIZE - 1);
>> +       }
>>
>>          put_obj_stock(flags);
>> +
>> +       if (nr_pages) {
>> +               rcu_read_lock();
>> +               __memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
>> +               rcu_read_unlock();
>> +       }
> It is not safe to call __memcg_kmem_uncharge() under rcu lock
> and without holding a reference to memcg. More details can refer
> to the following link.
>
> https://lore.kernel.org/linux-mm/20210319163821.20704-2-songmuchun@bytedance.com/
>
> In the above patchset, we introduce obj_cgroup_uncharge_pages to
> uncharge some pages from object cgroup. You can use this safe
> API.

Thanks for the comment. Will update my patch with call to 
obj_cgroup_uncharge_pages().

Cheers,
Longman

