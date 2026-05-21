Return-Path: <cgroups+bounces-16164-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPA/LRIaD2qLFgYAu9opvQ
	(envelope-from <cgroups+bounces-16164-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:43:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ACA5A783E
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4792731BD519
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F71028C869;
	Thu, 21 May 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ev4oglUl"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2417557E;
	Thu, 21 May 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372109; cv=none; b=ceGGC2ABqeaVQLrNvTQOWtaverCRZ66uUg9GgRLIcQHxl0ksbbwNO4eQzKtYoRJ+nolQDpPEV9WayNPipTLNxGOH9dmh2XifwWdTaaMp3t6S4btGiPs1rR5def53CAqyq2vmGZrd6rGmFpsj1rPNXUgGKXITsVSW7PMRibPGpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372109; c=relaxed/simple;
	bh=4X4dTrVnrCRdwq2PmmSlsN4CQJiNMpOytx931h2D08Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kywsShMUfLbVTxE9qu9GfzhjO01VGyeWL2aYvw86UxW3/4K+5Bhkvkl1tv9r/BLEhtbmcf8EiqrpWxoP7nJwQlsPbCjKrr0D8W+JPyDhWCx2iSz3BBS2UpbYskef9TH7Pu/MiNJUIkrf/FErSBGpiGb8z/kUdMuGhtUwaheWVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ev4oglUl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PpDhFcKLuOh+elUZrw78LX6XjQa12MKYgZFF//LfsPM=; b=Ev4oglUlz6u0dyrn6LfWVecjiB
	RLPQvWCAP8+RvPnIdecVuo/K19Pccg4YFXq0x8kOSOX+yt5T/S9sOYmKKxaLA8oyP0NkmYd0NpxT5
	py4UUp3tUqNxJHrdZD0MvarIqKwcv2s63yxQ0FXqH9Ny3xGmnTcP1Xz2iKqYe+kjHqLZAfExQrFtL
	jjceZKcOkTGxbx84i3zP6KMJ8jd5AcZbygDoPawYYRLrDQpr/PB6T/yyCzQRPDF15pW6yvUfpd1BT
	0YgZPxke+zdSCbJDDmHyCITt86biOJ2Fc0cyQdO51xHN58JDU7SFLbHJpDF4NRV9MyNG7cUNSUNQU
	bfaJYpyA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3xp-00000008Z3v-4514;
	Thu, 21 May 2026 14:01:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B24D93005E5; Thu, 21 May 2026 16:01:28 +0200 (CEST)
Date: Thu, 21 May 2026 16:01:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
Message-ID: <20260521140128.GS3102924@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube>
 <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
 <CAKfTPtCpt7jYSPF5-wE8jjVPMBJrp_SGUV4brpbF9tASaJFp5g@mail.gmail.com>
 <20260521132901.GJ3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521132901.GJ3126523@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16164-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 34ACA5A783E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:29:01PM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2026 at 02:13:48PM +0200, Vincent Guittot wrote:
> 
> > > Would it not be simpler to just move the update_entity_lag() call up a
> > > bit, like so?
> > >
> > > ---
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7999,6 +7999,9 @@ static bool __dequeue_task(struct rq *rq
> > >
> > >         clear_buddies(cfs_rq, se);
> > >
> > > +       update_curr(cfs_rq);
> > 
> > I agree it's simpler although we will call update_curr twice for one
> > level, but the 2nd call should be nop because of delta_exec being null
> > 
> > Prateek proposed update_curr(task_cfs_rq(p)). Using task_cfs_rq(p)
> > will ensure that we keep the same ordering as for_each_sched_entity
> 
> Given:
> 
>     R
>     |
>     G
>     |
>     t
> 
> Then task_cfs_rq() will be G's cfs_rq, while cfs_rq is R's cfs_rq.
> 
> Since all the actual running happens inside R, this is what is required
> by update_entity_lag().
> 
> Doing update_curr(task_cfs_rq()) here doesn't make sense.
> 
> I'm not sure I see a way in which running them out of order hurts
> anything.

Bah, I'm so full of fail. So update_curr() takes ->h_curr, which for R
would be G's se, not t. So yeah, Prateek is right and I should stop
trying to do more than one thing at a time :-(

