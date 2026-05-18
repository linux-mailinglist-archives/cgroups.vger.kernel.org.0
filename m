Return-Path: <cgroups+bounces-16048-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CnkHLSBC2pvIgUAu9opvQ
	(envelope-from <cgroups+bounces-16048-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:16:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20F573B62
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE6C308131E
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C524A3E;
	Mon, 18 May 2026 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SH1WblC4"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47F396D13;
	Mon, 18 May 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138811; cv=none; b=V8PfUsWdBTbe9kcoSFX2TbHHhXcP2uoVA4omVNsUXFeZE8N3kw76NGqbdcptAjGAD0GXvWiE5CypAue0AlO/fycbns4SCrSzD2b07P5sI4Djk+TVhgMQi7+dafERkVuNdpUR+OZRZpyJIH/oOrLBPMldNoEK3ickpqOteL00DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138811; c=relaxed/simple;
	bh=glRPy+T3VEld++JNwI+fJqBcRVqxWeoNhk7d0ihJb8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXwikN8vzy/Qj0IAR8IMADduDNv+8WQW2aWer0OIOLTkmzCISK1e49cZ5t4lGWH0NqqEMD27MsB6VQm+CTHMRk7dzxf0Ae3TBaKELLdVTcLKlzuDQBdNr8U83EjsMq1bgKYNXl4vTDDyqRT+FMbmf1Zkjb+yYrmzUm9QUzlezqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SH1WblC4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sOXgvOxiplvVHt7xJfFoPCb1TYYOJKSYO19fq+Z0iVc=; b=SH1WblC4BadfsMpE43wE/rmNzU
	FrpgNk4m+Do+178jV55ySubE2cc+rZzt84oLy7AQR7Fa25Awv9K8UXynTcXpluAJxLg4nYqpgpdYB
	vA4FTMN6VygqAgzQ7CjkvJ/ZkCL5lMA28HFA10y/KB+N2rBXYugF4CKl/SzkQf7uVbUsQJjkM8ivQ
	BwSkWFabJq3WN4tm4EBmZ9bDO+c84unDpJf+mE4+gmZzzcSxEORCYL8UfnEcX4mVd8W5JiZydVjlF
	emJWO9m7pmiIA3/HIdK+qGzbgpX46ax6LuGqt0FW05HT2guB+HKnhHX2PeLAEnx/8SGW+Uu4C+Qv2
	bHWjPtBQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP5GT-000000059IJ-1mMP;
	Mon, 18 May 2026 21:12:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6F9D3007A4; Mon, 18 May 2026 23:12:39 +0200 (CEST)
Date: Mon, 18 May 2026 23:12:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <20260518211239.GY3102624@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
 <CAKfTPtCXOnjtVV1gKLnbS8Lo6W4r8hbdUDYVYLMd2Qc1ZqBq4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCXOnjtVV1gKLnbS8Lo6W4r8hbdUDYVYLMd2Qc1ZqBq4w@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16048-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: CF20F573B62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 03:34:51PM +0200, Vincent Guittot wrote:
> On Wed, 13 May 2026 at 13:35, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
> >
> > > I haven't reviewed the patches yet but I ran some tests with it while
> > > testing sched latency related changes for short slice wakeup
> > > preemption. I have some large hackbench regressions with this series
> > > on HMP system with and without EAS. those figures are unexpected
> > > because the benchs run on root cfs
> > >
> > > One example with hackbench 8 groups thread pipe
> > > tip/sched/core  tip/sched/core          +this patchset          +this patchset
> > > slice 2.8ms     16ms                    2.8ms                   16ms
> > > dragonboard rb5 with EAS
> > > 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> > > 0,689(+/- 9.1%) +8%
> > >
> > > radxa orion6 HMP without EAS
> > > 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> > > 1,071(+/-5.9%) -82%
> > >
> > > Increasing the slice partly removes regressions but tis is surprising
> > > because the bench runs at root cfs and I thought that results will not
> > > change in such a case
> >
> > D'oh :/
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e54da4c6c945..77d0e1937f2c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9071,7 +9071,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
> >         enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
> >         struct task_struct *donor = rq->donor;
> >         struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
> > -       struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> > +       struct cfs_rq *cfs_rq = &rq->cfs;
> 
> I tested this patch on top of the series but it doesn't fix the perf
> regression on rb5
> 
> hackbench 8 groups thread pipe is still at 1.907(+/-7.6%) with default
> slice duration

Weird, I can't reproduce anymore with this fixed :/

I'll try more hackbench variants tomorrow I suppose.

