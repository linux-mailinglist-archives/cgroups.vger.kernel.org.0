Return-Path: <cgroups+bounces-11662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19821C3EA31
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 07:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC8AA4E1A50
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBA2FBDFD;
	Fri,  7 Nov 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RxGX48Cm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0B1AB6F1
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497695; cv=none; b=dcOyJIDTx4Qd35oCoaJd7/1jeE8EB1LP63WdKmXrHmnbWsnVlHbVuYRJ1lTwdBESeSbcq+5LQf9oOZ3gwxOIOtDI+Kg4yGS/H9yymtnh7TMeVpnj3p5A1pjQzDi0dkONeNLoMzpLDT76EOb/jnNhQRB+O/WOvDJJihVB5/Wwolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497695; c=relaxed/simple;
	bh=nGC+MuGSDBmvcckGeZiHtCXApGgufkorHPF8aYwIXGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCtSaL5mWvtDwZdlhYbV8Dn7E499kxbZGSzqAonthGaX9quE0/NzgAZMmxkRsqLfdLk7P/jWrbZI3fx9nxG4FODcV4OJIJ8G/B61kK7okkb7Op9VTmIFNqEqFD+t5NNtj7cIn20zWZf9d7wXTR6Av+byS9WqSkh9kCY8v17FSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RxGX48Cm; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762497687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRWYTILqG8LMnvyFfHYVWRrcjOpnBFKXzOGTUrz8/2Y=;
	b=RxGX48Cmlw64YK5Ash4JRiXe2KJcl8QsfvG5d0NVo2Whq/SC69I/M24gsIFV+OyovHivHT
	fTnAopzzhAy5DrElU2jfYVcKVMstboD4H8pUwQmskXdksEHwaodJwlSKF0dLe8EisvS2Ee
	ZMiH38qPA510qUuKZEL+BJcBoOGrICI=
Date: Fri, 7 Nov 2025 14:41:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aQ1_f_6KPRZknUGS@harry>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry,

On 11/7/25 1:11 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:17PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In a subsequent patch, we'll reparent the LRU folios. The folios that are
>> moved to the appropriate LRU list can undergo reparenting during the
>> move_folios_to_lru() process. Hence, it's incorrect for the caller to hold
>> a lruvec lock. Instead, we should utilize the more general interface of
>> folio_lruvec_relock_irq() to obtain the correct lruvec lock.
>>
>> This patch involves only code refactoring and doesn't introduce any
>> functional changes.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/vmscan.c | 46 +++++++++++++++++++++++-----------------------
>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 3a1044ce30f1e..660cd40cfddd4 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2016,9 +2016,9 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>>   	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false,
>>   					 lruvec_memcg(lruvec));
>>   
>> -	spin_lock_irq(&lruvec->lru_lock);
>> -	move_folios_to_lru(lruvec, &folio_list);
>> +	move_folios_to_lru(&folio_list);
>>   
>> +	spin_lock_irq(&lruvec->lru_lock);
>>   	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
>>   					stat.nr_demoted);
> 
> Maybe I'm missing something or just confused for now, but let me ask...
> 
> How do we make sure the lruvec (and the mem_cgroup containing the
> lruvec) did not disappear (due to offlining) after move_folios_to_lru()?

We obtained lruvec through the following method:

memcg = mem_cgroup_iter(target_memcg, NULL, partial);
do {
     struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);

     shrink_lruvec(lruvec, sc);
     --> shrink_inactive_list
} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));

The mem_cgroup_iter() will hold the refcount of this memcg, so IIUC,
the memcg will not disappear at this time.

> 
>>   	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>> @@ -2166,11 +2166,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
>>   	/*
>>   	 * Move folios back to the lru list.
>>   	 */
>> -	spin_lock_irq(&lruvec->lru_lock);
>> -
>> -	nr_activate = move_folios_to_lru(lruvec, &l_active);
>> -	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
>> +	nr_activate = move_folios_to_lru(&l_active);
>> +	nr_deactivate = move_folios_to_lru(&l_inactive);
>>   
>> +	spin_lock_irq(&lruvec->lru_lock);
>>   	__count_vm_events(PGDEACTIVATE, nr_deactivate);
>>   	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
>>   
>> @@ -4735,14 +4734,15 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>>   			set_mask_bits(&folio->flags.f, LRU_REFS_FLAGS, BIT(PG_active));
>>   	}
>>   
>> -	spin_lock_irq(&lruvec->lru_lock);
>> -
>> -	move_folios_to_lru(lruvec, &list);
>> +	move_folios_to_lru(&list);
>>   
>> +	local_irq_disable();
>>   	walk = current->reclaim_state->mm_walk;
>>   	if (walk && walk->batched) {
>>   		walk->lruvec = lruvec;
>> +		spin_lock(&lruvec->lru_lock);
>>   		reset_batch_size(walk);
>> +		spin_unlock(&lruvec->lru_lock);
>>   	}
> 
> Cc'ing RT folks as they may not want to disable IRQ on PREEMPT_RT.
> 
> IIRC there has been some effort in MM to reduce the scope of
> IRQ-disabled section in MM when PREEMPT_RT config was added to the
> mainline. spin_lock_irq() doesn't disable IRQ on PREEMPT_RT.

Thanks for this information.

> 
> Also, this will break RT according to Documentation/locking/locktypes.rst:
>> The changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
>> have a few implications. For example, on a non-PREEMPT_RT kernel
>> the following code sequence works as expected:
>>
>> local_irq_disable();
>> spin_lock(&lock);
>>
>> and is fully equivalent to:
>>
>> spin_lock_irq(&lock);
>> Same applies to rwlock_t and the _irqsave() suffix variants.
>>
>> On PREEMPT_RT kernel this code sequence breaks because RT-mutex requires
>> a fully preemptible context. Instead, use spin_lock_irq() or
>> spin_lock_irqsave() and their unlock counterparts.
>>
>> In cases where the interrupt disabling and locking must remain separate,
>> PREEMPT_RT offers a local_lock mechanism. Acquiring the local_lock pins
>> the task to a CPU, allowing things like per-CPU interrupt disabled locks
>> to be acquired. However, this approach should be used only where absolutely
>> necessary.

But how do we determine if it's necessary?

Thanks,
Qi

> 


