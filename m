Return-Path: <cgroups+bounces-8059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1FFAADB67
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5BF18835E2
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3531C8616;
	Wed,  7 May 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JHwuDU1D"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6B188734
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609896; cv=none; b=FBAebtthxhfj0UJ65/y/Q7F+1cgFzVM85kolrFwbUEwpynJu/Th/5PusFJhD7qncxggvbDAwo/KoiNIDftGY0/J9nnE3AdV4BSX7W/VPq8bT0MMGb5yGQLz9s9dtL+OH1XAJ5r0Fqb7lc3F95x9r89XNIzntdTO1LmctjIlP6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609896; c=relaxed/simple;
	bh=vmSrbiYCckAkEIXeTwfEt1+NuV0ZL8C2n/RbuptJUl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESjbeH1D4eH7a4GtaQAH+8jZN7EbXD7kMoiFLIvo1H8c64nIBtURCRRIJWI5djdmb6FZ4LT9zIaHCnUQlxzuqKpIzCiMgz//ATtBJpEER+XXynDAuQmFpWfQJA9QJesHLiIT3cNGZ0RoxRIOJTPKaee/GuJrMBOcXIEF+8cCIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JHwuDU1D; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 May 2025 09:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746609892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dStHY5fpNcqDWW2Pio95dd+616z2TJmryOCg4BVYuC4=;
	b=JHwuDU1DP2ERZm/8ZDfb8sA+09tL10Y7R8K0jlLl9Ys2x852/kTbWta+Ng/gnzToPVsQBS
	w0aX2fjgE4H6638OkeEOSDokBwczgyWMOM536gTBXuqmP5vnrH4Mh22oS3BHVinklEoLcM
	46OzfcYzABU/IoH1rLWgrsO8Y77nQ9M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 2/5] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <aBsm22A8qWjGJgY9@google.com>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503001222.146355-3-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 05:12:19PM -0700, JP Kobryn wrote:
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
> Conditional guards for checking validity of a given css were placed within
> css_rstat_updated/flush() to prevent undefined behavior occuring from kfunc
> usage in bpf programs. Guards were also placed within css_rstat_init/exit()
> in order to help consolidate calls to them. At call sites for all four
> functions, the existing guards were removed.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/linux/cgroup-defs.h                   |  46 ++--
>  kernel/cgroup/cgroup.c                        |  34 +--
>  kernel/cgroup/rstat.c                         | 200 ++++++++++--------
>  .../selftests/bpf/progs/btf_type_tag_percpu.c |  18 +-
>  4 files changed, 160 insertions(+), 138 deletions(-)
[..]
> @@ -6101,6 +6087,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
>  	} else {
>  		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
>  		BUG_ON(css->id < 0);
> +
> +		BUG_ON(css_rstat_init(css));

We call css_rstat_init() here for subsys css's that are not early
initialized, and in cgroup_setup_root() self css's. We can probably move
both calls into cgroup_init() as I mentioned earlier?

Also, I think this version just skips calling css_rstat_init() for early
initialized subsys css's, without adding the patch that you talked about
earlier which protects against early initialized subsystems using rstat.

>  	}
>  
>  	/* Update the init_css_set to contain a subsys
[..]
> @@ -217,31 +225,32 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
>  }
>  
>  /**
> - * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
> - * @root: root of the cgroup subtree to traverse
> + * css_rstat_updated_list - return a list of updated cgroups to be flushed

css's?

> + * @root: root of the css subtree to traverse
>   * @cpu: target cpu
>   * Return: A singly linked list of cgroups to be flushed
>   *
>   * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
> - * each returned cgroup is unlinked from the updated tree.
> + * each returned css is unlinked from the updated tree.
>   *
>   * The only ordering guarantee is that, for a parent and a child pair
>   * covered by a given traversal, the child is before its parent in
>   * the list.
>   *
>   * Note that updated_children is self terminated and points to a list of
> - * child cgroups if not empty. Whereas updated_next is like a sibling link
> - * within the children list and terminated by the parent cgroup. An exception
> + * child css's if not empty. Whereas updated_next is like a sibling link
> + * within the children list and terminated by the parent css. An exception
>   * here is the cgroup root whose updated_next can be self terminated.
>   */
[..]
> @@ -383,32 +395,45 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>  
>  int css_rstat_init(struct cgroup_subsys_state *css)
>  {
> -	struct cgroup *cgrp = css->cgroup;
> +	struct cgroup *cgrp;
>  	int cpu;
> +	bool is_cgroup = css_is_cgroup(css);
>  
> -	/* the root cgrp has rstat_cpu preallocated */
> -	if (!cgrp->rstat_cpu) {
> -		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
> -		if (!cgrp->rstat_cpu)
> -			return -ENOMEM;
> -	}
> +	if (is_cgroup) {
> +		cgrp = css->cgroup;

You can keep 'cgrp' initialized at the top of the function to avoid the
extra level of indentation here, right?

>  
> -	if (!cgrp->rstat_base_cpu) {
> -		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
> +		/* the root cgrp has rstat_base_cpu preallocated */
>  		if (!cgrp->rstat_base_cpu) {
> -			free_percpu(cgrp->rstat_cpu);
> +			cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
> +			if (!cgrp->rstat_base_cpu)
> +				return -ENOMEM;
> +		}
> +	} else if (css->ss->css_rstat_flush == NULL)
> +		return 0;

We can probably just do this at the beginning of the function to be able
to use the helper:

	if (!css_is_cgroup(css) && css->ss->css_rstat_flush == NULL)
		return 0;

Also, when the return value of css_is_cgroup() is cached as is_cgroup it
makes me hate the function name even more, because 'is_cgroup' is very
confusing for a css in my opinion since they all represent cgroups.

I really think this should be css_is_self() (or css_is_self_cgroup())
and the variable names would be 'is_self'.

> +
> +	/* the root cgrp's self css has rstat_cpu preallocated */
> +	if (!css->rstat_cpu) {
> +		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
> +		if (!css->rstat_cpu) {
> +			if (is_cgroup)
> +				free_percpu(cgrp->rstat_base_cpu);
> +
>  			return -ENOMEM;
>  		}
>  	}
>  
>  	/* ->updated_children list is self terminated */
>  	for_each_possible_cpu(cpu) {
> -		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
> -		struct cgroup_rstat_base_cpu *rstatbc =
> -			cgroup_rstat_base_cpu(cgrp, cpu);
> +		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
>  
> -		rstatc->updated_children = cgrp;
> -		u64_stats_init(&rstatbc->bsync);
> +		rstatc->updated_children = css;
> +
> +		if (is_cgroup) {
> +			struct cgroup_rstat_base_cpu *rstatbc;
> +
> +			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
> +			u64_stats_init(&rstatbc->bsync);
> +		}
>  	}
>  
>  	return 0;
[..]

