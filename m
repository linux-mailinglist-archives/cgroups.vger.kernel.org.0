Return-Path: <cgroups+bounces-8073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C00AAE7F1
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 19:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434B0980891
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3A28CF48;
	Wed,  7 May 2025 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5gBcLx/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAA1C84AA;
	Wed,  7 May 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639417; cv=none; b=t0S0dYXut9YhQIfOzBcoFPtelYOUW1XiMSH9dJH7YkOdLOvJ+R8n6gb64aTlELtO+VGz0bOBOUS0WbHlkjmmG56W7TIw12Ga3KqizMBf1QvSCvwsvO/H2vYCGngLOm3nCoZYYgfZMZVi7CIbP26JOQ7x/HOJscAYlxyTVSgPJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639417; c=relaxed/simple;
	bh=cZgHgbEMslEH7d4qnp23P8CWCIcdt5/T8snXdHQXoIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFcFyI67v/2baMh6+UbNa1kUMB5ETskJyUr65POruMmD0sWJaLibSmpEENzCMQt33FkLx50RvhhDiYwC8cOK465zIkmU08rHKpmoIpSIDdnIq0779VEhf1q5230O5AqQ1YdgMVIn43qUt2mmE/MdVrwgd8ldDmqRl8eeCyEiip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5gBcLx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724C9C4CEE9;
	Wed,  7 May 2025 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746639416;
	bh=cZgHgbEMslEH7d4qnp23P8CWCIcdt5/T8snXdHQXoIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5gBcLx/+W4OrIiWZ5mEORzBu+/MwAyuxa6sW1iOveMt1AbVE409oWBLaBe9YFT6L
	 +BJmwOuTwy475nvJMOzU2yOj5Hq6UBEFzSeoP4Ug7AdjqzknAB3YSydz9nlR0xUtIh
	 tPRgayVVB3L/rPkmPej9ZFQRBKHkVp5kyl+FkbcbfKPQcLB21rcVDj4HYs9SaegsFW
	 Dm86+RQGjxIklt//kN0qITbrcCli74syRXK80c2pQIC5N5+n9RMI7EFYas36hWE+ML
	 /XjfNG6TPa23jkpJ8JdWBhEFvqAeb3kffuOw//VVv2rwAtdnAITjB/KmfaO5SiBT7k
	 ctJ0PuZ6PUrnw==
Date: Wed, 7 May 2025 07:36:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Xi Wang <xii@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <aBuaN-xtOMs17ers@slm.duckdns.org>
References: <20250506183533.1917459-1-xii@google.com>
 <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain>
 <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>

Hello,

On Wed, May 07, 2025 at 10:23:24AM -0700, Xi Wang wrote:
> Overall I think your arguments depend on kernel and application threads are
> significantly different for cpu affinity management, but there isn't enough
> evidence for it. If cpuset is a bad idea for kernel threads it's probably not
> a good idea for user threads either. Maybe we should just remove cpuset from
> kernel and let applications threads go with boot time global variables and
> set their own cpu affinities.

I can't tell whether you're making a good faith argument. Even if you are,
you're making one bold claim without much substance and then jumping to the
other extreme based on that. This isn't a productive way to discuss these
things.

Thanks.

-- 
tejun

