Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043B3611E3
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhDOSQq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 14:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234407AbhDOSQp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 14:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618510582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1h8IZFi1Z3bjnp2kfdUz2arusyoZa29FI3VehSm75Y=;
        b=QjGb/L9dpr42TbC4egnSBcenVmkuoqSpoL+R96RGnAPci93jyExuSzel05ybC+oppUQRJl
        vls2E9hyc6Va4J1IYcp7Z9hBp7d/e9atSackf3Go3Qxa6rCBiCTpoWUi9um4XtdqbPk1sQ
        ewZT3HnU68muMyAggbPGipbw1wyTnHQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zWRKwnC-NR-aleFHUsa1pw-1; Thu, 15 Apr 2021 14:16:20 -0400
X-MC-Unique: zWRKwnC-NR-aleFHUsa1pw-1
Received: by mail-qv1-f72.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso2348517qvb.17
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y1h8IZFi1Z3bjnp2kfdUz2arusyoZa29FI3VehSm75Y=;
        b=etHiguNDIaMR5Be9fz8XjWUT8LlXeSu6k0triy//q9f5Yh2HulpXjOhya5WZyqXT4G
         mEYX3ej34lxlCa0sNZ7dJ2PW2uxTGsG0Hfln3bDwnTaaW6NRW/zrG/bA8jrDMdOlHNvL
         zlpgWTx4av8/wSf0tucEUShy6XlUf/+HxKiIQ+TsxrEf7hBT2W1h9wuBRRzw069mYjZt
         7jirZu3xKTeERqdvSw48ANMYm2loa7YCxqOw9y2bMPqKlhpo7XeBuxPwI52/s580gqyY
         EBOlDeV9wnp5vosgSRqEEiO+06JZVchBlFny2E/wyNwDtgss9matk/p+HdpbsgOESalL
         4XHQ==
X-Gm-Message-State: AOAM530w5ATik6Jj7F3gK0ekdwLURDgaO1cXONw1eK6Se2NuEOlifaeP
        UdWZIYFVwWGB84D4Z9AlZo902Erf8QjtR+pMTIlToxvSC0xALPLBmmgAmayjel6re3PDV8OLTqA
        XsTR7ZNjUymd/TfjWoA==
X-Received: by 2002:a37:40d5:: with SMTP id n204mr4744520qka.79.1618510580022;
        Thu, 15 Apr 2021 11:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSkR3FikpEZ87VWFSVVxj6qadAxNk7CY9UBAsUtCZvG+1cdpKO8aDbQzdyseIErEgeFrSvLg==
X-Received: by 2002:a37:40d5:: with SMTP id n204mr4744484qka.79.1618510579717;
        Thu, 15 Apr 2021 11:16:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f14sm2508355qka.54.2021.04.15.11.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:16:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
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
 <20210414012027.5352-6-longman@redhat.com> <YHh9l1+TUIzzFBtO@cmpxchg.org>
Message-ID: <8dbd3505-9c51-362f-82d8-5efa5773e020@redhat.com>
Date:   Thu, 15 Apr 2021 14:16:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHh9l1+TUIzzFBtO@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/15/21 1:53 PM, Johannes Weiner wrote:
> On Tue, Apr 13, 2021 at 09:20:27PM -0400, Waiman Long wrote:
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
>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> This makes sense, and also explains the previous patch a bit
> better. But please merge those two.
The reason I broke it into two is so that the patches are individually 
easier to review. I prefer to update the commit log of patch 4 to 
explain why the obj_stock structure is introduced instead of merging the 
two.
>
>> @@ -2229,7 +2229,8 @@ struct obj_stock {
>>   struct memcg_stock_pcp {
>>   	struct mem_cgroup *cached; /* this never be root cgroup */
>>   	unsigned int nr_pages;
>> -	struct obj_stock obj;
>> +	struct obj_stock task_obj;
>> +	struct obj_stock irq_obj;
>>   
>>   	struct work_struct work;
>>   	unsigned long flags;
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
>>   	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
>>   
>> -	return &stock->obj;
>> +	return in_task() ? &stock->task_obj : &stock->irq_obj;
>> +}
>> +
>> +#define get_obj_stock(flags)				\
>> +({							\
>> +	struct memcg_stock_pcp *stock;			\
>> +	struct obj_stock *obj_stock;			\
>> +							\
>> +	if (in_task()) {				\
>> +		preempt_disable();			\
>> +		(flags) = -1L;				\
>> +		stock = this_cpu_ptr(&memcg_stock);	\
>> +		obj_stock = &stock->task_obj;		\
>> +	} else {					\
>> +		local_irq_save(flags);			\
>> +		stock = this_cpu_ptr(&memcg_stock);	\
>> +		obj_stock = &stock->irq_obj;		\
>> +	}						\
>> +	obj_stock;					\
>> +})
>> +
>> +static inline void put_obj_stock(unsigned long flags)
>> +{
>> +	if (flags == -1L)
>> +		preempt_enable();
>> +	else
>> +		local_irq_restore(flags);
>>   }
> Please make them both functions and use 'unsigned long *flags'.
Sure, I can do that.
>
> Also I'm not sure doing in_task() twice would actually be more
> expensive than the == -1 special case, and easier to understand.
I can make that change too. Either way is fine with me.
>
>> @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
>>   	local_irq_save(flags);
>>   
>>   	stock = this_cpu_ptr(&memcg_stock);
>> -	drain_obj_stock(&stock->obj);
>> +	drain_obj_stock(&stock->irq_obj);
>> +	if (in_task())
>> +		drain_obj_stock(&stock->task_obj);
>>   	drain_stock(stock);
>>   	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>>   
>> @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>>   	memcg = obj_cgroup_memcg(objcg);
>>   	if (pgdat)
>>   		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> -	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>> +	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>>   	rcu_read_unlock();
> This is actually a bug introduced in the earlier patch, isn't it?
> Calling __mod_memcg_lruvec_state() without irqs disabled...
>
Not really, in patch 3, mod_objcg_state() is called only in the stock 
update context where interrupt had already been disabled. But now, that 
is no longer the case, that is why i need to update mod_objcg_state() to 
make sure irq is disabled before updating vmstat data array.

Cheers,
Longman

