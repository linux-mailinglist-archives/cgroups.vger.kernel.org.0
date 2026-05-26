Return-Path: <cgroups+bounces-16305-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAVFKGt/FWqtWAcAu9opvQ
	(envelope-from <cgroups+bounces-16305-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:09:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E085D4AE1
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD0DF3018299
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C63DE452;
	Tue, 26 May 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bhj82YA0"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44143C5523;
	Tue, 26 May 2026 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793765; cv=none; b=AneEDfVUAYWlOR3QWiNa93sFASkSx2UpTkefMmQ03gVJD0tfvpCO31ZcphbrKzc0Bzh1Jz6iqqRkITlwkioYjMJevgKJ1XP+SAIEdffqvkxsdNmJuFxT1d/J2H1IqIzu+tmfJBMCwRyxyrTqEUNSofaq2quShEmLbEorb2/5nAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793765; c=relaxed/simple;
	bh=3tb/Bq+4xuotcPqSefpw8ff/qx48sZGrA5jTMiJqZns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzKkGerSvorrr4Q41oSUbx93h3BCV5+Iq39996B8b1GcMVD0N2E5zdziZqxfcsijA0hakRFBS86sHFBXE1XORDAdsDxQgIz0Zg5rlEZacXfrw/lYUwImYkFBDqXoOYI9ZqG9+hI0dGPruXMdQma5R9v4RLfNNXAWjqlUoNUJxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bhj82YA0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/L/pKQfUi0SfGq7Om76IMjN58fjpuxIzq6Zz0iNdLac=; b=bhj82YA0Xu8C60hQ9iJxO+Jf/I
	cphTw8JggZgSy4V9VXy/A+Ah1WcuG4Fx39hV6V/gW3HOUYOQ9maij+ZQZvlJYJjTeKnSa2LnAFwzO
	/N2ylj0oD0PDrmaroumhnxcD/p2waNm3n2hj67K16wkE/3tW1MW1bEVcV8XPLQJzqCma0trOFX2N1
	IiXfk+Gl1FHGjTSbqwVdkeqV3Alcm8VteHiBb9+t8gyOKbA0ei1iTwZcKcLCy57ZJ4mk/3pbP4+gy
	f//h4C1dPbWwi4aJs4Vl6PbQrYtqIcFjNMiWIeFwDebe1POcNRBreMoXsmDoWtFkbQKIK8KDFFLiI
	R5C9jJIQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRpcs-0000000B3Av-1FDb;
	Tue, 26 May 2026 11:07:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2B1C5300323; Tue, 26 May 2026 13:07:09 +0200 (CEST)
Date: Tue, 26 May 2026 13:07:09 +0200
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
Message-ID: <20260526110709.GF4149641@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
 <85116808-8643-47d7-b4e7-2a11c3999b20@amd.com>
 <20260526095210.GC4149641@noisy.programming.kicks-ass.net>
 <3f1fc681-a73b-4bd2-9a6a-e61b8fbd5826@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1fc681-a73b-4bd2-9a6a-e61b8fbd5826@amd.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16305-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Queue-Id: 16E085D4AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:24:32PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 5/26/2026 3:22 PM, Peter Zijlstra wrote:
> > On Tue, May 26, 2026 at 02:45:45PM +0530, K Prateek Nayak wrote:
> > 
> >> The suggested diff above solves the crash in my case but your
> >> mileage may vary. Peter can comment if this is the right thing
> >> to do or not :-)
> > 
> > Is this a different issue than the one you raised before?
> 
> Yes, this is different. Essentially, this is what is happening:
> 
>   throttle_cfs_rq_work()
>     task_rq_lock()
> 
>     dequeue_task_fair(current)    /* Task is dequeued on cfs side */
>       __dequeue_task(current)
>         dequeue_hierarchy(current);
>           current->se.on_rq = 0;
>           /* update_load_sub() */
>     resched_curr();               /* Initiates a resched */
> 
>     task_rq_unlock()
>       local_irq_enable();
> 
>   =====> sched_tick()
>           task_tick_fair()
>              __calc_prop_weight()
>                /*
>                 * Oops: update_load_sub() above has
>                 * 0ed the weight of cfs_rq.
>                 */
>   <====
> 
>   preempt_schedule_irq()
>     next = ...
>     put_prev_set_next_task() /* The runtime context is switched here */
> 

Ah, right. OK, I'll go have a poke once I get these proxy patches I've
been spending too much time on posted.

I think I've found a 'problem' with that PROXY_WAKING ==> '->is_blocked
&& !->blocked_on' scheme :-(

> > We talked about throtte, and you were going to make a proper patch of that cleanup
> > iirc.
> 
> I had rebased your suggestion on tip and fixed a couple of splats but
> once it was functional, I noticed hackbench taking twice as long to
> complete compared to tip and I was chasing that before I fell sick.
> 
> Let me go dig deeper to see where exactly it is all going sideways.

Sure, no worries. This happens; computers just never want to just DTRT
already. I lost a day and then some trying to figure out why my
seemingly 'trivial' proxy changes ended up trying to run a dead task
last week...

