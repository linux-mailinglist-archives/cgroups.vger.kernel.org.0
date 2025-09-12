Return-Path: <cgroups+bounces-10002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D0B53F7E
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731DC7B6182
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62500134CB;
	Fri, 12 Sep 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsC0OTMU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DE2DC779;
	Fri, 12 Sep 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757636399; cv=none; b=B649SPUZum4FRSGeW/lIft9NOt+84Mh2zVHeJ0vWRs+VW9Uc3e1Ev2FVN7gIUXMym+YuK02/DjQi5mbJjT63aK+uz+M/DTFeIB8ns2cFLfekMB7fH5c4Wl5Le8Si7uQou2ko95LUWn3qcp8Z/7j9MAIoENj8pBVKuqV5lczM16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757636399; c=relaxed/simple;
	bh=u4FEke0ydQjSjz04Ux4SWmVQR4jg0KE0VTpOSi+ssD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbvlJQdLWlCXTS1CeEQzLSqcZyCegDmbouWG3Nwksvn9qIhW0YjpVSjf3zou4IpB6FGraY8SlGi6pypuZgqrEfGQhHWPso/rvo//ufl+zqV9ybR4GcwYRCU67WBcWxKlKqk+r2CUPZzRANu16BLNXJjNV0Rjuj8esRQniXsq6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsC0OTMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886ACC4CEF1;
	Fri, 12 Sep 2025 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757636398;
	bh=u4FEke0ydQjSjz04Ux4SWmVQR4jg0KE0VTpOSi+ssD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsC0OTMURwcxesMWGxQASvYxOqIKgehJjgEEOYkpa+XBdgRfw/dfPson1rWXNyIZn
	 4s5EscgTXyHeN0t96mPwzYjAal4hfbE/6oI999bI3IYBik2w/szkIUqwAWOVuRke4L
	 OoOnpsYSK147PPi/eWfUdGcf8EshR7f9q6HbDoQLZicBkX/yxQSEpUUnErPsYksDik
	 cDapOxAKhDprpQuFGwdzLuWosiBKvyMS8KypwWZaw4ShVM2LHXfqoPRwQ3jgRjE14+
	 wstBCQbnlJ0QcLPWgZL07spAE/+/qPuP5LWlGctLjMm9PuMKTRt7HDLxOk4aD45NX+
	 E7rJu14dPDp/w==
Date: Thu, 11 Sep 2025 14:19:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <aMNnLenCytO_KEKg@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910155809.684653538@infradead.org>

Hello,

On Wed, Sep 10, 2025 at 05:44:21PM +0200, Peter Zijlstra wrote:
> @@ -703,17 +703,24 @@ void double_rq_lock(struct rq *rq1, stru
>  struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
>  	__acquires(rq->lock)
>  {
> +	raw_spinlock_t *slock;
>  	struct rq *rq;
>  
>  	lockdep_assert_held(&p->pi_lock);
>  
>  	for (;;) {
>  		rq = task_rq(p);
> +		slock = p->srq_lock;
>  		raw_spin_rq_lock(rq);
> -		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
> +		if (slock)
> +			raw_spin_lock(slock);
> +		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p) &&
> +			   (!slock || p->srq_lock == slock))) {
>  			rq_pin_lock(rq, rf);
>  			return rq;
>  		}

With the !slock condition, the following scenario is possible:

  __task_rq_lock()
     slock = p->srq_lock; /* NULL */
                                                dispatch_enqueue()
                                                  p->srq_lock = &dsq->lock;
                                                enqueue finishes
     raw_spin_rq_lock(rq);
     rq is the same, $slock is NULL, return
  do something assuming p is locked down        p gets dispatched to another rq

I'm unclear on when p->srq_lock would be safe to set and clear, so the goal
is that whoever does [__]task_rq_lock() ends up waiting on the dsq lock that
the task is queued on, and if we can exclude other sched operations that
way, we don't have to hold source rq lock when moving the task to another rq
for execution, right?

In the last patch, it's set on dispatch_enqueue() and cleared when the task
leaves the DSQ. Let's consider a simple scenario where a task gets enqueued,
gets put on a non-local DSQ and then dispatched to a local DSQ, Assuming
everything works out and we don't have to lock the source rq for migration,
we'd be depending on task_rq_lock() reliably hitting p->srq_lock to avoid
races, but I'm not sure how this would work. Let's say p is currently
associated with CPU1 on a non-local DSQ w/ p->srq_lock set to its source
DSQ.

  pick_task_ext() on CPU0               task property change on CPU1
    locks the DSQ
    picks p      
    task_unlink_from_dsq()              task_rq_lock();
      p->srq_lock = NULL;                 lock rq on CPU1
    p is moved to local DSQ               sees p->src_lock == NULL
                                          return
  p starts running
  anything can happen
                                        proceed with property change

What am I missing?

Thanks.

-- 
tejun

