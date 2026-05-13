Return-Path: <cgroups+bounces-15875-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEHRJjIoBGrGEwIAu9opvQ
	(envelope-from <cgroups+bounces-15875-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:28:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61752EA18
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 806FD301DC2F
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D33D6CB3;
	Wed, 13 May 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDGXOrNS"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223339D6F8;
	Wed, 13 May 2026 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657324; cv=none; b=DdPbF4GI6ja8RCeFB9O20X3gCtlYEs7EDspqrTB3221SR+nCBQwiphbOftb4LtqFB6h5Y4AvkZd0NbJLQEhpmvQisB2BF8On7NYDdIkPlAcN9AU1bVNBQnvqx98xtKu7DMwSTicwlTfdwRIc6OE+Njx9B6W7vfLDEyU2q3Em8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657324; c=relaxed/simple;
	bh=DJv31fGQkpYt60L4skbC4LX1oXixrZOVqcm1+idtPZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9RFCFhyAJbAfM+ssv5Dc/gLAj0ZcoGDgZmoe6Z7BGakxM4UVa6mCrRQLjhJ8GFG3HsbcEyia+cXkEu0rFhT7AKzLrxE5bUCVs8pVSZ1nkqZJof47qkJKLr8Pn1bp3OJ2vDOm+SXGleYMR3sWsCq1vw5E2c3ZsMCxX6CTnKv4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDGXOrNS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jqzsYPbHrjWbDiCV5rjOx3nyZTqrTMDf0/dQxJUxs1c=; b=BDGXOrNSTD9Mf7iUtZvWpbEJ/h
	xTq9ml3yAZO0Tro2BKGffm5ZTDQ6kjxMvWymNve85FAyzWhRDqTaHNm9IDU170TU6KdrJBUI5Z/77
	YiolZXSl2cjFmi8Y0qJFUOe5ty0oTFozqBVNloqdWuKrwzHW4fg0A5iypStNj4pnVeBuhFWMs6MnT
	wFPbw170xN4ipC0eD9xoq1yKgXOPkDfRgDyN8JnlveK4zJW0Hi+smKSYE+0GDiVs6ChI8LC0Ojo3g
	XoSoazeWORIcym4CZ/8MJpZOmujqoIdsjbK4gIpUGlV0lIFXh2nRDerHktqf25dwS5TvAI2F3l7S+
	GZzzNqkQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN3yh-0000000GlLK-2Rm0;
	Wed, 13 May 2026 07:28:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72493300BDE; Wed, 13 May 2026 09:25:59 +0200 (CEST)
Date: Wed, 13 May 2026 09:25:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	qyousef@layalina.io
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
Message-ID: <20260513072559.GF1889694@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <133c4d08-5dfb-4f4f-83cb-f9652d4212ef@amd.com>
 <20260512110932.GB1889694@noisy.programming.kicks-ass.net>
 <dc4df15c-2f21-4141-ba7c-b2d8afbcd0c3@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4df15c-2f21-4141-ba7c-b2d8afbcd0c3@amd.com>
X-Rspamd-Queue-Id: 2F61752EA18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15875-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:31:05PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 5/12/2026 4:39 PM, Peter Zijlstra wrote:
> >> @@ -13819,6 +13831,12 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> >>  		if (on_rq)
> >>  			weight = __calc_prop_weight(cfs_rq, se, weight);
> >>  	}
> >> +	/*
> >> +	 * Add throttle work if the bandwidth allocation above failed
> >> +	 * to grab any runtime and throttled the task's hierarchy.
> >> +	 */
> >> +	if (throttled_hierarchy(task_cfs_rq(p)))
> >> +		task_throttle_setup_work(p);
> > 
> > We already call into account_cfs_rq_runtime(); which basically does all
> > we need.
> > 
> > I think the distinction between account_cfs_rq_runtime() and
> > check_cfs_rq_runtime() no longer makes sense. We can throttle a cfs_rq
> > at any point now, since we no longer remove the cfs_rq, but rather we
> > make the tasks suspend themselves until the cfs_rq naturally dequeues
> > for being empty.
> > 
> > Something like so perhaps?
> 
> That makes sense! The task should naturally execute the task work when
> exiting out of the kernel / IRQ handler into the userspace so we should
> be good.
> 
> I'll rebase the below diff on tip, test it a bit, add a commit log, and
> send it your way if you don't mind or would you like to keep it with the
> flat_cg bits?

Nah, this seems like something that can be done independent. And thus is
should be. That flat patch is big enough as is.

