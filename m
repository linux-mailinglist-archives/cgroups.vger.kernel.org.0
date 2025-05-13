Return-Path: <cgroups+bounces-8170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358CFAB5C13
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8E11B47670
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E582BE0E7;
	Tue, 13 May 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NK5qxc+N"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E72BEC2B
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159791; cv=none; b=kmBervfMUYoUFhubIPG0gvTNiKmk1I/nO8e2v9SwwBYg9+dEc0GpEJ9xAwdDAyHS5VipPbNLniW1Zhqzqbx8vmNvqz+H9J95vDiB5qSQCgs8OcnEVIaz1qwgr2m21tRZXvdcY/dfb91q8Gjohyn/HOZ9ctlsv2XpAvAX3nnOOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159791; c=relaxed/simple;
	bh=uiNLVpjjVEPJ514Y0QpySaJKz1m3PBF6s0hrPIFPLHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkYqfQN2rihTkbmkBGVYq0vA7khHYXHn9LLHwZ/0UZlh7vA/JhQWHPYnfMc0RcltKMeFQtpc/wGBeAyS5jUdPERq6OdZRqMMgf3/V8nd+Ew6dCzLD1JrfkMThDJ2VCwshG+uIc2mgv/BY+YaJhPfCVMjuG47QfUjyVr52xKOqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NK5qxc+N; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 May 2025 11:09:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747159777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vv+FYo0F71tS4hoW14bBVNzWUW6bVJMvqDmpJmWU8uw=;
	b=NK5qxc+N9KbpV7A9sskYymD/Y/qFYeyIOYkIqp8eVhxVMCF9CP++QsCUmcFROxS9kCjx4y
	peu0FilNvu3/3rvrw2CaQ/hX/vq5L3hC191u+jSXPgAFJiYaz0WCeS/mzfI6yHxRTd59mS
	idEKvwVvwgQuqhmEw5NNq35UhpGTmYk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Message-ID: <besg7pkhxa35fskaqcte2cplnkvr4nfpfivp6emc37ghkmdlmt@sdmuejz5u63d>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
 <20250513031316.2147548-2-shakeel.butt@linux.dev>
 <fbcc9892-838c-4156-8ece-94793c00a1c6@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcc9892-838c-4156-8ece-94793c00a1c6@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 12:22:28PM +0200, Vlastimil Babka wrote:
> On 5/13/25 05:13, Shakeel Butt wrote:
> > The function memcg_rstat_updated() is used to track the memcg stats
> > updates for optimizing the flushes. At the moment, it is not re-entrant
> > safe and the callers disabled irqs before calling. However to achieve
> > the goal of updating memcg stats without irqs, memcg_rstat_updated()
> > needs to be re-entrant safe against irqs.
> > 
> > This patch makes memcg_rstat_updated() re-entrant safe against irqs.
> > However it is using atomic_* ops which on x86, adds lock prefix to the
> > instructions. Since this is per-cpu data, the this_cpu_* ops are
> > preferred. However the percpu pointer is stored in struct mem_cgroup and
> > doing the upward traversal through struct mem_cgroup may cause two cache
> > misses as compared to traversing through struct memcg_vmstats_percpu
> > pointer.
> > 
> > NOTE: explore if there is atomic_* ops alternative without lock prefix.
> 
> local_t might be what you want here
> https://docs.kernel.org/core-api/local_ops.html
> 
> Or maybe just add __percpu to parent like this?
> 
> struct memcg_vmstats_percpu {
> ...
>         struct memcg_vmstats_percpu __percpu *parent;
> ...
> }
> 
> Yes, it means on each cpu's struct memcg_vmstats_percpu instance there will
> be actually the same value stored (the percpu offset) instead of the
> cpu-specific parent pointer, which might seem wasteful. But AFAIK this_cpu_*
> is optimized enough thanks to the segment register usage, that it doesn't
> matter? It shouldn't cause any extra cache miss you worry about, IIUC?
> 
> With that I think you could refactor that code to use e.g.
> this_cpu_add_return() and this_cpu_xchg() on the stats_updates and obtain
> the parent "pointer" in a way that's also compatible with these operations.
> 

Thanks, I will try both of these and see which one looks better.

> That is unless we want also nmi safety, then we're back to the issue of the
> previous series...

Nah just irq safety for now and thanks a lot of quick feedback and
review.

