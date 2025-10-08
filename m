Return-Path: <cgroups+bounces-10599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CAEBC41FC
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13CCA4EB0C5
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12E2F291D;
	Wed,  8 Oct 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NyHnFk7e"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F11C3BFC;
	Wed,  8 Oct 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914727; cv=none; b=a0r8AgGNXDfydjNIRokq11sSoI45gSMHTMpctAnfvA1JjNgNbhanv+JuSTcHY4B1RIoeDrD1/2yNKnb0Fu2z7EuV78iXwVdxv4laxGf+424vVC3PhnU+Qs5+ouQsFKT4DrpRuWt/7AM7z3UdRCo4Tc17a/ZRl04zp6FIWisHdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914727; c=relaxed/simple;
	bh=ygXITDmxgvDk+9cP2O8aFdDtbMfbLt+Ei6n5Zf6JZJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNEF2dJjju0hloXwVGgKuh4o4sv8mt6t1d/+ithKKPojC2Evxk7Tv0OeTOLe9PoRxYL8z71Qi5ZYYfw/nuOocr3z5pzbze5wPNrmUzK/GVLSvKneAvsoTiGguijTWcybwwWSoqJXUc06t+8jNRuF1hg2XGXlm2dokeiCQ+QyM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NyHnFk7e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Db+CrnXqBi3Tsj3WH0wxL6XqdkCufvMszezt0PqY9p0=; b=NyHnFk7eGuWHxzE78yd0m6MZwy
	TZdLA66TcGjWVURTSHhixSseDeeHznOOPFpSdeEL0LTTRG5W6CG8VIGqbvjJ3pxYaCKO628y1Z0rM
	YJN+tMqltqWK7rH7NWRd1D0v0KLPn4FHAeR+xTfH6UY8yEzJRgX0PTMA+6SKERcggZmUgHfCSz64x
	Rm/jD5PAPlH9GSHTg6EepNLf7aF/Wa0sa76Y2yZTlq7MNwiICf9Pw8Sw2NaCa6BVR1S/XSSrCgdXX
	st009Qdb+sNRnm3wGaJxs+fT34ZmpbwwXg2czhnxJecx2n3Epa0EzDKuqx1YN2jvdI9dDMWmMP54D
	wWOITh/A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6QDA-00000000bhN-1hZf;
	Wed, 08 Oct 2025 09:11:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40B62300220; Wed, 08 Oct 2025 11:11:51 +0200 (CEST)
Date: Wed, 8 Oct 2025 11:11:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	alexei.starovoitov@gmail.com
Subject: Re: [RFC][PATCH 0/3] sched/ext: Cleanup pick_task_scx()
Message-ID: <20251008091151.GS4067720@noisy.programming.kicks-ass.net>
References: <20251006104652.630431579@infradead.org>
 <aOWKn6f0OtegV1q0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOWKn6f0OtegV1q0@slm.duckdns.org>

On Tue, Oct 07, 2025 at 11:48:15AM -1000, Tejun Heo wrote:
> On Mon, Oct 06, 2025 at 12:46:52PM +0200, Peter Zijlstra wrote:
> > Hi,
> > 
> > So I had a poke at 'give @rf to pick_task() and fold balance_scx() into
> > pick_task_scx()' option to see how terrible it was. Turns out, not terrible at
> > all.
> > 
> > I've ran the sched_ext selftest and stress-ng --race-sched 0 thing with various
> > scx_* thingies on.
> 
> This is great. I was thinking that I needed to call pick_task() of other
> classes to detect the retry conditions but yeah enqueue() must be the
> triggering event and this is way neater. 

:-)

> Does this mean that balance() can be dropped from other classes too?

Possibly. But lets stick that on a todo list :-) I was also looking to
get rid of sched_class::pick_next_task() -- the only reason that
currently still exists is because of that fair cgroup nonsense.

I was looking at bringing back Rik's flatten series (easier now that the
cfs bandwidth throttle thing is fixed). That should get rid of that
hierarchical pick; and thus obviate that whole mess in
pick_next_task_fair().

> For the whole series:
> 
>  Acked-by: Tejun Heo <tj@kernel.org>
> 

Thanks!

Now, I do have a few questions from staring at this ext stuff for a
while:

 - So the 'RT' problem with balance_one() is due to:

    o rq-lock-break allowing higher prio task to come in
    o placing a task on the local dsq

   which results in that local-dsq getting 'starved'. The patches want
   to call switch_class(), which I suppose will work, this is something
   like:

   if (rq_modified_above(rq, &ext_sched_class)) {
      /*
       * We don't have a next task at this point, but can guess at its
       * class based on the highest set bit in the queue_mask.
       */
      scx_cpu_release(reason_from_mask(rq->queue_mask), NULL);
      return RETRY_TASK;
   }

   But I was thinking that we could also just stick that task back onto
   some global dsq, right? (presumably the one we just pulled it from is
   a good target). This would effectively 'undo' the balance_one().


 - finish_dispatch() -- one of the problems that I ran into with the
   shared rq lock implementation is that pick_task_scx() will in fact
   try and enqueue on a non-local dsq.

   The callchain is something like:

     pick_task_scx()
       bpf__sched_ext_ops_dispatch()
         scx_bpf_dsq_move_to_local()
	   flush_dispatch_buf()
	     dispatch_enqueue() // dsq->id != SCX_DSQ_LOCAL
 
   And this completely messes up the locking -- I'm not sure how to fix
   this yet. But adding this flush to do random other things to various
   code paths really complicates things. Per the function what we really
   want to do is move-to-local, but then we end up doing random other
   things instead :/


 - finish_dispatch() -- per the above problem I read this function and
   found that:

     "the BPF scheduler is allowed to dispatch tasks spuriously"

   and I had to go and buy a new WTF'o'meter again :/ Why would you
   allow such a thing? Detect the case because the BPF thing is
   untrusted and can do crazy things, sure. But then kill it dead; don't
   try and excuse badness.


 - scx_bpf_dsq_move_to_local() found per the above problem, but per its
   comment it is possible BPF calls this with its own locks held. This
   then results in:

   CPU1 

   try_to_wake_up()
     rq_lock();
     enqueue_task() := enqueue_task_scx()
       bpf__sched_ext_ops_something_or_other()
         your bpf area lock thing

   // rq->lock
   // bpf area lock

   CPU2
     bpf__sched_ext_whatever()
       bpf area lock
         scx_bpf_move_to_local()
	   rq_lock()

   // bpf area lock
   // rq->lock

  and we have a deadlock -- I thought BPF was supposed to be safe? And
  while the recent rqspinlock has a timeout, and there the bpf validator
  knows a spinlock exists and can prohibit kernel helper calls, this
  bpf area lock you have has no such things (afaict) and BPF can
  completely mess up the kernel. How is this okay?



