Return-Path: <cgroups+bounces-3268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F23912925
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89E31F28164
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C565F873;
	Fri, 21 Jun 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIObQLFe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706244AEF2
	for <cgroups@vger.kernel.org>; Fri, 21 Jun 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982831; cv=none; b=fNqg579k/HiQuWlMO30zntxdkXD5lGO/t/5sFleoFPY94iQCs0Eh9qGt2usFO6aO9MDnFug7x1DntLHvYM/0jZETyWZnDCpuW8FRVFqw+DJ6JWxFDYnd/bhsSoxDNg5i5t7iCLs2KP9lhY4ZMADEodcBD1sxkLKp1XdlbinUwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982831; c=relaxed/simple;
	bh=DZJlAi4dyBH8I99r68PHVwY0JqwlfNNiIzz24nZFbXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lvud3kSXzIwhQFXyCGcvQOuP0TD1Qd6Ixjnf5uQr3nnm1IMgl4fC3PY5uH4xv8AW07JCbB91+2BcA3nmJRW33AfnAjvpGPhaYYskJqhtsbLBcQ2GCVxmSbOSqxuUpMDMES/NoxpCEr/WCWJqDL5oXurFpGoMexFHJBPyVdsVKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIObQLFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718982828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EP/kWpZ/AZr0wzKgF+O2dWS3CSDCoLm/7KmRqzqigc4=;
	b=dIObQLFe/UikKZTCIdC5m68SjdJl1Ny4m+qPOcsrxOus6cOPedTCjQhgDUH86a7PzVgymY
	YLAXD+FLCdlB8p0/zLdXFs5Zhm1iaou+JO6Ajiicjz4Z2UloSD3bBNdcV0D+tWAeGQ+SR2
	IGdu0TDOGeS845Ah3p0RpcB6jKx+x9Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-qD7zYqEPO-GFO_glMF_BXw-1; Fri,
 21 Jun 2024 11:13:44 -0400
X-MC-Unique: qD7zYqEPO-GFO_glMF_BXw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2273C1956055;
	Fri, 21 Jun 2024 15:13:42 +0000 (UTC)
Received: from [10.22.17.209] (unknown [10.22.17.209])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC86B3000605;
	Fri, 21 Jun 2024 15:13:39 +0000 (UTC)
Message-ID: <f75c9256-1969-4b34-bc93-106581157042@redhat.com>
Date: Fri, 21 Jun 2024 11:13:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 cgroups@vger.kernel.org, yosryahmed@google.com, shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171898037079.1222367.13467317484793748519.stgit@firesoul>
 <bb5d0ff3-c130-4f98-bac1-e3b95ddc7791@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <bb5d0ff3-c130-4f98-bac1-e3b95ddc7791@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6/21/24 10:47, Jesper Dangaard Brouer wrote:
>
> Hold off applying this patch, as test kernel didn't boot with this patch
> applied on top of TJ's cgroup tree (on commit ec9eeb89e60d86).  I don't
> know if this is related to this patch or not.

Commit ec9eeb89e60d86 is just a snapshot of the Linus' tree. You should 
use for-next/for-6.11 tag as a base.

Cheers,
Longman

>
> --Jesper
>
> On 21/06/2024 16.32, Jesper Dangaard Brouer wrote:
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
>> root cgroup. Flushing cgroup subtree's can still lead to lock 
>> contention.
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
>> @@ -499,6 +499,11 @@ static inline struct cgroup 
>> *cgroup_parent(struct cgroup *cgrp)
>>       return NULL;
>>   }
>>   +static inline bool cgroup_is_root(struct cgroup *cgrp)
>> +{
>> +    return cgroup_parent(cgrp) == NULL;
>> +}
>> +
>>   /**
>>    * cgroup_is_descendant - test ancestry
>>    * @cgrp: the cgroup to be tested
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index fb8b49437573..5aba95e92d31 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -11,6 +11,7 @@
>>     static DEFINE_SPINLOCK(cgroup_rstat_lock);
>>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>> +static atomic_t root_rstat_flush_ongoing = ATOMIC_INIT(0);
>>     static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>   @@ -350,8 +351,25 @@ __bpf_kfunc void cgroup_rstat_flush(struct 
>> cgroup *cgrp)
>>   {
>>       might_sleep();
>>   +    /*
>> +     * This avoids thundering herd problem on global rstat lock. 
>> When an
>> +     * ongoing flush of the entire tree is in progress, then skip 
>> flush.
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
>>   @@ -362,13 +380,20 @@ __bpf_kfunc void cgroup_rstat_flush(struct 
>> cgroup *cgrp)
>>    * Flush stats in @cgrp's subtree and prevent further flushes.  
>> Must be
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
>>   @@ -379,6 +404,9 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>>       __releases(&cgroup_rstat_lock)
>>   {
>> +    if (cgroup_is_root(cgrp))
>> +        atomic_set(&root_rstat_flush_ongoing, 0);
>> +
>>       __cgroup_rstat_unlock(cgrp, -1);
>>   }
>>
>>
>


