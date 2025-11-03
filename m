Return-Path: <cgroups+bounces-11541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33798C2E056
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 21:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6596D4E235E
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EB82BDC05;
	Mon,  3 Nov 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NgGiMVsG"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C332BDC34;
	Mon,  3 Nov 2025 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201733; cv=none; b=IIbDgnqwirKfPGNRdHeSzEnAuQE/eM3iQfUMS6BVjfHa2Rrx+EmyWM5MtavCbKCaeZxZMUAmJ5oA/Y/hAlceFdmu0deOVlnWvnzuG/fbApZv3Qv3cRAsbiGQGswkhR/k7P5N0Sg43H3hsItuuaiNMXdy5iLqexaIozZA4iIianc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201733; c=relaxed/simple;
	bh=KwJp28per4NFUtg1u0z/n2acrEg1XmzoRRsZJy8dmXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0kRGR0InaKW6Krvb4yJqMSBr+1t577D6xtpA7ARXPcrKGo/K/q5kNxFCftnBpoTyy50DQ1WWbpHIYoY167/7ZLHdRgaIN/SHqOys+Fr2OTxlxFsWtFU0NK1hoNAyyzoZRK4gyZBXtITrbS92ilc2DfQhco1knrnPJZObyVYey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NgGiMVsG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3MQ6OTcbyhaV8fq49T+ttFC1Ns3fjv3EEaqONZ0Go9E=; b=NgGiMVsGQ81moz8HZCLQBpuLD/
	0+q6rxRBdH40hmaep9xLB0PAD6fplQ4LXaWwWuY6cN9eqOgPYy/QdTHkvmYtm8IyECV+rI0nyUvt3
	FphWQ7ie1EBKL/4pTTcMzbRA8r+jfDHvm6IcnkVdbNuR1YjYcF08gcqlrMirxRXX2L0TPvQs2hCVg
	ElI3v3s+vR8GHKXAl/KPqG0QFPpY5CD/ut8PW6QME86lvLsL+qKQOvHi+0FE0fGhdYtAI3vYvhnUD
	ORRXqlDJcLMS0Y4l2vwsO1iJg32pIqolNFdTiXbzJU41NQ6wc/WJv2vUz6eJdZNSAQORxjNr/J5xI
	eMqIwVvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1AR-0000000HW3n-01wn;
	Mon, 03 Nov 2025 20:28:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2576530029E; Mon, 03 Nov 2025 21:28:43 +0100 (CET)
Date: Mon, 3 Nov 2025 21:28:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <dschatzberg@meta.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 4/4] sched_ext: Fix cgroup exit ordering by moving
 sched_ext_free() to finish_task_switch()
Message-ID: <20251103202843.GF3245006@noisy.programming.kicks-ass.net>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-5-tj@kernel.org>
 <aQkPqUSMr5L0spd8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQkPqUSMr5L0spd8@slm.duckdns.org>

On Mon, Nov 03, 2025 at 10:25:13AM -1000, Tejun Heo wrote:
> sched_ext_free() was called from __put_task_struct() when the last reference
> to the task is dropped, which could be long after the task has finished
> running. This causes cgroup-related problems:
> 
> - ops.init_task() can be called on a cgroup which didn't get ops.cgroup_init()'d
>   during scheduler load, because the cgroup might be destroyed/unlinked
>   while the zombie or dead task is still lingering on the scx_tasks list.
> 
> - ops.cgroup_exit() could be called before ops.exit_task() is called on all
>   member tasks, leading to incorrect exit ordering.
> 
> Fix by moving it to finish_task_switch() to be called right after the final
> context switch away from the dying task, matching when sched_class->task_dead()
> is called. Rename it to sched_ext_dead() to match the new calling context.
> 
> By calling sched_ext_dead() before cgroup_task_dead(), we ensure that:
> 
> - Tasks visible on scx_tasks list have valid cgroups during scheduler load,
>   as cgroup_mutex prevents cgroup destruction while the task is still linked.
> 
> - All member tasks have ops.exit_task() called and are removed from scx_tasks
>   before the cgroup can be destroyed and trigger ops.cgroup_exit().
> 
> This fix is made possible by the cgroup_task_dead() split in the previous patch.
> 
> This also makes more sense resource-wise as there's no point in keeping
> scheduler side resources around for dead tasks.
> 
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> v2: - Description correction and update (Andrea Righi).
> 
>  include/linux/sched/ext.h |    4 ++--
>  kernel/fork.c             |    1 -
>  kernel/sched/core.c       |    6 ++++++
>  kernel/sched/ext.c        |    2 +-
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -207,14 +207,14 @@ struct sched_ext_entity {
>  	struct list_head	tasks_node;
>  };
>  
> -void sched_ext_free(struct task_struct *p);
> +void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
>  bool scx_rcu_cpu_stall(void);
>  
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
>  
> -static inline void sched_ext_free(struct task_struct *p) {}
> +static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
>  static inline bool scx_rcu_cpu_stall(void) { return false; }
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -736,7 +736,6 @@ void __put_task_struct(struct task_struc
>  	WARN_ON(tsk == current);
>  
>  	unwind_task_free(tsk);
> -	sched_ext_free(tsk);
>  	io_uring_free(tsk);
>  	cgroup_task_free(tsk);
>  	task_numa_free(tsk, true);
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5222,6 +5222,12 @@ static struct rq *finish_task_switch(str
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);

^^^ can you not use task_dead_scx() ?

> +		/*
> +		 * sched_ext_dead() must come before cgroup_task_dead() to
> +		 * prevent cgroups from being removed while its member tasks are
> +		 * visible to SCX schedulers.
> +		 */
> +		sched_ext_dead(prev);
>  		cgroup_task_dead(prev);
>  
>  		/* Task is done with its stack. */
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2926,7 +2926,7 @@ void scx_cancel_fork(struct task_struct
>  	percpu_up_read(&scx_fork_rwsem);
>  }
>  
> -void sched_ext_free(struct task_struct *p)
> +void sched_ext_dead(struct task_struct *p)
>  {
>  	unsigned long flags;
>  

