Return-Path: <cgroups+bounces-9988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8669B52DD2
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826C5560DF4
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31032F0C42;
	Thu, 11 Sep 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENcGAwBU"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152473019B8;
	Thu, 11 Sep 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584741; cv=none; b=kAu01v7xBGW+NVO2xngWpt3BkNnbtkqybjE+yrA2Gm8t7XyzQg5ARFK1JLt1EozvAAYaiOMutIOLSdAk7Hx2qSkgh73d7mBA6ip77w8qnB3MDQmojuDv21S/VlLk8+NPcemBVbkeHrwcmYrYnJeIWNlxbpSObcKBTJnh/2v9v1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584741; c=relaxed/simple;
	bh=w+TJfprpCRYcOr1Brbhr7wReEsIF1ksoNNRObvVeP/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKqRj+eLB4m/JjqJISIK1BneVI5LNWJP9f8plAFkQ1DpC32qrSriE7PWinHi+26EZFiedfuCwF/N2sA7JCuMUs3hSJsiIIM4QynMvxY2vOTsaJOGIhc/dd/LYcEQxT/yfQVHzRm9S7keMPvwJwcH6OXaZb0WUYPSDyJCn/UGFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ENcGAwBU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XOFvHZY3zaHv7gFRF9Hz9JoTk86FWnYYcafh9azu6eM=; b=ENcGAwBUBiAHNNlvFaIb4Hhw7R
	gUgHqj359P9V2oxPjFxAPCf65CD+EQvku+MK6UStoSo6/P0UBOirGmIF3kg1LuzXO6s9HLs0Px1Cb
	G1bgi1zgY5tGbI6/wnpumFHGlMoHsBdw6j1lhnv2mgviCEOXBDoIbMMAl8EGvq6R0H6OS88zu5wir
	V7KhfxyPw67fG1L/e2Bm4Q/ZuC3DcqDd4o/xgcmTp3SMy7NO2OGhzRtaTvw+ntJNXgu17tUJAeIdn
	+RFKhsGgOkExV+3fclE0OduxZDdVkygyfsYnVMucLV1X9lw7oG/4/U/+s3/SZUpbF4LdR/YtOceDs
	8K+07q6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwe4l-000000063TG-1TNc;
	Thu, 11 Sep 2025 09:58:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C47AD3002EB; Thu, 11 Sep 2025 11:58:45 +0200 (CEST)
Date: Thu, 11 Sep 2025 11:58:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <20250911095845.GC1386988@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
 <20250910183555.GV3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910183555.GV3289052@noisy.programming.kicks-ass.net>

On Wed, Sep 10, 2025 at 08:35:55PM +0200, Peter Zijlstra wrote:

> I'll go untangle it, but probably something for tomorrow, I'm bound to
> make a mess of it now :-)

Best I could come up with is something like this. I tried a few other
approaches, but they all turned into a bigger mess.

Let me go try and run this.

---
 kernel/sched/core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2481,11 +2481,11 @@ static inline bool is_cpu_allowed(struct
  * Returns (locked) new rq. Old rq's lock is released.
  */
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-				   struct task_struct *p, int new_cpu)
+				   struct task_struct *p, int new_cpu, int flags)
 {
 	lockdep_assert_rq_held(rq);
 
-	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
+	deactivate_task(rq, p, flags | DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -2493,7 +2493,7 @@ static struct rq *move_queued_task(struc
 
 	rq_lock(rq, rf);
 	WARN_ON_ONCE(task_cpu(p) != new_cpu);
-	activate_task(rq, p, 0);
+	activate_task(rq, p, flags);
 	wakeup_preempt(rq, p, 0);
 
 	return rq;
@@ -2533,7 +2533,7 @@ static struct rq *__migrate_task(struct
 	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
-	rq = move_queued_task(rq, rf, p, dest_cpu);
+	rq = move_queued_task(rq, rf, p, dest_cpu, 0);
 
 	return rq;
 }
@@ -3007,7 +3007,7 @@ static int affine_move_task(struct rq *r
 
 		if (!is_migration_disabled(p)) {
 			if (task_on_rq_queued(p))
-				rq = move_queued_task(rq, rf, p, dest_cpu);
+				rq = move_queued_task(rq, rf, p, dest_cpu, DEQUEUE_LOCKED);
 
 			if (!pending->stop_pending) {
 				p->migration_pending = NULL;

