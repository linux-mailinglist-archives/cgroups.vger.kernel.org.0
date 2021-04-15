Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F283612B3
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhDOTG6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 15:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234735AbhDOTG5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 15:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618513593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEe76+1lfitRLX7ayQ138JdnojjAHhZEepE6oK4fMzM=;
        b=H67Muo1X73tlPmia4K7LglApEuG1s2zaApj3eA+e1bLPoY2vDLqovBatsNJ2gPs4FCBX5f
        3zHO7uRxEjPLDuJcLrW/2LlPK8VBAj6W6ZI9u+NpaRZRogJd8AEGWXPpRgXNTM2/8VSMl4
        W2KweDrwHJGG5ICPwclJkX+acPy/w5c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-fZXpUDPUNsOtNOCBDGnpjQ-1; Thu, 15 Apr 2021 15:06:32 -0400
X-MC-Unique: fZXpUDPUNsOtNOCBDGnpjQ-1
Received: by mail-qk1-f197.google.com with SMTP id n191so2189114qka.9
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 12:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gEe76+1lfitRLX7ayQ138JdnojjAHhZEepE6oK4fMzM=;
        b=MtnPmOQxkDKDicObPjVmNYA9goxbJgYMkzcvWjg6sHIGLQYyfCZRPitKqlhzRbnzKk
         v9TPnLCk/+fJ9QEksieRC/0uBiDyqQJKzykRlzbQ1pfqoDy0PM6f0aJiGMp1RQZD0OIS
         SP/A2fpkUceSozFv6MEyKNHtP3AuvxBA/parC2v5p2F+LuKtXL1Fx6j7nApRSEX3prBc
         DUG/5uBDZGUfwRvSxQ0Sv8FyQQ+R1sPnE7DvEqDcUznQut3ztVmIwoKUaBql/V1wxDBq
         CyWtkpVZ2koWsp1GZs3iLmsLqQDFvemhrlpZw85/dk3sNiksQ51sR3NzsInExOwzr9CY
         5f0w==
X-Gm-Message-State: AOAM532BlFGkNShnH2iDefJN2pB6sI/uQBs0+8DNjaPMmbzMZCtnixDP
        G+R002YuTU/lEiaiqz9ngf2GyOT4dYPnidOFuNbGEb6u249YCG2L65T1FyGmO6u7sIYEhhKzjmh
        c6TDhcy5UWUx4S0FlrA==
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr4732753qvq.6.1618513591647;
        Thu, 15 Apr 2021 12:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuVQaHY7IISH7UyW+PwaDWQOamBxU2GgKPhE5CUuu6sk1Maoqcddj2cyAcylO6CivOxCKntA==
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr4732719qvq.6.1618513591332;
        Thu, 15 Apr 2021 12:06:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id o189sm2659335qkd.60.2021.04.15.12.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 12:06:29 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <llong@redhat.com>
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
 <20210414012027.5352-6-longman@redhat.com> <YHh9l1+TUIzzFBtO@cmpxchg.org>
 <8dbd3505-9c51-362f-82d8-5efa5773e020@redhat.com>
 <YHiLmxE9oCOfmbS3@cmpxchg.org>
Message-ID: <d4d4de9b-5020-fe62-3709-bcd97e9b54ba@redhat.com>
Date:   Thu, 15 Apr 2021 15:06:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHiLmxE9oCOfmbS3@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/15/21 2:53 PM, Johannes Weiner wrote:
> On Thu, Apr 15, 2021 at 02:16:17PM -0400, Waiman Long wrote:
>> On 4/15/21 1:53 PM, Johannes Weiner wrote:
>>> On Tue, Apr 13, 2021 at 09:20:27PM -0400, Waiman Long wrote:
>>>> Most kmem_cache_alloc() calls are from user context. With instrumentation
>>>> enabled, the measured amount of kmem_cache_alloc() calls from non-task
>>>> context was about 0.01% of the total.
>>>>
>>>> The irq disable/enable sequence used in this case to access content
>>>> from object stock is slow.  To optimize for user context access, there
>>>> are now two object stocks for task context and interrupt context access
>>>> respectively.
>>>>
>>>> The task context object stock can be accessed after disabling preemption
>>>> which is cheap in non-preempt kernel. The interrupt context object stock
>>>> can only be accessed after disabling interrupt. User context code can
>>>> access interrupt object stock, but not vice versa.
>>>>
>>>> The mod_objcg_state() function is also modified to make sure that memcg
>>>> and lruvec stat updates are done with interrupted disabled.
>>>>
>>>> The downside of this change is that there are more data stored in local
>>>> object stocks and not reflected in the charge counter and the vmstat
>>>> arrays.  However, this is a small price to pay for better performance.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> Acked-by: Roman Gushchin <guro@fb.com>
>>>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>>> This makes sense, and also explains the previous patch a bit
>>> better. But please merge those two.
>> The reason I broke it into two is so that the patches are individually
>> easier to review. I prefer to update the commit log of patch 4 to explain
>> why the obj_stock structure is introduced instead of merging the two.
> Well I did not find them easier to review separately.
>
>>>> @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
>>>>    	local_irq_save(flags);
>>>>    	stock = this_cpu_ptr(&memcg_stock);
>>>> -	drain_obj_stock(&stock->obj);
>>>> +	drain_obj_stock(&stock->irq_obj);
>>>> +	if (in_task())
>>>> +		drain_obj_stock(&stock->task_obj);
>>>>    	drain_stock(stock);
>>>>    	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>>>> @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>>>>    	memcg = obj_cgroup_memcg(objcg);
>>>>    	if (pgdat)
>>>>    		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>> -	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>>>> +	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>>>>    	rcu_read_unlock();
>>> This is actually a bug introduced in the earlier patch, isn't it?
>>> Calling __mod_memcg_lruvec_state() without irqs disabled...
>>>
>> Not really, in patch 3, mod_objcg_state() is called only in the stock update
>> context where interrupt had already been disabled. But now, that is no
>> longer the case, that is why i need to update mod_objcg_state() to make sure
>> irq is disabled before updating vmstat data array.
> Oh, I see it now. Man, that's subtle. We've had several very hard to
> track down preemption bugs in those stats, because they manifest as
> counter imbalances and you have no idea if there is a leak somewhere.
>
> The convention for these functions is that the __ prefix indicates
> that preemption has been suitably disabled. Please always follow this
> convention, even if the semantic change is temporary.
I see. I will fix that in the next version.
>
> Btw, is there a reason why the stock caching isn't just part of
> mod_objcg_state()? Why does the user need to choose if they want the
> caching or not? It's not like we ask for this when charging, either.
>
Yes, I can revert it to make mod_objcg_state() to call 
mod_obj_stock_state() internally instead of the other way around.

Cheers,
Longman

