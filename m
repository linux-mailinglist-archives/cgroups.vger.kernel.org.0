Return-Path: <cgroups+bounces-8068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFCAAE295
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D533526F91
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC47289839;
	Wed,  7 May 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRaVJAQI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AE78F4F;
	Wed,  7 May 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627066; cv=none; b=WcDpqMqevcTzf27uRz8pPGcRY4RcqKZLBNGN76Y4nHwzVR86i5w6lGI4wnR3Z+kVVHNM2YSBH3vqUrqj9cMaFCDg8m8lu8LEWpICqJyYSWZCnX8eFKTvSMZNAeDddYXFa0DPMKtZhbbCym6uNgyUsYBckc7XVvgkIYNbY0tXq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627066; c=relaxed/simple;
	bh=EPtZPdWnf1JqNFcjM9ySpu3634mu6I6XC7Kid0ic0Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWFPQY1eFA1c5P/Ufu+1YhGR3kXQNea+6SqcYKMusn1GCIAdiIyHPNh+pZyYx7IUbm+Zmx1Y8vx1E1AtL/t+EAEjEyurRVbKfTiihxHv0ZZ9cC35RbB8EzkL1knwtu6J334YxajWJ3yMXavBz/T50uerL84WT3H3uAqNcZj89Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRaVJAQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934DC4CEE2;
	Wed,  7 May 2025 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746627065;
	bh=EPtZPdWnf1JqNFcjM9ySpu3634mu6I6XC7Kid0ic0Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRaVJAQI54Mmnlp4Qgi6njmN2yKwk8a/NdTyWMtHpREoUNR0fP/Uh3iZeVFH4L2eG
	 Sy57euXUcExqr6jhACBAy6GTwZJfmbOSXTl349z4UiLYBveRHexnMOB9N7nOYRMEbX
	 4OEkmsLNLM3+MEDmJRSUnKXlYDoSMc//0oDMLtdgg31FMUiZQHglY1QG2a1FY6C1Jg
	 rTSROS5eHvypCpuw0RIkcOvJWS23EGNzvAkwlN6cqAkzDVOdSD09PvB1m78vqtB8dw
	 eL6yAYWAmlmfGZGzMInYfI7UAU30t4S5HruofoK/MI0/HeLHspHg2rLAGB/17Rx4xl
	 ohRQMwQYmPjjg==
Date: Wed, 7 May 2025 16:11:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Xi Wang <xii@google.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Chen Yu <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
Message-ID: <aBtp98E9q37FLeMv@localhost.localdomain>
References: <20250506183533.1917459-1-xii@google.com>
 <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>

Le Tue, May 06, 2025 at 08:43:57PM -0700, Xi Wang a écrit :
> On Tue, May 6, 2025 at 5:17 PM Tejun Heo <tj@kernel.org> wrote:
> For the use cases, there are two major requirements at the moment:
> 
> Dynamic cpu affinity based isolation: CPUs running latency sensitive threads
> (vcpu threads) can change over time. We'd like to configure kernel thread
> affinity at run time too.

I would expect such latency sensitive application to run on isolated
partitions. And those already don't pull unbound kthreads.

> Changing cpu affinity at run time requires cpumask
> calculations and thread migrations. Sharing cpuset code would be nice.

There is already some (recent) affinity management in the kthread subsystem.
A list of kthreads having a preferred affinity (but !PF_NO_SETAFFINITY)
is maintained and automatically handled against hotplug events and housekeeping
state.

> 
> Support numa based memory daemon affinity: We'd like to restrict kernel memory
> daemons but maintain their numa affinity at the same time. cgroup hierarchies
> can be helpful, e.g. create kernel, kernel/node0 and kernel/node1 and move the
> daemons to the right cgroup.

The kthread subsystem also handles node affinity. See kswapd / kcompactd. And it
takes care of that while still honouring isolated / isolcpus partitions:

      d1a89197589c ("kthread: Default affine kthread to its preferred NUMA node")

> 
> Workqueue coverage is optional. kworker threads can use their separate
> mechanisms too.
> 
> Since the goal is isolation, we'd like to restrict as many kthreads as possible,
> even the ones that don't directly interact with user applications.
> 
> The kthreadd case is handled - a new kthread can be forked inside a non root
> cgroup, but based on flags it can move itself to the root cgroup before threadfn
> is called.

kthreadd and other kthreads that don't have a preferred affinity are also
affine outside isolcpus/nohz_full. And since isolated cpuset partitions
create NULL domains, those kthreads won't run there either.

What am I missing?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

