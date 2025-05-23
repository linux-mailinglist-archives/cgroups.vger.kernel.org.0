Return-Path: <cgroups+bounces-8336-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CDDAC2C7D
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B984A574C
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877021579F;
	Fri, 23 May 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qFuuEvm/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BCA20E03F
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043798; cv=none; b=uIDod4dfC1/yX+FX9WCWv7rgIScJMUi1Ym0coBeN/Yq7o13/EEWe77SM910wOTOCwapXoLpWm7fyoQ644Oksaeprv8tGfqqg59CGeYwqSoxkENWV916AloEH4xCRrXbBIhlEFZqtLEphginR6KIGHkuzNHiLqxfQdDhyINzEcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043798; c=relaxed/simple;
	bh=UC1IY7GDCljDH55InOed2t4QKEhyH3VEoGg/RBcTfJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB4o2uyRTI3jIt6jUywAZdO60Jq9bW6Zsvjt5l9GsfZMciu2Fhub6RK+DVDJwzkiPlLqtUfTVLBUzERqgOa8/861h4w53KvSQRzf5T+5Bz/DR/FP2fKeaJjC1fnoFTRvqB1M2rz37Ue+lA9RRJ9Bo5ZCc/q4r28OefzhB8Wv0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qFuuEvm/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 16:42:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748043784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw4eN0qQQXqMxLwyqIdk47YqQp0VMxRQquWBawW7/XA=;
	b=qFuuEvm/rG2JcjdBOv6o9n1algz2BxVu7HuqslSM4C1W89BMFdGsBDEiWAAK/F9LvRIAyr
	Zqv+USOL2PRJ3WyD0aZsm2Eljq07oW7YZJ1ZtxXCH+riKdBl4xKqKYH0OqZc9cIRFX4Mtr
	shtzjwK0PQAVVMMySa3bl4Yrr163c5U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Yu <yu.c.chen@intel.com>
Cc: peterz@infradead.org, akpm@linux-foundation.org, mkoutny@suse.com, 
	mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
Message-ID: <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 08:51:15PM +0800, Chen Yu wrote:
> On systems with NUMA balancing enabled, it has been found
> that tracking task activities resulting from NUMA balancing
> is beneficial. NUMA balancing employs two mechanisms for task
> migration: one is to migrate a task to an idle CPU within its
> preferred node, and the other is to swap tasks located on
> different nodes when they are on each other's preferred nodes.
> 
> The kernel already provides NUMA page migration statistics in
> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched. However,
> it lacks statistics regarding task migration and swapping.
> Therefore, relevant counts for task migration and swapping should
> be added.
> 
> The following two new fields:
> 
> numa_task_migrated
> numa_task_swapped
> 
> will be shown in /sys/fs/cgroup/{GROUP}/memory.stat, /proc/{PID}/sched
> and /proc/vmstat

Hmm these are scheduler events, how are these relevant to memory cgroup
or vmstat? Any reason to not expose these in cpu.stat?

