Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE017479434
	for <lists+cgroups@lfdr.de>; Fri, 17 Dec 2021 19:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhLQSq7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Dec 2021 13:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237952AbhLQSq7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Dec 2021 13:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639766818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vj95PH5YcZQElxd40GSKn7w/1+83YhThrl64e1za+3E=;
        b=iFXyp12SMZbw/R6On4EQXOrzXs1yxOqWC3ak21zMsPa8KlmMboB2gdSoB9Qa+9Dg6U5pb5
        QUUKddeO6g7Gw+eU+8oueVqTi2A+vmVDiDFwSu1Ru6VuqB5ECXxzsGbFiIM2JqqMH/yCS3
        UAXeyl6f4wu8P5sotN5uScq+Mc96ZKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-Va9oEGDwOgKlVp2Jkgzccw-1; Fri, 17 Dec 2021 13:46:57 -0500
X-MC-Unique: Va9oEGDwOgKlVp2Jkgzccw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86A96EAF8;
        Fri, 17 Dec 2021 18:46:55 +0000 (UTC)
Received: from [10.22.32.51] (unknown [10.22.32.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 507DC519AE;
        Fri, 17 Dec 2021 18:46:54 +0000 (UTC)
Message-ID: <b82efbad-1eb2-9441-ab0b-cbb3d2b5eac6@redhat.com>
Date:   Fri, 17 Dec 2021 13:46:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH-next v3] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
References: <20211214144412.447035-1-longman@redhat.com>
 <Ybx3ubNFfGpCqhn0@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Ybx3ubNFfGpCqhn0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/17/21 06:42, Sebastian Andrzej Siewior wrote:
> On 2021-12-14 09:44:12 [-0500], Waiman Long wrote:
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2096,7 +2096,12 @@ struct obj_stock {
>>   #endif
>>   };
>>   
>> +/*
>> + * The local_lock protects the whole memcg_stock_pcp structure including
>> + * the embedded obj_stock structures.
>> + */
>>   struct memcg_stock_pcp {
>> +	local_lock_t lock;
>>   	struct mem_cgroup *cached; /* this never be root cgroup */
>>   	unsigned int nr_pages;
>>   	struct obj_stock task_obj;
>> @@ -2145,7 +2150,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   	if (nr_pages > MEMCG_CHARGE_BATCH)
>>   		return ret;
>>   
>> -	local_irq_save(flags);
>> +	local_lock_irqsave(&memcg_stock.lock, flags);
> This still does not explain why the lock is acquired here where it
> appears to be unrelated to memcg_stock.lock.

consume_stock() can be called in both task and irq context. irq context 
may include softirq where interrupt may have been enabled and something 
get interrupt again. The original code just do a local_irq_save() 
without documenting why we are doing so. So I didn't see a need to add 
comment about that.

>>   
>>   	stock = this_cpu_ptr(&memcg_stock);
>>   	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
>> @@ -2779,29 +2784,34 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>>    * which is cheap in non-preempt kernel. The interrupt context object stock
>>    * can only be accessed after disabling interrupt. User context code can
>>    * access interrupt object stock, but not vice versa.
>> + *
>> + * This task and interrupt context optimization is disabled for PREEMPT_RT
>> + * as there is no performance gain in this case and changes will be made to
>> + * irq_obj only.
>> + *
>> + * For non-PREEMPT_RT, we are not replacing preempt_disable() by local_lock()
>> + * as nesting of task_obj and irq_obj are allowed which may cause lockdep
>> + * splat if local_lock() is used. Using separate local locks will complicate
>> + * the interaction between obj_stock and the broader memcg_stock object.
>>    */
>>   static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
>>   {
>> -	struct memcg_stock_pcp *stock;
>> -
>> -	if (likely(in_task())) {
>> +	if (likely(in_task()) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
>>   		*pflags = 0UL;
>>   		preempt_disable();
>> -		stock = this_cpu_ptr(&memcg_stock);
>> -		return &stock->task_obj;
>> +		return this_cpu_ptr(&memcg_stock.task_obj);
> Do we need to keep the memcg_stock.task_obj for !RT?
> I'm not really convinced that disabling either preemption or interrupts
> is so much better compared to actual locking locking with lockdep
> annotation. Looking at the history, I'm also impressed by that fact that
> disabling/ enabling interrupts is *so* expensive that all this is
> actually worth it.

For !RT with voluntary or no preemption, preempt_disable() is just a 
compiler barrier. So it is definitely cheaper than disabling interrupt. 
The performance benefit is less with preemptible but !RT kernel. 
Microbenchmark testing shows a performance improvement of a few percents 
depending on the exact benchmark.

Cheers,
Longman

