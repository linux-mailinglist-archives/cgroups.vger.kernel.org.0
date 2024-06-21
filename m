Return-Path: <cgroups+bounces-3267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511991285B
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32921F28E3D
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86882C697;
	Fri, 21 Jun 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNZR64Oi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B73BBF6;
	Fri, 21 Jun 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981258; cv=none; b=CUljvYoJDUaCj0eq1T8NZM65Ru/zghLkRKdE+XdzaVqjuimyQDxQ7l0pPxgiw82WrGr3iEP/VEiz12ZGA4TW2a7GqnJEdYmFyD2uFvTCzEwa8TOTqBvGitfju59URMonZj4EEFB6RDUCn9Le2im6C+yTGRiJlTf/N3iRmnZNFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981258; c=relaxed/simple;
	bh=A4cHDnX1dTFnwXGGupX/t2tXu929gQBMR7klMhczcXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+qcW+rqeqWYt+XfPd0Ri6Q+D3E1mzFf2cmX5Quk6bSo6D/9kklH6XPuq7Cf6VvO+jKEtkUtBan18qx5feZtN+N0B8H1PMToJUtYcL7fqTBB4AAmnWkSV42FCCSUTp/F6Cx1PjQh0MuFA6NdHwSEWREdXLQTBuD59e4pkYCCAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNZR64Oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22733C2BBFC;
	Fri, 21 Jun 2024 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981257;
	bh=A4cHDnX1dTFnwXGGupX/t2tXu929gQBMR7klMhczcXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CNZR64Oi/yGvjiIO9c08wB97tdigaAbD3nXW1SWG09xe3RUMtfjcgeiRCPk4OKMnO
	 H8Qqi2ZBEpiChDehsyVYDqilHXhVbZL8DUOiLsuRDLUcF/+MezjUah766nns+AvqAx
	 oyPNVIczTiX/hNaPnnNISiXUQvR+03ZVOfuJTLHAGVj1av4nC2ZnwEaB0Djftm3TO0
	 5dXhOTiIWY37VmbX4/GUI4Fv+yHZ2RXpVOQlXIABalVN8AkobBcOXXdseB+xZ/KssU
	 L5rgxH6/fximTAmjvtLWjhsB6oG8n1DhTB6mrrzFrfViKXg1DoDs3YCsj+6xsdVnNs
	 Id52lhRwTAGAw==
Message-ID: <bb5d0ff3-c130-4f98-bac1-e3b95ddc7791@kernel.org>
Date: Fri, 21 Jun 2024 16:47:34 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171898037079.1222367.13467317484793748519.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <171898037079.1222367.13467317484793748519.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hold off applying this patch, as test kernel didn't boot with this patch
applied on top of TJ's cgroup tree (on commit ec9eeb89e60d86).  I don't
know if this is related to this patch or not.

--Jesper

On 21/06/2024 16.32, Jesper Dangaard Brouer wrote:
> Avoid lock contention on the global cgroup rstat lock caused by kswapd
> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
> call inlined in shrink_node, which takes the rstat lock.
> 
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
> we noted severe lock contention on the rstat lock. This contention
> causes 12 CPUs to waste cycles spinning every time kswapd runs.
> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
> due to spinning on the rstat lock.
> 
> To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
> empty, __alloc_pages_slowpath calls wake_all_kswapds(), causing all
> kswapdN threads to wake up simultaneously. The kswapd thread invokes
> shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously.
> Leveraging this detail: balance_pgdat() have NULL value in
> target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
> root_mem_cgroup.
> 
> To resolve the kswapd issue, we generalized the "stats_flush_ongoing"
> concept to apply to all users of cgroup rstat, not just memcg. This
> concept was originally reverted in commit 7d7ef0a4686a ("mm: memcg:
> restore subtree stats flushing"). If there is an ongoing rstat flush,
> limited to the root cgroup, the flush is skipped. This is effective as
> kswapd operates on the root tree, sufficiently mitigating the thundering
> herd problem.
> 
> This lowers contention on the global rstat lock, although limited to the
> root cgroup. Flushing cgroup subtree's can still lead to lock contention.
> 
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   include/linux/cgroup.h |    5 +++++
>   kernel/cgroup/rstat.c  |   28 ++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..ad41cca5c3b6 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -499,6 +499,11 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
>   	return NULL;
>   }
>   
> +static inline bool cgroup_is_root(struct cgroup *cgrp)
> +{
> +	return cgroup_parent(cgrp) == NULL;
> +}
> +
>   /**
>    * cgroup_is_descendant - test ancestry
>    * @cgrp: the cgroup to be tested
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index fb8b49437573..5aba95e92d31 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -11,6 +11,7 @@
>   
>   static DEFINE_SPINLOCK(cgroup_rstat_lock);
>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static atomic_t root_rstat_flush_ongoing = ATOMIC_INIT(0);
>   
>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>   
> @@ -350,8 +351,25 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>   {
>   	might_sleep();
>   
> +	/*
> +	 * This avoids thundering herd problem on global rstat lock. When an
> +	 * ongoing flush of the entire tree is in progress, then skip flush.
> +	 */
> +	if (atomic_read(&root_rstat_flush_ongoing))
> +		return;
> +
> +	/* Grab right to be ongoing flusher, return if loosing race */
> +	if (cgroup_is_root(cgrp) &&
> +	    atomic_xchg(&root_rstat_flush_ongoing, 1))
> +		return;
> +
>   	__cgroup_rstat_lock(cgrp, -1);
> +
>   	cgroup_rstat_flush_locked(cgrp);
> +
> +	if (cgroup_is_root(cgrp))
> +		atomic_set(&root_rstat_flush_ongoing, 0);
> +
>   	__cgroup_rstat_unlock(cgrp, -1);
>   }
>   
> @@ -362,13 +380,20 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>    * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
>    * paired with cgroup_rstat_flush_release().
>    *
> + * Current invariant, not called with root cgrp.
> + *
>    * This function may block.
>    */
>   void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   	__acquires(&cgroup_rstat_lock)
>   {
>   	might_sleep();
> +
>   	__cgroup_rstat_lock(cgrp, -1);
> +
> +	if (atomic_read(&root_rstat_flush_ongoing))
> +		return;
> +
>   	cgroup_rstat_flush_locked(cgrp);
>   }
>   
> @@ -379,6 +404,9 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>   	__releases(&cgroup_rstat_lock)
>   {
> +	if (cgroup_is_root(cgrp))
> +		atomic_set(&root_rstat_flush_ongoing, 0);
> +
>   	__cgroup_rstat_unlock(cgrp, -1);
>   }
>   
> 
> 

