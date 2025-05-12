Return-Path: <cgroups+bounces-8145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FCAB44AE
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 21:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75201899DA8
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FA297A51;
	Mon, 12 May 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GEWi9xep"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5A298247
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077181; cv=none; b=btXXqA7Y31LIDojeBtKJEGCBeuTNGBKgz9Y8385MCFvDpSftVW9HDlwAXaf8laQ7IEUJeNnRiIh252mpZvuq1tAlr1cfEB5wV3OUQsw/dZRCo4qaRMXSDF6oAObPR/BlBk2ontRIFNKUTnZLcVXG06qMIk9oKMLGNSKcJ8+JG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077181; c=relaxed/simple;
	bh=x23mxA82De3cXdZgj34aQv76fZozL81umdIXokRJ4MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t79M5u3XOgqAfFtUhM3IIxb0Elc3aHG+KCSKF85y9HZO4IOWHbZ2b30n1b4J7hSyyQJvdfOC1gZRvT/qI6Br8XyyidtnlCfOxYDiXIbqxWHvbmcIkz+JMpCRuLlthEMDNHEgIwq5jgv4bfs5/QtbNu1VNusejIh+e9ej8lkRfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GEWi9xep; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 May 2025 12:12:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747077174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqVwqlZm0Qlg6KxhYJj/U/iuxKDNt6d7QLnu+Tbwxmg=;
	b=GEWi9xepBuUD84Xj6HySZwI1fUdZ1NMcdnQxSfPl28Sz4E2JabYfQWGfYtVKaSfs3gWfd7
	vZzse9fB54pbGKa9+vqFt0R8nEldYEJgJ5Js2BD3+rLgFEvvnPZYyDi4aM+W4h8F978mTp
	R2WWBjsuU51IuooEqJXc7vpYirmx8dM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
X-Migadu-Flow: FLOW_OUT

I forgot to CC Tejun, so doing it now.

On Mon, May 12, 2025 at 05:56:09PM +0200, Vlastimil Babka wrote:
> On 5/10/25 01:28, Shakeel Butt wrote:
> > BPF programs can trigger memcg charged kernel allocations in nmi
> > context. However memcg charging infra for kernel memory is not equipped
> > to handle nmi context. This series adds support for kernel memory
> > charging for nmi context.
> > 
> > The initial prototype tried to make memcg charging infra for kernel
> > memory re-entrant against irq and nmi. However upon realizing that
> > this_cpu_* operations are not safe on all architectures (Tejun), this
> 
> I assume it was an off-list discussion?
> Could we avoid this for the architectures where these are safe, which should
> be the major ones I hope?

Yes it was an off-list discussion. The discussion was more about the
this_cpu_* ops vs atomic_* ops as on x86 this_cpu_* does not have lock
prefix and how I should prefer this_cpu_* over atomic_* for my series on
objcg charging without disabling irqs. Tejun pointed out this_cpu_* are
not nmi safe for some archs and it would be better to handle nmi context
separately. So, I am not that worried about optimizing for NMI context
but your next comment on generic_atomic64_* ops is giving me headache.

> 
> > series took a different approach targeting only nmi context. Since the
> > number of stats that are updated in kernel memory charging path are 3,
> > this series added special handling of those stats in nmi context rather
> > than making all >100 memcg stats nmi safe.
> 
> Hmm so from patches 2 and 3 I see this relies on atomic64_add().
> But AFAIU lib/atomic64.c has the generic fallback implementation for
> architectures that don't know better, and that would be using the "void
> generic_atomic64_##op" macro, which AFAICS is doing:
> 
>         local_irq_save(flags);                                          \
>         arch_spin_lock(lock);                                           \
>         v->counter c_op a;                                              \
>         arch_spin_unlock(lock);                                         \
>         local_irq_restore(flags);                                       \
> 
> so in case of a nmi hitting after the spin_lock this can still deadlock?
> 
> Hm or is there some assumption that we only use these paths when already
> in_nmi() and then another nmi can't come in that context?
> 
> But even then, flush_nmi_stats() in patch 1 isn't done in_nmi() and uses
> atomic64_xchg() which in generic_atomic64_xchg() implementation also has the
> irq_save+spin_lock. So can't we deadlock there?

I was actually assuming that atomic_* ops are safe against nmis for all
archs. I looked at atomic_* ops in include/asm-generic/atomic.h and it
is using arch_cmpxchg() for CONFIG_SMP and it seems like for archs with
cmpxchg should be fine against nmi. I am not sure why atomic64_* are not
using arch_cmpxchg() instead. I will dig more.

I also have the followup series on objcg charging without irq almost
ready. I will send it out as rfc soon.

Thanks a lot for awesome and insightful comments.
Shakeel

