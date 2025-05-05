Return-Path: <cgroups+bounces-8010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E30AA9A35
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04277A19B5
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EC2690ED;
	Mon,  5 May 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RVkChGu3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437725D20E
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465245; cv=none; b=JN+nwIh7laOIzDndWxHXUGKorSQXQA29bc8SsXJAH+govuZqcc5Ffk6xk7n7GHetJ/B1ms/5mzVsWjhd7xiYna96MuZvmC+xmApgAvEX6JCz6PvhaF7ylQ90uvVKcal0BjNa0e6josVnUacq+JeWCe3DUxJiTQO0QqnuT28Yl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465245; c=relaxed/simple;
	bh=y3a34D/WISysEXLW2dRH40jIrBVqXYZwMPGPzgPMSn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWQ8LwPgyTfM3AzKCAXXAInnWyQrOY0ab3j6I55ZzjpTICBWLiglR3WKv69jUqjZCv65FuCWZjn6ubJf2Ez7FXSbYi28dA+UDXRp8VEpKgvAFhHAamM+TwE6m8UPQkcQn5PnykqqRH4UOxr/Om71gc0OlLaEBib5UBEp6aIg7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RVkChGu3; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 10:13:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746465240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E24kJ44em7O2f1doQqPbEivgystWHS55cv/k6/FiNHU=;
	b=RVkChGu3assQs6W1YgJ8JLKqafWbJ8czNHoU+CkVNLUBbODpPY6e+XqelKnVrzU9BU8iij
	LcYaVyHMe0FBpZqEyrwYQKb/sUb4+kIZWP7lE+CQ4uO1QgwSmemHaFdI5YcujOlenDLHZX
	AZbpHvkoU4tK17yCZRuDSP3iNMC9Vhw=
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
Message-ID: <ek6ptpggcmnp5kyt37ytriu6d4gj5grpfwcok3rupu5tbjoil3@6cqmoj43bsum>
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev>
 <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
 <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
 <81a2e692-dd10-4253-afbc-062e0be67ca4@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a2e692-dd10-4253-afbc-062e0be67ca4@suse.cz>
X-Migadu-Flow: FLOW_OUT

Ccing networking folks.

Background: https://lore.kernel.org/dvyyqubghf67b3qsuoreegqk4qnuuqfkk7plpfhhrck5yeeuic@xbn4c6c7yc42/

On Mon, May 05, 2025 at 12:28:43PM +0200, Vlastimil Babka wrote:
> On 5/3/25 01:03, Shakeel Butt wrote:
> >> > index cd81c70d144b..f8b9c7aa6771 100644
> >> > --- a/mm/memcontrol.c
> >> > +++ b/mm/memcontrol.c
> >> > @@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> >> >  {
> >> >         struct memcg_stock_pcp *stock;
> >> >         uint8_t stock_pages;
> >> > -       unsigned long flags;
> >> >         bool ret = false;
> >> >         int i;
> >> >
> >> > @@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> >> >                 return ret;
> >> >
> >> >         if (gfpflags_allow_spinning(gfp_mask))
> >> > -               local_lock_irqsave(&memcg_stock.lock, flags);
> >> > -       else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
> >> > +               local_lock(&memcg_stock.lock);
> >> > +       else if (!local_trylock(&memcg_stock.lock))
> >> >                 return ret;
> >>
> >> I don't think it works.
> >> When there is a normal irq and something doing regular GFP_NOWAIT
> >> allocation gfpflags_allow_spinning() will be true and
> >> local_lock() will reenter and complain that lock->acquired is
> >> already set... but only with lockdep on.
> > 
> > Yes indeed. I dropped the first patch and didn't fix this one
> > accordingly. I think the fix can be as simple as checking for
> > in_task() here instead of gfp_mask. That should work for both RT and
> > non-RT kernels.
> 
> These in_task() checks seem hacky to me. I think the patch 1 in v1 was the
> correct way how to use the local_trylock() to avoid these.
> 
> As for the RT concerns, AFAIK RT isn't about being fast, but about being
> preemptible, and the v1 approach didn't violate that - taking the slowpaths
> more often shouldn't be an issue.
> 
> Let me quote Shakeel's scenario from the v1 thread:
> 
> > I didn't really think too much about PREEMPT_RT kernels as I assume
> > performance is not top priority but I think I get your point. Let me
> 
> Agreed.
> 
> > explain and correct me if I am wrong. On PREEMPT_RT kernel, the local
> > lock is a spin lock which is actually a mutex but with priority
> > inheritance. A task having the local lock can still get context switched
> 
> Let's say (seems implied already) this is a low prio task.
> 
> > (but will remain on same CPU run queue) and the newer task can try to
> 
> And this is a high prio task.
> 
> > acquire the memcg stock local lock. If we just do trylock, it will
> > always go to the slow path but if we do local_lock() then it will sleeps
> > and possibly gives its priority to the task owning the lock and possibly
> > make that task to get the CPU. Later the task slept on memcg stock lock
> > will wake up and go through fast path.
> 
> I think from RT latency perspective it could very much be better for the
> high prio task just skip the fast path and go for the slowpath, instead of
> going to sleep while boosting the low prio task to let the high prio task
> use the fast path later. It's not really a fast path anymore I'd say.

Thanks Vlastimil, this is actually a very good point. Slow path of memcg
charging is couple of atomic operations while the alternative here is at
least two context switches (and possibly scheduler delay). So, it does
not seem like a fast path anymore.

I have cc'ed networking folks to get their take as well. Orthogonally I
will do some netperf benchmarking on v1 with RT kernel.

