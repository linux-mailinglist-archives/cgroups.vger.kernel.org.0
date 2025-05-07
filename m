Return-Path: <cgroups+bounces-8051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56726AAD217
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 02:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9387B1B6F
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2D79EA;
	Wed,  7 May 2025 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRcjwgGe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3AA94A;
	Wed,  7 May 2025 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577052; cv=none; b=WU1PE9UjTzXrfNNI+0e1kF+M/CY57mK/SU96It3bKBGDoseVzkW1RLMFHfK7I/X166dRE8aiY8WCH+Jl9UjtCdLQvjXCiJE7ps+oScJgMFBU3bK2OqeUflUQFL7SQAiIEixIIfIIX1ih1MZllTzchteycFg4qUHwjWcUu0DSsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577052; c=relaxed/simple;
	bh=MakT+WYmxK41bmc2ErA6nAOXCn5sVq4HGRU81gTqA6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzIR0gtQTi5lMRusidWoDN7c0ASyMiUVCnpM9SmZ7796+AcOwMyw9Aj39xOBkr6mKKSpeylhiSeb4p8OoMap4ciqXvTFalz7+k6P8GsZjaL3wkCnEOL5WpRsHUE1w0cIX48csgXMdGUJZe4UCUUO/D+i/tery+HwZvPyS68nyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRcjwgGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F276C4CEEE;
	Wed,  7 May 2025 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746577051;
	bh=MakT+WYmxK41bmc2ErA6nAOXCn5sVq4HGRU81gTqA6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRcjwgGebtyFUZ46LrW76G6InKntPpJqUapu6xKxZnjpIlLUnoxiDLKvkCDX9gFnd
	 hUFYdKHCM0h9+nvZZOgQfb7HymIig7Rk6+ICXiBBgHHXtJg9UzNL9kbaTR70TYs2bn
	 wUzFlp1omC49+s635X2G28BMVp8sYqsaeWOQ5hJE1UvFlT5Z9mpcSE5i1f4QHDYa1t
	 JODxovu/KhYHQYW8to0sJM8Qu1PL9vaHEJ7D+L0fdg9D2C4OpU3Pw3qjKCbbsYseoq
	 mN7VcugPNARcIQAnhVEJ7Smlssnrncl+Ol5ViPKxxR6h1pF4806J1gkRHtrUDaupkP
	 9uAYJZOd/BV0g==
Date: Tue, 6 May 2025 14:17:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Lai Jiangshan <jiangshanlai@gmail.com1>,
	Frederic Weisbecker <frederic@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Chen Yu <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
Message-ID: <aBqmmtST-_9oM9rF@slm.duckdns.org>
References: <20250506183533.1917459-1-xii@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506183533.1917459-1-xii@google.com>

Hello,

On Tue, May 06, 2025 at 11:35:32AM -0700, Xi Wang wrote:
> In theory we should be able to manage kernel tasks with cpuset
> cgroups just like user tasks, would be a flexible way to limit
> interferences to real-time and other sensitive workloads. This is
> however not supported today: When setting cpu affinity for kthreads,
> kernel code uses a simpler control path that directly lead to
> __set_cpus_allowed_ptr or __ktread_bind_mask. Neither honors cpuset
> restrictions.
> 
> This patch adds cpuset support for kernel tasks by merging userspace
> and kernel cpu affinity control paths and applying the same
> restrictions to kthreads.
> 
> The PF_NO_SETAFFINITY flag is still supported for tasks that have to
> run with certain cpu affinities. Kernel ensures kthreads with this
> flag have their affinities locked and they stay in the root cpuset:
> 
> If userspace moves kthreadd out of the root cpuset (see example
> below), a newly forked kthread will be in a non root cgroup as well.
> If PF_NO_SETAFFINITY is detected for the kthread, it will move itself
> into the root cpuset before the threadfn is called. This does depend
> on the kthread create -> kthread bind -> wake up sequence.

Can you describe the use cases in detail? This is not in line with the
overall direction. e.g. We're making cpuset work with housekeeping mechanism
and tell workqueue which CPUs can be used for unbound execution and kthreads
which are closely tied to userspace activities are spawned into the same
cgroups as the user thread and subject to usual resource control.

There are a lot of risks in subjecting arbitrary kthreads to all cgroup
resource controls and just allowing cpuset doesn't seem like a great idea.
Integration through housekeeping makes a lot more sense to me. Note that
even for just cpuset thread level control doesn't really work that well. All
kthreads are forked by kthreadd. If you move the kthreadd into a cgroup, all
kthreads includling kworkers for all workqueues will be spawned there. The
granularity of control isn't much better than going through housekeeping.

Thanks.

-- 
tejun

