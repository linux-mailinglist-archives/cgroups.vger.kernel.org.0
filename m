Return-Path: <cgroups+bounces-13239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47ED235D5
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 10:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAA23113045
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B7345CA2;
	Thu, 15 Jan 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ov+K6aJn"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4534403A;
	Thu, 15 Jan 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467984; cv=none; b=oHtohDP+8AAqtyBLQEkYzkaPV2Kyu4GB9yq/KSBIqxe7As4UXKQypbCiH54cHdLo9mvL0F/ddjy31kKkOgbrfP8evaJUOqTANFX+d75sgtXYsuAuHrPBSg97pIZnCOkxs85CaWuFk6k/6pqBz94QSudq06tUVGDz9Fy47JslRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467984; c=relaxed/simple;
	bh=QtXrY1BzyAWQDCoRetiYhjCCl5TRbbzVkYeUJgUnpqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTPGOfY9qYe0GftGmCmqDZvPFnVyFYuOQUZOiIAcalsrYuUD8VaTDir0nLlOurQZU47QV9dOYUsTv3STpZvPxqvhxJN5BKN8qOL4kIDn/DCsx2Jufq+Yg6J838my+RYKaWHmD3QauStLNUWQZqOaGdwsRumP29FXHdRjSLAP680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ov+K6aJn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W598fxA4tcfvMZqVc/8UaYOmwTru2sIEcl6XEyPCud8=; b=ov+K6aJnY0lOzxO2t+3c6TMoVH
	vTnkg0gp81L5Oxdfmlws+DidoQ97YjbUmjLVXGX6510BRRwzLLGzfB7/95FpO1xUSikfzxRGDvWPf
	jnDoIoyIozzko7uVXBJqPIDj+S7joftX9xiMdPlq2CgVWF7t6H8gkYKuH8JiIDlZMxZCBfdCcOmYr
	r14Aofds/tK98SszhFaivACY5igabQGInvSZkTVThLe3ecriA1Osuo7WzWuBik/uF7msOUZL0xnrq
	V8ufw0iGBEt6pcPlpsgw2H6xklAQWxwUEQKHoH68dc+vQuu9/4vbVnjzvtb1+BMIo+gev+vxn2tal
	7K78V3zQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgJIl-00000006NX6-1gs6;
	Thu, 15 Jan 2026 09:06:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E8D513005E5; Thu, 15 Jan 2026 10:05:57 +0100 (CET)
Date: Thu, 15 Jan 2026 10:05:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260115090557.GC831285@noisy.programming.kicks-ass.net>
References: <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
 <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
 <20260115082431.GE830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115082431.GE830755@noisy.programming.kicks-ass.net>

On Thu, Jan 15, 2026 at 09:24:31AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 14, 2026 at 03:20:48PM +0100, Juri Lelli wrote:
> 
> > > --- a/kernel/sched/syscalls.c
> > > +++ b/kernel/sched/syscalls.c
> > > @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
> > >  		 * itself.
> > >  		 */
> > >  		newprio = rt_effective_prio(p, newprio);
> > > -		if (newprio == oldprio)
> > > +		if (newprio == oldprio && !dl_prio(newprio))
> > >  			queue_flags &= ~DEQUEUE_MOVE;
> > >  	}
> > 
> > We have been using (improperly?) ENQUEUE_SAVE also to know when a new
> > entity gets setscheduled to DEADLINE (or its parameters are changed) and
> > it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
> > quick first look, it does sound good to me.
> 
> If this is strictly about tasks coming into SCHED_DEADLINE there are a
> number of alternative options:
> 
>  - there are the sched_class::switch{ing,ed}_to() callbacks;
>  - there is (the fairly recent) ENQUEUE_CLASS.
> 
> Anyway, let me break up this one patch into individual bits and write
> changelogs. I'll stick them in queue/sched/urgent for now; hopefully
> Pierre can given them a spin and report back if it all sorts his
> problem).

Now live at:

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/urgent

Please test.

