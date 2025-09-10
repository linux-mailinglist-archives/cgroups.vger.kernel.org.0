Return-Path: <cgroups+bounces-9936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFE7B51CCD
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F1A7A0356
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC42335BBC;
	Wed, 10 Sep 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcWTM8YD"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5A32F774;
	Wed, 10 Sep 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520043; cv=none; b=einX+nebhJCyVua0niIwcc2pnNos2rKcssjQ86znKEWpCF4sFis10KC8pdcZ+2k+kAlH1/WXsZj29JnPOOSL3fEM61GD6KJh7gpsxQK7ZFa5dm4fDrj8lAQm+P+ABlYT+JQGMb9K8jAPSisn5AWyMzXvDOaJBQulkW5Ap8f6kJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520043; c=relaxed/simple;
	bh=+SBu/NKPdyC5nAz1A9E/LJLm0LC/xkfFy8dViSf1hSs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HgoXVKsxkWMTwKKp4cJFJgp59rjAMrI6kaSDwqBHOiDavfTMp9x7XVNucV2vCkpjqWDxOEOA589MyvzgLvKSew7R1IFm7l02EmaSg8Mhr1RKxPajk/EUPPWMbBSFr+7FNZIyrbJgMc7tPAf51yfXhR+dWmkAoCZjipSw82UVE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bcWTM8YD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=U/+Fx4A53xEfXCRTuNuO6C8QlTHTslSx7NN0UvlNNqQ=; b=bcWTM8YDZG0VJ4zuUGgxfAvGyJ
	I8sSG4DFfOgGhfmhOWVUqycFGoFKbnVu+d/BjfOUar6wYxz8ASouzcxUnSXsKDqGySTpXwwtlrezm
	ftu10Vv1TO7RECuV8VEz2wQ7YSyYslETQNLtANtNbC8EPPK1x9CULrLSUSA9bKJHFEWBoBr9dwfgz
	VLZpAIZXd+rXJD21llGUECfgoICgVgINRh/l2up3dUleKYb9ysyqnCPBHHJ+vkAngAGA5URvwKtjd
	lI+OnwBg0kdgYA6XBoMqIM9HEBs/RFJJ1O1AX2+HxkuxknyasjGPRLXxhff7PPQeX8nxXMwyy7U0R
	/nIqK6Kg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufI-3FL8;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9C053302F52; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.336621043@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
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
Subject: [PATCH 09/14] sched: Make __do_set_cpus_allowed() use the sched_change pattern
References: <20250910154409.446470175@infradead.org>
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
@@ -2697,28 +2697,12 @@ void set_cpus_allowed_common(struct task
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



