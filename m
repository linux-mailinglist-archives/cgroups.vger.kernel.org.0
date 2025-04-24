Return-Path: <cgroups+bounces-7775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D12A99C9F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8462D7AED25
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5F17F7;
	Thu, 24 Apr 2025 00:16:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE78625;
	Thu, 24 Apr 2025 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453799; cv=none; b=V1jhDJXWKZhro9KLsS4Gn3jCskm9oBNS5avEO6561ayjR16/dLk4EcTfMDMY4kYI+HiG3qRWnMMRXsxdveIHfc57Y+NdugvlphMV3y5HwMi+VfsH9FSbqXBNqwhjw/y1xngXhNJKb7+lWQL9z6b0BHMW5QuWMSWhxOD39/07x0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453799; c=relaxed/simple;
	bh=IFTrO0iIkqqipDsOems/BeJlcz4nbbFBbkODkt4C7TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZnge4WDxFTf9y9gaaoYT9GNgyWGNBsIniRJkvReqWpkRFsI2KBA1ZvbKNnc4SfUisgIHeRzMzCqDk+6EU5S0gaUrIt00CnsQd3O9pJBdK8Xbwm0VRbtNR2JBKXNbylbW1YrFKsC0jx+U196dKU+WJIlW/KboLy1FWLJNY9mFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D03C4CEE2;
	Thu, 24 Apr 2025 00:16:36 +0000 (UTC)
Date: Wed, 23 Apr 2025 20:18:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mgorman@suse.de,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 tj@kernel.org, llong@redhat.com, sraithal@amd.com, venkat88@linux.ibm.com,
 kprateek.nayak@amd.com, raghavendra.kt@amd.com, yu.c.chen@intel.com,
 tim.c.chen@intel.com, vineethr@linux.ibm.com, chris.hyser@oracle.com,
 daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com, mkoutny@suse.com,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Message-ID: <20250423201829.17d4c382@gandalf.local.home>
In-Reply-To: <20250424000146.1197285-3-libo.chen@oracle.com>
References: <20250424000146.1197285-1-libo.chen@oracle.com>
	<20250424000146.1197285-3-libo.chen@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:01:46 -0700
Libo Chen <libo.chen@oracle.com> wrote:

> +++ b/include/trace/events/sched.h
> @@ -745,6 +745,37 @@ TRACE_EVENT(sched_skip_vma_numa,
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
> +		__array( char,		comm,		TASK_COMM_LEN		)
> +		__field( pid_t,		pid					)
> +		__field( pid_t,		tgid					)
> +		__field( pid_t,		ngid					)
> +		__array( unsigned long, mem_allowed, BITS_TO_LONGS(MAX_NUMNODES))
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> +		__entry->pid		 = task_pid_nr(tsk);
> +		__entry->tgid		 = task_tgid_nr(tsk);
> +		__entry->ngid		 = task_numa_group_id(tsk);
> +		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
> +		       sizeof(__entry->mem_allowed));

Is mem_allowed->bits guaranteed to be the size of BITS_TO_LONGS(MAX_NUM_NODES)
in size? If not, then memcpy will read beyond that size.

-- Steve


> +	),
> +
> +	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
> +		  __entry->comm,
> +		  __entry->pid,
> +		  __entry->tgid,
> +		  __entry->ngid,
> +		  MAX_NUMNODES, __entry->mem_allowed)
> +);

