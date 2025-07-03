Return-Path: <cgroups+bounces-8678-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D3AF83DE
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE23E7A38E9
	for <lists+cgroups@lfdr.de>; Thu,  3 Jul 2025 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED872D3741;
	Thu,  3 Jul 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kghDbcnD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284282BEC50
	for <cgroups@vger.kernel.org>; Thu,  3 Jul 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582793; cv=none; b=nTSRoMZjVTn8uDRC/fQ9ZG+YKwQUTOXrPp2/Y/+wDmzxAXfO8EV5LR00YJ12Mh6hQN7gYgdl2mlyZglVaZBsxTCb4nYtWMfRFw4I+Q0HograCts5zEGL0Db2Ch0/mJb5+wglakJc0iYZG2DfwJUydXh8L7aeJhH054rVDwoq3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582793; c=relaxed/simple;
	bh=KaBidEahIKr7N4eELNwxzF36oly3VI2dfL3D6DcxkmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODynmNdDlG1UYWH6vDIkI4Rf3EwPf95qJPFk9NA8D9UCdqBSysUXuELd7fvStJ13U6nUc4w2RXpbkHeNbJhJEF+Vri3Ha/k2JYPQzLMGwikEu07wIXCDzct6555Uc0gvFp4x8WtjqrXHm/1CPPtfFp9Ns+00ohS70vSxVtPTKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kghDbcnD; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Jul 2025 15:46:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751582778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHwIqAp/B8daR4LVuH57/rc6G148Q4tQ/FTZcGDdVkk=;
	b=kghDbcnDvBVgHJ0dowMXteUg0gVzJ5n0x45H2J3+4Mb1Yx4kndrQkcqehVgjpJX8YzDOcl
	FdM4zive8jcp6WYd30Oc/kik2OkBoXPdyLHmlNPvu+l/OPYYZFpxVPmJVh3jqP1989jheL
	a4VUcbKYLjXSs9vkL5MHNS12tsBtcAw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
Message-ID: <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t>
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev>
 <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 03, 2025 at 03:29:16PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 03, 2025 at 01:00:12PM -0700, Shakeel Butt wrote:
> > Currently the rstat updater and the flusher can race and cause a
> > scenario where the stats updater skips adding the css to the lockless
> > list but the flusher might not see those updates done by the skipped
> > updater. This is benign race and the subsequent flusher will flush those
> > stats and at the moment there aren't any rstat users which are not fine
> > with this kind of race. However some future user might want more
> > stricter guarantee, so let's add appropriate comments and data_race()
> > tags to ease the job of future users.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  kernel/cgroup/rstat.c | 32 +++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index c8a48cf83878..b98c03b1af25 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -60,6 +60,12 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
> >   * Atomically inserts the css in the ss's llist for the given cpu. This is
> >   * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
> >   * will be processed at the flush time to create the update tree.
> > + *
> > + * NOTE: if the user needs the guarantee that the updater either add itself in
> > + * the lockless list or the concurrent flusher flushes its updated stats, a
> > + * memory barrier is needed before the call to css_rstat_updated() i.e. a
> > + * barrier after updating the per-cpu stats and before calling
> > + * css_rstat_updated().
> >   */
> >  __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
> >  {
> > @@ -86,8 +92,13 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
> >  		return;
> >  
> >  	rstatc = css_rstat_cpu(css, cpu);
> > -	/* If already on list return. */
> > -	if (llist_on_list(&rstatc->lnode))
> > +	/*
> > +	 * If already on list return. This check is racy and smp_mb() is needed
> > +	 * to pair it with the smp_mb() in css_process_update_tree() if the
> > +	 * guarantee that the updated stats are visible to concurrent flusher is
> > +	 * needed.
> > +	 */
> > +	if (data_race(llist_on_list(&rstatc->lnode)))
> 
> OK, I will bite...
> 
> Why is this needed given the READ_ONCE() that the earlier patch added to
> llist_on_list()?
> 
> >  		return;
> >  
> >  	/*
> > @@ -145,9 +156,24 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
> >  	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
> >  	struct llist_node *lnode;
> >  
> > -	while ((lnode = llist_del_first_init(lhead))) {
> > +	while ((lnode = data_race(llist_del_first_init(lhead)))) {
> 
> And for this one, why not make init_llist_node(), which is invoked from
> llist_del_first_init(), do a WRITE_ONCE()?
> 

Let me answer this one first. The previous patch actually made
init_llist_node() do WRITE_ONCE().

So the actual question is why do we need
data_race([READ|WRITE]_ONCE()) instead of just [READ|WRITE]_ONCE()?
Actually I had the similar question myself and found the following
comment in include/linux/compiler.h:

/**
 * data_race - mark an expression as containing intentional data races
 *
 * This data_race() macro is useful for situations in which data races
 * should be forgiven.  One example is diagnostic code that accesses
 * shared variables but is not a part of the core synchronization design.
 * For example, if accesses to a given variable are protected by a lock,
 * except for diagnostic code, then the accesses under the lock should
 * be plain C-language accesses and those in the diagnostic code should
 * use data_race().  This way, KCSAN will complain if buggy lockless
 * accesses to that variable are introduced, even if the buggy accesses
 * are protected by READ_ONCE() or WRITE_ONCE().
 *
 * This macro *does not* affect normal code generation, but is a hint
 * to tooling that data races here are to be ignored.  If the access must
 * be atomic *and* KCSAN should ignore the access, use both data_race()
 * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
 */

IIUC correctly, I need to protect llist_node against tearing and as well
as tell KCSAN to ignore the access for race then I should use both.
Though I think KCSAN treat [READ|WRITE]_ONCE similar to data_race(), so
it kind of seem redundant but I think at least I want to convey that we
need protection against tearing and ignore KCSAN and using both conveys
that. Let me know if you think otherwise.

thanks a lot for taking a look.



