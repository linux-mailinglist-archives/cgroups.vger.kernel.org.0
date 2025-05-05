Return-Path: <cgroups+bounces-8017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD3AA9D8B
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD743A97F1
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212C1F0E24;
	Mon,  5 May 2025 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahAcf858"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D028801
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478199; cv=none; b=tDZDX1Ii15OkyiKDp5+rG51gh38jhI2mLmj8bpQD0qGIpZYNVgd62IOuoy0s5Z5cAIryNVf4Q+mTxo49iv4hT8EnYoeTDxBDH+jiq+5nIaYpTfBJtPrdez6wWBb5AoFgAHIjXjNlOgk6Pfk4oXkSU42y7uHB/rLYgnCF6S8e5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478199; c=relaxed/simple;
	bh=lbYOOzUdlsyvOpHixDp0NGqXVE2yy85/aWguybOWo8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhB4UrfT8phmviiG6o6n/7Id1gv72m+BFfFNDBEjBAuoQF31LJIECJnMPhUXcvfXEsnwUR/s/rfCi7NP6l9NTBJRvgH4U9jb0/elW/iudt7rTX5In69smA441KK6/o1YraHWw/WPq00dLgNs/mygp3bh7ivS4H8EjNnOndIP3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahAcf858; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 13:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746478194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXnskhOWpeWI0e/0mm8lMZ5XqD+oRKL2LPwz4l/PMBI=;
	b=ahAcf858/5Hm3ezeiisZ4WTTLdRS5hJGHpFzbfKMCqqLIuBQj7tciw3L3RZcPfd5PO1gTK
	QWLKGxM8ABZv/l4euaYLcdZIjUPgP2i0nYO7qmvo4IZcAubQH3T6+48kFKU9m3oHGuVZdL
	mmRjo4RYH9HxPCzyMhWBRplB2m/AAzM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
Message-ID: <jilyoryfq7cg6xp4cxbipct5vfbhu7ivp2jmzzigufqd6r5uss@h2cmibfg3fdf>
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev>
 <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
 <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
 <81a2e692-dd10-4253-afbc-062e0be67ca4@suse.cz>
 <ek6ptpggcmnp5kyt37ytriu6d4gj5grpfwcok3rupu5tbjoil3@6cqmoj43bsum>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ek6ptpggcmnp5kyt37ytriu6d4gj5grpfwcok3rupu5tbjoil3@6cqmoj43bsum>
X-Migadu-Flow: FLOW_OUT

On Mon, May 05, 2025 at 10:13:37AM -0700, Shakeel Butt wrote:
> Ccing networking folks.
> 
> Background: https://lore.kernel.org/dvyyqubghf67b3qsuoreegqk4qnuuqfkk7plpfhhrck5yeeuic@xbn4c6c7yc42/
> 
> On Mon, May 05, 2025 at 12:28:43PM +0200, Vlastimil Babka wrote:
> > On 5/3/25 01:03, Shakeel Butt wrote:
> > >> > index cd81c70d144b..f8b9c7aa6771 100644
> > >> > --- a/mm/memcontrol.c
> > >> > +++ b/mm/memcontrol.c
> > >> > @@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> > >> >  {
> > >> >         struct memcg_stock_pcp *stock;
> > >> >         uint8_t stock_pages;
> > >> > -       unsigned long flags;
> > >> >         bool ret = false;
> > >> >         int i;
> > >> >
> > >> > @@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> > >> >                 return ret;
> > >> >
> > >> >         if (gfpflags_allow_spinning(gfp_mask))
> > >> > -               local_lock_irqsave(&memcg_stock.lock, flags);
> > >> > -       else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
> > >> > +               local_lock(&memcg_stock.lock);
> > >> > +       else if (!local_trylock(&memcg_stock.lock))
> > >> >                 return ret;
> > >>
> > >> I don't think it works.
> > >> When there is a normal irq and something doing regular GFP_NOWAIT
> > >> allocation gfpflags_allow_spinning() will be true and
> > >> local_lock() will reenter and complain that lock->acquired is
> > >> already set... but only with lockdep on.
> > > 
> > > Yes indeed. I dropped the first patch and didn't fix this one
> > > accordingly. I think the fix can be as simple as checking for
> > > in_task() here instead of gfp_mask. That should work for both RT and
> > > non-RT kernels.
> > 
> > These in_task() checks seem hacky to me. I think the patch 1 in v1 was the
> > correct way how to use the local_trylock() to avoid these.
> > 
> > As for the RT concerns, AFAIK RT isn't about being fast, but about being
> > preemptible, and the v1 approach didn't violate that - taking the slowpaths
> > more often shouldn't be an issue.
> > 
> > Let me quote Shakeel's scenario from the v1 thread:
> > 
> > > I didn't really think too much about PREEMPT_RT kernels as I assume
> > > performance is not top priority but I think I get your point. Let me
> > 
> > Agreed.
> > 
> > > explain and correct me if I am wrong. On PREEMPT_RT kernel, the local
> > > lock is a spin lock which is actually a mutex but with priority
> > > inheritance. A task having the local lock can still get context switched
> > 
> > Let's say (seems implied already) this is a low prio task.
> > 
> > > (but will remain on same CPU run queue) and the newer task can try to
> > 
> > And this is a high prio task.
> > 
> > > acquire the memcg stock local lock. If we just do trylock, it will
> > > always go to the slow path but if we do local_lock() then it will sleeps
> > > and possibly gives its priority to the task owning the lock and possibly
> > > make that task to get the CPU. Later the task slept on memcg stock lock
> > > will wake up and go through fast path.
> > 
> > I think from RT latency perspective it could very much be better for the
> > high prio task just skip the fast path and go for the slowpath, instead of
> > going to sleep while boosting the low prio task to let the high prio task
> > use the fast path later. It's not really a fast path anymore I'd say.
> 
> Thanks Vlastimil, this is actually a very good point. Slow path of memcg
> charging is couple of atomic operations while the alternative here is at
> least two context switches (and possibly scheduler delay). So, it does
> not seem like a fast path anymore.
> 
> I have cc'ed networking folks to get their take as well. Orthogonally I
> will do some netperf benchmarking on v1 with RT kernel.

Let me share the result with PREEMPT_RT config on next-20250505 with and
without the v1 of this series.

I ran varying number of netperf clients in different cgroups on a 72 CPU
machine.

 $ netserver -6
 $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

number of clients | Without series | With series
  6               | 38559.1 Mbps   | 38652.6 Mbps
  12              | 37388.8 Mbps   | 37560.1 Mbps
  18              | 30707.5 Mbps   | 31378.3 Mbps
  24              | 25908.4 Mbps   | 26423.9 Mbps
  30              | 22347.7 Mbps   | 22326.5 Mbps
  36              | 20235.1 Mbps   | 20165.0 Mbps

I don't see any significant performance difference for the network
intensive workload with this series.

I am going to send out v3 which will be rebased version of v1 with all
these details unless someone has concerns about this.

