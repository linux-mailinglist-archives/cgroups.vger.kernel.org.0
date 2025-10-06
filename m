Return-Path: <cgroups+bounces-10549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3768BBDBE9
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F421885E6F
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B325B1FC;
	Mon,  6 Oct 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LBYFt7IH"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DF215F42;
	Mon,  6 Oct 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747560; cv=none; b=iup0T9Dzu0B+LYJ867PeQTC1txv5E/NrlmIg/J7IcWcQMOrdJYX+j8sxKtEw6sIU4keazZhgyL5JKUj9DhGXjJN4Jw/IcmvZG2YBOTzDSfVcD/kFkqRVSAi/QRxk74YsN81sj628Qc88K17Zrw1BboF6+F9ARXdZtYSVJ+Z2bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747560; c=relaxed/simple;
	bh=q/mQQad02fec3KRDgHLKjGaVdgdetNPm65tL4bPFZfg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=E2uNuTWupFoYGewTtGqQ0qwAolSE5BOvmks5TATt+6pYilo+0mANuKq9NH4s9Iq5XfqLdTyLolTxHSPsADRTQ+6oKXhCoaZNnco5op1a3B4L1UYeTEEO29Ze6TSOwQ6KXvXUGGNkxWr2EtxUqn0tO4J2NwqJuGeXRNITpdUnVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LBYFt7IH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=iIvGQ9AECv7VbRj4ol/gnuQgZMBrsdsc9a+qXMZl7v4=; b=LBYFt7IHRlPzUE8YoTjPlxnknI
	QAWDfUI2hDh9CjIN+DtfWIZpptooNEQmeMDOTtEAhBwZj7zSwUfk63N+b/WCHFEAktL+tCTPX/fQp
	fBlAmw0Nfar5Dyodcft7LY83BNF//gVVgUHNB6bWQgfRsoS5v9xQ/PdvpHJ+l5ZTm0dmSfk5H91cC
	IIDjh8byGzIPDP7WTC92f8r3BD9muAG0fMdSl5slUfkAKvgU84F/y9YMspxwcpSGisN9VruNowM/o
	DNh3x1DRMgGijGCuNX94zW6XAS4+o7G2M2N4Zqsdcga5PEqXReqrSKa4PQ1pAJENmA9f/sGnDOrPv
	heuijHdg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iix-00000009ydA-3P8q;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E198630302C; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.574803551@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@kernel.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 09/12] sched: Make __do_set_cpus_allowed() use the sched_change pattern
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Now that do_set_cpus_allowed() holds all the regular locks, convert it
to use the sched_change pattern helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2664,28 +2664,12 @@ void set_cpus_allowed_common(struct task
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	struct rq *rq = task_rq(p);
-	bool queued, running;
+	u32 flags = DEQUEUE_SAVE | DEQUEUE_NOCLOCK;
 
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_rq_held(rq);
-
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-
-	if (running)
-		put_prev_task(rq, p);
-
-	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_set_cpus_allowed(p->mm, ctx->new_mask);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	scoped_guard (sched_change, p, flags) {
+		p->sched_class->set_cpus_allowed(p, ctx);
+		mm_set_cpus_allowed(p->mm, ctx->new_mask);
+	}
 }
 
 /*



