Return-Path: <cgroups+bounces-7718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25159A96D01
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 15:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B89740145B
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B52836AC;
	Tue, 22 Apr 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zv0Ngf4b"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA82836B9
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328812; cv=none; b=FjD6xYB5PCGmO59cQYmz2P69zbmr0agqe38tPoCFMpRpWV3yqc/nqys3ouhbiyOJYoxweuVpSjE/HUNS5uEoq5TQBs20mqYwUbaMhEArDmdDRYCln59e4C5t28ulz+5ToyLr3ek6BAM+PhT09XK8NjrcXZtOUXCqPJZCA3ttTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328812; c=relaxed/simple;
	bh=vJgHwd67bP5kkfk58TGOP/SpxesF1FSegW6/a2eXw3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5NJSx0FGi+S7ArcL4jjB39GCjkbTxga+p6iQD75ruq8MFIh2Yr/Osx7jrf9wONje0WfInEjsgOlHhOANzi/zVdiLHg6qhL87T7lUMkgurwdxslPFCYxjMfnxGtGQiDLoxC+qxmquLcDFHh9IODyHglElqETOCHqaA42ZufjzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zv0Ngf4b; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 06:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745328807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AY4fKwl2w/0Y+OFsSf3SMakvPUO3ks8cM5I2ij4eDiw=;
	b=Zv0Ngf4bz0eYmnFNTs1TPIxd+MjPqkyuKBdUzXCJQ4kdaiFkD3t8E5nGWb80KRNIBcxf28
	+0JTgeVV0oSMlcY7vDC2/g/dmnBTnBBl0zup6+YYM+z7o9N2dss0uYzLP7zeWWcAVuWL9f
	Ah2hZgZ5oiyNbl0FzO2YL9QfuqIcVRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <aAeao_0s8fBY0gC2@Asmaa.>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-5-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 06:10:49PM -0700, JP Kobryn wrote:
