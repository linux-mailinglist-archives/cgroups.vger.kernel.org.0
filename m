Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E59369769
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhDWQxN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 12:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhDWQxK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Apr 2021 12:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619196753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enManHEzv32cqVRF46CePltyDkAaNIcE1LHVBh9NKfk=;
        b=cN95ag1KU0DekGdbbouEnDyAhDBvvOIABqLS21gxxEMiaTHuUUq3xzZCBJ4qVjZtFPzKtV
        NWErz/HO7IP+Pzy3lS+ZEnag24hmps3Y18JAWdeAyXgZLJ94XAvCp4rEdEhiN14HBnLVEc
        fFP0sN5ZL0BPG4bAvv7PkOpf4zMXR+w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-3zKI3HI8Nyq-Im7smoxSeA-1; Fri, 23 Apr 2021 12:52:32 -0400
X-MC-Unique: 3zKI3HI8Nyq-Im7smoxSeA-1
Received: by mail-qv1-f70.google.com with SMTP id a3-20020a0ce3830000b02901a32a1f457eso15478934qvl.1
        for <cgroups@vger.kernel.org>; Fri, 23 Apr 2021 09:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=enManHEzv32cqVRF46CePltyDkAaNIcE1LHVBh9NKfk=;
        b=TtEsIV6chW1T6gZDa1+GdUoaHo439CLkQTJg/mLrOlRBGHNL8N7leBHZ4XEovA/YJN
         0M1JRNS8tpXCBNry/aj+u9WXZ4AK7uLjo9dqWe7C1lNpKyQOTLQvhgw2t24vAv7U6IC8
         m6t93SHGsjvUo+5YddpjxWEV6Y2NCBH+9+1llcybXdQxxM+/IEzRNlFjT1gPtPfnqjOE
         U9+cL+NKfAez5Rb4EMpF3PepDpbXQV0t1VzSF8YNZG/fbJ8uZ1G4pzaKiGQqISMTdQ2R
         6Mh8fd284dmtOhHaM06kvnhJbzE19RsgMOytwpVsoGBDlZm0UnhMKxTMjHHG//3ks5KQ
         ZUZg==
X-Gm-Message-State: AOAM531VUlSZ3SY7oMakSvuzUEQBXyo/KK8lvh4HmH4/6tMfaDgZWuOQ
        vNjLZyuZT285kqdIF524qmZXfu4zetwy9KtVJTOEBCj7Ymd4/63tqbPgeqiBxq+0kWt+35QkNAQ
        L8z564mnS9NO+Z/sQ7A==
X-Received: by 2002:a37:610f:: with SMTP id v15mr5225541qkb.217.1619196751461;
        Fri, 23 Apr 2021 09:52:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxslCgP6jpThSvanZXOk3vTRKMvnGz/iORN8PDsijPju3+a1N78M/PLK/NmsHFZInr7A6udA==
X-Received: by 2002:a37:610f:: with SMTP id v15mr5225521qkb.217.1619196751257;
        Fri, 23 Apr 2021 09:52:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a30sm5232405qtn.4.2021.04.23.09.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 09:52:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-next v5 2/4] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
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
 <20210420192907.30880-3-longman@redhat.com>
 <YIC1HEKF8SQQdnxa@carbon.dhcp.thefacebook.com>
 <ded96eba-8c0c-1822-61b5-de0577b7ebab@redhat.com> <YIIpSvs09GhDN+gb@carbon>
Message-ID: <6a261f7f-a127-a757-9f4c-4231823911c1@redhat.com>
Date:   Fri, 23 Apr 2021 12:52:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIIpSvs09GhDN+gb@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/22/21 9:56 PM, Roman Gushchin wrote:
> On Thu, Apr 22, 2021 at 12:58:52PM -0400, Waiman Long wrote:
>> On 4/21/21 7:28 PM, Roman Gushchin wrote:
>>> On Tue, Apr 20, 2021 at 03:29:05PM -0400, Waiman Long wrote:
>>>> Before the new slab memory controller with per object byte charging,
>>>> charging and vmstat data update happen only when new slab pages are
>>>> allocated or freed. Now they are done with every kmem_cache_alloc()
>>>> and kmem_cache_free(). This causes additional overhead for workloads
>>>> that generate a lot of alloc and free calls.
>>>>
>>>> The memcg_stock_pcp is used to cache byte charge for a specific
>>>> obj_cgroup to reduce that overhead. To further reducing it, this patch
>>>> makes the vmstat data cached in the memcg_stock_pcp structure as well
>>>> until it accumulates a page size worth of update or when other cached
>>>> data change. Caching the vmstat data in the per-cpu stock eliminates two
>>>> writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
>>>> specific vmstat data by a write to a hot local stock cacheline.
>>>>
>>>> On a 2-socket Cascade Lake server with instrumentation enabled and this
>>>> patch applied, it was found that about 20% (634400 out of 3243830)
>>>> of the time when mod_objcg_state() is called leads to an actual call
>>>> to __mod_objcg_state() after initial boot. When doing parallel kernel
>>>> build, the figure was about 17% (24329265 out of 142512465). So caching
>>>> the vmstat data reduces the number of calls to __mod_objcg_state()
>>>> by more than 80%.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>>>> ---
>>>>    mm/memcontrol.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 83 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 7cd7187a017c..292b4783b1a7 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -782,8 +782,9 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>>>>    	rcu_read_unlock();
>>>>    }
>>>> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>>> -		     enum node_stat_item idx, int nr)
>>>> +static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
>>>> +				     struct pglist_data *pgdat,
>>>> +				     enum node_stat_item idx, int nr)
>>>>    {
>>>>    	struct mem_cgroup *memcg;
>>>>    	struct lruvec *lruvec;
>>>> @@ -791,7 +792,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>>>    	rcu_read_lock();
>>>>    	memcg = obj_cgroup_memcg(objcg);
>>>>    	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>> -	mod_memcg_lruvec_state(lruvec, idx, nr);
>>>> +	__mod_memcg_lruvec_state(lruvec, idx, nr);
>>>>    	rcu_read_unlock();
>>>>    }
>>>> @@ -2059,7 +2060,10 @@ struct memcg_stock_pcp {
>>>>    #ifdef CONFIG_MEMCG_KMEM
>>>>    	struct obj_cgroup *cached_objcg;
>>>> +	struct pglist_data *cached_pgdat;
>>> I wonder if we want to have per-node counters instead?
>>> That would complicate the initialization of pcp stocks a bit,
>>> but might shave off some additional cpu time.
>>> But we can do it later too.
>>>
>> A per node counter will certainly complicate the code and reduce the
>> performance benefit too.
> Hm, why? We wouldn't need to flush the stock if the release happens
> on some other cpu not matching the current pgdat.

I had actually experimented with just caching vmstat data for the local 
node only. It turned out the hit rate was a bit lower. That is why I 
keep the current approach and I need to do further investigation on a 
better approach.

Cheers,
Longman


