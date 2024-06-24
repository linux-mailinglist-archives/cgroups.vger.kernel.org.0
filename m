Return-Path: <cgroups+bounces-3301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BE9147D3
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 12:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CE2B20E93
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF013541F;
	Mon, 24 Jun 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxjeIi28"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A922F24;
	Mon, 24 Jun 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226164; cv=none; b=u5IbVhuwZiu+S+pAfweJ63s8+mrwIfslcSCaWEJe0fCmURCmpl8XDjPKEzETEhol7BtgCe6xpghPvhEa0T7i8bOlREbOPapAqPgNavb4ChRYrvJro5+5aLKA7OoiIYBGRPROoyhxCAJ1AoRW8H/1HzxM5Su2ihhC6uqu5C1PWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226164; c=relaxed/simple;
	bh=GvAARBMTw7Stefz/r4lhdSuznA2R3pe8J7SJUtv8Seo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InTTM9dJn+vXEE4W437MU0rRdzGQoxVuySx9QNMlPyKgQ3XA9/99g8kUVhIaFybbFRh5LEcYcmfcMDd19YhPL1eE3HtGi/dWmEVnB7Cm4ZHXRbA5iTfgXe6lgaL5xZN1T6g2E0v24zlUblKjQ7gXcg3BWKbZtSaKD9H6iNxEN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxjeIi28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B32C2BBFC;
	Mon, 24 Jun 2024 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719226164;
	bh=GvAARBMTw7Stefz/r4lhdSuznA2R3pe8J7SJUtv8Seo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TxjeIi28++EhKDGutTg7cz67VVUBof99379p7tIdkUUy0rncv3lV+fGCCkEz3i62K
	 hzTA2BUWHnvfM0bkXtHwH4Mjpz4750poyXjLxa6qMewod5fnVUvAUbjZYEwW11bDJz
	 7a4eX8Sgwzlj9dflXJZI3hC1Tcb1MEFN+Crn7P8WH+Gn1EOdQHw1gYIB6VbpmykvXC
	 2XvwWLEN8Eg0FU5G5RAbtlMa5CUUB9JdxmwOJq8nn+hby0JfxI6+YrRZExRaSYEZnn
	 DdZq0pAwLbuJbueaL1jIiPyMlKUt7FnkaZqUAs1fyzGDx+uBXP92SKEl6eUH61uKJI
	 mfUHihVbp+u3w==
Message-ID: <c98bd274-1af3-4d0d-8b14-fb524c954c1d@kernel.org>
Date: Mon, 24 Jun 2024 12:49:20 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Waiman Long <longman@redhat.com>, tj@kernel.org, cgroups@vger.kernel.org,
 yosryahmed@google.com, shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171898037079.1222367.13467317484793748519.stgit@firesoul>
 <2de2850c-c844-4a75-884a-18d552fcb846@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <2de2850c-c844-4a75-884a-18d552fcb846@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/06/2024 18.08, Waiman Long wrote:
