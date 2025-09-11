Return-Path: <cgroups+bounces-10000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F8B53D33
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 22:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAF2586401
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73E2C2361;
	Thu, 11 Sep 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AftvDV8J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074622759C;
	Thu, 11 Sep 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623208; cv=none; b=cPkyFt7oRuB0NkoPWQ8aV8fMqobe0DxdV/qWsjHBkEYBsGpoYau4+aHEHFrWdLnsCQ1zcB3Fq59IoyYXAVJPhgmd2T3vfqniGtlSwIoPnXEKJYQtAquoeReZaQmIEKjzsRqXHv0BiqAYs/pPkfySKc2kfIfCi3L2GjNfgKdJKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623208; c=relaxed/simple;
	bh=8hnQ06uJnhREH5akTgfN6vsYLtIKYGhKoV9nBO8LIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh1KVfxYs7WKvfgWUNIwWHBQ87g9oStGwNmi2yROVDU8NzdRFosB0F6vqoyN3qCTuAgXA63qS4dpZPZzi9f1ktogb9gUNjEHmH4790A1UynxIQhW40QB9b3HiJtkUUJ/9dyg5KEGKO7IcG2+dm7cgL1vylxA+/T/ibpz1UWFgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AftvDV8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68BDC4CEF0;
	Thu, 11 Sep 2025 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757623207;
	bh=8hnQ06uJnhREH5akTgfN6vsYLtIKYGhKoV9nBO8LIzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AftvDV8JrnN/pCxzs4ZYnz8PrF01oECxqlncRV1as21fsghKqbpIzgvRawFRTkC+a
	 bYxye24rnIMCudF2SywiTfNYDAAceCCelN45DU6mwtKpvkFphI6oqEjwvFT8eBwUQb
	 b8WDoaSOdeAkDE2ZztzDu0PBn3hIJ4lg9uVMYyedKiisAUDtlZI5bPNxa9PQdshRrT
	 UDI0AwHsdhaGTvfSNGxCHE2e2ViWvmTVseXwmKQTambLGDEmBegnj7W9Zw5cDPdOL2
	 nvxQr3ZUPGEoiTQC0mFPdayF3rSomp98t5dyGuOTP1jA319zMDqWX0BgXhgq6u5VJO
	 pb9ZQFRontAXg==
Date: Thu, 11 Sep 2025 10:40:06 -1000
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
Message-ID: <aMMzpnyx__ZgZGRc@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911094240.GW3289052@noisy.programming.kicks-ass.net>

Hello,

On Thu, Sep 11, 2025 at 11:42:40AM +0200, Peter Zijlstra wrote:
...
> I didn't immediately see how to do that. Doesn't that
> list_for_each_entry_safe_reverse() rely on rq->lock to retain integrity?

Ah, sorry, I was thinking it was iterating scx_tasks list. Yes, as
implemented, it needs to hold rq lock throughout.

> Moreover, since the goal is to allow:
> 
>  __schedule()
>    lock(rq->lock);
>    next = pick_task() := pick_task_scx()
>      lock(dsq->lock);
>      p = some_dsq_task(dsq);
>      task_unlink_from_dsq(p, dsq);
>      set_task_cpu(p, cpu_of(rq));
>      move_task_to_local_dsq(p, ...);
>      return p;
> 
> without dropping rq->lock, by relying on dsq->lock to serialize things,
> I don't see how we can retain the runnable list at all.
>
> And at this point, I'm not sure I understand ext well enough to know
> what this bypass stuff does at all, let alone suggest means to
> re architect this.

Bypass mode is enabled when the kernel side can't trust the BPF scheduling
anymore and wants to fall back to dumb FIFO scheduling to guarantee forward
progress (e.g. so that we can switch back to fair).

It comes down to flipping scx_rq_bypassing() on, which makes scheduling
paths bypass most BPF parts and fall back to FIFO behavior, and then making
sure every thread is on FIFO behavior. The latter part is what the loop is
doing. It scans all currently runnable tasks and dequeues and re-enqueues
them. As scx_rq_bypass() is true at this point, if a task were queued on the
BPF side, the cycling takes it out of the BPF side and puts it on the
fallback FIFO queue.

If we want to get rid of the locking requirement:

- Walk scx_tasks list which is iterated with a cursor and allows dropping
  locks while iterating. However, on some hardware, there are cases where
  CPUs are extremely slowed down from BPF scheduler making bad decisions and
  causing a lot of sync cacheline pingponging across e.g. NUMA nodes. As
  scx_bypass() is what's supposed to extricate the system from this state,
  walking all tasks while going through each's locking probably isn't going
  to be great.

- We can update ->runnable_list iteration to allow dropping rq lock e.g.
  with a cursor based iteration. Maybe some code can be shared with
  scx_tasks iteration. Cycling through locks still isn't going to be great
  but here it's likely a lot fewer of them at least.

Neither option is great. Leave it as-is for now?

Thanks.

-- 
tejun

