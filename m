Return-Path: <cgroups+bounces-10449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A636B9E29A
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 11:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EF3829CF
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729F27B34C;
	Thu, 25 Sep 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tUim3ZmY"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F7279DC0;
	Thu, 25 Sep 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790815; cv=none; b=up88+t3i/44/WFVfbFKr2J5V7MHS2s3wgUTxNTlLMoID7FI1bdpU/kk7O8qf/WEWzJUw526qcAADjKXjjkWPXXnJGiKvlm53V4ms6pBVesZx8PMQvj0hB9kiXPMDQwaiqz1avom2le9ceXd0lgaL1obH10CRfB5wk/bJoF0I3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790815; c=relaxed/simple;
	bh=ZPvO9PTAg+99xp/hHtY7UyWzYlncvEtxZ2NHXB69vJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNHxsXKd9Yjzl1FP1MFlXFuXusmyjjm93qmuD0HXdbCZGRk0RixXPlsMCy0rlOFuDo55OUeY6i7hl+NndWB0NaiLZE8/QVZ7kOOjp5D/QzEoESVJEbfrLYSTgMOifmN/TmLEO8vkB6cx+LqYiptiVIUvcx4YcisXiRfIMb3CK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tUim3ZmY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W5OXsf0oAxdXlt6+7tQCXLnSUInV5Ahdeu+tyrRyD3E=; b=tUim3ZmYG8MqpiekfPvi7zlgsu
	iC9Am7zsIf2nZVW/U5ea4oG6BV8MEjmJ6dycjoFKueuULEgdH7ZVISaEP63rlpxGFYqmcw/hNzGK0
	Aym5m2zFAuSP4i5nnSkwG+6GuBhj6XiSca/1rLdGAkrVrLwfSH8hhfpv4iApEmTv3c9h1dXCWFDTY
	HQYVxIFzkmnBmqptk4npPTNaxsl7EoVmBnEMDheTSK1OXc9pR4j/5N1jp65L15lta6XI+8S29Edm0
	wJ2D7RkOBvnD6XHf7//thAxSuU/aEokBtXAcxVApE7d0XlcwRsml485xSzL2X6BYTKapU1wg3tHmj
	4HEc9oNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1hpZ-00000000WwQ-07dJ;
	Thu, 25 Sep 2025 09:00:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3EB783002BF; Thu, 25 Sep 2025 11:00:01 +0200 (CEST)
Date: Thu, 25 Sep 2025 11:00:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <20250925090001.GX4067720@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <02811bd7-b401-4e16-bb7d-4edeb0b89ffd@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02811bd7-b401-4e16-bb7d-4edeb0b89ffd@arm.com>

On Thu, Sep 18, 2025 at 04:15:45PM +0100, Christian Loehle wrote:

> Hi Peter, A couple of issues popped up when testing this [1] (that don't trigger on [2]):
> 
> When booting (arm64 orion o6) I get:
> 
> [    1.298020] sched: DL replenish lagged too much
> [    1.298364] ------------[ cut here ]------------
> [    1.298377] WARNING: CPU: 4 PID: 0 at kernel/sched/deadline.c:239 inactive_task_timer+0x3d0/0x474

Ah, right. Robot reported this one too. I'll look into it. Could be one
of the patches in sched/urgent cures it, but who knows. I'll have a
poke.

> and when running actual tests (e.g. iterating through all scx schedulers under load):
> 
> [  146.532691] ================================                                                                     
> [  146.536947] WARNING: inconsistent lock state                                                                     
> [  146.541204] 6.17.0-rc4-cix-build+ #58 Tainted: G S      W                                                        
> [  146.547457] --------------------------------                                                                     
> [  146.551713] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.                                                 
> [  146.557705] rcu_tasks_trace/79 [HC0[0]:SC0[0]:HE0:SE1] takes:                                                    
> [  146.563438] ffff000089c90e58 (&dsq->lock){?.-.}-{2:2}, at: __task_rq_lock+0x88/0x194                             

> [  146.840178]                                                                                                      
> [  146.813242]  #0: ffff800082e6e650 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x328/0x570 
> [  146.823403]  #1: ffff800082adc1f0 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c                   
> [  146.832014]  #2: ffff000089c90e58 (&dsq->lock){?.-.}-{2:2}, at: __task_rq_lock+0x88/0x194                        
> 
> [  146.840178] stack backtrace:
> [  146.844521] CPU: 10 UID: 0 PID: 79 Comm: rcu_tasks_trace Tainted: G S      W           6.17.0-rc4-cix-build+ #58 PREEMPT 
> [  146.855463] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [  146.860240] Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Orion O6, BIOS 0.3.0-1 2025-04-28T03:35:34+00:00
> [  146.872136] Sched_ext: simple (enabled+all), task: runnable_at=-4ms
> [  146.872138] Call trace:
> [  146.880822]  show_stack+0x18/0x24 (C)
> [  146.884471]  dump_stack_lvl+0x90/0xd0
> [  146.888131]  dump_stack+0x18/0x24
> [  146.891432]  print_usage_bug.part.0+0x29c/0x364
> [  146.895950]  mark_lock+0x778/0x978
> [  146.899338]  mark_held_locks+0x58/0x90
> [  146.903074]  lockdep_hardirqs_on_prepare+0x100/0x210
> [  146.908025]  trace_hardirqs_on+0x5c/0x1cc
> [  146.912025]  _raw_spin_unlock_irqrestore+0x6c/0x70
> [  146.916803]  task_call_func+0x110/0x164

Ooh, yeah, that's buggered. Let me go fix!

Thanks for testing!