> 
> Introducing both per-task and per-memory cgroup (memcg) NUMA
> balancing statistics facilitates a rapid evaluation of the
> performance and resource utilization of the target workload.
> For instance, users can first identify the container with high
> NUMA balancing activity and then further pinpoint a specific
> task within that group, and subsequently adjust the memory policy
> for that task. In short, although it is possible to iterate through
> /proc/$pid/sched to locate the problematic task, the introduction
> of aggregated NUMA balancing activity for tasks within each memcg
> can assist users in identifying the task more efficiently through
> a divide-and-conquer approach.
> 
> As Libo Chen pointed out, the memcg event relies on the text
> names in vmstat_text, and /proc/vmstat generates corresponding items
> based on vmstat_text. Thus, the relevant task migration and swapping
> events introduced in vmstat_text also need to be populated by
> count_vm_numa_event(), otherwise these values are zero in
> /proc/vmstat.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v4->v5:
> no change.
> v3->v4:
> Populate the /prov/vmstat otherwise the items are all zero.
> (Libo)
> v2->v3:
> Remove unnecessary p->mm check because kernel threads are
> not supported by Numa Balancing. (Libo Chen)
> v1->v2:
> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  include/linux/sched.h                   | 4 ++++
>  include/linux/vm_event_item.h           | 2 ++
>  kernel/sched/core.c                     | 9 +++++++--
>  kernel/sched/debug.c                    | 4 ++++
>  mm/memcontrol.c                         | 2 ++
>  mm/vmstat.c                             | 2 ++
>  7 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7..d346f3235945 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1670,6 +1670,12 @@ The following nested keys are defined.
>  	  numa_hint_faults (npn)
>  		Number of NUMA hinting faults.
>  
> +	  numa_task_migrated (npn)
> +		Number of task migration by NUMA balancing.
> +
> +	  numa_task_swapped (npn)
> +		Number of task swap by NUMA balancing.
> +
>  	  pgdemote_kswapd
>  		Number of pages demoted by kswapd.
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f96ac1982893..1c50e30b5c01 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -549,6 +549,10 @@ struct sched_statistics {
>  	u64				nr_failed_migrations_running;
>  	u64				nr_failed_migrations_hot;
>  	u64				nr_forced_migrations;
> +#ifdef CONFIG_NUMA_BALANCING
> +	u64				numa_task_migrated;
> +	u64				numa_task_swapped;
> +#endif
>  
>  	u64				nr_wakeups;
>  	u64				nr_wakeups_sync;
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 9e15a088ba38..91a3ce9a2687 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -66,6 +66,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		NUMA_HINT_FAULTS,
>  		NUMA_HINT_FAULTS_LOCAL,
>  		NUMA_PAGE_MIGRATE,
> +		NUMA_TASK_MIGRATE,
> +		NUMA_TASK_SWAP,
>  #endif
>  #ifdef CONFIG_MIGRATION
>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c81cf642dba0..62b033199e9c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3352,6 +3352,10 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  #ifdef CONFIG_NUMA_BALANCING
>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>  {
> +	__schedstat_inc(p->stats.numa_task_swapped);
> +	count_vm_numa_event(NUMA_TASK_SWAP);
> +	count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
> +
>  	if (task_on_rq_queued(p)) {
>  		struct rq *src_rq, *dst_rq;
>  		struct rq_flags srf, drf;
> @@ -7953,8 +7957,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> -
> +	__schedstat_inc(p->stats.numa_task_migrated);
> +	count_vm_numa_event(NUMA_TASK_MIGRATE);
> +	count_memcg_event_mm(p->mm, NUMA_TASK_MIGRATE);
>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>  }
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 56ae54e0ce6a..f971c2af7912 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		P_SCHEDSTAT(nr_failed_migrations_running);
>  		P_SCHEDSTAT(nr_failed_migrations_hot);
>  		P_SCHEDSTAT(nr_forced_migrations);
> +#ifdef CONFIG_NUMA_BALANCING
> +		P_SCHEDSTAT(numa_task_migrated);
> +		P_SCHEDSTAT(numa_task_swapped);
> +#endif
>  		P_SCHEDSTAT(nr_wakeups);
>  		P_SCHEDSTAT(nr_wakeups_sync);
>  		P_SCHEDSTAT(nr_wakeups_migrate);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c96c1f2b9cf5..cdaab8a957f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -463,6 +463,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>  	NUMA_PAGE_MIGRATE,
>  	NUMA_PTE_UPDATES,
>  	NUMA_HINT_FAULTS,
> +	NUMA_TASK_MIGRATE,
> +	NUMA_TASK_SWAP,
>  #endif
>  };
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4c268ce39ff2..ed08bb384ae4 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1347,6 +1347,8 @@ const char * const vmstat_text[] = {
>  	"numa_hint_faults",
>  	"numa_hint_faults_local",
>  	"numa_pages_migrated",
> +	"numa_task_migrated",
> +	"numa_task_swapped",
>  #endif
>  #ifdef CONFIG_MIGRATION
>  	"pgmigrate_success",
> -- 
> 2.25.1
> 

