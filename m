Return-Path: <cgroups+bounces-10475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C9CBA53B8
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1DA6248CD
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD726B2D2;
	Fri, 26 Sep 2025 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me9WeMme"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCF17BA6;
	Fri, 26 Sep 2025 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922764; cv=none; b=s6/oiXJ4q47fwWDc3cFQx76rNx71mjhZ4YAfcc47phWQp0WM4zMttPuOHBhha3Cw7p9SIIPFIGMZqJmElt5i+DzeXsU2CIeg6jPgy05YJe6j78CnLNeOncgJLqd06HSeoKv04BZ83+LYEymEao0f1RpkjA2qADVSXljN2Wa9BIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922764; c=relaxed/simple;
	bh=y2HsFa4mUc1wJo6FT6LcQXE3U4dYpvtDPvCC2BQtCW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdZQfI9XgjH0acpcZDgbIqtFaTdSj4GN6CzCbBRGosOUjbM8EAe8M2aIrMJZ6tHF+FOMgFZTZtW/ji38gJQWo16qVfTdsU+xkYhFXMeLy5J/XCCjRB2QQDLWcNAp4TJRQYbdrpBFwrpKRhRplNl5R7K/XEsRbdqXbljZzTKUPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me9WeMme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B4EC4CEF4;
	Fri, 26 Sep 2025 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922762;
	bh=y2HsFa4mUc1wJo6FT6LcQXE3U4dYpvtDPvCC2BQtCW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Me9WeMme6rIwdLABYykyG5eNlDK5NFeKiPOz27CP5s++NyyY6mAhY2H4DgUko0w29
	 lxBJVv7vSYjeXQfha7cgp7tgr1deluwwe8lYKsi1PQlpqgqOWH6CScys8w0NhR42Pg
	 IyNp08s/PhltIbHg00rg59eMahWe6qOJPZtihAVeaC40jd/joXpTBuf64COhAIzSm9
	 jlz4Q0qe06dNoBT1HeNhMYrBosdNNSSrzT/Ob9K/6EkWnGwfdPYj+ifzcVU+MD75Ph
	 dbn4a8oAja4YlPi+T2i4wR7gVLg+WTGEUasL+ruTx2Iwij5wLSxJNpwuSkTkUEvQZ/
	 fbxQLsrD3Yh5w==
Date: Fri, 26 Sep 2025 11:39:21 -1000
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
Message-ID: <aNcICdscrYDUMKiU@slm.duckdns.org>
References: <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
 <20250926103628.GE4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926103628.GE4067720@noisy.programming.kicks-ass.net>

Hello,

On Fri, Sep 26, 2025 at 12:36:28PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 25, 2025 at 11:43:18AM -1000, Tejun Heo wrote:
> > Yes, I was on a similar train of thought. The only reasonable way that I can
> > think of for solving this for BPF managed tasks is giving each task its own
> > inner sched lock, which makes sense as all sched operations (except for
> > things like watchdog) are per-task and we don't really need wider scope
> > locking.
> 
> Like I've said before; I really don't understand how that would be
> helpful at all.
> 
> How can you migrate a task by holding a per-task lock?

Let's see whether I'm completely confused. Let's say we have p->sub_lock
which is optionally grabbed by task_rq_lock() if requested by the current
sched class (maybe it's a sched_class flag). Then, whoever is holding the
sub_lock would exclude property and other changes to the task.

In sched_ext, let's say p->sub_lock nests inside dsq locks. Also, right now,
we're piggy backing on rq lock for local DSQs. We'd need to make local DSQs
use their own locks like user DSQs. Then,

- If a task needs to be migrated either during enqueue through
  process_ddsp_deferred_locals() or during dispatch from BPF through
  finish_dispatch(): Leave rq locks alone. Grab sub_lock inside
  dispatch_to_local_dsq() after grabbing the target DSQ's lock.

- scx_bpf_dsq_move_to_local() from dispatch: This is a bit tricky as we need
  to scan the tasks on the source DSQ to find the task to dispatch. However,
  there's a patch being worked on to add rcu protected pointer to the first
  task which would be the task to be consumed in vast majority of cases, so
  the fast path wouldn't be complicated - grab sub_lock, do the moving. If
  the first task isn't a good candidate, we'd have to grab DSQ lock, iterate
  looking for the right candidate, unlock DSQ and grab sub_lock (or
  trylock), and see if the task is still on the DSQ and then relock and
  remove.

- scx_bpf_dsq_move() during BPF iteration: DSQ is unlocked during each
  iteration visit, so this is straightforward. Grab sub-lock and do the rest
  the same.

Wouldn't something like the above provide equivalent synchronization as the
dynamic lock approach? Whoever is holding sub_lock would be guaranteed that
the task won't be migrating while the lock is held.

However, thinking more about it. I'm unsure how e.g. the actual migration
would work. The actual migration is done by: deactivate_task() ->
set_task_cpu() -> switch rq locks -> activate_task(). Enqueueing/dequeueing
steps have operations that depend on rq lock - psi updates, uclamp updates
and so on. How would they work?

Thanks.

-- 
tejun

