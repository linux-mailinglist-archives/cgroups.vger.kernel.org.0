Return-Path: <cgroups+bounces-10069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17896B5732C
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 10:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FDA3A9B47
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A772ECD26;
	Mon, 15 Sep 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMVuRFzi"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD612EAB83;
	Mon, 15 Sep 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925510; cv=none; b=nwPW7YlySbXCnx8HzzuWhEFs2hYvAb/inppwNbrPzOxQrMcZqN8klKExO/HuSDwsrTQak9AZB8JuGTCAMI5a12o9kMKmAEE6rHoMifyeC9VnQrReR0oOskpsP4QJrnwTXG/n++T7dqd4/wrKzVhvshuHA4bXBytzpJQxeS1bC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925510; c=relaxed/simple;
	bh=JrJpsdeX9I2kWwalMMtD/gF5m4F/paBcJmibIeKR5f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNTWeqxTigI06JWYeQEr6zeUAocbEMsDnnNreLVk86wJlCBcYNqw+NIw3tfFknRNVS84dlHgU/0FLphsrl1Rj5CQjoMyh3FYze1tuu22mJl72d9q8m46AMMXI2TxizACj13OXDkzvU0eu6s6wWV33kK5QjcETF1nQdY3NC+6mVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QMVuRFzi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1HGzVHn2DWvwUBJDfAea0CauflSfX3VQjqYrUtMgN+4=; b=QMVuRFzizyLo1uAgDu9CG4pee+
	xvf/CcpeaRCZ+HATf+bGABp4iKyU0liNOgBDb9ZG6pTUBIq6lgaxMUoH8zXLU0+VBHRth2pQBUtiK
	FJbVWcAUeIuT+TEuL5Ku8H+Qi/AqXZ63KiV5zttWtFpaXDIbhGMsYW0ryr251LivVT25pWNmPfZ2h
	agWgwoOwYNLM9YBjxYHL6lvzdh3vxZ4XRCFWppW3KZ7dfB6jdySp4YcmYQkp/HfeLg/rhLRMzHRyd
	uZiwrNSrbmcL3HOl8ifHHPbYg36jfRYTZiQMuNYphaoBnBHBjz2R82Js5M+kbGe/dMZIb88zi00vV
	UjWfNoBQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4j2-00000006uCF-3SGt;
	Mon, 15 Sep 2025 08:38:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8FED4300212; Mon, 15 Sep 2025 10:38:15 +0200 (CEST)
Date: Mon, 15 Sep 2025 10:38:15 +0200
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
Message-ID: <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMRexZ_SIUVgkIpZ@slm.duckdns.org>

On Fri, Sep 12, 2025 at 07:56:21AM -1000, Tejun Heo wrote:

> It *seems* that way to me. There are two other scenarios tho.
> 
> - A task can move from a non-local DSQ to another non-local DSQ at any time
>   while queued. As this doesn't cause rq migration, we can probably just
>   overwrite p->srq_lock to the new one. Need to think about it a bit more.

It can use task_on_rq_migrating(), exactly like 'normal' rq-to-rq
migration:

	LOCK src_dsq->lock
	p->on_rq = TASK_ON_RQ_MIGRATING;
	task_unlink_from_dsq();
	UNLOCK src_dsq->lock

	LOCK dst_dsq->lock
	dispatch_enqueue()
	p->on_rq = TASK_ON_RQ_QUEUED;
	UNLOCK dst_dsq->lock

Same reasoning as for the pick_task_scx() migration, if it observes
!p->srq_lock, then it must observe MIGRATING and we'll spin-wait until
QUEUED. At which point we'll see the new srq_lock.

> - A task can be queued on a BPF data structure and thus may not be on any
>   DSQ. I think this can be handled by adding a raw_spinlock to task_struct
>   and treating the task as if it's on its own DSQ by pointing to that one,
>   and grabbing that lock when transferring that task from BPF side.

Hmm, and BPF data structures cannot have a lock associated with them?
I'm thinking they must, something is serializing all that.

> So, it *seems* solvable but I'm afraid it's becoming too subtle. How about
> doing something simpler and just add a per-task lock which nests inside rq
> lock which is always grabbed by [__]task_rq_lock() and optionally grabbed by
> sched classes that want to migrate tasks without grabbing the source rq
> lock? That way, we don't need to the lock pointer dancing while achieving
> about the same result. From sched_ext's POV, grabbing that per-task lock is
> likely going to be cheaper than doing the rq lock switching, so it's way
> simpler and nothing gets worse.

I *really* don't like that. Fundamentally a runqueue is 'rich' data
structure. It has a container (list, tree, whatever) but also a pile of
statistics (time, vtime, counts, load-sums, averages). Adding/removing a
task from a runqueue needs all that serialized. A per-task lock simply
cannot do this.

If you've hidden this lock inside BPF such that C cannot access it, then
your abstraction needs fixing. Surely it is possible to have a C DSQ to
mirror whatever the BPF thing does. Add a few helpers for BPF to
create/destroy DSQs (IDs) and a callback to map a task to a DSQ. Then
the C part can use the DSQ lock, and hold it while calling into whatever
BPF.

Additionally, it can sanity check the BPF thing, tasks cannot go
'missing' without C knowing wtf they went -- which is that bypass
problem, no?

