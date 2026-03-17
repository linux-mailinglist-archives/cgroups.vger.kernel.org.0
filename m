Return-Path: <cgroups+bounces-14840-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Et8E24xuWnsuQEAu9opvQ
	(envelope-from <cgroups+bounces-14840-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA22A839C
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60AE0302AF36
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6D377019;
	Tue, 17 Mar 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MvcxCoip"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A529368941;
	Tue, 17 Mar 2026 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=sPw7ykfPcxrUV9z26a+ouYzG14VDa9VyON3x08ub0GKV/vSmsrv4X6R3ynZPEuo6tAKcSeAYPXpdIVVbV1q4qZtKCDP93WDL/tnxmqpbT3gdJuAhn6OlMolKjZPD4io5PCR3pleQnBsAzTuLZdn4zJ0kbgDftLwImX6NPtkwo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=oz/nKY2JY2XxmQP/gISL7Loky6Je7txW6d2OIdUr/kE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Yb71hQ/XGlDcThVc2gQqLZVZH9TK4Z7klyfkSfZJpJIgLh2qf1XWj9KoeCD16LNje28ZV57I/gqB9y/h6iYhi4uAi5kt2HOwsTnjunPMU91QiKjs/ec4gEJD3ee0xz75OoObxrPAbf0qknHIAvl5XY61yvp/dh+ssqWCbl8MhNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MvcxCoip; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=LnEpHpYBQaWBKPY9OFV1cbVCVT8OOVFifXCq/B8ezh4=; b=MvcxCoipidWfptwr+HKRyouzJp
	1E7XI/4OYkFYDg31PdPgW+Mz7tO8c4jUlLdfVcgf+gwFio6LZjCxK7f0uwLAQU7buOhGXdFweTZON
	vOniltKienhNdXVEwOEYKUtWZYEQu+BO5eQkkWP0+KuhKyVy9BOfg4nECvHh+OUDIk0sZei7vB8tq
	JYSQWu8jxgZmAWxwAJ/wapG5aVTSmEIPEh+JpIf1IGR9yPuKs51uzTCCejINUsUnGJpS8NhKCX3+c
	1AFglnqX3Ijsqx+xAvuwb1z2w2qRrFdihs54OlW1dXfQnejrdmbJGhV4md+YqD6gR6aWb56eLisHc
	FHWLVQ/A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxY-00000002YWu-1SN9;
	Tue, 17 Mar 2026 10:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2FE103032ED; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104343.103915618@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com
Subject: [RFC][PATCH 6/8] sched/fair: Add newidle balance to pick_task_fair()
References: <20260317095113.387450089@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14840-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFCA22A839C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With commit 50653216e4ff ("sched: Add support to pick functions to
take rf") removing the balance callback, the pick_task() callback is
in charge of newidle balancing.

This means pick_task_fair() should do so too. This hasn't been a
problem in practise because pick_next_task_fair() is used. However,
since we'll be removing that one shortly, make sure pick_next_task()
is up to scratch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8892,16 +8892,18 @@ static void wakeup_preempt_fair(struct r
 }
 
 static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
+	__must_hold(__rq_lockp(rq))
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
 	struct task_struct *p;
 	bool throttled;
+	int new_tasks;
 
 again:
 	cfs_rq = &rq->cfs;
 	if (!cfs_rq->nr_queued)
-		return NULL;
+		goto idle;
 
 	throttled = false;
 
@@ -8922,6 +8924,14 @@ static struct task_struct *pick_task_fai
 	if (unlikely(throttled))
 		task_throttle_setup_work(p);
 	return p;
+
+idle:
+	new_tasks = sched_balance_newidle(rq, rf);
+	if (new_tasks < 0)
+		return RETRY_TASK;
+	if (new_tasks > 0)
+		goto again;
+	return NULL;
 }
 
 static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
@@ -9011,6 +9021,7 @@ pick_next_task_fair(struct rq *rq, struc
 
 static struct task_struct *
 fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+	__must_hold(__rq_lockp(dl_se->rq))
 {
 	return pick_task_fair(dl_se->rq, rf);
 }



