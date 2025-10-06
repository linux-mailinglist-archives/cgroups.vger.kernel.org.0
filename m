Return-Path: <cgroups+bounces-10552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2129BBDBF8
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F034AAC3
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA4264A76;
	Mon,  6 Oct 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q5MeTx63"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228123314B;
	Mon,  6 Oct 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747561; cv=none; b=egmm3C/PTY8KVI2ttfsR/2GagjaPqqdkQodODdktAmB584DyyKeDWrrTaO8zZZK+dEuPfpiA9iVTrx0YvYWPurcgKxlmqQFY8E2Ob+KD8R4g+0mem+Joeg5kbNvX0Fp4lDej6NjH+5t5dZqWbFnWAzep+8Ktj2/dhScOchv29wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747561; c=relaxed/simple;
	bh=TBOsjh5msezKVy3SJD6PzCzp4xG8h4Zbz5m8LYzdih0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FpIa4893GUhkH6coZYbHRa0D9KWmSBzbTGl8Oy6WnpuRN78nom3X0BMBQMwzoQYRyjj+/v3tBvyu9h89ZhRmtrmNmlS4haNhqY8vACCPK3VLWXO1AbmA9N4yN4azSssfmQj/hoNSitEauw4QoSu9DGfto/Riz06mDDji21g4ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q5MeTx63; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=5fdDBWetzyDppzwCsqnsKCICzvIF4lbyV4cpTrAa49s=; b=q5MeTx63kvuQbollZFQns892vV
	5Y1ZGHdSx8p6tcqhwrfumf/qBHyUaiU3jb9reFkCAtjcNi68tZEktkQerqcwI9kOlTXK5eqccx1Jo
	t/UReIQW1i/drdBtVsxroXhiy6WGRTFYq8bwWaYPM+v/+LAC3fVQUlfMjmUP8fEublnhlyiAzOjED
	kbYOCcmB6WaeRLG657zEJJqz6IzzhwjAX4sScRZg3eHdtfjZ9ckfZnwFL/XWMFh75udOwRjxGk4yG
	g2XtCuNWEAz9AZnKPFowbNZW9GHAEjIcGFzP9qTR1+T8/S8zQu3S3qD/F4a9lCtj1m2qlw3rvSubW
	PUkPFKgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iiy-00000009ydV-2DME;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E9DEB303032; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.813272361@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:13 +0200
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
Subject: [PATCH 11/12] sched: Match __task_rq_{,un}lock()
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In preparation to adding more rules to __task_rq_lock(), such that
__task_rq_unlock() will no longer be requivalent to rq_unlock(),
make sure every __task_rq_lock() is matched by a __task_rq_unlock()
and vice-versa.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   13 ++++++++-----
 kernel/sched/sched.h |    8 ++++----
 kernel/sched/stats.h |    2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2582,7 +2582,8 @@ static int migration_cpu_stop(void *data
 		 */
 		WARN_ON_ONCE(!pending->stop_pending);
 		preempt_disable();
-		task_rq_unlock(rq, p, &rf);
+		rq_unlock(rq, &rf);
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		preempt_enable();
@@ -2591,7 +2592,8 @@ static int migration_cpu_stop(void *data
 out:
 	if (pending)
 		pending->stop_pending = false;
-	task_rq_unlock(rq, p, &rf);
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 
 	if (complete)
 		complete_all(&pending->done);
@@ -3708,7 +3710,7 @@ static int ttwu_runnable(struct task_str
 		ttwu_do_wakeup(p);
 		ret = 1;
 	}
-	__task_rq_unlock(rq, &rf);
+	__task_rq_unlock(rq, p, &rf);
 
 	return ret;
 }
@@ -4301,7 +4303,7 @@ int task_call_func(struct task_struct *p
 	ret = func(p, arg);
 
 	if (rq)
-		rq_unlock(rq, &rf);
+		__task_rq_unlock(rq, p, &rf);
 
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
@@ -7364,7 +7366,8 @@ void rt_mutex_setprio(struct task_struct
 
 	rq_unpin_lock(rq, &rf);
 	__balance_callbacks(rq);
-	raw_spin_rq_unlock(rq);
+	rq_repin_lock(rq, &rf);
+	__task_rq_unlock(rq, p, &rf);
 
 	preempt_enable();
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1825,7 +1825,8 @@ struct rq *task_rq_lock(struct task_stru
 	__acquires(p->pi_lock)
 	__acquires(rq->lock);
 
-static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
+static inline void
+__task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
@@ -1837,8 +1838,7 @@ task_rq_unlock(struct rq *rq, struct tas
 	__releases(rq->lock)
 	__releases(p->pi_lock)
 {
-	rq_unpin_lock(rq, rf);
-	raw_spin_rq_unlock(rq);
+	__task_rq_unlock(rq, p, rf);
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
@@ -1849,7 +1849,7 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct
 
 DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
 		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
-		    __task_rq_unlock(_T->rq, &_T->rf),
+		    __task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
 
 static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -206,7 +206,7 @@ static inline void psi_ttwu_dequeue(stru
 
 		rq = __task_rq_lock(p, &rf);
 		psi_task_change(p, p->psi_flags, 0);
-		__task_rq_unlock(rq, &rf);
+		__task_rq_unlock(rq, p, &rf);
 	}
 }
 



