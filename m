Return-Path: <cgroups+bounces-7749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC0A99291
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 17:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4214B7AC27B
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907422BE10C;
	Wed, 23 Apr 2025 15:33:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B98C2BE0F4;
	Wed, 23 Apr 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422389; cv=none; b=KZuXfUs45wR3lYdxGw/HcT/Cnq8Ujf2W8K/PluJTG7d304A5DRVyt49KzCpRjt5ctjOfb306kaUQsXU8knX8j5jjNBHMyYn7TUIXYg3PDnaQ2ysMQamZJ+mbdOWI16KkWveCKjokH4deFMQqYaVaDDI/kCbMlpnGkSeIQu3BjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422389; c=relaxed/simple;
	bh=QGIDE6jHCVvxMU/bZQi+KvAf0v/Q7SkGJgaBWu+WIjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFUX1FfCCl3Rc/Y6IAbKhlNG3CtBNO8XDEESLhXcYjsCPc7OHDthlNsXwtTMkqk+3EbxXtQTGssSYsFslEOXF/OyDvDgDF5L+PDcVYBF610FN/IxBCpGzK2cPH/PuO6lsmPfYK7xELZ6xRAGTO01rU8NAIqtLs9rLwLP68sA6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90DEC4CEE3;
	Wed, 23 Apr 2025 15:33:06 +0000 (UTC)
Date: Wed, 23 Apr 2025 11:34:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, tj@kernel.org,
 akpm@linux-foundation.org, llong@redhat.com, kprateek.nayak@amd.com,
 raghavendra.kt@amd.com, yu.c.chen@intel.com, tim.c.chen@intel.com,
 vineethr@linux.ibm.com, chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
 lorenzo.stoakes@oracle.com, mkoutny@suse.com, Dhaval.Giani@amd.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Message-ID: <20250423113459.0e53be50@gandalf.local.home>
In-Reply-To: <20250417191543.1781862-3-libo.chen@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
	<20250417191543.1781862-3-libo.chen@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 12:15:43 -0700
Libo Chen <libo.chen@oracle.com> wrote:

> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 8994e97d86c13..25ee542fa0063 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -745,6 +745,36 @@ TRACE_EVENT(sched_skip_vma_numa,
>  		  __entry->vm_end,
>  		  __print_symbolic(__entry->reason, NUMAB_SKIP_REASON))
>  );
> +
> +TRACE_EVENT(sched_skip_cpuset_numa,
> +
> +	TP_PROTO(struct task_struct *tsk, nodemask_t *mem_allowed_ptr),
> +
> +	TP_ARGS(tsk, mem_allowed_ptr),
> +
> +	TP_STRUCT__entry(
> +		__array( char,		comm,		TASK_COMM_LEN	)
> +		__field( pid_t,		pid				)
> +		__field( pid_t,		tgid				)
> +		__field( pid_t,		ngid				)
> +		__field( nodemask_t *,	mem_allowed_ptr			)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> +		__entry->pid		 = task_pid_nr(tsk);
> +		__entry->tgid		 = task_tgid_nr(tsk);
> +		__entry->ngid		 = task_numa_group_id(tsk);
> +		__entry->mem_allowed_ptr = mem_allowed_ptr;

This is a bug. You can't save random pointers in the TP_fast_assign() and
reference it later in the TP_printk().

The TP_fast_assign() is executed during the normal kernel workflow when the
tracepoint is triggered. The pointer is saved into the ring buffer.

> +	),
> +
> +	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
> +		  __entry->comm,
> +		  __entry->pid,
> +		  __entry->tgid,
> +		  __entry->ngid,
> +		  nodemask_pr_args(__entry->mem_allowed_ptr))

The TP_printk() is executed when a user reads the /sys/kernel/tracing/trace
file. Which could be literally months later.

The nodemask_pr_args() will dereference the __entry->mem_allowed_ptr from
what was saved in the ring buffer, which the content it points to could
have been freed days ago.

If that happens, then BOOM! Kernel goes bye-bye!

The trace event verifier is made to find bugs like his. And with the recent
update to handle "%*p" it found this bug. ;-)

-- Steve


> +);
>  #endif /* CONFIG_NUMA_BALANCING */

