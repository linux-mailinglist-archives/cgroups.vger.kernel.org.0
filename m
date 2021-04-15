Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202A63610C5
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhDORI7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 13:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233969AbhDORI5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 13:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618506514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4bUwdWqx5JUrWJYR1rKkQlIPcDgNW5mI87L7J9m2Ko=;
        b=HMlDzOBsO9FtPKidhpmYUZVrSl40bs1GxJV36AqBOOk1V+tZclNUIKHHg/j0h4lIGZYKtI
        khLfF1o2cguWp2JLcYC1YoW+kB+nkw8T24toNmVkF1zlz6qwdFgCeqZPmDyOaeI8R8J0U6
        DKv2MCqXegXcxLO1SBtZW6FteAQOvTI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-3H6ADOl5NeWClnsZQ17wIQ-1; Thu, 15 Apr 2021 13:08:32 -0400
X-MC-Unique: 3H6ADOl5NeWClnsZQ17wIQ-1
Received: by mail-qk1-f199.google.com with SMTP id w16so1801320qkf.22
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 10:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c4bUwdWqx5JUrWJYR1rKkQlIPcDgNW5mI87L7J9m2Ko=;
        b=oj5/PpUhmgN6ooCBjaf+QgQmdsCfsPTqLrKG+xYnD0gVMjQN2/AUXsrWs8Lj3/Ar3Q
         lROO1/kdGDNIDu3wyp1hE13YUcEHnUTHmNaF5lJYBw7AOV+uSi5BpAmq6jiEgp7k1Apd
         ZdI2GDmmqmRn2GpAInaWHGXF/V1o+oy1uZtxfhpm/aWHviuJ15ZtUPNikTHYega78xBZ
         tjmv8Cgs3WITcdq9oajQ7OGjo/hpXeqQcdwSjzSzGkCsvJpoyy1FPpCwFzy7XgGZvQF7
         0c7oTX6GbQ1A0PEcoAP4E7ix7oNtcsubC3UafYytxBWNZUDDTi6c9PmpjoP1v8ELyHXZ
         MKcA==
X-Gm-Message-State: AOAM5326gZRVaDPy8+E59zu45fV4ZsTbWAM02qcCi8kM50sRCYrsILLE
        vBfqxku2N3ZAM8yt0wVUbR+gervSsEsm8TulQh0kvXvrGtVGRe8gJf5zmoP7fWPN8XcAjJkIIto
        CuCT4z4LJOdGT/xj8wA==
X-Received: by 2002:a0c:e601:: with SMTP id z1mr4249162qvm.62.1618506511990;
        Thu, 15 Apr 2021 10:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYKgNv627ZQRacj4Z0akpbwf6cDPraxoDdrUd5LGopDdVhUkGCp7HX14SZP2g3PIZr3viwAg==
X-Received: by 2002:a0c:e601:: with SMTP id z1mr4249129qvm.62.1618506511823;
        Thu, 15 Apr 2021 10:08:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id u21sm2196347qtq.11.2021.04.15.10.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:08:31 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-4-longman@redhat.com> <YHhu1BOMj1Ip+sb3@cmpxchg.org>
Message-ID: <5abe499a-b1ad-fa22-3487-1a6e00e30e17@redhat.com>
Date:   Thu, 15 Apr 2021 13:08:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHhu1BOMj1Ip+sb3@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/15/21 12:50 PM, Johannes Weiner wrote:
> On Tue, Apr 13, 2021 at 09:20:25PM -0400, Waiman Long wrote:
>> Before the new slab memory controller with per object byte charging,
>> charging and vmstat data update happen only when new slab pages are
>> allocated or freed. Now they are done with every kmem_cache_alloc()
>> and kmem_cache_free(). This causes additional overhead for workloads
>> that generate a lot of alloc and free calls.
>>
>> The memcg_stock_pcp is used to cache byte charge for a specific
>> obj_cgroup to reduce that overhead. To further reducing it, this patch
>> makes the vmstat data cached in the memcg_stock_pcp structure as well
>> until it accumulates a page size worth of update or when other cached
>> data change.
>>
>> On a 2-socket Cascade Lake server with instrumentation enabled and this
>> patch applied, it was found that about 17% (946796 out of 5515184) of the
>> time when __mod_obj_stock_state() is called leads to an actual call to
>> mod_objcg_state() after initial boot. When doing parallel kernel build,
>> the figure was about 16% (21894614 out of 139780628). So caching the
>> vmstat data reduces the number of calls to mod_objcg_state() by more
>> than 80%.
> Right, but mod_objcg_state() is itself already percpu-cached. What's
> the benefit of avoiding calls to it with another percpu cache?
>
There are actually 2 set of vmstat data that have to be updated. One is 
associated with the memcg and other one is for each lruvec within the 
cgroup. Caching it in obj_stock, we replace 2 writes to two colder 
cachelines with one write to a hot cacheline. If you look at patch 5, I 
break obj_stock into two - one for task context and one for irq context. 
Interrupt disable is no longer needed in task context, but that is not 
possible when writing to the actual vmstat data arrays.

Cheers,
Longman

