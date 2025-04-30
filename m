Return-Path: <cgroups+bounces-7955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32DAA4D2E
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9843A9A7A
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A1259C8A;
	Wed, 30 Apr 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K26iuG03"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1F1E5B8A
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018895; cv=none; b=B9JP2q3zMkWPdfuk6p8hk1uT23+3zsCDX4muDjOpoc/8vCxuFiUBaFfu+J3SQiioAek/GBDbVbuhRjn0GDlW6uYEhCvGjuLxyo2Uv0g1hngvvoGLQv/61XnqGOY22//hgoFvzF/RHVDlTL3sMhCpN+4rxohrdtRMQrmFMRZbk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018895; c=relaxed/simple;
	bh=5wz2Fr6vpIAmaGJzTU+u+b3SwuPFbTAoUYEIddss4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhnjygyX9IPtBdKaI/aImPUOGWcOTXRtRtCuwirObgc1gUNMrnpuEU96KalAldCR7liKANOSeRGDYsY2wtsxEw04Li3vmtO82nIwATkHX2MMpgDfbDDOU/4jD+Z5ss7lljxTCImEZcgYT+Fp+dUHfoDp0uv7mzqKqtrrlsZ0zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K26iuG03; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 06:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746018880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGXCoPebQpBN7d9KiYFtD7+T3Ar2fmtuRlVtn6J5UqE=;
	b=K26iuG03G/2tOpBPupr8ClbpU5zNWopJDq0PAhEgaELU8dRYdMheVhHr6NTj1zdc3qyIW0
	6rtFGC0gP0CaewrqmmHxLZvu9x/hPZ+fXqT21/8EomGkxlSBaN4dsJJVWvbcoM+QQebbgN
	KxD9MnRiaZiCYAx9FLSjMwzDl0VlE3w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <aBIiNMXIl6vyaNQ6@Asmaa.>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
 <20250429061211.1295443-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429061211.1295443-4-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 28, 2025 at 11:12:09PM -0700, Shakeel Butt wrote:
> To make css_rstat_updated() able to safely run in nmi context, it can
> not spin on locks and rather has to do trylock on the per-cpu per-ss raw
> spinlock. This patch implements the backlog mechanism to handle the
> failure in acquiring the per-cpu per-ss raw spinlock.
> 
> Each subsystem provides a per-cpu lockless list on which the kernel
> stores the css given to css_rstat_updated() on trylock failure. These
> lockless lists serve as backlog. On cgroup stats flushing code path, the
> kernel first processes all the per-cpu lockless backlog lists of the
> given ss and then proceeds to flush the update stat trees.
> 
> With css_rstat_updated() being nmi safe, the memch stats can and will be
> converted to be nmi safe to enable nmi safe mem charging.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  kernel/cgroup/rstat.c | 99 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 76 insertions(+), 23 deletions(-)
> 
[..]
> @@ -153,6 +160,51 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>  
>  		css = parent;
>  	}
> +}
> +
> +static void css_process_backlog(struct cgroup_subsys *ss, int cpu)
> +{
> +	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
> +	struct llist_node *lnode;
> +
> +	while ((lnode = llist_del_first_init(lhead))) {
> +		struct css_rstat_cpu *rstatc;
> +
> +		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
> +		__css_rstat_updated(rstatc->owner, cpu);
> +	}
> +}
> +
> +/**
> + * css_rstat_updated - keep track of updated rstat_cpu
> + * @css: target cgroup subsystem state
> + * @cpu: cpu on which rstat_cpu was updated
> + *
> + * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
> + * rstat_cpu->updated_children list. See the comment on top of
> + * css_rstat_cpu definition for details.
> + */
> +__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
> +{
> +	unsigned long flags;
> +
> +	/*
> +	 * Speculative already-on-list test. This may race leading to
> +	 * temporary inaccuracies, which is fine.
> +	 *
> +	 * Because @parent's updated_children is terminated with @parent
> +	 * instead of NULL, we can tell whether @css is on the list by
> +	 * testing the next pointer for NULL.
> +	 */
> +	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
> +		return;
> +
> +	if (!_css_rstat_cpu_trylock(css, cpu, &flags)) {


IIUC this trylock will only fail if a BPF program runs in NMI context
and tries to update cgroup stats, interrupting a context that is already
holding the lock (i.e. updating or flushing stats).

How often does this happen in practice tho? Is it worth the complexity?

I wonder if it's better if we make css_rstat_updated() inherently
lockless instead.

What if css_rstat_updated() always just adds to a lockless tree, and we
defer constructing the proper tree to the flushing side? This should
make updates generally faster and avoids locking or disabling interrupts
in the fast path. We essentially push more work to the flushing side.

We may be able to consolidate some of the code too if all the logic
manipulating the tree is on the flushing side.

WDYT? Am I missing something here?

> +		css_add_to_backlog(css, cpu);
> +		return;
> +	}
> +
> +	__css_rstat_updated(css, cpu);
>  
>  	_css_rstat_cpu_unlock(css, cpu, flags, true);
>  }
> @@ -255,6 +307,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
>  
>  	flags = _css_rstat_cpu_lock(root, cpu, false);
>  
> +	css_process_backlog(root->ss, cpu);
>  	/* Return NULL if this subtree is not on-list */
>  	if (!rstatc->updated_next)
>  		goto unlock_ret;
> -- 
> 2.47.1
> 

