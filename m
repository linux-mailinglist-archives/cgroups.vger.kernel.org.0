Return-Path: <cgroups+bounces-8679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E7AF848E
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 01:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4407C175A73
	for <lists+cgroups@lfdr.de>; Thu,  3 Jul 2025 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B812DCF4A;
	Thu,  3 Jul 2025 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElIk1J98"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E12DCC06;
	Thu,  3 Jul 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586827; cv=none; b=qE3L+j6Et0ASOvLG9T7RKeqJgEXS4l3C01V8fgK9RJNQwPr9xrodiNWB1+rDbAYgbABTWirQ+PhnE/W3jBLreuvDe6DUapAfsEyVALUs7EC3vS8wMWFiJeO6tV/Oro/QgGykRuqq4+BSmqIG4MgOlaMyap5fYS+iNh9e6x1vMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586827; c=relaxed/simple;
	bh=qukI32wDemMhrFXO13zfcpkB5KdHJVb7oljNa0uLMHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seZWnY8TYsnTM730Uy3+oX8zFIxDKXU1yRv848XLushhFCYjKjB599hZj1braJzp4T8WhCnT3XCRgSCPDhOWEyznKYhVBX/zE//lkGtd/4NduHsOyJrtqfgtxNaHZs+bpSwYgR9GBBfBCPEIpl2f4YnqRbFmT6+Hinsd65l4TFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElIk1J98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5674C4CEF1;
	Thu,  3 Jul 2025 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751586825;
	bh=qukI32wDemMhrFXO13zfcpkB5KdHJVb7oljNa0uLMHE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ElIk1J98ka4kXvejP33Ieez21jyiulfz3tqxd8YuDuCx6d9oriNW+Me2CiDDChian
	 Kp5d7HzMeJ6DHKrbuk6bYTidwbuUTDf6NgKx8Pk0v9oktECuxxcMVNkBifZ4v2C4ne
	 3/nJ5+bD0bJDt/p7gsd4G3vc/McrS2xc5CfRZms/C2St/h9kD0iRFwJXapAwK9aZs7
	 Z/2F/83BeNlrKXQy/uPG/Dmtxdvgbk2mg/IeQE9cIwuJJ/m3g84vWKwSP0oktLP8Kb
	 wIsOTfIsCPpRFx8BCr+cCcKOcrlF7/KUe4c/KFuxXGyScaFNJvkMIBUnawWXsowGfM
	 oq14fprt/l+XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50894CE0D3B; Thu,  3 Jul 2025 16:53:45 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:53:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
Message-ID: <f6900de7-bfab-47da-b29d-138c75c172fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev>
 <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
 <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t>

