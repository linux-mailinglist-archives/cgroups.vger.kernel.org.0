Return-Path: <cgroups+bounces-7960-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D014AA4FC4
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA34D4E17F5
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747819F487;
	Wed, 30 Apr 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LFQKKNP+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBE1B6CE0
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025539; cv=none; b=ABzOLMnhi0oMAtxGNAk90Mo+eHWUeoMAPP2/TPq369ohB2uvnh8QJr7uMiQQHjdo0PK6dwxRf6cQuzrEJBUytXDKPpBbjcJHd+hsx3n+8L4RLbRqp110CAiHWcqZbsbHdcSFJHbKe9SLKK11bKRYb4hLFJsWTq8OkwbnJDJB7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025539; c=relaxed/simple;
	bh=/Y8Xcw4X9LJX/QnqM3TAw0gkwR279WtZkcGhFdVGfDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuK9EsgiuBrPZ14dN1iFMmXN0fPjQxGWkMTLpLBfuYLRmag52/VCv1MnNlp/UZqhS/yzAlfwt+2qGoN4zvRvR+TNNyuyMBduJPqEuVe0IkSgLr9TZA8hqdmraxy+nXXAQ+OiiY7mEFknsv7qYsC2x8ZwlYGvd19sdrXiLkqNXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LFQKKNP+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 08:05:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746025534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpIQNCU7S/pOp1j7VaB6fj72/ADMB01oQnJ2fNfA0oQ=;
	b=LFQKKNP+gwd7xNP/gx4JfwFegBctJsu/O3SYGudvRa2cQmE64BDj7Wo5WP2MZnB7AOHCn/
	ZnNdly5JqjBnyqgalB9AFwfkB0223ycyy8tekHGM4NRGkoFIzAly5VyhlylxcRf0pQTOlV
	VmbZuN2yvrekUUTFXDMnlg/PhSCfo6U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <f4uoxrjr4xer3w4mgwpxypdfdopynwqi4mwc6yskvotbd4ty2f@y4bqddqxoamw>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <f3e0c710-0815-44ad-844c-0e8a079bf663@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e0c710-0815-44ad-844c-0e8a079bf663@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 11:57:13AM +0200, Vlastimil Babka wrote:
> On 4/16/25 20:02, Shakeel Butt wrote:
> > Memory cgroup accounting is expensive and to reduce the cost, the kernel
> > maintains per-cpu charge cache for a single memcg. So, if a charge
> > request comes for a different memcg, the kernel will flush the old
> > memcg's charge cache and then charge the newer memcg a fixed amount (64
> > pages), subtracts the charge request amount and stores the remaining in
> > the per-cpu charge cache for the newer memcg.
> > 
> > This mechanism is based on the assumption that the kernel, for locality,
> > keep a process on a CPU for long period of time and most of the charge
> > requests from that process will be served by that CPU's local charge
> > cache.
> > 
> > However this assumption breaks down for incoming network traffic in a
> > multi-tenant machine. We are in the process of running multiple
> > workloads on a single machine and if such workloads are network heavy,
> > we are seeing very high network memory accounting cost. We have observed
> > multiple CPUs spending almost 100% of their time in net_rx_action and
> > almost all of that time is spent in memcg accounting of the network
> > traffic.
> > 
> > More precisely, net_rx_action is serving packets from multiple workloads
> > and is observing/serving mix of packets of these workloads. The memcg
> > switch of per-cpu cache is very expensive and we are observing a lot of
> > memcg switches on the machine. Almost all the time is being spent on
> > charging new memcg and flushing older memcg cache. So, definitely we
> > need per-cpu cache that support multiple memcgs for this scenario.
> > 
> > This patch implements a simple (and dumb) multiple memcg percpu charge
> > cache. Actually we started with more sophisticated LRU based approach but
> > the dumb one was always better than the sophisticated one by 1% to 3%,
> > so going with the simple approach.
> > 
> > Some of the design choices are:
> > 
> > 1. Fit all caches memcgs in a single cacheline.
> > 2. The cache array can be mix of empty slots or memcg charged slots, so
> >    the kernel has to traverse the full array.
> > 3. The cache drain from the reclaim will drain all cached memcgs to keep
> >    things simple.
> > 
> > To evaluate the impact of this optimization, on a 72 CPUs machine, we
> > ran the following workload where each netperf client runs in a different
> > cgroup. The next-20250415 kernel is used as base.
> > 
> >  $ netserver -6
> >  $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> > 
> > number of clients | Without patch | With patch
> >   6               | 42584.1 Mbps  | 48603.4 Mbps (14.13% improvement)
> >   12              | 30617.1 Mbps  | 47919.7 Mbps (56.51% improvement)
> >   18              | 25305.2 Mbps  | 45497.3 Mbps (79.79% improvement)
> >   24              | 20104.1 Mbps  | 37907.7 Mbps (88.55% improvement)
> >   30              | 14702.4 Mbps  | 30746.5 Mbps (109.12% improvement)
> >   36              | 10801.5 Mbps  | 26476.3 Mbps (145.11% improvement)
> > 
> > The results show drastic improvement for network intensive workloads.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> See below
> 
> > ---
> >  mm/memcontrol.c | 128 ++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 91 insertions(+), 37 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1ad326e871c1..0a02ba07561e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1769,10 +1769,11 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
> >  	pr_cont(" are going to be killed due to memory.oom.group set\n");
> >  }
> >  
> > +#define NR_MEMCG_STOCK 7
> >  struct memcg_stock_pcp {
> >  	local_trylock_t stock_lock;
> > -	struct mem_cgroup *cached; /* this never be root cgroup */
> > -	unsigned int nr_pages;
> > +	uint8_t nr_pages[NR_MEMCG_STOCK];
> > +	struct mem_cgroup *cached[NR_MEMCG_STOCK];
> 
> I have noticed memcg_stock is a DEFINE_PER_CPU and not
> DEFINE_PER_CPU_ALIGNED so I think that the intended cacheline usage isn't
> guaranteed now.
> 
> Actually tried compiling and got in objdump -t vmlinux:
> 
> ffffffff83a26e60 l     O .data..percpu  0000000000000088 memcg_stock
> 
> AFAICS that's aligned to 32 bytes only (0x60 is 96) bytes, not 64.
> 
> changing to _ALIGNED gives me:
> 
> ffffffff83a2c5c0 l     O .data..percpu  0000000000000088 memcg_stock
> 
> 0xc0 is 192 so multiple of 64, so seems to work as intended and indeed
> necessary. So you should change it too while adding the comment.
> 

Wow I didn't notice this at all. Thanks a lot. I will fix this in the
next fix diff.

