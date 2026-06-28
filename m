Return-Path: <cgroups+bounces-17364-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k304K7muQWoKtgkAu9opvQ
	(envelope-from <cgroups+bounces-17364-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 01:31:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 035176D546F
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 01:31:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=tq+f28bx;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17364-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17364-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D670300F52C
	for <lists+cgroups@lfdr.de>; Sun, 28 Jun 2026 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F13016E0;
	Sun, 28 Jun 2026 23:30:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081914ABE
	for <cgroups@vger.kernel.org>; Sun, 28 Jun 2026 23:30:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782689451; cv=none; b=DH9K+lnyqvSCowiFPCYaCwWjTltyjjZzLKcmFpQnxm7AgktKcHZl4Lw2zBA9H+9MVMSBM5LWVUJrhg5+0DeYxYzgwuSCEL+G7kwXTzsTKD7ufjbjU5uy2I6by23wTlJnrw7Qf2fYvBVN2IlC6hE3q0RAHgXMPyfcwsSvFsF36lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782689451; c=relaxed/simple;
	bh=FCAvNvxt8yJR747sY2QIYNVfKqAcM3FtTwOwPVy0OXI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RKJKU2YXaoaoUhTvQt/zZC47htJYJDu+aCqK2/VHkjLEu+ccz9uyJLoVmxOtRSjZLRSQsYURsJZ6/VFtuQNFdwL25K02M3YH8PDB6Fz4ix30xpxieRJaZDlkKF4krF/pX55o2Sj+TEWVGvhTF5wTEuTkhSRmMnZhaoYB1KRe2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tq+f28bx; arc=none smtp.client-ip=95.215.58.170
Message-ID: <e9f31c44-3be9-4697-a335-f04400e6618e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782689436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9qNzKYvxdqu61KfKKEr8FAjRGqAf6PehJoagBWoQsI=;
	b=tq+f28bx0v/xl204JG6zey8ukwAqo9sSVDwPVgKQcC76H2aao4uyf/OKl6GbXHlUWA26Wa
	a1xP4fl3iE0bywnw5ZfwTBxOSEoGLyj2ug2j4LjP23LgzbS2o5oeHKOqUNUd/TMjOf+V6m
	O/UcKEMHy/n+RYXQQfZkkoyJJejZnAI=
Date: Mon, 29 Jun 2026 07:30:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fernand Sieber <sieberf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Alexander Graf <graf@amazon.com>, Misha Karataiev <karataev@amazon.com>,
 nh-open-source@amazon.com
Subject: Re: [PATCH] sched/core: Add core_sibling_idle accounting
To: Yuxuan Liu <liuyuxua@amazon.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20260623234306.93562-1-liuyuxua@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260623234306.93562-1-liuyuxua@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:tj@kernel.org,m:lizefan.x@bytedance.com,m:hannes@cmpxchg.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:bristot@redhat.com,m:vschneid@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sieberf@amazon.com,m:dwmw@amazon.co.uk,m:graf@amazon.com,m:karataev@amazon.com,m:nh-open-source@amazon.com,m:liuyuxua@amazon.com,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-17364-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 035176D546F


Hi Yuxuan,

Thanks for the patch. I'm still new to this area, so please correct me if I'm wrong — two quick questions:

1. It looks like core_sibling_idle_start is set whenever occ < smt_width (any sibling idle), whereas core_forceidle_count is only bumped when the idle sibling has runnable work (nr_running > 0). So sibling_idle also counts idle from a sibling that simply has nothing to run, not just cookie-conflict idle. Scenario 1 (sibling_idle_usec ≈ usage_usec for a single busy-loop) seems to confirm this.

That broader semantic may be exactly right for fleet placement, but it's wider than the cover letter's wording ("no compatible workload can share the core") suggests. Would it be worth clarifying in the docs that this is total sibling idle, or discussing whether the cookie-conflict-only subset should be separate?

2. The accounting lives under CONFIG_SCHEDSTATS while the cpu.stat output is only gated on CONFIG_SCHED_CORE, so with SCHED_CORE=y/SCHEDSTATS=n the field would always read 0. (Same as force_idle_usec today.) Might be worth a note in the docs, or consider decoupling from schedstats.

Thanks,
Tao

在 2026/6/24 07:43, Yuxuan Liu 写道:
> When a VM runs on one SMT thread and core scheduling leaves the sibling
> idle because no compatible workload can share the core, existing metrics
> (forced idle time) only report this cost if another task is actively
> waiting. Without waiting tasks, the stranded capacity looks like free
> capacity to external fleet management software, leading it to place
> additional workloads onto hosts that are already effectively fully
> loaded. Add core_sibling_idle to capture all idle time caused by core
> scheduling constraints so orchestrators can make accurate placement
> decisions.
> 
> To avoid redundant bookkeeping, forceidle and sibling_idle accounting
> are consolidated into a single function __sched_core_account_idle().
> Both metrics share a common timestamp (core_sibling_idle_start) and
> occupation count (core_sibling_idle_occupation), replacing the separate
> core_forceidle_start and core_forceidle_occupation fields. The
> forceidle subset is derived from core_forceidle_count within the same
> accounting pass.
> 
> The new metric is exposed as core_sched.sibling_idle_usec in cgroup v2
> cpu.stat, alongside the existing core_sched.force_idle_usec. The
> per-task core_sibling_idle_sum is also available via /proc/<pid>/sched
> for debugging.
> 
> == Testing ==
> Testing is done using QEMU.
> 
> === Scenario 1: No CPU Contention ===
> The system has 2 CPUs, with 1 VM (2 vCPUs) that uses core scheduling and
> runs an infinite loop pinned to vCPU 0:
> taskset -c 0 sh -c 'while true; do :; done' &
> 
> In the VM's cpu.stat, its core_sched.force_idle_usec is near 0 (199 us)
> while core_sched.sibling_idle_usec (117796370 us) is identical to
> usage_usec (123946273 us).
> 
> === Scenario 2: With CPU Contention ===
> Same setup as Scenario 1 except with 2 VMs (2 vCPUs each).
> 
> Both VMs have identical core_sched.force_idle_usec and
> core_sched.sibling_idle_usec in their respective cpu.stat, with
> sibling_idle_usec being slightly higher.
> 
> Signed-off-by: Yuxuan Liu <liuyuxua@amazon.com>
> ---
>  include/linux/cgroup-defs.h |  1 +
>  include/linux/kernel_stat.h |  2 ++
>  include/linux/sched.h       |  1 +
>  kernel/cgroup/rstat.c       | 11 ++++++
>  kernel/sched/core.c         | 33 +++++++++---------
>  kernel/sched/core_sched.c   | 67 +++++++++++++++++++++++++------------
>  kernel/sched/cputime.c      | 12 +++++++
>  kernel/sched/debug.c        |  1 +
>  kernel/sched/sched.h        | 17 ++++++----
>  9 files changed, 101 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index c0c2b26725d0f..b65c910cbd872 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -301,6 +301,7 @@ struct cgroup_base_stat {
>  
>  #ifdef CONFIG_SCHED_CORE
>  	u64 forceidle_sum;
> +	u64 sibling_idle_sum;
>  #endif
>  };
>  
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 9935f7ecbfb9e..0e1386a9816ff 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -30,6 +30,7 @@ enum cpu_usage_stat {
>  	CPUTIME_GUEST_NICE,
>  #ifdef CONFIG_SCHED_CORE
>  	CPUTIME_FORCEIDLE,
> +	CPUTIME_SIBLING_IDLE,
>  #endif
>  	NR_STATS,
>  };
> @@ -132,6 +133,7 @@ extern void account_idle_ticks(unsigned long ticks);
>  
>  #ifdef CONFIG_SCHED_CORE
>  extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
> +extern void __account_sibling_idle_time(struct task_struct *tsk, u64 delta);
>  #endif
>  
>  #endif /* _LINUX_KERNEL_STAT_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index fad3aad97c7b0..5b1a1c247b12a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -544,6 +544,7 @@ struct sched_statistics {
>  
>  #ifdef CONFIG_SCHED_CORE
>  	u64				core_forceidle_sum;
> +	u64				core_sibling_idle_sum;
>  #endif
>  #endif /* CONFIG_SCHEDSTATS */
>  } ____cacheline_aligned;
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index c32439b855f5d..29ef399d1c7e7 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -326,6 +326,7 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
>  	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
>  #ifdef CONFIG_SCHED_CORE
>  	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
> +	dst_bstat->sibling_idle_sum += src_bstat->sibling_idle_sum;
>  #endif
>  }
>  
> @@ -337,6 +338,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
>  	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
>  #ifdef CONFIG_SCHED_CORE
>  	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
> +	dst_bstat->sibling_idle_sum -= src_bstat->sibling_idle_sum;
>  #endif
>  }
>  
> @@ -430,6 +432,9 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
>  	case CPUTIME_FORCEIDLE:
>  		rstatc->bstat.forceidle_sum += delta_exec;
>  		break;
> +	case CPUTIME_SIBLING_IDLE:
> +		rstatc->bstat.sibling_idle_sum += delta_exec;
> +		break;
>  #endif
>  	default:
>  		break;
> @@ -472,6 +477,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
>  
>  #ifdef CONFIG_SCHED_CORE
>  		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
> +		bstat->sibling_idle_sum += cpustat[CPUTIME_SIBLING_IDLE];
>  #endif
>  	}
>  }
> @@ -483,6 +489,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  	struct cgroup_base_stat bstat;
>  #ifdef CONFIG_SCHED_CORE
>  	u64 forceidle_time;
> +	u64 sibling_idle_time;
>  #endif
>  
>  	if (cgroup_parent(cgrp)) {
> @@ -492,6 +499,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  			       &utime, &stime);
>  #ifdef CONFIG_SCHED_CORE
>  		forceidle_time = cgrp->bstat.forceidle_sum;
> +		sibling_idle_time = cgrp->bstat.sibling_idle_sum;
>  #endif
>  		cgroup_rstat_flush_release();
>  	} else {
> @@ -501,6 +509,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  		stime = bstat.cputime.stime;
>  #ifdef CONFIG_SCHED_CORE
>  		forceidle_time = bstat.forceidle_sum;
> +		sibling_idle_time = bstat.sibling_idle_sum;
>  #endif
>  	}
>  
> @@ -509,6 +518,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  	do_div(stime, NSEC_PER_USEC);
>  #ifdef CONFIG_SCHED_CORE
>  	do_div(forceidle_time, NSEC_PER_USEC);
> +	do_div(sibling_idle_time, NSEC_PER_USEC);
>  #endif
>  
>  	seq_printf(seq, "usage_usec %llu\n"
> @@ -518,6 +528,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  
>  #ifdef CONFIG_SCHED_CORE
>  	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
> +	seq_printf(seq, "core_sched.sibling_idle_usec %llu\n", sibling_idle_time);
>  #endif
>  }
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d558e43aedcf2..73999633f9059 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -369,7 +369,7 @@ static void __sched_core_flip(bool enabled)
>  		for_each_cpu(t, smt_mask)
>  			cpu_rq(t)->core_enabled = enabled;
>  
> -		cpu_rq(cpu)->core->core_forceidle_start = 0;
> +		cpu_rq(cpu)->core->core_sibling_idle_start = 0;
>  
>  		sched_core_unlock(cpu, &flags);
>  
> @@ -6124,18 +6124,19 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	/* reset state */
>  	rq->core->core_cookie = 0UL;
> -	if (rq->core->core_forceidle_count) {
> +	if (rq->core->core_sibling_idle_occupation) {
>  		if (!core_clock_updated) {
>  			update_rq_clock(rq->core);
>  			core_clock_updated = true;
>  		}
> -		sched_core_account_forceidle(rq);
> -		/* reset after accounting force idle */
> -		rq->core->core_forceidle_start = 0;
> +		sched_core_account_idle(rq);
> +		rq->core->core_sibling_idle_start = 0;
> +		rq->core->core_sibling_idle_occupation = 0;
> +		if (rq->core->core_forceidle_count) {
> +			need_sync = true;
> +			fi_before = true;
> +		}
>  		rq->core->core_forceidle_count = 0;
> -		rq->core->core_forceidle_occupation = 0;
> -		need_sync = true;
> -		fi_before = true;
>  	}
>  
>  	/*
> @@ -6221,9 +6222,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		}
>  	}
>  
> -	if (schedstat_enabled() && rq->core->core_forceidle_count) {
> -		rq->core->core_forceidle_start = rq_clock(rq->core);
> -		rq->core->core_forceidle_occupation = occ;
> +	if (schedstat_enabled() && occ < cpumask_weight(smt_mask)) {
> +		rq->core->core_sibling_idle_start = rq_clock(rq->core);
> +		rq->core->core_sibling_idle_occupation = occ;
>  	}
>  
>  	rq->core->core_pick_seq = rq->core->core_task_seq;
> @@ -6480,14 +6481,14 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
>  	core_rq->core_cookie               = rq->core_cookie;
>  	core_rq->core_forceidle_count      = rq->core_forceidle_count;
>  	core_rq->core_forceidle_seq        = rq->core_forceidle_seq;
> -	core_rq->core_forceidle_occupation = rq->core_forceidle_occupation;
>  
>  	/*
> -	 * Accounting edge for forced idle is handled in pick_next_task().
> +	 * Accounting edge for sibling idle is handled in pick_next_task().
>  	 * Don't need another one here, since the hotplug thread shouldn't
>  	 * have a cookie.
>  	 */
> -	core_rq->core_forceidle_start = 0;
> +	core_rq->core_sibling_idle_occupation = rq->core_sibling_idle_occupation;
> +	core_rq->core_sibling_idle_start = 0;
>  
>  	/* install new leader */
>  	for_each_cpu(t, smt_mask) {
> @@ -10071,8 +10072,8 @@ void __init sched_init(void)
>  		rq->core_enabled = 0;
>  		rq->core_tree = RB_ROOT;
>  		rq->core_forceidle_count = 0;
> -		rq->core_forceidle_occupation = 0;
> -		rq->core_forceidle_start = 0;
> +		rq->core_sibling_idle_occupation = 0;
> +		rq->core_sibling_idle_start = 0;
>  
>  		rq->core_cookie = 0UL;
>  #endif
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index a57fd8f27498f..f9aa119b52afd 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -237,38 +237,59 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>  #ifdef CONFIG_SCHEDSTATS
>  
>  /* REQUIRES: rq->core's clock recently updated. */
> -void __sched_core_account_forceidle(struct rq *rq)
> +/*
> + * Account core scheduling idle cost.  Both forceidle (idle sibling has
> + * waiting tasks) and sibling_idle (any idle sibling) are derived from
> + * the same time delta and scaled by their respective idle counts.
> + * A single loop charges both metrics to each running cookied task.
> + */
> +void __sched_core_account_idle(struct rq *rq)
>  {
>  	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
> +	unsigned int occ = rq->core->core_sibling_idle_occupation;
> +	unsigned int fi_count = rq->core->core_forceidle_count;
> +	unsigned int smt_width, idle_count;
>  	u64 delta, now = rq_clock(rq->core);
> +	u64 fi_delta = 0, si_delta = 0;
>  	struct rq *rq_i;
>  	struct task_struct *p;
>  	int i;
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	WARN_ON_ONCE(!rq->core->core_forceidle_count);
> -
> -	if (rq->core->core_forceidle_start == 0)
> +	if (rq->core->core_sibling_idle_start == 0)
>  		return;
>  
> -	delta = now - rq->core->core_forceidle_start;
> +	delta = now - rq->core->core_sibling_idle_start;
>  	if (unlikely((s64)delta <= 0))
>  		return;
>  
> -	rq->core->core_forceidle_start = now;
> +	if (WARN_ON_ONCE(!occ))
> +		return;
>  
> -	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
> -		/* can't be forced idle without a running task */
> -	} else if (rq->core->core_forceidle_count > 1 ||
> -		   rq->core->core_forceidle_occupation > 1) {
> -		/*
> -		 * For larger SMT configurations, we need to scale the charged
> -		 * forced idle amount since there can be more than one forced
> -		 * idle sibling and more than one running cookied task.
> -		 */
> -		delta *= rq->core->core_forceidle_count;
> -		delta = div_u64(delta, rq->core->core_forceidle_occupation);
> +	smt_width = cpumask_weight(smt_mask);
> +	idle_count = smt_width - occ;
> +	if (!idle_count)
> +		return;
> +
> +	rq->core->core_sibling_idle_start = now;
> +
> +	/*
> +	 * For SMT-2 with one idle sibling (the common case), both
> +	 * idle_count and occ are 1, so si_delta == fi_delta == delta
> +	 * with no division needed.  For larger SMT configurations, we
> +	 * scale by the respective idle count / occupation since there
> +	 * can be more than one idle sibling and more than one running
> +	 * cookied task.
> +	 */
> +	si_delta = delta;
> +	if (idle_count > 1 || occ > 1)
> +		si_delta = div_u64(delta * idle_count, occ);
> +
> +	if (fi_count) {
> +		fi_delta = delta;
> +		if (fi_count > 1 || occ > 1)
> +			fi_delta = div_u64(delta * fi_count, occ);
>  	}
>  
>  	for_each_cpu(i, smt_mask) {
> @@ -279,22 +300,24 @@ void __sched_core_account_forceidle(struct rq *rq)
>  			continue;
>  
>  		/*
> -		 * Note: this will account forceidle to the current cpu, even
> -		 * if it comes from our SMT sibling.
> +		 * Note: this will account idle time to the current cpu,
> +		 * even if it comes from our SMT sibling.
>  		 */
> -		__account_forceidle_time(p, delta);
> +		__account_sibling_idle_time(p, si_delta);
> +		if (fi_delta)
> +			__account_forceidle_time(p, fi_delta);
>  	}
>  }
>  
>  void __sched_core_tick(struct rq *rq)
>  {
> -	if (!rq->core->core_forceidle_count)
> +	if (!rq->core->core_sibling_idle_occupation)
>  		return;
>  
>  	if (rq != rq->core)
>  		update_rq_clock(rq->core);
>  
> -	__sched_core_account_forceidle(rq);
> +	__sched_core_account_idle(rq);
>  }
>  
>  #endif /* CONFIG_SCHEDSTATS */
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index b453f8a6a7c76..2a3500323c3c4 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -243,6 +243,18 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
>  
>  	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
>  }
> +
> +/*
> + * Account for sibling idle time due to core scheduling.
> + *
> + * REQUIRES: schedstat is enabled.
> + */
> +void __account_sibling_idle_time(struct task_struct *p, u64 delta)
> +{
> +	__schedstat_add(p->stats.core_sibling_idle_sum, delta);
> +
> +	task_group_account_field(p, CPUTIME_SIBLING_IDLE, delta);
> +}
>  #endif
>  
>  /*
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 115e266db76bf..2c3bf256308dc 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1059,6 +1059,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  
>  #ifdef CONFIG_SCHED_CORE
>  		PN_SCHEDSTAT(core_forceidle_sum);
> +		PN_SCHEDSTAT(core_sibling_idle_sum);
>  #endif
>  	}
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 65ff0254659ac..c52effdb2e172 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1156,8 +1156,13 @@ struct rq {
>  	unsigned long		core_cookie;
>  	unsigned int		core_forceidle_count;
>  	unsigned int		core_forceidle_seq;
> -	unsigned int		core_forceidle_occupation;
> -	u64			core_forceidle_start;
> +	/*
> +	 * Shared start timestamp and occupation for both forceidle and
> +	 * sibling_idle accounting.  Set whenever occupation < SMT width
> +	 * (any sibling is idle), not just when core_forceidle_count > 0.
> +	 */
> +	unsigned int		core_sibling_idle_occupation;
> +	u64			core_sibling_idle_start;
>  #endif
>  
>  	/* Scratch cpumask to be temporarily used under rq_lock */
> @@ -1966,12 +1971,12 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
>  
>  #if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
>  
> -extern void __sched_core_account_forceidle(struct rq *rq);
> +extern void __sched_core_account_idle(struct rq *rq);
>  
> -static inline void sched_core_account_forceidle(struct rq *rq)
> +static inline void sched_core_account_idle(struct rq *rq)
>  {
>  	if (schedstat_enabled())
> -		__sched_core_account_forceidle(rq);
> +		__sched_core_account_idle(rq);
>  }
>  
>  extern void __sched_core_tick(struct rq *rq);
> @@ -1984,7 +1989,7 @@ static inline void sched_core_tick(struct rq *rq)
>  
>  #else
>  
> -static inline void sched_core_account_forceidle(struct rq *rq) {}
> +static inline void sched_core_account_idle(struct rq *rq) {}
>  
>  static inline void sched_core_tick(struct rq *rq) {}
>  