On Thu, Jul 03, 2025 at 03:46:07PM -0700, Shakeel Butt wrote:
> On Thu, Jul 03, 2025 at 03:29:16PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 03, 2025 at 01:00:12PM -0700, Shakeel Butt wrote:
> > > Currently the rstat updater and the flusher can race and cause a
> > > scenario where the stats updater skips adding the css to the lockless
> > > list but the flusher might not see those updates done by the skipped
> > > updater. This is benign race and the subsequent flusher will flush those
> > > stats and at the moment there aren't any rstat users which are not fine
> > > with this kind of race. However some future user might want more
> > > stricter guarantee, so let's add appropriate comments and data_race()
> > > tags to ease the job of future users.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  kernel/cgroup/rstat.c | 32 +++++++++++++++++++++++++++++---
> > >  1 file changed, 29 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > > index c8a48cf83878..b98c03b1af25 100644
> > > --- a/kernel/cgroup/rstat.c
> > > +++ b/kernel/cgroup/rstat.c
> > > @@ -60,6 +60,12 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
> > >   * Atomically inserts the css in the ss's llist for the given cpu. This is
> > >   * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
> > >   * will be processed at the flush time to create the update tree.
> > > + *
> > > + * NOTE: if the user needs the guarantee that the updater either add itself in
> > > + * the lockless list or the concurrent flusher flushes its updated stats, a
> > > + * memory barrier is needed before the call to css_rstat_updated() i.e. a
> > > + * barrier after updating the per-cpu stats and before calling
> > > + * css_rstat_updated().
> > >   */
> > >  __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
> > >  {
> > > @@ -86,8 +92,13 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
> > >  		return;
> > >  
> > >  	rstatc = css_rstat_cpu(css, cpu);
> > > -	/* If already on list return. */
> > > -	if (llist_on_list(&rstatc->lnode))
> > > +	/*
> > > +	 * If already on list return. This check is racy and smp_mb() is needed
> > > +	 * to pair it with the smp_mb() in css_process_update_tree() if the
> > > +	 * guarantee that the updated stats are visible to concurrent flusher is
> > > +	 * needed.
> > > +	 */
> > > +	if (data_race(llist_on_list(&rstatc->lnode)))
> > 
> > OK, I will bite...
> > 
> > Why is this needed given the READ_ONCE() that the earlier patch added to
> > llist_on_list()?
> > 
> > >  		return;
> > >  
> > >  	/*
> > > @@ -145,9 +156,24 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
> > >  	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
> > >  	struct llist_node *lnode;
> > >  
> > > -	while ((lnode = llist_del_first_init(lhead))) {
> > > +	while ((lnode = data_race(llist_del_first_init(lhead)))) {
> > 
> > And for this one, why not make init_llist_node(), which is invoked from
> > llist_del_first_init(), do a WRITE_ONCE()?
> > 
> 
> Let me answer this one first. The previous patch actually made
> init_llist_node() do WRITE_ONCE().
> 
> So the actual question is why do we need
> data_race([READ|WRITE]_ONCE()) instead of just [READ|WRITE]_ONCE()?

You should *almost* always use [READ|WRITE]_ONCE() instead of data_race().

> Actually I had the similar question myself and found the following
> comment in include/linux/compiler.h:
> 
> /**
>  * data_race - mark an expression as containing intentional data races
>  *
>  * This data_race() macro is useful for situations in which data races
>  * should be forgiven.  One example is diagnostic code that accesses
>  * shared variables but is not a part of the core synchronization design.
>  * For example, if accesses to a given variable are protected by a lock,
>  * except for diagnostic code, then the accesses under the lock should
>  * be plain C-language accesses and those in the diagnostic code should
>  * use data_race().  This way, KCSAN will complain if buggy lockless
>  * accesses to that variable are introduced, even if the buggy accesses
>  * are protected by READ_ONCE() or WRITE_ONCE().
>  *
>  * This macro *does not* affect normal code generation, but is a hint
>  * to tooling that data races here are to be ignored.  If the access must
>  * be atomic *and* KCSAN should ignore the access, use both data_race()
>  * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
>  */
> 
> IIUC correctly, I need to protect llist_node against tearing and as well
> as tell KCSAN to ignore the access for race then I should use both.
> Though I think KCSAN treat [READ|WRITE]_ONCE similar to data_race(), so
> it kind of seem redundant but I think at least I want to convey that we
> need protection against tearing and ignore KCSAN and using both conveys
> that. Let me know if you think otherwise.
> 
> thanks a lot for taking a look.

The thing to remember is that data_race() does not affect the
generated code (except of course when running KCSAN), and thus does
absolutely nothing to prevent load/store tearing.  You need things like
[READ|WRITE]_ONCE() to prevent tearing.

So if it does not affect the generated code, what is the point of
data_race()?

One answer to this question is for diagnostics where you want KCSAN
to check the main algorithm, but you don't want KCSAN to be confused
by the diagnostic accesses.  For example, you might use something like
ASSERT_EXCLUSIVE_ACCESS() as in __list_splice_init_rcu(), and not want
your diagnostic accesses to result in false-positive KCSAN reports
due to interactions with ASSERT_EXCLUSIVE_ACCESS() on some particular
memory location.  And if you were to use READ_ONCE() to access that same
memory location in your diagnostics, KCSAN would complain if they ran
concurrently with that ASSERT_EXCLUSIVE_ACCESS().  So you would instead
use data_race() to suppress such complaints.

Does that make sense?

						Thanx, Paul

