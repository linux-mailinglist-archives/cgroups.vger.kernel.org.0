Return-Path: <cgroups+bounces-10049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D66B554B3
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38BA1C20995
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982CC31C582;
	Fri, 12 Sep 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJdc4e2/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08731AF31;
	Fri, 12 Sep 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694754; cv=none; b=Y689YXc92s7Lpm2dv9MdfWom7ouyqhtBI5yVrnsD5jbv6Ka4VJN9iMx8EJuR87W+0OfyEjO9ewzBzdDa66CK9XuzncLcghS6PsU1z2T3C5jNT/l20Z4MjK4QabUW7RV/xaTHdTldXtBlFMa0dtsEwbJFKiwF4UjmmvdOhl1+UX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694754; c=relaxed/simple;
	bh=k6DozkD2qnAlpcYCFgcPvCG/FlOIBf8mDL1YnHlApZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh+zwrCc26x2TEviJ8/WT9+QqbX1MPJSqILJxwlO7ML6ukTeeiG3tTuDE3IIUUAWgfJzwJ3dx5W6nyFjiMqrxOJRkf/RZR+a06/Muko3qp0Bk2AKS46jmUDG/qgAXiTmX4NesT8yAx2AujxKVb0q5Bz/EmtGflLHcFGAIL5u9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJdc4e2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF165C4CEF1;
	Fri, 12 Sep 2025 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757694753;
	bh=k6DozkD2qnAlpcYCFgcPvCG/FlOIBf8mDL1YnHlApZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJdc4e2/OhFsiErFJ0J+4XpIWuoqHEcSOQbMz5LgEbe4McWH2PybozfrYwcVVxK+I
	 VZw81bZQbl1DpEnTMrhUSgafgFWJS8MrnuU3fRkrnubwtMKZWmlwdLCsDXF/RVLevW
	 208QzIeNQlBL0t72p8cavBRc3JDYt0s3FJUY9D/p/p0SXfl+U7U4Z+GDKsdv+oSMF6
	 CPqtImiK/C3IQc3o93p+Jmhg234lVDBHP52vFDnwVtrvd5WZJ2XYCSUBXkMQbmxk90
	 hXPk+v6ZmVQ7otvkXFPzD+YLUX6mPzUs6k4AePv2vuQOi6lfRFL+2Q/xI1oRg1aIBv
	 2JNeBB+zl6HMg==
Date: Fri, 12 Sep 2025 06:32:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <aMRLIEtmcWc0XNmg@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141904.GA3289052@noisy.programming.kicks-ass.net>

Hello,

On Fri, Sep 12, 2025 at 04:19:04PM +0200, Peter Zijlstra wrote:
...
> Ah, but I think we *have* to change it :/ The thing is that with the new
> pick you can change 'rq' without holding the source rq->lock. So we
> can't maintain this list.
> 
> Could something like so work?
> 
> 	scoped_guard (rcu) for_each_process_thread(g, p) {
> 		if (p->flags & PF_EXITING || p->sched_class != ext_sched_class)
> 			continue;
> 
> 		guard(task_rq_lock)(p);
> 		scoped_guard (sched_change, p) {
> 			/* no-op */
> 		}
> 	}	

Yeah, or I can make scx_tasks iteration smarter so that it can skip through
the list for tasks which aren't runnable. As long as it doesn't do lock ops
on every task, it should be fine. I think this is solvable one way or
another. Let's continue in the other subthread.

Thanks.

-- 
tejun

