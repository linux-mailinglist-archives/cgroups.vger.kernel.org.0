Return-Path: <cgroups+bounces-15860-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEeGIJRxA2q55wEAu9opvQ
	(envelope-from <cgroups+bounces-15860-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 20:29:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDE527A0C
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B99FF308E811
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46A382F2C;
	Tue, 12 May 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9Sm/nsk"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609D3EDE51;
	Tue, 12 May 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610355; cv=none; b=IiXIQQuqX+IyN+bY2zE7uHbQTFQcSGAC56yR761vF0iOQf0MOQrFPikAmvCpbrq2dFf4dAUgS0/o6X0WEet/qoM6UyyhgsnN5GyA0LIMsYckRqpJ55ox00etdDKadmfpeninVgJsKtpGjChhH69pXHCS6KLHK2hmzQLM586qskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610355; c=relaxed/simple;
	bh=To7mJ7+Td3uQVTAjbowa0CA7iU6pgortI6FFiqIn1I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwLDGLZcVk62ot+B9ETWzPgcsqE9eIn6obFqMWl/LUuSvxCX9VA9EtzFq2BAAfTFOKy9XtxD8Pe3QZKUaC9NK20CMwlBdcHKX0DNZ2VTTwNxaxBnV8QaD5XDv6EEI50wWEmYs/bsQHsfmraGxe/uDUZmi89wqmxeOi5f0hzisVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p9Sm/nsk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xH6WE77CT/nuZIKx6+l2ZYiqMAlpA65dKL0thlpwzHY=; b=p9Sm/nskOxQ3TunDDy7PXcG+XO
	RO4p9M8NgS1VmGLI+QRCQydVzg/rW6VQ66JYhwoMFNBwy3Vkhrf93jP8J2z71e1g97zG7clMmWXzy
	+8u6EI95XyP5IBTVLEpyUP1MQClhPyRTob7uONAwZerSfhGrQvMy6HOWnSnuMRc8eVsVb13qoynC7
	4UMB1dHvB8SnTg24583+JrDKJlXz4ykQzPTwDiF7VcHPpCeOqyy3TUVosGAuXWx7/bEoBha47XBES
	Qka9qjZvzReTM/KTecqNrMn149qJRIEM4mFcGmIVASWNectcYfJaXawRL/V86VJ0p2ni/g8RgaN88
	GZHPCb/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMrnP-0000000FcLW-2Jxn;
	Tue, 12 May 2026 18:25:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D7069302F8E; Tue, 12 May 2026 20:25:30 +0200 (CEST)
Date: Tue, 12 May 2026 20:25:30 +0200
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
Message-ID: <20260512182530.GB2855641@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260512092040.GN3102624@noisy.programming.kicks-ass.net>
 <20260512182439.GA2855641@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512182439.GA2855641@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: 01CDE527A0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15860-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:24:39PM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 11:20:40AM +0200, Peter Zijlstra wrote:
> > On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
> > 
> > > 
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
> > > 
> > > I will review the patchset and try to get what is going wrong
> > 
> > Yeah, that is unexpected. Let me go have another look too.
> 
> So I can reproduce even without the last patch applied. I suspect it is
> in the cgroup mode patches somewhere. My first suspect is that concur
> mode thing doing bad things to track the 'global' nr_running thing.

Argh, n/m PEBKAC. I'll try this again in the morning :/

