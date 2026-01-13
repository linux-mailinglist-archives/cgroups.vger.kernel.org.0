Return-Path: <cgroups+bounces-13143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BEDD18915
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8060C3020833
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43438BF8E;
	Tue, 13 Jan 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5gzRRKx"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7E38BF8F;
	Tue, 13 Jan 2026 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304855; cv=none; b=m33iBEf/jqKo1tjwCkWfBm6eKntZJVXalU4zfUPqaLD9kcdZtRAJqGREjsfJMtb7gcqzltgo2Us3VjmJ/xQ7GpoEdsEaMaYAEvMv/BLfS2/rOm0bGzbkwDHfNKDSuSeLASo9+uYdZiYTdnh/fsgUlCcpq1T0uLGBaWMCNGG6snY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304855; c=relaxed/simple;
	bh=o3zch3jzbXpHmk076D+tohORLNFHpM8gRwvctU3x33w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqsQVrNJaCktwcE/KipJ8cJ4oUoRic57CMvhB4C53RjKHfRzNHWqhefRpn+qDsd9bt1DV+TTngsfaXwR57rP95/NehtycfPlZg9sfsyKI0oMBI/N9aswfmb6tEH8SHjclOksaRBU9Ph0o/jX2yhZk1G6bHiukggbhxiHB0siggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V5gzRRKx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qc+ID8gt2F/5xHHKvlFOKQHH8dxaAkGxnYawKjkZvl0=; b=V5gzRRKxoTT5SS0sQDWPYuIl7k
	bnynmpSBy4R6JMBwhwu2JdxcP8z5WF6x0uGD7RFbpvRfn5hB2FQqrKfCJkfrbbGaTe988vTgS7+UV
	J+bpwn0SjBMOe33Ny6z+s5O6lMM/6F2VNrIgsuhaGmBn1iaqnW6l28sDulxkjrWCu2e8x7sUdjzt1
	+HGdeRMXByv8VdRp0mNSf1NlWh/SHaClZM9ogGFCA5n8BcW+A7JAxp7jw74nskxA3IaLVTswOMU3Q
	22RNuAQmNUNxnGjdsGaRb2n+SR3crm0Azs7lFR67d9k5XLXihIcmaYVugwdgW1dh5ocFaCSI/HejD
	/m/uU3mQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfcrn-00000002jjM-3dIp;
	Tue, 13 Jan 2026 11:47:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8CEA30049A; Tue, 13 Jan 2026 12:47:18 +0100 (CET)
Date: Tue, 13 Jan 2026 12:47:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260113114718.GA831050@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>

On Tue, Jan 13, 2026 at 11:45:43AM +0100, Pierre Gondois wrote:
> Hello Prateek,
> 
> On 1/13/26 05:12, K Prateek Nayak wrote:
> > Hello Pierre,
> > 
> > On 1/13/2026 2:14 AM, Pierre Gondois wrote:
> > > Hello Peter,
> > > 
> > > It seems this patch:
> > > 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change pattern")
> > > is triggering the following warning:
> > > rq_pin_lock()
> > > \-WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
> > Can you check if the following solution helps your case too:
> > https://lore.kernel.org/all/20260106104113.GX3707891@noisy.programming.kicks-ass.net/
> > 
> I can still see the issue.
> It seems the task deadline is also updated in:
> sched_change_end()
> \-enqueue_task_dl()
>   \-enqueue_dl_entity()
>     \-setup_new_dl_entity()
>       \-replenish_dl_new_period()
> if the task's period finished.
> 
> So in sched_change_end(), the task priority (i.e. p->dl.deadline) is
> updated.
> This results in having an old_deadline earlier than the new p->dl.deadline.
> Thus the rq->balance_callback:
> 
> prio_changed_dl() {
> ...
> if (dl_time_before(old_deadline, p->dl.deadline))
>   deadline_queue_pull_task(rq);
> ...
> }

Hum... so this one is a little more tricky.

So the normal rules are that DEQUEUE_SAVE + ENQUEUE_RESTORE should be as
invariant as possible.

But what I think happens here is that at the point of dequeue we are
effectively ready to throttle/replenish, but we don't.

Then at enqueue, we do. The replenish changes the deadline and we're up
a creek.

Let me think about this for a bit...

