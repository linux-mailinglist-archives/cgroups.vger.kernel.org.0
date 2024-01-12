Return-Path: <cgroups+bounces-1137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD3482C67D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 22:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDE8284869
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E0168D1;
	Fri, 12 Jan 2024 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCSIAizM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D2168C6;
	Fri, 12 Jan 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Jan 2024 12:59:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705093210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AB0MhXLRhT3Dw+J97a9ohvojU5mnHzEbf5k0cXw9MEc=;
	b=jCSIAizMUFXd7/w/grgND+UVmxqA6uuDX+7U0FUaXe3p3HfY6GmGpUXKrUiubSDWFzT2S2
	vSTx3JJxWzQksGIYsAEhP3kGxGh2xolezlaVponVMi7mFgseKDkrQ8SG+EUeGQL0KsRVKz
	3Uvrxq3gVegobcOFauyvFxHH9/ofRXQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <ZaGoSdNpouolFHdT@P9FQF9L96D.corp.robot.car>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
 <CALvZod6eb2uPPW+y=CnB_KumOW-MJjqJK=zOqfzwwJ-JX9eP0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod6eb2uPPW+y=CnB_KumOW-MJjqJK=zOqfzwwJ-JX9eP0g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 12, 2024 at 11:04:06AM -0800, Shakeel Butt wrote:
> On Thu, Jan 11, 2024 at 11:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> [...]
> >
> > From 6124a13cb073f5ff06b9c1309505bc937d65d6e5 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Thu, 11 Jan 2024 07:18:47 -0500
> > Subject: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
> >
> > While investigating hosts with high cgroup memory pressures, Tejun
> > found culprit zombie tasks that had were holding on to a lot of
> > memory, had SIGKILL pending, but were stuck in memory.high reclaim.
> >
> > In the past, we used to always force-charge allocations from tasks
> > that were exiting in order to accelerate them dying and freeing up
> > their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> > prohibit unconditional exceeding the limit of dying tasks"); it noted
> > that this can cause (userspace inducable) containment failures, so it
> > added a mandatory reclaim and OOM kill cycle before forcing charges.
> > At the time, memory.high enforcement was handled in the userspace
> > return path, which isn't reached by dying tasks, and so memory.high
> > was still never enforced by dying tasks.
> >
> > When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
> > overcharges") added synchronous reclaim for memory.high, it added
> > unconditional memory.high enforcement for dying tasks as well. The
> > callstack shows that this path is where the zombie is stuck in.
> >
> > We need to accelerate dying tasks getting past memory.high, but we
> > cannot do it quite the same way as we do for memory.max: memory.max is
> > enforced strictly, and tasks aren't allowed to move past it without
> > FIRST reclaiming and OOM killing if necessary. This ensures very small
> > levels of excess. With memory.high, though, enforcement happens lazily
> > after the charge, and OOM killing is never triggered. A lot of
> > concurrent threads could have pushed, or could actively be pushing,
> > the cgroup into excess. The dying task will enter reclaim on every
> > allocation attempt, with little hope of restoring balance.
> >
> > To fix this, skip synchronous memory.high enforcement on dying tasks
> > altogether again. Update memory.high path documentation while at it.
> >
> > Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>
> 
> I am wondering if you have seen or suspected a similar issue but for
> remote memcg charging. For example pageout on a global reclaim which
> has to allocate buffers for some other memcg.

You mean dying tasks entering a direct reclaim mode?
Or kswapd being stuck in the reclaim path?

