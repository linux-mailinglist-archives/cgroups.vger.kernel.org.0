Return-Path: <cgroups+bounces-16315-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKy+FxuWFWp9WgcAu9opvQ
	(envelope-from <cgroups+bounces-16315-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:46:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894AC5D5BCD
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FC47302A4D8
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B81EB1AA;
	Tue, 26 May 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCm1vazp"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72275155C82;
	Tue, 26 May 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799575; cv=none; b=gCeFocYeMO7cFOsvdxShbCQ9iK0olxrYkEQoI3Shg1wzq6hBrjx24T69y0F0XwY5A4uxzDrjbM81ir+Ok4ySyEshHQmIn4VcomxfJH7Y0MHk4JtTD3XXZPw9iCFHl0kZ79LaVCEPT5Kg3dc8rFeB238lm4bt296Pc6ANPYjaBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799575; c=relaxed/simple;
	bh=U4Xzy5I1tp3zXSneLh4gKr+RJFv0GfIKo3Dm/LmTU28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRFfr/WU3O2yyHpfSuT7gQxoDxjZWZi9IwZw+QpWVU3joSSprnoGETX3EF0QX+Am+C8dIs60cWefLJk19mIx2IT0wO53qauiFEWUI2iilh58u3DsuyNaBlUZO9zvY5Mhic0JB/DM83YMqSHwUhRfSEQLZZULI/DS8gSbKJ5CGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fCm1vazp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rkgWCF29mR6MYm02fUHtiVL/nxLhy0FulB0I8BQLvz4=; b=fCm1vazprDjxmazoOQ1ab+SiM+
	T7pWjDExompMsjslBW/ptyGKZYpsd3ostYltnRCwCsiDvQlRwinFop4B0kNye0uPlP4MC5hIc8hRZ
	1CC5dnCXabtHF5JZwUj/072VocFyJEaI93A08j6F6486TJdyk7jzbzbQkllElvjjfDPP1EAF5EYL7
	TD68P6NKrJAzE2Oup/gdmGf+WoNodGzMQOA7dnRfYpzPKaK3j4pjmi04S364YAWSDZDxyWlRVP+2e
	mOjfeILeMv6cxdkABuMtZnPJR6XIAJcgWsS/QJhRv4Ap7dsVsEJwJ+9BvXBYtWaKhofOUJHGj6cL8
	CQZt/W4A==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRr5W-000000013NZ-0Vs3;
	Tue, 26 May 2026 12:40:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D234300323; Tue, 26 May 2026 14:40:48 +0200 (CEST)
Date: Tue, 26 May 2026 14:40:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Zhang Qiao <zhangqiao22@huawei.com>, mingo@kernel.org,
	longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	qyousef@layalina.io, Hui Tang <tanghui20@huawei.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
Message-ID: <20260526124048.GV3102924@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
 <85116808-8643-47d7-b4e7-2a11c3999b20@amd.com>
 <20260526095210.GC4149641@noisy.programming.kicks-ass.net>
 <3f1fc681-a73b-4bd2-9a6a-e61b8fbd5826@amd.com>
 <20260526110709.GF4149641@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526110709.GF4149641@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16315-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim]
X-Rspamd-Queue-Id: 894AC5D5BCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:07:09PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 04:24:32PM +0530, K Prateek Nayak wrote:
> > Hello Peter,
> > 
> > On 5/26/2026 3:22 PM, Peter Zijlstra wrote:
> > > On Tue, May 26, 2026 at 02:45:45PM +0530, K Prateek Nayak wrote:
> > > 
> > >> The suggested diff above solves the crash in my case but your
> > >> mileage may vary. Peter can comment if this is the right thing
> > >> to do or not :-)
> > > 
> > > Is this a different issue than the one you raised before?
> > 
> > Yes, this is different. Essentially, this is what is happening:
> > 
> >   throttle_cfs_rq_work()
> >     task_rq_lock()
> > 
> >     dequeue_task_fair(current)    /* Task is dequeued on cfs side */
> >       __dequeue_task(current)
> >         dequeue_hierarchy(current);
> >           current->se.on_rq = 0;
> >           /* update_load_sub() */
> >     resched_curr();               /* Initiates a resched */
> > 
> >     task_rq_unlock()
> >       local_irq_enable();
> > 
> >   =====> sched_tick()
> >           task_tick_fair()
> >              __calc_prop_weight()
> >                /*
> >                 * Oops: update_load_sub() above has
> >                 * 0ed the weight of cfs_rq.
> >                 */
> >   <====
> > 
> >   preempt_schedule_irq()
> >     next = ...
> >     put_prev_set_next_task() /* The runtime context is switched here */
> > 
> 
> Ah, right. OK, I'll go have a poke once I get these proxy patches I've
> been spending too much time on posted.

Yes, your solution seems reasonable. I'll fold that and push out a new
version a little later today.

