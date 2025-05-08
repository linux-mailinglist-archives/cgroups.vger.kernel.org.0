Return-Path: <cgroups+bounces-8080-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C41AAEFD6
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 02:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E970503443
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 00:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F64C92;
	Thu,  8 May 2025 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ0KGebR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DDF9C1;
	Thu,  8 May 2025 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746662915; cv=none; b=M02qqBFZMrpNGOj0um8Z5TY1B3VjNv8nYWiVujhU5930kqHDyDtRsbgSBgVBkq5s97iVeel1BK71s0bPC2m+aU0Q8BrKq06NN3YhyHsN6KxA9nYgf/xMYmirEMtyl0ZPC1BBRmHmjBKjYaVrfxwFtMAfXxePSm8ElmZKdmQ7pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746662915; c=relaxed/simple;
	bh=Muk/MzjAwA6106QZ1Bi2pRiDmNZk2l3pcRkfv/NE9NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG9s+vHsv+lLMbzdG8xtr9HePprudhx+RppKUAfNwIjycrpTClHHYOdTyWIaePFrSRjKdaFIvEPQpgJdlYVqXY8dLRQ0e6NN93WJ4YxCdWiElgHzEO0gIWFzb9m19dN2N7lrXPBgvrbcoyzojrSD/pzDTRO/Ype76Drjrcp5ZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ0KGebR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B51AC4CEE2;
	Thu,  8 May 2025 00:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746662915;
	bh=Muk/MzjAwA6106QZ1Bi2pRiDmNZk2l3pcRkfv/NE9NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZ0KGebRspOOXu/KpsHBKhDPnjaP1+yjl977lToMltvNjB2UzblsZpZ7R1DMGkYi5
	 +G4nUX/uiLsV7BSEoxAguyuHDYfeYTFsN0O7COn+tiWI4hSUgNKWwD7vd0ILOXoaaS
	 vjwmTeqA4F3ynm3zA4VaQn7IeC+FHM4bPwR7ZrFaBqE5PrWneR6dJmMw5xTpriANcR
	 OIZQ9lcNGsQmYt/9rewMkT1SOVUXM1QqPHsD5X7odk+IEJ2sJMRACXj9p2/FIvtEVO
	 J1dQqIBWPBRsjKl4FPgqlK8f3odEPRr/es2Dl5UXUuBM8iDQNoEUu2DuzXIAV0+GNM
	 I/LBaXL/ox3EQ==
Date: Thu, 8 May 2025 02:08:32 +0200
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
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Chen Yu <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	jiangshanlai@gmail.com
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
Message-ID: <aBv2AG-VbZ4gcWpi@pavilion.home>
References: <20250506183533.1917459-1-xii@google.com>
 <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain>
 <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
 <aBuaN-xtOMs17ers@slm.duckdns.org>
 <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>

Le Wed, May 07, 2025 at 01:07:16PM -0700, Xi Wang a écrit :
> On Wed, May 7, 2025 at 10:36 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, May 07, 2025 at 10:23:24AM -0700, Xi Wang wrote:
> > > Overall I think your arguments depend on kernel and application threads are
> > > significantly different for cpu affinity management, but there isn't enough
> > > evidence for it. If cpuset is a bad idea for kernel threads it's probably not
> > > a good idea for user threads either. Maybe we should just remove cpuset from
> > > kernel and let applications threads go with boot time global variables and
> > > set their own cpu affinities.
> >
> > I can't tell whether you're making a good faith argument. Even if you are,
> > you're making one bold claim without much substance and then jumping to the
> > other extreme based on that. This isn't a productive way to discuss these
> > things.
> >
> > Thanks.
> >
> > --
> > tejun
> 
> Yes this is still serious technical discussion. Frederic made several "we can't
> have b because we already have / are working on a" statements which were not
> very actionable. Deducing to a particular case is a quick way to simplify.

I referred to a particular case (isolation) because you said this is your
usecase. You still haven't explained us why the current affinity management for
kthreads doesn't work for you.

> I'd prefer to focus more on higher level technical tradeoffs.
> 
> Overall compartmentalization limits resource (cpu) sharing which limits
> overcommit thus efficiency.
> cpumask restrictions are not ideal but sometimes
> necessary. Dynamically configurable cpumasks are better than statically
> reserved cpus.

For which usecase?

> I do think the cgroup tree structure sometimes helps and we don't have to use
> it for all cases.

Also kernel threads are special beasts, even some !PF_NO_SETAFFINTIY kthreads
have actual affinity preferences. If they can go through cpusets, this must be
dealt with. And admins will need to know about those affinity preferences for
each kthreads.

Also do we want to be able to expose all the cgroup limits to kthreads? Even
if only cpusets is allowed to have kthreads, does cpusets.mems make
sense to be exposed for example?

If your issue is ever resolved through cpusets, this will have to be maintained
forever with all those subtleties in mind.

I tend to think that CPU isolation is a very straightforward cpusets usecase:
no load balancing, NULL domains and tasks usually don't compete much for the
CPU since the point is to not be disturbed anyway.

And NULL domains already exclude kernel threads, dynamically. So please give
us a compelling reason for doing this.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

