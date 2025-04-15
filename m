Return-Path: <cgroups+bounces-7544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992DA890CC
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A71917D56F
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF93596B;
	Tue, 15 Apr 2025 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isujnLKZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7B111BF;
	Tue, 15 Apr 2025 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677668; cv=none; b=VmGIsU2o0/BIlEAPASqZQBygQF968vQ1ejJAs9MiS0sHx/It8QMHc0O8FUgctnHn0QyAnBcSusJ+RerP3ftRFWKBNoPgYCzGfNIMxrRN121LS5SYu2/C272N1zFr6/QTOkyWyBIw7gcWOiLw1m/cVdxusM9oj44g5Ei5V61zfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677668; c=relaxed/simple;
	bh=DjGBKzYbzZBbpkJ0MrKAyTgSBUDd+rZ8JP5bIZpHppI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9zzmgNNSo1ONby87yP+6SdVrsOf4uSxpK2XlqEJi71cQKoddKCPoWj3YWV9u0i3pSa0aOVZJTbDgw72yMnyygRpzXE64bM76yFfPOMO/NQdDy2FSAcGsxp9PtMfJPbfqQwPu9oYVxqakOWD7bx497uucJt9aMnL9QZTY7k+MJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isujnLKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8498CC4CEE2;
	Tue, 15 Apr 2025 00:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677667;
	bh=DjGBKzYbzZBbpkJ0MrKAyTgSBUDd+rZ8JP5bIZpHppI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isujnLKZ7TRlGddlYHi/xRM27uUB7XqT6uyBTl1lGgjEQqt1zYaOkM3a3E5rbgKOc
	 kk++eDipscxZR80n1XwmsP78nv0wYb1Yx/JVBbxKlTLJ0fuBUv89mdUxiu5RKAlqSo
	 9oFj1npri1vfeWUe0I31bKVmcIe8XdY24aIR/PhX6/m9U8E9YzhXeSD7/zZ7p7rPbE
	 34up/YHkE43kZzRHyLeFGB2a9aApwhAcUhfajwarCgwqEC/2zJuEsC4PTHRjaE4Ro7
	 fcndlGAlJE9vyjVJQiC2vFqIbImMACQ+WWvWR8qHiCxkQDF/uCqxy0NkoGxc0DFCM4
	 e0i2qKBs1Ajkg==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: Re: [RFC PATCH v4 5/6] migrate,sysfs: add pagecache promotion
Date: Mon, 14 Apr 2025 17:41:05 -0700
Message-Id: <20250415004105.121462-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411221111.493193-6-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 18:11:10 -0400 Gregory Price <gourry@gourry.net> wrote:

> adds /sys/kernel/mm/numa/pagecache_promotion_enabled
> 
> When page cache lands on lower tiers, there is no way for promotion
> to occur unless it becomes memory-mapped and exposed to NUMA hint
> faults.  Just adding a mechanism to promote pages unconditionally,
> however, opens up significant possibility of performance regressions.
> 
> Similar to the `demotion_enabled` sysfs entry, provide a sysfs toggle
> to enable and disable page cache promotion.  This option will enable
> opportunistic promotion of unmapped page cache during syscall access.
> 
> This option is intended for operational conditions where demoted page
> cache will eventually contain memory which becomes hot - and where
> said memory likely to cause performance issues due to being trapped on
> the lower tier of memory.
> 
> A Page Cache folio is considered a promotion candidates when:
>   0) tiering and pagecache-promotion are enabled

"Tiering" here means NUMA_BALANCING_MEMORY_TIERING, right?  Why do you make
this feature depend on it?

If there is a good reason for the dependency, what do you think about

1. making pagecache_promotion_enabled automatically eanbles
   NUMA_BALANCING_MEMORY_TIERING, or
2. adding another flag for NUMA balancing
   (e.g., echo 4 > /proc/sys/kernel/numa_balancing) that enables this feature
   and mapped pages promotion together?

>   1) the folio resides on a node not in the top tier
>   2) the folio is already marked referenced and active.
>   3) Multiple accesses in (referenced & active) state occur quickly.

I don't clearly understand what 3) means, particularly the criteria of "quick",
and how the speed is measured.  Could you please clarify?

