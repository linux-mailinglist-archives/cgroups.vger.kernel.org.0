Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9A4705B1
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhLJQdM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 11:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233286AbhLJQdM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 11:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639153776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5El+Q3eIgzJBovVYIEGNnx5wIrj3Zs25homqjZk9cI=;
        b=M7CmYHBWRLhriYQ0LHhJbSUVAEtpRMKDgEdTr6TRTA/ZHD6UUcDpElbhYp5ZEOQNazTWns
        XDlAl7VIrXCoCjnxc0vg5vrD9D36ydvUcsiZkyijyLO8dTaHQZBiJs6Iw5JxymtD1ePqNk
        Fe+4D/aW/xM9/NRwVUHJMrlQ0GG17ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-YLOBJioWPJSSEzJxl9TEmQ-1; Fri, 10 Dec 2021 11:29:35 -0500
X-MC-Unique: YLOBJioWPJSSEzJxl9TEmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B770192CC41;
        Fri, 10 Dec 2021 16:29:33 +0000 (UTC)
Received: from [10.22.33.49] (unknown [10.22.33.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 423E85DF4B;
        Fri, 10 Dec 2021 16:29:32 +0000 (UTC)
Message-ID: <80ee87bb-f36c-4a16-9095-43ea84818375@redhat.com>
Date:   Fri, 10 Dec 2021 11:29:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH-next v2] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211210025228.158196-1-longman@redhat.com>
 <YbNPrGEjtKjzEjQa@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YbNPrGEjtKjzEjQa@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 12/10/21 08:01, Sebastian Andrzej Siewior wrote:
> On 2021-12-09 21:52:28 [-0500], Waiman Long wrote:
> …
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
> …
>> @@ -2210,7 +2211,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   	struct memcg_stock_pcp *stock;
>>   	unsigned long flags;
>>   
>> -	local_irq_save(flags);
>> +	local_lock_irqsave(&memcg_stock.lock, flags);
> Why is this one using the lock? It isn't accessing irq_obj, right?
Well, the lock isn't just for irq_obj. It protects the whole memcg_stock 
structure which include irq_obj. Sometimes, data in irq_obj (or 
task_obj) will get transfer to nr_pages and vice versa. So it is easier 
to use one single lock for the whole thing.
>
>>   	stock = this_cpu_ptr(&memcg_stock);
>>   	if (stock->cached != memcg) { /* reset if necessary */
>> @@ -2779,29 +2780,28 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>>    * which is cheap in non-preempt kernel. The interrupt context object stock
>>    * can only be accessed after disabling interrupt. User context code can
>>    * access interrupt object stock, but not vice versa.
>> + *
>> + * This task and interrupt context optimization is disabled for PREEMPT_RT
>> + * as there is no performance gain in this case.
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
>>   	}
> We usually add the local_lock_t to the object it protects, struct
> obj_stock it this case.
> That would give you two different locks (instead of one) so you wouldn't
> have to use preempt_disable() to avoid lockdep's complains. Also it
> would warn you if you happen to use that obj_stock in !in_task() which
> is isn't possible now.
> The only downside would be that drain_local_stock() needs to acquire two
> locks.
>
As said above, having separate locks will complicate the interaction 
between irq_obj and the broader memcg_stock fields. Besides throughput 
is a less important matrix for PREEMPT_RT, so I am not trying to 
optimize throughput performance for PREEMPT_RT here.

Cheers,
Longman

