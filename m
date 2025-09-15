Return-Path: <cgroups+bounces-10070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479FB57364
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 10:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBBA1A2013D
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2202ECD28;
	Mon, 15 Sep 2025 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pzdaJVk4"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9220CCCA;
	Mon, 15 Sep 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926150; cv=none; b=U9VW9UPTqIgaiF65iwV5ttRLbuB2EdY953hiJEJsOTh+FPuwhOgxmmB3QRzyFHdua4snkNuRrFu+UbrWQ3HNP7j99QPe+HJA4Edw/w20e3NNEh8TZfAdZhc8Qq3cTIJ8uLgeNb2hGo5HJEtsy/CzurjWbBqkuKBFC0aDgaXgwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926150; c=relaxed/simple;
	bh=1Hq7BE4gdFZftPb1aAXAIghgRQDX8TIAVhdgjgd60QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdLRqZQ6Cx+U3qsCYSAuVFwxEigL511lynhE/OMTrPvQ4mBr9U7l8ynRlHSvkaojDWiUPtw5X5MEB7flGYTAnG5WJYktffXBKSQ/D2zLCgqDg5G11RsJUJQJ7/oVN1s6fwOcYv03gynqLZRfrhsuB7lFduCmVQBeQdeEDXk2g9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pzdaJVk4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3bp4fFVaXgCbZQ3/oZPcoRxfkggdhuJoGajCHZtYWHE=; b=pzdaJVk4fPZ8FnMl5Crsd5o4Nv
	tRX0PxYhZpf5ZKOrOO3cawf8ukc+mrHznIXLCIq+gCyBRPDeCSuXVgQRAuZLiJ65V5lKgCnlOT6Ki
	MsgonN0/abMIen/z2+q2Z6t7ZCwEfWk2ng52ok04Kayj+JW/Xi7t4OLNCEZKfqQ19srtf2yWS+VPr
	/XJFiGLVox9p4wZ7rp5HI8E6Aq7iZ1yEWKqnzmUUXoVxYkcUA8QdK1CudRq3n/WronRTyFuFjX215
	1Y7ykhBK+gwTc7qmPpy/fpzqcYtwPLSFhnpoYt+MUndEzrYyCa3Y+bVA/UBoppkCt3PqCV0n+I2fm
	6Pl90Nfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4tN-0000000BbIv-2cEk;
	Mon, 15 Sep 2025 08:48:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A57B7300212; Mon, 15 Sep 2025 10:48:56 +0200 (CEST)
Date: Mon, 15 Sep 2025 10:48:56 +0200
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
Message-ID: <20250915084856.GC3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
 <aMRLIEtmcWc0XNmg@slm.duckdns.org>
 <aMXw-xvmGIZ9-UFJ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMXw-xvmGIZ9-UFJ@slm.duckdns.org>

On Sat, Sep 13, 2025 at 12:32:27PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 12, 2025 at 06:32:32AM -1000, Tejun Heo wrote:
> > Yeah, or I can make scx_tasks iteration smarter so that it can skip through
> > the list for tasks which aren't runnable. As long as it doesn't do lock ops
> > on every task, it should be fine. I think this is solvable one way or
> > another. Let's continue in the other subthread.
> 
> Thought more about it. There's another use case for this runnable list,
> which is the watchdog. As in the migration synchronization, I think the
> right thing to do here is just adding a nested lock. That doesn't add any
> overhead or complications to other sched classes and from sched_ext POV
> given how expensive migrations can be, if we make that a bit cheaper (and I
> believe we will with changes being discussed), added up, the outcome would
> likely be lower overhead.

I really don't see how you could possibly retain that runnable_list.

pick_next_task() must be able to migrate a task from a shared runqueue
to a local runqueue. It must do this without taking a random other
per-cpu runqueue. Therefore, a task on a DSQ must have no 'local' state.

This very much means the runnable_list cannot be per cpu.

No per-task lock is going to help with that.

The watchdog will have to go iterate DSQs or something like that.