> 
> Since promotion is not safe to execute unconditionally from within
> folio_mark_accessed, we defer promotion to a new task_work captured
> in the task_struct.  This ensures that the task doing the access has
> some hand in promoting pages - even among deduplicated read only files.
> 
> We limit the total number of folios on the promotion list to the
> promotion rate limit to limit the amount of inline work done during
> large reads - avoiding significant overhead.  We do not use the existing
> rate-limit check function this checked during the migration anyway.
> 
> The promotion node is always the local node of the promoting cpu.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../ABI/testing/sysfs-kernel-mm-numa          | 20 +++++++
>  include/linux/memory-tiers.h                  |  2 +
>  include/linux/migrate.h                       |  5 ++
>  include/linux/sched.h                         |  4 ++
>  include/linux/sched/sysctl.h                  |  1 +
>  init/init_task.c                              |  2 +
>  kernel/sched/fair.c                           | 24 +++++++-
>  mm/memory-tiers.c                             | 27 +++++++++
>  mm/migrate.c                                  | 55 +++++++++++++++++++
>  mm/swap.c                                     |  8 +++
>  10 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> index 77e559d4ed80..ebb041891db2 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> @@ -22,3 +22,23 @@ Description:	Enable/disable demoting pages during reclaim
>  		the guarantees of cpusets.  This should not be enabled
>  		on systems which need strict cpuset location
>  		guarantees.
> +
> +What:		/sys/kernel/mm/numa/pagecache_promotion_enabled

This is not for any page cache page but unmapped page cache pages, right?
I think making the name be more explicit about it could avoid confuses?

> +Date:		January 2025

Captain, it's April ;)

> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Enable/disable promoting pages during file access
> +
> +		Page migration during file access is intended for systems
> +		with tiered memory configurations that have significant
> +		unmapped file cache usage. By default, file cache memory
> +		on slower tiers will not be opportunistically promoted by
> +		normal NUMA hint faults, because the system has no way to
> +		track them.  This option enables opportunistic promotion
> +		of pages that are accessed via syscall (e.g. read/write)
> +		if multiple accesses occur in quick succession.

I again think it would be nice to clarify how quick it should be.

> +
> +		It may move data to a NUMA node that does not fall into
> +		the cpuset of the allocating process which might be
> +		construed to violate the guarantees of cpusets.  This
> +		should not be enabled on systems which need strict cpuset
> +		location guarantees.
[...]
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
[...]
> @@ -957,11 +958,37 @@ static ssize_t demotion_enabled_store(struct kobject *kobj,
>  	return count;
>  }
>  
> +static ssize_t pagecache_promotion_enabled_show(struct kobject *kobj,
> +						struct kobj_attribute *attr,
> +						char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n",
> +			  numa_pagecache_promotion_enabled ? "true" : "false");
> +}

How about using str_true_false(), like demotion_enabled_show() does?

[...]
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -44,6 +44,8 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/pagewalk.h>
> +#include <linux/sched/numa_balancing.h>
> +#include <linux/task_work.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -2762,5 +2764,58 @@ int migrate_misplaced_folio_batch(struct list_head *folio_list, int node)
>  	BUG_ON(!list_empty(folio_list));
>  	return nr_remaining ? -EAGAIN : 0;
>  }
> +
> +/**
> + * promotion_candidate: report a promotion candidate folio
> + *
> + * The folio will be isolated from LRU if selected, and task_work will
> + * putback the folio on promotion failure.
> + *
> + * Candidates may not be promoted and may be returned to the LRU.

Is this for situations that are different from the above sentence explaining
cases?  If so, could you clarify that?

> + *
> + * Takes a folio reference that will be released in task work.
> + */
> +void promotion_candidate(struct folio *folio)
> +{
> +	struct task_struct *task = current;
> +	struct list_head *promo_list = &task->promo_list;
> +	struct callback_head *work = &task->numa_promo_work;
> +	int nid = folio_nid(folio);
> +	int flags, last_cpupid;
> +
> +	/* do not migrate toptier folios or in kernel context */
> +	if (node_is_toptier(nid) || task->flags & PF_KTHREAD)
> +		return;
> +
> +	/*
> +	 * Limit per-syscall migration rate to balancing rate limit. This avoids

Isn't this per-task work rather than per-syscall?

> +	 * excessive work during large reads knowing that task work is likely to
> +	 * hit the rate limit and put excess folios back on the LRU anyway.
> +	 */
> +	if (task->promo_count >= sysctl_numa_balancing_promote_rate_limit)
> +		return;
> +
> +	/* Isolate the folio to prepare for migration */
> +	nid = numa_migrate_check(folio, NULL, 0, &flags, folio_test_dirty(folio),
> +				 &last_cpupid);
> +	if (nid == NUMA_NO_NODE)
> +		return;
> +
> +	if (migrate_misplaced_folio_prepare(folio, NULL, nid))
> +		return;
> +
> +	/*
> +	 * If work is pending, add this folio to the list. Otherwise, ensure
> +	 * the task will execute the work, otherwise we can leak folios.
> +	 */
> +	if (list_empty(promo_list) && task_work_add(task, work, TWA_RESUME)) {
> +		folio_putback_lru(folio);
> +		return;
> +	}
> +	list_add_tail(&folio->lru, promo_list);
> +	task->promo_count += folio_nr_pages(folio);
> +	return;
> +}
> +EXPORT_SYMBOL(promotion_candidate);

Why export this symbol?


Thanks,
SJ

[...]

