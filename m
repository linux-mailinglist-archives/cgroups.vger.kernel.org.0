Return-Path: <cgroups+bounces-7207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CEA6AFD9
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 22:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2502189DA93
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291951EB9E3;
	Thu, 20 Mar 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2ZfbHR6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24733E7
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506278; cv=none; b=WOtp3FENBrzeVL5W0OWD8xtbwSrAkh2sjibyeaslYduMtgb2w44V/PZoQXwVfDxdQY+zkQQMX1tlREx4HKJ5kUhPw4f1iFJHItpV5EZb1dGXXEp5kx+c3jV0nYECtV368y80ofLbPadZMX/pUPprdsrA9E7fDuyIZMj8dvBlbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506278; c=relaxed/simple;
	bh=TPM4zkiUpof4BVgPmG5PxOWmeP2hLPon50K+AdUyKpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC/Ta5WL+1pjfSuvJraCPw/pEmi74lF8LTReUxQSU9WKhBysDZHfutwI8Nlt2Kw9oQbyb6j56RRFnsdJ4Lr0lA/RpMLN1O+RtcQ7uhg3GC9hHDD2jNI1yrL0u532QLxBNxyOVbpPR1wIwEgvdexDODFuyUCTEu189Fb278fNfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2ZfbHR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BD7C4CEE3;
	Thu, 20 Mar 2025 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506278;
	bh=TPM4zkiUpof4BVgPmG5PxOWmeP2hLPon50K+AdUyKpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2ZfbHR6u0WcrJcn82rbUZPK5etGLQrXd5aVw1M+gVKDoVZeClexxLOpy3xlDv/XS
	 0NSnByR4yqWQ1pQHjaLF75EjAzAYfD8KsjT6F8YVr9juacmjrYLU6yEBT8ohhMJ6gC
	 /bij1Ifg/agzKTyY06sN3ZvaFFtiryQi9FSd8bqBradr5V84nrMsIowmpNi3fD5RQs
	 wYPptFmYg255U0eOM6ybVafxEjHPdn2+1+OPYft9JpqT9V+MSQZd2NKxngh7Q6isWy
	 8fma4kQIQgnKGOSXEiUvwr2igRwxj5nYd9TQHHhKMySr6tC3RXqnqdMLx5ujCHVTtO
	 X/hUk03zZUE0g==
Date: Thu, 20 Mar 2025 11:31:17 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/4 v3] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <Z9yJJXdWdZ_1fmrR@slm.duckdns.org>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319222150.71813-3-inwardvessel@gmail.com>

Hello,

On Wed, Mar 19, 2025 at 03:21:48PM -0700, JP Kobryn wrote:
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
> the cgroup and instead place them on the css. Finally, change the
> updated/flush API's to accept a reference to a css instead of a cgroup.
> This allows a specific subsystem to be associated with an update or flush.
> Separate rstat trees will now exist for each unique subsystem.
> 
> Since updating/flushing will now be done at the subsystem level, there is
> no longer a need to keep track of updated css nodes at the cgroup level.
> The list management of these nodes done within the cgroup (rstat_css_list
> and related) has been removed accordingly. There was also padding in the
> cgroup to keep rstat_css_list on a cacheline different from
> rstat_flush_next and the base stats. This padding has also been removed.

Overall, this looks okay but I think the patch should be split further.
There's too much cgroup -> css renames mixed with actual changes which makes
it difficult to understand what the actual changes are. Can you please
separate it into a patch which makes everything css based but the actual
queueing and flushing is still only on the cgroup css and then the next
patch to actually split out linking and flushing to each css?

> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 13fd82a4336d..4e71ae9858d3 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -346,6 +346,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>  	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
>  }
>  
> +static inline bool css_is_cgroup(struct cgroup_subsys_state *css)
> +{
> +	return css->ss == NULL;
> +}

Maybe introduce this in a prep patch and replace existing users?

...
> @@ -6082,11 +6077,16 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
>  	css->flags |= CSS_NO_REF;
>  
>  	if (early) {
> -		/* allocation can't be done safely during early init */
> +		/* allocation can't be done safely during early init.
> +		 * defer idr and rstat allocations until cgroup_init().
> +		 */

Nit: Please use fully winged comment blocks for multilines with
captalizations.

Thanks.

-- 
tejun

