Return-Path: <cgroups+bounces-6750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C01A4A262
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 20:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076A5189A7AE
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5F1F09A2;
	Fri, 28 Feb 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UMLnaGOu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61511F8743
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769486; cv=none; b=ngwgefGU80KvsC99XwRR8++FN7e6AGU74CRWXcenq0QJ73qbZi4w22dbPsX0OFjhZRIuJU6CYMnp2zjMxHZ43UMd4ck/6VwT/HmoA+7qu3Ba10Q8qUGjX1V7kIO2ZWfjyLwUw3KkT6S88Yhc83+6JXwHb+DFJVPCaYHA0lrdD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769486; c=relaxed/simple;
	bh=rF65UpvkFrTK18kYQr44FCKkPQK75A02IX2G1n2HixI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMW3XjQi60Bz3dLF/V9pwzki8xR7fr4tcNuC/T05NEu988pU7GrQ43mGO1aRVKjvq3ZOg1EmC3aDaHf1GlRTKgRWarwUgvdJkwXuPIQoowt/ol2Dwiv6v8Iz0ukqALvO7QGTSi7cMAZNyanZL4qWmevn377VptS1od88YM3DBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UMLnaGOu; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 19:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740769482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUoDXTNpMhUllcwII7ASYWMxp1W5rvEw1o/euNXhFvk=;
	b=UMLnaGOufHW2t9TCLQ7Uujtem/w0EipDTVwUlF6w8zUz34cLvZLa3FyJ7oQf21Fy75YZEd
	gBEOUDBqj8votVKeejBpflSyHbUF8fw/sNQcDFsFb7xQ+FLe1Dr8uweLmfTVLxiEQN+/g1
	BiP+swD13BBQEaenUpa8u5wStxxP2HU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <Z8IIxUdRpqxZyIHO@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:55:40PM -0800, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Each cgroup owns rstat pointers. This means that a tree of pending rstat
> updates can contain changes from different subsystems. Because of this
> arrangement, when one subsystem is flushed via the public api
> cgroup_rstat_flushed(), all other subsystems with pending updates will
> also be flushed. Remove the rstat pointers from the cgroup and instead
> give them to each cgroup_subsys_state. Separate rstat trees will now
> exist for each unique subsystem. This separation allows for subsystems
> to make updates and flushes without the side effects of other
> subsystems. i.e. flushing the cpu stats does not cause the memory stats
> to be flushed and vice versa. The change in pointer ownership from
> cgroup to cgroup_subsys_state allows for direct flushing of the css, so
> the rcu list management entities and operations previously tied to the
> cgroup which were used for managing a list of subsystem states with
> pending flushes are removed. In terms of client code, public api calls
> were changed to now accept a reference to the cgroup_subsys_state so
> that when flushing or updating, a specific subsystem is associated with
> the call.

I think the subject is misleading. It makes it seem like this is a
refactoring patch that is only moving a member from one struct to
another, but this is actually the core of the series.

Maybe something lik "cgroup: use separate rstat trees for diffrent
subsystems"?

Also, breaking down the commit message into paragraphs helps with
readability.

[..]
> @@ -386,8 +394,8 @@ struct cgroup_rstat_cpu {
>  	 *
>  	 * Protected by per-cpu cgroup_rstat_cpu_lock.
>  	 */
> -	struct cgroup *updated_children;	/* terminated by self cgroup */
> -	struct cgroup *updated_next;		/* NULL iff not on the list */
> +	struct cgroup_subsys_state *updated_children;	/* terminated by self */
> +	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */

nit: comment indentation needs fixing here

>  };
>  
>  struct cgroup_freezer_state {
[..]  
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index afc665b7b1fe..31b3bfebf7ba 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -164,7 +164,9 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
>  static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);

Should we rename cgrp_dfl_root_rstat_cpu to indicate that it's specific
to self css?

