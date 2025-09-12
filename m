Return-Path: <cgroups+bounces-10045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5285B5508F
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044917C3FF1
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5955D313525;
	Fri, 12 Sep 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVBzqUt4"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE530F800;
	Fri, 12 Sep 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686332; cv=none; b=sg58sjid7xCOcAot+yr6G7AtG1QKwkEteJqUJj4pKV4Ve3wDyTVLZnulc1PtVeD3Wy6tXOyVAqDe2smnevq74i3E31bTVvaH0i7SDbV21SEzPUc4D6FjKO+JVNGkfJmgLD6PGnw7bLFEcMOnPJdHTYReZDB3F3GCLk0gRFxIQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686332; c=relaxed/simple;
	bh=S2W16AqL/yJVfSvd6onR+MyfPBJxRwx2+yqvvAEySnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgqiRh5PTlyXvMM/l/KK44N3LURDYIOv+jPLJqhQRM4ZK7JZJjGjC+HTWz1ulShiKZ7ZRXdntcDSM5UgWtKDNA3sTzZqmdi7eHvycWTA9eD137Kc29TETayclu1AnMFo7DVh51gworc4ROxA4IVo2HW5qkYeeNmX7p6bi8+jbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NVBzqUt4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8oQI0JKp33i40J2KNP9dwR222zQEHIkhUDjyNzOj4GU=; b=NVBzqUt4DD2XB6D9rUubsPPfsk
	MwFDlvLG3jDu7t0jC3+BL6Y9/khMnd0KBTmlRUGlSNOgQDz7ayLtgzERg/e8r9I+y9D2RQdhtIjlv
	ofBNsE1LRc5Hr4sVaIUwL0MJmm12XqYowbvxl2i6A0bRYAIvRhe9oUlfkn8i7ePu0XIhwSRasa/rW
	TAUyNVbKcH+IemikdjlEBY/XhRb5ZGJiMN+4Lb1tCu3kmUka1OjE8DnaX9NPIqyKPv9yUzsUzSMg2
	T7rWk4hIrtb4j8hN1fwob677X6IxJddxIiWeI47jh6emtKVtoVG+/fX/eLClxVBrYC8yDyB8f+mhK
	92uPs3zQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux4VK-00000006NKm-20cB;
	Fri, 12 Sep 2025 14:11:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB2823002EB; Fri, 12 Sep 2025 16:11:56 +0200 (CEST)
Date: Fri, 12 Sep 2025 16:11:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <20250912141156.GE1386988@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>

On Fri, Sep 12, 2025 at 01:54:59PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 11, 2025 at 02:19:57PM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Sep 10, 2025 at 05:44:21PM +0200, Peter Zijlstra wrote:
> > > @@ -703,17 +703,24 @@ void double_rq_lock(struct rq *rq1, stru
> > >  struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
> > >  	__acquires(rq->lock)
> > >  {
> > > +	raw_spinlock_t *slock;
> > >  	struct rq *rq;
> > >  
> > >  	lockdep_assert_held(&p->pi_lock);
> > >  
> > >  	for (;;) {
> > >  		rq = task_rq(p);
> > > +		slock = p->srq_lock;
> > >  		raw_spin_rq_lock(rq);
> > > -		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
> > > +		if (slock)
> > > +			raw_spin_lock(slock);
> > > +		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p) &&
> > > +			   (!slock || p->srq_lock == slock))) {
> > >  			rq_pin_lock(rq, rf);
> > >  			return rq;
> > >  		}
> 
> Yeah, I think that needs to change a little. Perhaps something like:
> 
> 	slock2 = p->srq_lock;
> 	if (... && (!slock2 || slock2 == slock))

I'm being stupid, all that wants is: && (p->srq_lock == slock). If there
is a mis-match, unlock and re-try.

