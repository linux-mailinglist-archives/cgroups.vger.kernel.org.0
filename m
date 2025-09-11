Return-Path: <cgroups+bounces-9986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641FB52D76
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244B9584F33
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249A2EA754;
	Thu, 11 Sep 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hdg+XIoS"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EE22126D;
	Thu, 11 Sep 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583777; cv=none; b=TRC+0Ar1ZxVgE3Eq+eMTuvE394Dri7mR4UUkmInfUPU6HuguDep8sh//nqQ4erQJCLykGQRX9+Rs1VVkvachU217VFuOR0Z5URZTwnQTW1o8ilRz9b/Su9p+FDOcbuZWJIv7lIkCUpiz3mICdMiQ/bU9CwtGZ+I9lPEneKiP9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583777; c=relaxed/simple;
	bh=eoF+xhQuZZiXGE3ETMzOfqIvoFjC9irk5xTR5tysIP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9DG5lnIvzjTgyJyPkfLM5see7HPMtVDsRVrhh139QrJofYbWnTH3zgSn6e1IkKHeJ5KPs+ffSvz3ehD0NgwOfC90E10lAJ1kXGG3swTTCx6F4pfiGJIKXsnDpxjJWIAKCMpIOpV7Unhjvk0jbXGkIK1bBR/wIfm5kl1gdWrwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hdg+XIoS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QmjX2Bdx8mXSpadVmIH0ku1notQE8AZgDmia0TULekg=; b=hdg+XIoSfq2sK+i1KAtCVawnVG
	oV0zjbDB1VzQajgn+jl7l967T4kHiYorzjYwtiTJiEvlofMiL4Xd7P7FdI2chscA6SDTMauY7Rc9l
	iFebO3xYsu5PrLV/RSFoCrGtCbt/mei4XB8nWrYEjEqyU4a6t2RNhLv1Jx9XhQ4JizlOl7qLcWsuu
	BKn/Ud5WZoLJGAGcFi1uIu9gaGsd7bCneDdV84mthvct4TNmLqSMvaEXuNcPH+0gOEXgSGK+Omc2I
	9XAm3/ulpLNBpGjB3vv/3spiYh3DH+tIMVcB7J2fk5ZNgiNMJ8SN+7cLm3C4bZ+fKiLIo9GTvsNXg
	ZQZuoiVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdpC-00000008Yj2-1dia;
	Thu, 11 Sep 2025 09:42:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C836E3002EB; Thu, 11 Sep 2025 11:42:40 +0200 (CEST)
Date: Thu, 11 Sep 2025 11:42:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMItk3c5H6Z2CD4X@slm.duckdns.org>

On Wed, Sep 10, 2025 at 04:01:55PM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Wed, Sep 10, 2025 at 05:44:22PM +0200, Peter Zijlstra wrote:
> > Provide a LOCKED queue flag, indicating that the {en,de}queue()
> > operation is in task_rq_lock() context.
> > 
> > Note: the sched_change in scx_bypass() is the only one that does not
> > use task_rq_lock(). If that were fixed, we could have sched_change
> > imply LOCKED.
> 
> I don't see any harm in doing task_rq_lock() in the scx_bypass() loop.
> Please feel free to switch that for simplicity.

I didn't immediately see how to do that. Doesn't that
list_for_each_entry_safe_reverse() rely on rq->lock to retain integrity?

Moreover, since the goal is to allow:

 __schedule()
   lock(rq->lock);
   next = pick_task() := pick_task_scx()
     lock(dsq->lock);
     p = some_dsq_task(dsq);
     task_unlink_from_dsq(p, dsq);
     set_task_cpu(p, cpu_of(rq));
     move_task_to_local_dsq(p, ...);
     return p;

without dropping rq->lock, by relying on dsq->lock to serialize things,
I don't see how we can retain the runnable list at all.

And at this point, I'm not sure I understand ext well enough to know
what this bypass stuff does at all, let alone suggest means to
re architect this.