> 
> On 6/21/24 10:32, Jesper Dangaard Brouer wrote:
>> Avoid lock contention on the global cgroup rstat lock caused by kswapd
>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
>> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
>> call inlined in shrink_node, which takes the rstat lock.
>>
>> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
>> we noted severe lock contention on the rstat lock. This contention
>> causes 12 CPUs to waste cycles spinning every time kswapd runs.
>> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
>> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
>> due to spinning on the rstat lock.
>>
>> To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
>> empty, __alloc_pages_slowpath calls wake_all_kswapds(), causing all
>> kswapdN threads to wake up simultaneously. The kswapd thread invokes
>> shrink_node (via balance_pgdat) triggering the cgroup rstat flush
>> operation as part of its work. This results in kernel self-induced rstat
>> lock contention by waking up all kswapd threads simultaneously.
>> Leveraging this detail: balance_pgdat() have NULL value in
>> target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
>> root_mem_cgroup.
>>
>> To resolve the kswapd issue, we generalized the "stats_flush_ongoing"
>> concept to apply to all users of cgroup rstat, not just memcg. This
>> concept was originally reverted in commit 7d7ef0a4686a ("mm: memcg:
>> restore subtree stats flushing"). If there is an ongoing rstat flush,
>> limited to the root cgroup, the flush is skipped. This is effective as
>> kswapd operates on the root tree, sufficiently mitigating the thundering
>> herd problem.
>>
>> This lowers contention on the global rstat lock, although limited to the
>> root cgroup. Flushing cgroup subtree's can still lead to lock contention.
>>
>> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   include/linux/cgroup.h |    5 +++++
>>   kernel/cgroup/rstat.c  |   28 ++++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index 2150ca60394b..ad41cca5c3b6 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -499,6 +499,11 @@ static inline struct cgroup *cgroup_parent(struct 
>> cgroup *cgrp)
>>       return NULL;
>>   }
>> +static inline bool cgroup_is_root(struct cgroup *cgrp)
>> +{
>> +    return cgroup_parent(cgrp) == NULL;
>> +}

Please let me know if above code is correct?

>> +
>>   /**
>>    * cgroup_is_descendant - test ancestry
>>    * @cgrp: the cgroup to be tested
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index fb8b49437573..5aba95e92d31 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -11,6 +11,7 @@
>>   static DEFINE_SPINLOCK(cgroup_rstat_lock);
>>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>> +static atomic_t root_rstat_flush_ongoing = ATOMIC_INIT(0);
>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>> @@ -350,8 +351,25 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup 
>> *cgrp)
>>   {
>>       might_sleep();
>> +    /*
>> +     * This avoids thundering herd problem on global rstat lock. When an
>> +     * ongoing flush of the entire tree is in progress, then skip flush.
>> +     */
>> +    if (atomic_read(&root_rstat_flush_ongoing))
>> +        return;
>> +
>> +    /* Grab right to be ongoing flusher, return if loosing race */
>> +    if (cgroup_is_root(cgrp) &&
>> +        atomic_xchg(&root_rstat_flush_ongoing, 1))
>> +        return;
>> +
>>       __cgroup_rstat_lock(cgrp, -1);
>> +
>>       cgroup_rstat_flush_locked(cgrp);
>> +
>> +    if (cgroup_is_root(cgrp))
>> +        atomic_set(&root_rstat_flush_ongoing, 0);
>> +
>>       __cgroup_rstat_unlock(cgrp, -1);
>>   }
>> @@ -362,13 +380,20 @@ __bpf_kfunc void cgroup_rstat_flush(struct 
>> cgroup *cgrp)
>>    * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
>>    * paired with cgroup_rstat_flush_release().
>>    *
>> + * Current invariant, not called with root cgrp.
>> + *
>>    * This function may block.
>>    */
>>   void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>       __acquires(&cgroup_rstat_lock)
>>   {
>>       might_sleep();
>> +
>>       __cgroup_rstat_lock(cgrp, -1);
>> +
>> +    if (atomic_read(&root_rstat_flush_ongoing))
>> +        return;
>> +
>>       cgroup_rstat_flush_locked(cgrp);
>>   }
>> @@ -379,6 +404,9 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>>       __releases(&cgroup_rstat_lock)
>>   {
>> +    if (cgroup_is_root(cgrp))
>> +        atomic_set(&root_rstat_flush_ongoing, 0);
>> +
>>       __cgroup_rstat_unlock(cgrp, -1);
>>   }
> 
> Since both cgroup_rstat_flush_hold() and cgroup_rstat_flush_release() 
> are not called with root cgroup, the cgroup_rstat_flush_hold() hunk is 
> essentially dead code.
> 

Yes, the cgroup_rstat_flush_release chunk is essentially dead code.
I will send a V2 with this code removed.

--Jesper