> Different subsystems may call cgroup_rstat_updated() within the same
> cgroup, resulting in a tree of pending updates from multiple subsystems.
> When one of these subsystems is flushed via cgroup_rstat_flushed(), all
> other subsystems with pending updates on the tree will also be flushed.
> 
> Change the paradigm of having a single rstat tree for all subsystems to
> having separate trees for each subsystem. This separation allows for
> subsystems to perform flushes without the side effects of other subsystems.
> As an example, flushing the cpu stats will no longer cause the memory stats
> to be flushed and vice versa.
> 
> In order to achieve subsystem-specific trees, change the tree node type
> from cgroup to cgroup_subsys_state pointer. Then remove those pointers from
> the cgroup and instead place them on the css. Finally, change update/flush
> functions to make use of the different node type (css). These changes allow
> a specific subsystem to be associated with an update or flush. Separate
> rstat trees will now exist for each unique subsystem.
> 
> Since updating/flushing will now be done at the subsystem level, there is
> no longer a need to keep track of updated css nodes at the cgroup level.
> The list management of these nodes done within the cgroup (rstat_css_list
> and related) has been removed accordingly.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
[..]
> @@ -219,6 +219,13 @@ struct cgroup_subsys_state {
>  	 * Protected by cgroup_mutex.
>  	 */
>  	int nr_descendants;
> +
> +	/*
> +	 * A singly-linked list of css structures to be rstat flushed.
> +	 * This is a scratch field to be used exclusively by
> +	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
> +	 */

Ditto obsolete function name.

> +	struct cgroup_subsys_state *rstat_flush_next;
>  };
>  
>  /*
> @@ -329,10 +336,10 @@ struct cgroup_base_stat {
>  
>  /*
>   * rstat - cgroup scalable recursive statistics.  Accounting is done
> - * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
> + * per-cpu in css_rstat_cpu which is then lazily propagated up the
>   * hierarchy on reads.
>   *
> - * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
> + * When a stat gets updated, the css_rstat_cpu and its ancestors are
>   * linked into the updated tree.  On the following read, propagation only
>   * considers and consumes the updated tree.  This makes reading O(the
>   * number of descendants which have been active since last read) instead of
> @@ -346,7 +353,7 @@ struct cgroup_base_stat {
>   * This struct hosts both the fields which implement the above -
>   * updated_children and updated_next.
>   */
> -struct cgroup_rstat_cpu {
> +struct css_rstat_cpu {
>  	/*
>  	 * Child cgroups with stat updates on this cpu since the last read
>  	 * are linked on the parent's ->updated_children through
> @@ -358,8 +365,8 @@ struct cgroup_rstat_cpu {
>  	 *
>  	 * Protected by per-cpu cgroup_rstat_cpu_lock.
>  	 */
> -	struct cgroup *updated_children;	/* terminated by self cgroup */
> -	struct cgroup *updated_next;		/* NULL iff not on the list */
> +	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */
> +	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
>  };
>  
>  /*
> @@ -521,25 +528,16 @@ struct cgroup {
>  	struct cgroup *dom_cgrp;
>  	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
>  
> -	/* per-cpu recursive resource statistics */
> -	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +	/* per-cpu recursive basic resource statistics */

This comment should probably be dropped now as it's only providing
partial info and is potentially confusing.

>  	struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
> -	struct list_head rstat_css_list;
>  
>  	/*
> -	 * Add padding to separate the read mostly rstat_cpu and
> -	 * rstat_css_list into a different cacheline from the following
> -	 * rstat_flush_next and *bstat fields which can have frequent updates.
> +	 * Add padding to keep the read mostly rstat per-cpu pointer on a
> +	 * different cacheline than the following *bstat fields which can have
> +	 * frequent updates.
>  	 */
>  	CACHELINE_PADDING(_pad_);
>  
> -	/*
> -	 * A singly-linked list of cgroup structures to be rstat flushed.
> -	 * This is a scratch field to be used exclusively by
> -	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
> -	 */
> -	struct cgroup	*rstat_flush_next;
> -
>  	/* cgroup basic resource statistics */
>  	struct cgroup_base_stat last_bstat;
>  	struct cgroup_base_stat bstat;
[..]
> @@ -5425,6 +5417,9 @@ static void css_free_rwork_fn(struct work_struct *work)
>  		struct cgroup_subsys_state *parent = css->parent;
>  		int id = css->id;
>  
> +		if (ss->css_rstat_flush)
> +			css_rstat_exit(css);
> +

This call now exists in both branches (self css or not), so it's
probably best to pull it outside. We should probably also pull the call
in cgroup_destroy_root() outside into css_free_rwork_fn() so that we end
up with a single call to css_rstat_exit() (apart from failure paths).

We can probably also use css_is_cgroup() here instead of 'if (ss)' for
consistency.

>  		ss->css_free(css);
>  		cgroup_idr_remove(&ss->css_idr, id);
>  		cgroup_put(cgrp);
[..]  
> @@ -5659,6 +5647,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
>  		goto err_free_css;
>  	css->id = err;
>  
> +	if (ss->css_rstat_flush) {
> +		err = css_rstat_init(css);
> +		if (err)
> +			goto err_free_css;
> +	}
> +
>  	/* @css is ready to be brought online now, make it visible */
>  	list_add_tail_rcu(&css->sibling, &parent_css->children);
>  	cgroup_idr_replace(&ss->css_idr, css, css->id);
> @@ -5672,7 +5666,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
>  err_list_del:
>  	list_del_rcu(&css->sibling);
>  err_free_css:
> -	list_del_rcu(&css->rstat_css_node);
>  	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
>  	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
>  	return ERR_PTR(err);
> @@ -6104,11 +6097,17 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
>  	css->flags |= CSS_NO_REF;
>  
>  	if (early) {
> -		/* allocation can't be done safely during early init */
> +		/*
> +		 * Allocation can't be done safely during early init.
> +		 * Defer IDR and rstat allocations until cgroup_init().
> +		 */
>  		css->id = 1;
>  	} else {
>  		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
>  		BUG_ON(css->id < 0);
> +
> +		if (ss->css_rstat_flush)
> +			BUG_ON(css_rstat_init(css));
>  	}
>  
>  	/* Update the init_css_set to contain a subsys
> @@ -6207,9 +6206,17 @@ int __init cgroup_init(void)
>  			struct cgroup_subsys_state *css =
>  				init_css_set.subsys[ss->id];
>  
> +			/*
> +			 * It is now safe to perform allocations.
> +			 * Finish setting up subsystems that previously
> +			 * deferred IDR and rstat allocations.
> +			 */
>  			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
>  						   GFP_KERNEL);
>  			BUG_ON(css->id < 0);
> +
> +			if (ss->css_rstat_flush)
> +				BUG_ON(css_rstat_init(css));

The calls to css_rstat_init() are really difficult to track. Let's
recap, before this change we had two calls:
- In cgroup_setup_root(), for root cgroups.
- In cgroup_create(), for non-root cgroups.

This patch adds 3 more, so we end up with 5 calls as follows:
- In cgroup_setup_root(), for root self css's.
- In cgroup_create(), for non-root self css's.
- In cgroup_subsys_init(), for root subsys css's without early
  initialization.
- In cgroup_init(), for root subsys css's with early
  initialization, as we cannot call it from cgroup_subsys_init() early
  as allocations are not allowed during early init.
- In css_create(), for non-root non-self css's.

We should try to consolidate as much as possible. For example:
- Can we always make the call for root subsys css's in cgroup_init(),
  regardless of early initialization status? Is there a need to make the
  call early for subsystems that use early in cgroup_subsys_init()
  initialization?

- Can we always make the call for root css's in cgroup_init(),
  regardless of whether the css is a self css or a subsys css? I imagine
  we'd still need two separate calls, one outside the loop for the self
  css's, and one in the loop for subsys css's, but having them in the
  same place should make things easier.

Ideally if we can do both the above, we'd end up with 3 calling
functions only:
- cgroup_init() -> for all root css's.
- cgroup_create() -> for non-root self css's.
- css_create() -> for non-root subsys css's.

Also, we should probably document all the different call paths for
css_rstat_init() and css_rstat_exit() somewhere.


>  		} else {
>  			cgroup_init_subsys(ss, false);
>  		}

