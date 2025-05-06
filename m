Return-Path: <cgroups+bounces-8037-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B5AABFD4
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D535A507D93
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97424EA8F;
	Tue,  6 May 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3a/VwQc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1D136358
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524273; cv=none; b=CeconviYL53K9qqyoNSFYrpor2kvJRaZniJJysjuZjdAY5egsn9C5VexxvuwRuEoP/KC6AzQuOwKsDZD1INzIPxJB0IJLRJnrv4pM7IOcjHOZWqaKo0SeFjZTdqtSTkGfRK2M7qjG34fMgAY7N/mBIvU2sW5HivHmHWsjVo2iaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524273; c=relaxed/simple;
	bh=u33c8TBGv1fRkdC+YQ7sdruovOn6lqcPknhMcC0T1TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW+uJu18g1K13iQTW3/D2sXhteb8q5wBR9uuX8Z+qzMG5cIlAWPqDm40omcFhP4wI28lYI0jrNSaPEcC5BA9HZGWGDllTPJQlFOKDbY5rlSe+THFPk6R03GfX0A3bSo+N0WxvrR/jCsqpaeUUzsa2DmQqZvqWt7IMYJ5on8FCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3a/VwQc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 09:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746524269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+I17Esksy2u9+n2ecIj4ZUAYevC/b4CdVAs83HtwMM=;
	b=B3a/VwQcp3FIQS4TVsh1kqFzEld9KwSaT1rQVeRkKnafAtW08nVWhkP4HV1WlNFTVuY6ip
	qUo0eLAksL4oKkPRzmhDHY6ImktlDkVfvy/L8h3mngONFoidDr5zzYcTtyDByu9RqTBv4l
	yEhT0+ERp8c9ITD1vO0mMsnz8492qrM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <aBnYZqJtZLDMKQYU@google.com>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
 <68079aa7.df0a0220.30a1a0.cbb2SMTPIN_ADDED_BROKEN@mx.google.com>
 <e8de82fe-feea-4be2-93eb-620b8ece6748@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8de82fe-feea-4be2-93eb-620b8ece6748@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 04:43:41PM -0700, JP Kobryn wrote:
