Return-Path: <cgroups+bounces-14861-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QECqAt1qumnnWAIAu9opvQ
	(envelope-from <cgroups+bounces-14861-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:05:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4772B8A5E
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 582BC303B4D3
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDA36C0B7;
	Wed, 18 Mar 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O8Xpap+l"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C1392C3A;
	Wed, 18 Mar 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824592; cv=none; b=NdoTbMh7jVI/wdbEbHoTjJd77ku03riL4onvnFRoiFjhfcfB9qf7453mIejwOLhilyEUU37BY7cUU2D92GVyeyh9wE1u8kI5wgoCVj6Wu4CkuwfDtfP2dKfT1xEaIfkN0D2d64d+dsIfn0qMWfeCg8OKK+geHxJiyN5XW/rOGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824592; c=relaxed/simple;
	bh=y+igbPyBNoJzyUZWac9pYNzpR0+D8wuRRbSVJttzpt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv5CcclLU8w3rJ+dYUb/AY8v42buynaj5I2hrLrh1VKP3Ssc5AEC8DZpfkTwUuTD0tyIQrDoEHqL2fPS7d5fKejOsF1t0WWGjh1YREZaNkzqh2TY6s74bo6VVlFjgphmm25uKbMA3qq/oa3lSSHLKqYxcBJe0EJ1oYZCi38Lw3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O8Xpap+l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QbbsA76HDYSuEudE+7hi5OEI6ET5j03hz+4ah49fLkE=; b=O8Xpap+lVVdyBTrnxsM2eNCFUW
	BxYEO1ib+0Wc/onAqkArMN8ZVFDjbNfcJQvV/z4vB1kE9OKlQb/9vbVEJ1YiFMeWqz93uhWpyl5fc
	nNsVVECsj8b6IeeMq7eFQjLR9tvE8oHxjoafsGNebt07NVt1N3rk/Z6FunRgQ/lxmuESMga4AOmZ0
	u7EEEowV757HR8Qgz/vLwKg1hG1LGKpq6iA8FS7MJzMnPhagWqlRotr/RUiX7sAuOZ35jQJV8XPAd
	fp0WZO7U+0vm3prPUvMkBxr/fa6ykO11esdnsKn735uSW+zknEwENDXq1RlzbEVY/nXatFCzWcnJm
	iOwhpC2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2mnp-0000000AmLl-113A;
	Wed, 18 Mar 2026 09:02:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14EB3303249; Wed, 18 Mar 2026 10:02:56 +0100 (CET)
Date: Wed, 18 Mar 2026 10:02:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com
Subject: Re: [RFC][PATCH 8/8] sched/eevdf: Move to a single runqueue
Message-ID: <20260318090255.GG3738010@noisy.programming.kicks-ass.net>
References: <20260317095113.387450089@infradead.org>
 <20260317104343.338573840@infradead.org>
 <dc1a390f-16de-49b2-af85-a9df3f62eb8e@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1a390f-16de-49b2-af85-a9df3f62eb8e@amd.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14861-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7F4772B8A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:16:52PM +0530, K Prateek Nayak wrote:

> > +	/*
> > +	 * XXX comment on the curr thing
> > +	 */
> > +	curr = (cfs_rq->curr == se);
> > +	if (curr)
> > +		place_entity(cfs_rq, se, flags);
> >  
> > +	if (se->on_rq && se->sched_delayed)
> > +		requeue_delayed_entity(cfs_rq, se);
> >  
> > +	weight = enqueue_hierarchy(p, flags);
> 
> Here is question I had when I first saw this on sched/flat and I've
> only looked at the series briefly:
> 
> enqueue_hierarchy() would end up updating the averages, and reweighing
> the hierarchical load of the entities in the new task's hierarchy ...
> 
> >  
> > +	if (!curr) {
> > +		reweight_eevdf(cfs_rq, se, weight, false);
> > +		place_entity(cfs_rq, se, flags | ENQUEUE_QUEUED);
> 
> ... and the hierarchical weight of the newly enqueued task would be
> based on this updated hierarchical proportion.
> 
> However, the tasks that are already queued have their deadlines
> calculated based on the old hierarchical proportions at the time they
> were enqueued / during the last task_tick_fair() for an entity that
> was put back.
> 
> Consider two tasks of equal weight on cgroups with equal weights:
> 
>     root    (weight: 1024)
>    /    \
>   CG0   CG1 (wight(CG0,CG1) = 512)
>    |     |
>    T0    T1 (h_weight(T0,T1) = 256)
> 
> 
> and a third task of equal weight arrives (for the sake of simplicity
> also consider both cgroups have saturated their respective global
> shares on this CPU - similar to UP mode):
> 
> 
>                             root        (weight: 1024)
>                            /    \
>          (weight: 512)   CG0    CG1     (weight: 512)
>                          /     /   \
>   (h_weight(T0) = 256)  T0    T1    T2  (h_weight(T2) = 128)
>                        
>                            (h_weight(T1) = 256)
> 
> 
> Logically, once T2 arrives, T1 should also be reweighed, it's
> hierarchical proportions be adjusted, and its vruntime and deadline
> be also adjusted accordingly based on the lag but that doesn't
> happen.

You are absolutely right.

> Instead, we continue with an approximation of h_load as seen
> sometime during the past. Is that alright with EEVDF or am I missing
> something?

Strictly speaking it is dodgy as heck ;-) I was hoping that on average
it would all work out. Esp. since PELT is a fairly slow and smooth
function, the reweights will mostly be minor adjustments.

> Can it so happen that on SMP, future enqueues, and SMP conditions
> always lead to larger h_load for the newly enqueued tasks and as a
> result the older tasks become less favorable for the pick leading
> to starvation? (Am I being paranoid?)

So typically the most recent enqueue will always have the smaller
fraction of the group weight. This would lead to a slight favour to the
older enqueue. So I think this would lead to a FIFO like bias.

But there is definitely some fun to be had here.

One definite fix is setting cgroup_mode to 'up' :-)

> > +		__enqueue_entity(cfs_rq, se);
> >  	}
> >  
> >  	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
> 
> Anyhow, me goes and sees if any of this makes a difference to the
> benchmarks - I'll throw the biggest one at it first and see how
> that goes.

Thanks, fingers crossed. :-)

