Return-Path: <cgroups+bounces-15874-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPVfChQpBGrfEwIAu9opvQ
	(envelope-from <cgroups+bounces-15874-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:32:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBC52EAEF
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CAC30BF0E2
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B083D6497;
	Wed, 13 May 2026 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hdnvmLqQ"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02937399CEF;
	Wed, 13 May 2026 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657324; cv=none; b=Sa2FWtZN47s+qsCtIf32bJ7dh0gtT8a1BcTEHwuAnR3kPkpDUsm3BbDbeHkMbYmQLmSGdPXxFp+rKsg1f4aZq+lcE7NGgXqdiiwDk0umOeIiwLAWxBsSucIxX6+7t9mxL2UbtDeaVZPGEh5hIstt4uSNnE9McbyiFqyufshzVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657324; c=relaxed/simple;
	bh=42AOEQUBwBuB/gmOZDF1E+KjyLk6+r/HsuYZ6WksJ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmyOmM2sPH33jGuEKCD58BZEbvu/0R4+dj/QnJEjWu/N1xRjI/KEjUibivHYUbS1MipZMNqVVnBxmrBL/JC9boangVLkrY+V4ddLizq/Mrikp0LN9MVmyQ0LKhdiqZumG2qxRKqwu+bpi9ajtDuiTpoElsl1UG21qHdlgNdenw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hdnvmLqQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IzAGYMx7uDKCue0uiQSrq/gponLm1tivP9HcSrBDwgA=; b=hdnvmLqQs6guRjQjvCX0NFJVm7
	YhtDeOblM8X8e889e6yAQRxKU0Tdx5JU+J5bQv4Y4A0stPRzmcgMUm6pGwG3cT3aFKEGPqgdQsb33
	1RDSjzGDa91HM6cBy25tTl1g8WwKoPWVT1kxofV9t9JN18dReuvupdX0sxVIxL8iI1CV4MIOJSWrr
	ogGc5atGPqdvBEC1tAX+MUgVQOCSpT6st6w6ocFmEXYeVQngWRp0PzUe8oCa4e4rWG918xH1nodzx
	WoUDJ5oqqhuvMw3uw+FRxPJy6z9f4Nh9epkuF8IxyQ7SpWX2bsHLW6k8cGiks5D52L9LmMBzNx4WL
	p5gRzFVA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN3xs-0000000GlIj-47MZ;
	Wed, 13 May 2026 07:27:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE766300B8A; Wed, 13 May 2026 09:25:07 +0200 (CEST)
Date: Wed, 13 May 2026 09:25:07 +0200
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
Message-ID: <20260513072507.GE1889694@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260512092040.GN3102624@noisy.programming.kicks-ass.net>
 <20260512182439.GA2855641@noisy.programming.kicks-ass.net>
 <20260512182530.GB2855641@noisy.programming.kicks-ass.net>
 <CAKfTPtBq6QO6yjL9SHWfL+pSoe=4_cddzYtqWGXtpLJmi8hSig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBq6QO6yjL9SHWfL+pSoe=4_cddzYtqWGXtpLJmi8hSig@mail.gmail.com>
X-Rspamd-Queue-Id: 76EBC52EAEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15874-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,infradead.org:email,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:32:12PM +0200, Vincent Guittot wrote:
> On Tue, 12 May 2026 at 20:25, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 12, 2026 at 08:24:39PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 12, 2026 at 11:20:40AM +0200, Peter Zijlstra wrote:
> > > > On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
> > > >
> > > > >
> > > > > I haven't reviewed the patches yet but I ran some tests with it while
> > > > > testing sched latency related changes for short slice wakeup
> > > > > preemption. I have some large hackbench regressions with this series
> > > > > on HMP system with and without EAS. those figures are unexpected
> > > > > because the benchs run on root cfs
> > > > >
> > > > > One example with hackbench 8 groups thread pipe
> > > > > tip/sched/core  tip/sched/core          +this patchset          +this patchset
> > > > > slice 2.8ms     16ms                    2.8ms                   16ms
> > > > > dragonboard rb5 with EAS
> > > > > 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> > > > > 0,689(+/- 9.1%) +8%
> > > > >
> > > > > radxa orion6 HMP without EAS
> > > > > 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> > > > > 1,071(+/-5.9%) -82%
> > > > >
> > > > > Increasing the slice partly removes regressions but tis is surprising
> > > > > because the bench runs at root cfs and I thought that results will not
> > > > > change in such a case
> > > > >
> > > > > I will review the patchset and try to get what is going wrong
> > > >
> > > > Yeah, that is unexpected. Let me go have another look too.
> > >
> > > So I can reproduce even without the last patch applied. I suspect it is
> > > in the cgroup mode patches somewhere. My first suspect is that concur
> > > mode thing doing bad things to track the 'global' nr_running thing.
> >
> > Argh, n/m PEBKAC. I'll try this again in the morning :/
> 
> Reverting the last patch is enough to recover performance

Yeah, I was on a fail-streak yesterday. I forgot to copy the kernel
image before reboot ...

Lets see if today is better :-)

