Return-Path: <cgroups+bounces-7716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436EBA96A36
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5655F16181B
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA427D779;
	Tue, 22 Apr 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iv/V2WDP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7020E6F9
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325380; cv=none; b=jALYTKMkxkSfQ8VkLUcGXvfCqpakxtep2nwkY5vdoz/SWtbDjNJFBnOnHl4RiYZAXyPlpCYg1c2lMoWF/8wkRNR8PAxzA3aCSGZtyJrxS6eqhEG9fmTQNIexKJF2YENp0K+3S/SXyerj1pCTHJwPqkHg1o26BcUXiyyA9PautBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325380; c=relaxed/simple;
	bh=dfAwI3lOHpl38RuzVzutJbx7UD9CeoyqXfETkF9GhcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb0J86D7Pr0Yh+pPZiNPlqFjOYtsp4b+Y5H33YDRTgbXkztVlGS/fAHbh/XeNouLMiJwkFWcmXqhcLzsx9voGZQP+Rb8FsbeQwW3MMlygjzTjXCcDj6tjTxaaqwiG+233nxkGQIudZ7gadm1ghubQxeXmwNmcIeWbh/8pAw2hsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iv/V2WDP; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 05:35:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745325372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xX4ac+jakmfpKw0R41ELxZ+ydV3Ie4b8KV3KHy9a80I=;
	b=iv/V2WDPfV34MAgZTHrv7SYmQ89JZ3G8zew50m8kZwHxvkQyB9+dZlk7JXrEUdReWNt04T
	sbxxE1j6mplJ8glGxW6fTTnCF5vqS0rN+DxOz6uz0l/4HQp9wX0sAXt7wm54h19KwHC8f4
	To5JHyWv5QBuXbXWEFFLU7ou+CqHTRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/5] cgroup: change rstat function signatures from
 cgroup-based to css-based
Message-ID: <aAeNHknSO4XcwT4N@Asmaa.>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-4-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 06:10:48PM -0700, JP Kobryn wrote:
> This non-functional change serves as preparation for moving to
> subsystem-based rstat trees. To simplify future commits, change the
> signatures of existing cgroup-based rstat functions to become css-based and
> rename them to reflect that.
> 
> Though the signatures have changed, the implementations have not. Within
> these functions use the css->cgroup pointer to obtain the associated cgroup
> and allow code to function the same just as it did before this patch. At
> applicable call sites, pass the subsystem-specific css pointer as an
> argument or pass a pointer to cgroup::self if not in subsystem context.
> 
> Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
> are not altered yet since there would be a larger amount of css to
> cgroup conversions which may overcomplicate the code at this
> intermediate phase.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
[..]
> @@ -5720,6 +5716,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>  	cgrp->root = root;
>  	cgrp->level = level;
>  
> +	/*
> +	 * Now that init_cgroup_housekeeping() has been called and cgrp->self
> +	 * is setup, it is safe to perform rstat initialization on it.
> +	 */
> +	ret = css_rstat_init(&cgrp->self);
> +	if (ret)
> +		goto out_stat_exit;
> +

Sorry for the late review, but this looks wrong to me. I think this
should goto out_kernfs_remove..

>  	ret = psi_cgroup_alloc(cgrp);
>  	if (ret)
>  		goto out_kernfs_remove;

..and this should goto out_stat_exit.

> @@ -5790,10 +5794,10 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>  
>  out_psi_free:
>  	psi_cgroup_free(cgrp);
> +out_stat_exit:
> +	css_rstat_exit(&cgrp->self);
>  out_kernfs_remove:
>  	kernfs_remove(cgrp->kn);
> -out_stat_exit:
> -	cgroup_rstat_exit(cgrp);
>  out_cancel_ref:
>  	percpu_ref_exit(&cgrp->self.refcnt);
>  out_free_cgrp:
[..]
> @@ -298,36 +304,41 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
>  	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>  }
>  
> -static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> +static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
> +		int cpu_in_loop)
>  	__releases(&cgroup_rstat_lock)
>  {
> +	struct cgroup *cgrp = css->cgroup;
> +
>  	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
>  	spin_unlock_irq(&cgroup_rstat_lock);
>  }
>  
>  /**
> - * cgroup_rstat_flush - flush stats in @cgrp's subtree
> - * @cgrp: target cgroup
> + * css_rstat_flush - flush stats in @css->cgroup's subtree
> + * @css: target cgroup subsystem state
>   *
> - * Collect all per-cpu stats in @cgrp's subtree into the global counters
> + * Collect all per-cpu stats in @css->cgroup's subtree into the global counters
>   * and propagate them upwards.  After this function returns, all cgroups in
>   * the subtree have up-to-date ->stat.
>   *
> - * This also gets all cgroups in the subtree including @cgrp off the
> + * This also gets all cgroups in the subtree including @css->cgroup off the
>   * ->updated_children lists.
>   *
>   * This function may block.
>   */
> -__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
> +__bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>  {
> +	struct cgroup *cgrp = css->cgroup;
>  	int cpu;
>  
>  	might_sleep();
>  	for_each_possible_cpu(cpu) {
> -		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
> +		struct cgroup *pos;
>  
>  		/* Reacquire for each CPU to avoid disabling IRQs too long */
> -		__cgroup_rstat_lock(cgrp, cpu);
> +		__css_rstat_lock(css, cpu);
> +		pos = cgroup_rstat_updated_list(cgrp, cpu);

Moving this call under the lock is an unrelated bug fix that was already
done by Shakeel in commit 7d6c63c31914 ("cgroup: rstat: call
cgroup_rstat_updated_list with cgroup_rstat_lock").

Otherwise this LGTM.