> On 4/22/25 6:33 AM, Yosry Ahmed wrote:
> > On Thu, Apr 03, 2025 at 06:10:49PM -0700, JP Kobryn wrote:
> [..]
> > > @@ -5425,6 +5417,9 @@ static void css_free_rwork_fn(struct work_struct *work)
> > >   		struct cgroup_subsys_state *parent = css->parent;
> > >   		int id = css->id;
> > > +		if (ss->css_rstat_flush)
> > > +			css_rstat_exit(css);
> > > +
> > 
> > This call now exists in both branches (self css or not), so it's
> > probably best to pull it outside. We should probably also pull the call
> > in cgroup_destroy_root() outside into css_free_rwork_fn() so that we end
> > up with a single call to css_rstat_exit() (apart from failure paths).
> 
> This can be done if css_rstat_exit() is modified to guard against
> invalid css's like being a subsystem css and not having implemented
> css_rstat_flush.
> 
> > 
> > We can probably also use css_is_cgroup() here instead of 'if (ss)' for
> > consistency.
> > 
> > >   		ss->css_free(css);
> > >   		cgroup_idr_remove(&ss->css_idr, id);
> > >   		cgroup_put(cgrp);
> > [..]
> > > @@ -5659,6 +5647,12 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
> > >   		goto err_free_css;
> > >   	css->id = err;
> > > +	if (ss->css_rstat_flush) {
> > > +		err = css_rstat_init(css);
> > > +		if (err)
> > > +			goto err_free_css;
> > > +	}
> > > +
> > >   	/* @css is ready to be brought online now, make it visible */
> > >   	list_add_tail_rcu(&css->sibling, &parent_css->children);
> > >   	cgroup_idr_replace(&ss->css_idr, css, css->id);
> > > @@ -5672,7 +5666,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
> > >   err_list_del:
> > >   	list_del_rcu(&css->sibling);
> > >   err_free_css:
> > > -	list_del_rcu(&css->rstat_css_node);
> > >   	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
> > >   	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> > >   	return ERR_PTR(err);
> > > @@ -6104,11 +6097,17 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
> > >   	css->flags |= CSS_NO_REF;
> > >   	if (early) {
> > > -		/* allocation can't be done safely during early init */
> > > +		/*
> > > +		 * Allocation can't be done safely during early init.
> > > +		 * Defer IDR and rstat allocations until cgroup_init().
> > > +		 */
> > >   		css->id = 1;
> > >   	} else {
> > >   		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
> > >   		BUG_ON(css->id < 0);
> > > +
> > > +		if (ss->css_rstat_flush)
> > > +			BUG_ON(css_rstat_init(css));
> > >   	}
> > >   	/* Update the init_css_set to contain a subsys
> > > @@ -6207,9 +6206,17 @@ int __init cgroup_init(void)
> > >   			struct cgroup_subsys_state *css =
> > >   				init_css_set.subsys[ss->id];
> > > +			/*
> > > +			 * It is now safe to perform allocations.
> > > +			 * Finish setting up subsystems that previously
> > > +			 * deferred IDR and rstat allocations.
> > > +			 */
> > >   			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
> > >   						   GFP_KERNEL);
> > >   			BUG_ON(css->id < 0);
> > > +
> > > +			if (ss->css_rstat_flush)
> > > +				BUG_ON(css_rstat_init(css));
> > 
> > The calls to css_rstat_init() are really difficult to track. Let's
> > recap, before this change we had two calls:
> > - In cgroup_setup_root(), for root cgroups.
> > - In cgroup_create(), for non-root cgroups.
> > 
> > This patch adds 3 more, so we end up with 5 calls as follows:
> > - In cgroup_setup_root(), for root self css's.
> > - In cgroup_create(), for non-root self css's.
> > - In cgroup_subsys_init(), for root subsys css's without early
> >    initialization.
> > - In cgroup_init(), for root subsys css's with early
> >    initialization, as we cannot call it from cgroup_subsys_init() early
> >    as allocations are not allowed during early init.
> > - In css_create(), for non-root non-self css's.
> > 
> > We should try to consolidate as much as possible. For example:
> > - Can we always make the call for root subsys css's in cgroup_init(),
> >    regardless of early initialization status? Is there a need to make the
> >    call early for subsystems that use early in cgroup_subsys_init()
> >    initialization?
> > 
> > - Can we always make the call for root css's in cgroup_init(),
> >    regardless of whether the css is a self css or a subsys css? I imagine
> >    we'd still need two separate calls, one outside the loop for the self
> >    css's, and one in the loop for subsys css's, but having them in the
> >    same place should make things easier.
> 
> The answer might be the same for the two questions above. I think at
> best, we can eliminate the single call below to css_rstat_init():
> 
> cgroup_init()
> 	for_each_subsys(ss, ssid)
> 		if (ss->early_init)
> 			css_rstat_init(css) /* remove */
> 
> I'm not sure if it's by design and also an undocumented constraint but I
> find that it is not possible to have a cgroup subsystem that is
> designated for "early init" participate in rstat at the same time. The
> necessary ordering of actions should be:
> 
> init_and_link_css(css, ss, ...)
> css_rstat_init(css)
> css_online(css)
> 
> This sequence occurs within cgroup_init_subsys() when ss->early_init is
> false. However, when early_init is true, the last two calls are
> effectively inverted:
> 
> css_online(css)
> css_rstat_init(css) /* too late */
> 
> This needs to be avoided or else failures will occur during boot.
> 
> Note that even before this series, this constraint seems to have
> existed. Using branch for-6.16 as a base, I experimented with a minimal
> custom test cgroup in which I implement css_rstat_flush while early_init
> is on. The system fails during boot because online_css() is called
> before cgroup_rstat_init().
> 
> cgroup_init_early()
> 	for_each_subsys(ss, ssid)
> 		if (ss->early)
> 			cgroup_init_subsys(ss, true)
> 				css = ss->css_alloc()
> 				online_css(css)
> cgroup_init()
> 	cgroup_setup_root()
> 		cgroup_rstat_init(root_cgrp) /* too late */

I am looking at online_css() and cgroup_rstat_init() and I cannot
immediately see the ordering requirement.

Is the idea that once a css is online an rstat flush can occur, and it
would crash if cgroup_rstat_init() hadn't been called yet? I am
wondering when would the flush occur before cgroup_init() is called.

Anyway, if that is possible I think enforcing this is probably
important.

> 
> Unless I"m missing something, do you think this constraint is worthy of
> a separate patch? Something like this that prevents the combination of
> rstat with early_init:
> 
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6130,7 +6130,8 @@ int __init cgroup_init_early(void)
>     for_each_subsys(ss, i) {
> -       WARN(!ss->css_alloc || !ss->css_free || ss->name || ss->id,
> +       WARN(!ss->css_alloc || !ss->css_free || ss->name || ss->id ||
> +           (ss->early_init && ss->css_rstat_flush),
> 
> > 
> > Ideally if we can do both the above, we'd end up with 3 calling
> > functions only:
> > - cgroup_init() -> for all root css's.
> > - cgroup_create() -> for non-root self css's.
> > - css_create() -> for non-root subsys css's.
> > 
> > Also, we should probably document all the different call paths for
> > css_rstat_init() and css_rstat_exit() somewhere.
> 
> Will do.

