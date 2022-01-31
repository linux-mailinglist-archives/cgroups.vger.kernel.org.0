Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD44A3CC3
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 04:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiAaD4I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 22:56:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237080AbiAaD4H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 22:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643601367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7pCh7cso6UhMDVYM0raa9qRlRsS2NwAWhyuB/0+4Xk=;
        b=b1H/jZIDR2vTP0htoS7tp5ltlwrNe/h9UoOr8t1QSnNBYREs5Jgq8WuGLING19lqmgcntK
        YS38p18eiFxVK527hbbH7ehR9X67ZN2qZO8ri1OUJOjDaD2olskt1LxtbQisItQ47IUWMS
        Jo7IV33ClP/8KioUbjWHsaHNG0rcRSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-5kSMH5M_O3aJWcyic-QoSw-1; Sun, 30 Jan 2022 22:56:01 -0500
X-MC-Unique: 5kSMH5M_O3aJWcyic-QoSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25C92802C87;
        Mon, 31 Jan 2022 03:55:59 +0000 (UTC)
Received: from [10.22.16.114] (unknown [10.22.16.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19FE85E24E;
        Mon, 31 Jan 2022 03:55:57 +0000 (UTC)
Message-ID: <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
Date:   Sun, 30 Jan 2022 22:55:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/1/21 19:51, Roman Gushchin wrote:
> On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
>> When freeing a page associated with an offlined memcg, refill_stock()
>> will put it into local stock delaying its demise until another memcg
>> comes in to take its place in the stock. To avoid that, we now check
>> for offlined memcg and go directly in this case to the slowpath for
>> the uncharge via the repurposed cancel_charge() function.
> Hi Waiman!
>
> I'm afraid it can make a cleanup of a dying cgroup slower: for every
> released page we'll potentially traverse the whole cgroup tree and
> decrease atomic page counters.
>
> I'm not sure I understand the benefits we get from this change which
> do justify the slowdown on the cleanup path.
>
> Thanks!

I was notified of a lockdep splat that this patch may help to prevent.

[18073.102101] ======================================================
[18073.102101] WARNING: possible circular locking dependency detected
[18073.102101] 5.14.0-42.el9.x86_64+debug #1 Not tainted
[18073.102101] ------------------------------------------------------
[18073.102101] bz1567074_bin/420270 is trying to acquire lock:
[18073.102101] ffffffff9bdfc478 (css_set_lock){..-.}-{2:2}, at: 
obj_cgroup_release+0x79/0x210
[18073.102101]
[18073.102101] but task is already holding lock:
[18073.102101] ffff88806ba4ef18 (&sighand->siglock){-...}-{2:2}, at: 
force_sig_info_to_task+0x6c/0x370
[18073.102101]
[18073.102101] which lock already depends on the new lock.
[18073.102101]
[18073.102101]
[18073.102101] the existing dependency chain (in reverse order) is:
[18073.102101]
[18073.102101] -> #1 (&sighand->siglock){-...}-{2:2}:
[18073.102101]        __lock_acquire+0xb72/0x1870
[18073.102101]        lock_acquire.part.0+0x117/0x340
[18073.102101]        _raw_spin_lock_irqsave+0x43/0x90
[18073.102101]        __lock_task_sighand+0xa0/0x210
[18073.102101]        cgroup_freeze_task+0x6f/0x150
[18073.102101]        cgroup_migrate_execute+0x25f/0xf90
[18073.102101]        cgroup_update_dfl_csses+0x417/0x4f0
[18073.102101]        cgroup_subtree_control_write+0x67b/0xa10
[18073.102101]        cgroup_file_write+0x1ef/0x6a0
[18073.102101]        kernfs_fop_write_iter+0x2c7/0x460
[18073.102101]        new_sync_write+0x36f/0x610
[18073.102101]        vfs_write+0x5c6/0x890
[18073.102101]        ksys_write+0xf9/0x1d0
[18073.102101]        do_syscall_64+0x3b/0x90
[18073.102101]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[18073.102101]
[18073.102101] -> #0 (css_set_lock){..-.}-{2:2}:
[18073.102101]        check_prev_add+0x15e/0x20f0
[18073.102101]        validate_chain+0xac6/0xde0
[18073.102101]        __lock_acquire+0xb72/0x1870
[18073.102101]        lock_acquire.part.0+0x117/0x340
[18073.102101]        _raw_spin_lock_irqsave+0x43/0x90
[18073.102101]        obj_cgroup_release+0x79/0x210
[18073.102101]        percpu_ref_put_many.constprop.0+0x16b/0x1a0
[18073.102101]        drain_obj_stock+0x1a8/0x310
[18073.102101]        refill_obj_stock+0xa4/0x480
[18073.102101]        obj_cgroup_charge+0x104/0x240
[18073.102101]        kmem_cache_alloc+0x94/0x400
[18073.102101]        __sigqueue_alloc+0x1b9/0x460
[18073.102101]        __send_signal+0x4b2/0xf60
[18073.102101]        force_sig_info_to_task+0x226/0x370
[18073.102101]        force_sig_fault+0xb0/0xf0
[18073.102101]        noist_exc_debug+0xec/0x110
[18073.102101]        asm_exc_debug+0x2b/0x30
[18073.102101]
[18073.102101] other info that might help us debug this:
[18073.102101]
[18073.102101]  Possible unsafe locking scenario:
[18073.102101]
[18073.102101]        CPU0                    CPU1
[18073.102101]        ----                    ----
[18073.102101]   lock(&sighand->siglock);
[18073.102101]                                lock(css_set_lock);
[18073.102101] lock(&sighand->siglock);
[18073.102101]   lock(css_set_lock);
[18073.102101]
[18073.102101]  *** DEADLOCK ***
[18073.102101]
[18073.102101] 2 locks held by bz1567074_bin/420270:
[18073.102101]  #0: ffff88806ba4ef18 (&sighand->siglock){-...}-{2:2}, 
at: force_sig_info_to_task+0x6c/0x370
[18073.102101]  #1: ffffffff9bd0ea00 (rcu_read_lock){....}-{1:2}, at: 
percpu_ref_put_many.constprop.0+0x0/0x1a0
[18073.102101]
[18073.102101] stack backtrace:
[18073.102101] CPU: 0 PID: 420270 Comm: bz1567074_bin Kdump: loaded Not 
tainted 5.14.0-42.el9.x86_64+debug #1
[18073.102101] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2007
[18073.102101] Call Trace:
[18073.102101]  dump_stack_lvl+0x57/0x7d
[18073.102101]  check_noncircular+0x26a/0x310
[18073.102101]  ? pvclock_clocksource_read+0x2b8/0x520
[18073.102101]  ? print_circular_bug+0x1f0/0x1f0
[18073.102101]  ? alloc_chain_hlocks+0x1de/0x530
[18073.102101]  check_prev_add+0x15e/0x20f0
[18073.102101]  validate_chain+0xac6/0xde0
[18073.102101]  ? check_prev_add+0x20f0/0x20f0
[18073.102101]  __lock_acquire+0xb72/0x1870
[18073.102101]  ? __lock_acquire+0xb72/0x1870
[18073.102101]  lock_acquire.part.0+0x117/0x340
[18073.102101]  ? obj_cgroup_release+0x79/0x210
[18073.102101]  ? rcu_read_unlock+0x40/0x40
[18073.102101]  ? rcu_read_lock_sched_held+0x3f/0x70
[18073.102101]  ? lock_acquire+0x224/0x2d0
[18073.102101]  ? obj_cgroup_release+0x79/0x210
[18073.102101]  _raw_spin_lock_irqsave+0x43/0x90
[18073.102101]  ? obj_cgroup_release+0x79/0x210
[18073.102101]  obj_cgroup_release+0x79/0x210
[18073.102101]  percpu_ref_put_many.constprop.0+0x16b/0x1a0
[18073.102101]  drain_obj_stock+0x1a8/0x310
[18073.102101]  refill_obj_stock+0xa4/0x480
[18073.102101]  obj_cgroup_charge+0x104/0x240
[18073.102101]  ? __sigqueue_alloc+0x1b9/0x460
[18073.102101]  kmem_cache_alloc+0x94/0x400
[18073.102101]  ? __sigqueue_alloc+0x129/0x460
[18073.102101]  __sigqueue_alloc+0x1b9/0x460
[18073.102101]  __send_signal+0x4b2/0xf60
[18073.102101]  ? send_signal+0x9f/0x580
[18073.102101]  force_sig_info_to_task+0x226/0x370
[18073.102101]  force_sig_fault+0xb0/0xf0
[18073.102101]  ? force_sig_fault_to_task+0xe0/0xe0
[18073.102101]  ? asm_exc_debug+0x23/0x30
[18073.102101]  ? notify_die+0x88/0x100
[18073.102101]  ? asm_exc_debug+0x23/0x30
[18073.102101]  noist_exc_debug+0xec/0x110
[18073.102101]  asm_exc_debug+0x2b/0x30

The &sighand->siglock => css_set_lock locking sequence is caused by a 
task holding sighand->siglock and call kmem_cache_alloc(GFP_ATOMIC) and 
the release of the obj_cgroup originally from an offlined memcg in 
percpu stock leading to the call of obj_cgroup_release() which takes the 
cs_set_lock. The chance of hitting that is very small, but it can still 
happen. So do you think addressing this possible deadlock scenario is 
worth the possible slower release of an offlined memcg?

Cheers,
Longman

>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4b32896d87a2..4568363062c1 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2167,6 +2167,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   	return ret;
>>   }
>>   
>> +static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
>> +
>>   /*
>>    * Returns stocks cached in percpu and reset cached information.
>>    */
>> @@ -2178,9 +2180,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>>   		return;
>>   
>>   	if (stock->nr_pages) {
>> -		page_counter_uncharge(&old->memory, stock->nr_pages);
>> -		if (do_memsw_account())
>> -			page_counter_uncharge(&old->memsw, stock->nr_pages);
>> +		cancel_charge(old, stock->nr_pages);
>>   		stock->nr_pages = 0;
>>   	}
>>   
>> @@ -2219,6 +2219,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   	struct memcg_stock_pcp *stock;
>>   	unsigned long flags;
>>   
>> +	/*
>> +	 * An offlined memcg shouldn't be put into stock.
>> +	 */
>> +	if (unlikely(memcg->kmem_state != KMEM_ONLINE)) {
>> +		cancel_charge(memcg, nr_pages);
>> +		return;
>> +	}
>> +
>>   	local_irq_save(flags);
>>   
>>   	stock = this_cpu_ptr(&memcg_stock);
>> @@ -2732,7 +2740,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>   	return try_charge_memcg(memcg, gfp_mask, nr_pages);
>>   }
>>   
>> -#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
>>   static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   {
>>   	if (mem_cgroup_is_root(memcg))
>> @@ -2742,7 +2749,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   	if (do_memsw_account())
>>   		page_counter_uncharge(&memcg->memsw, nr_pages);
>>   }
>> -#endif
>>   
>>   static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>>   {
>> -- 
>> 2.18.1
>>