>  
>  /* the default hierarchy */
> -struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
> +struct cgroup_root cgrp_dfl_root = {
> +	.cgrp.self.rstat_cpu = &cgrp_dfl_root_rstat_cpu
> +};
>  EXPORT_SYMBOL_GPL(cgrp_dfl_root);
>  
>  /*
[..]
> @@ -5407,7 +5401,11 @@ static void css_free_rwork_fn(struct work_struct *work)
>  		struct cgroup_subsys_state *parent = css->parent;
>  		int id = css->id;
>  
> +		if (css->ss->css_rstat_flush)
> +			cgroup_rstat_exit(css);
> +
>  		ss->css_free(css);
> +

nit: extra blank line here

>  		cgroup_idr_remove(&ss->css_idr, id);
>  		cgroup_put(cgrp);
>  
> @@ -5431,7 +5429,7 @@ static void css_free_rwork_fn(struct work_struct *work)
>  			cgroup_put(cgroup_parent(cgrp));
>  			kernfs_put(cgrp->kn);
>  			psi_cgroup_free(cgrp);
> -			cgroup_rstat_exit(cgrp);
> +			cgroup_rstat_exit(&cgrp->self);
>  			kfree(cgrp);
>  		} else {
>  			/*
> @@ -5459,11 +5457,7 @@ static void css_release_work_fn(struct work_struct *work)
>  	if (ss) {
>  		struct cgroup *parent_cgrp;
>  
> -		/* css release path */
> -		if (!list_empty(&css->rstat_css_node)) {
> -			cgroup_rstat_flush(cgrp);
> -			list_del_rcu(&css->rstat_css_node);
> -		}
> +		cgroup_rstat_flush(css);

Here we used to call cgroup_rstat_flush() only if there was a
css_rstat_flush() callback registered, now we call it unconditionally.

Could this cause a NULL dereference when we try to call
css->ss->css_rstat_flush() for controllers that did not register a
callback?

>  
>  		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>  		if (ss->css_released)
[..]
> @@ -6188,6 +6186,9 @@ int __init cgroup_init(void)
>  			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
>  						   GFP_KERNEL);
>  			BUG_ON(css->id < 0);
> +
> +			if (css->ss && css->ss->css_rstat_flush)
> +				BUG_ON(cgroup_rstat_init(css));

Why do we need this call here? We already call cgroup_rstat_init() in
cgroup_init_subsys(). IIUC for subsystems with ss->early_init, we will
have already called cgroup_init_subsys() in cgroup_init_early().

Did I miss something?

>  		} else {
>  			cgroup_init_subsys(ss, false);
>  		}
[..]
> @@ -300,27 +306,25 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>  }
>  
>  /* see cgroup_rstat_flush() */
> -static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
> +static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
>  	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>  {
> +	struct cgroup *cgrp = css->cgroup;
>  	int cpu;
>  
>  	lockdep_assert_held(&cgroup_rstat_lock);
>  
>  	for_each_possible_cpu(cpu) {
> -		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
> +		struct cgroup_subsys_state *pos;
>  
> +		pos = cgroup_rstat_updated_list(css, cpu);
>  		for (; pos; pos = pos->rstat_flush_next) {
> -			struct cgroup_subsys_state *css;
> +			if (!pos->ss)
> +				cgroup_base_stat_flush(pos->cgroup, cpu);
> +			else
> +				pos->ss->css_rstat_flush(pos, cpu);
>  
> -			cgroup_base_stat_flush(pos, cpu);
> -			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
> -
> -			rcu_read_lock();
> -			list_for_each_entry_rcu(css, &pos->rstat_css_list,
> -						rstat_css_node)
> -				css->ss->css_rstat_flush(css, cpu);
> -			rcu_read_unlock();
> +			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);

We should call bpf_rstat_flush() only if (!pos->ss) as well, right?
Otherwise we will call BPF rstat flush whenever any subsystem is
flushed.

I guess it's because BPF can now pass any subsystem to
cgroup_rstat_flush(), and we don't keep track. I think it would be
better if we do not allow BPF programs to select a css and always make
them flush the self css.

We can perhaps introduce a bpf_cgroup_rstat_flush() wrapper that takes
in a cgroup and passes cgroup->self internally to cgroup_rstat_flush().

But if the plan is to remove the bpf_rstat_flush() call here soon then
it's probably not worth the hassle.

Shakeel (and others), WDYT?

