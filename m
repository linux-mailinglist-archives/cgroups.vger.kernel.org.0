Return-Path: <cgroups+bounces-15893-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDc9IRx0BGprIQIAu9opvQ
	(envelope-from <cgroups+bounces-15893-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:52:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A315335DA
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63FDC302FFCA
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF3413240;
	Wed, 13 May 2026 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ee2tYia9"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9454407582;
	Wed, 13 May 2026 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676220; cv=none; b=rUutRpvE4+UCBMEw7akusKUR0/iskxr+NQOjlyowvSRtkaIShFDXF6U5wMGaaiYwfDaYhX56J8O4PJGe9mXuXhKSaWI/D4csqGQLu1Tp6ll6927JIkBAQsdcgz6cTdhTzGe8FrEgTunrQUuFP3YzxwqFCY7OqC/2aiKrusi9iwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676220; c=relaxed/simple;
	bh=gRPvs6PXPbu7knhieTEtFOxn5jJTFgZyfo5qVpi9dGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGdr0TZDwaCL1+q1z0RQKZa38qbjNLXd5ZD5YJbxrP9aqvglGt2ZlMY3vg52kod8DENZOYLYqJ7Tu1p7wLIvZaGu/MwY3F2ugXutSETu9NKR08DyyevExj5/FKk5xdmxxBQVapZRFfOfO6rzy5CY4mvdtwN9HkVREFYJWiJ9BvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ee2tYia9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y3vovCO+Igd7oq8tTCnKK+WLaG5HU8hllZSY20e2fe0=; b=ee2tYia9sDjXgybttdycQlDgxX
	JkBbvZqisnf/ZI7K2RT4gzxKzlvLfZVcO6rzLsooXHpx3TWII1ysmq3r6fjXoO7EdNeJ1CXgL3IjI
	nL1SC3v4vuLTLHN3Arm0lpg0gY0mJ1unMxnVW/X9T4Hqu0LXopdCsEp5j9lhISBvB2CyT9G6kN8FW
	YjwtZqCOJZAa4+cBw6nwHWJP61GU85MLDT/Rzgip+z95n6vMIruPIN/8u36LLjQXAMBwedT/D+5bo
	bdrF/wJ9bs+AM3yPvnFHRpT+aDkZSCitP74dhXGVEaCSKmRAhs1GNyc2PdmtS1/VLQm11+1YQwZDF
	8m0B+XKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN8vd-0000000HS4U-1Vvc;
	Wed, 13 May 2026 12:43:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82C5F300382; Wed, 13 May 2026 14:43:08 +0200 (CEST)
Date: Wed, 13 May 2026 14:43:08 +0200
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
Message-ID: <20260513124308.GA1283187@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: 88A315335DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15893-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 01:35:10PM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
> 
> > I haven't reviewed the patches yet but I ran some tests with it while
> > testing sched latency related changes for short slice wakeup
> > preemption. I have some large hackbench regressions with this series
> > on HMP system with and without EAS. those figures are unexpected
> > because the benchs run on root cfs
> > 
> > One example with hackbench 8 groups thread pipe
> > tip/sched/core  tip/sched/core          +this patchset          +this patchset
> > slice 2.8ms     16ms                    2.8ms                   16ms
> > dragonboard rb5 with EAS
> > 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> > 0,689(+/- 9.1%) +8%
> > 
> > radxa orion6 HMP without EAS
> > 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> > 1,071(+/-5.9%) -82%
> > 
> > Increasing the slice partly removes regressions but tis is surprising
> > because the bench runs at root cfs and I thought that results will not
> > change in such a case
> 
> D'oh :/
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e54da4c6c945..77d0e1937f2c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9071,7 +9071,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
>  	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
>  	struct task_struct *donor = rq->donor;
>  	struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
> -	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> +	struct cfs_rq *cfs_rq = &rq->cfs;
>  	int cse_is_idle, pse_is_idle;
>  
>  	/*

With that fixed, I now get:

	vanilla	slice(*)

FPS min	  3.0	11.1
    avg  44.7	57.3
    max  88.1	96.2

FT  min   9.1	 8.0
    avg  41.4	21.0
    max 157.2   53.9

FPS (Frames Per Second)
FT  (FrameTime)


Which I suppose shows we now preempt less. Its still significantly
better with reduced slice, but not as good as it was.


