Return-Path: <cgroups+bounces-16722-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JgnIIcmzJmribQIAu9opvQ
	(envelope-from <cgroups+bounces-16722-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:21:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946065618B
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MNtbC7fq;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16722-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16722-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2A203042FBE
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9EE3C0613;
	Mon,  8 Jun 2026 12:16:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560993BB9FC
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920971; cv=none; b=uVVykCZnT4DB7ImEE2k4qUJE3SJ0lzMfXfQfCtMRw9UwB+bYhV07n/NJLTlCJJZ1vztHnK3AtTmg6kYbBdOILuTYKD9jJXfgKx0UifBItbdN4nbZJrTeLFLNlj60jgBTtE3xNHStq2VjxfYj0MxV1bOIxeYHtTLV74Yta7ivAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920971; c=relaxed/simple;
	bh=tDC7u52egQ55UBVu3L5EMvdM3Vtu7xDSms+xUy0L7YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrb1eYKMPPCPagILTW+WB/08HwkODQc6VezdRUZwjcgvop+yZEjxpowzEZPYoBb8BJSruZDYWF4uIrBzxdGnTJQiCLnkn1xNjFAhAVFODc9bKOfVrGavL0pz3y65NWGgWFOsgOetGEqGhjqiUsnLYJYYUj5CcbGjDi6zdpBR46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNtbC7fq; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3071275f8f.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920968; x=1781525768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOIvSewylSpCmuC9OVq7JPT5uWWaJG2zU5cqeF25bdA=;
        b=MNtbC7fqAvcJ4DGOCs299AC1jcmNRSVulF0OCzJXgyEEudLQ0BHWrVQmCKNjzpjUy3
         EAhTlyR6s/LwwMlt6CG7Cn+UErlYebwG/EoQxZsbhmYr+nggiC6LAOK1yjOWwlMASAXv
         7TkTrG9vRsMjMyvfGzR5JrtGM4ygdthlIF4rC5HTvUKdk4nTRGSZWKcsZMWzMFFN/NyP
         Ff5Eyca/HY/kdyPc9yKUZe6OIBQ8oaXhf/QpSbyfV7AvYQ9OV1mrcym9+iVuQORCr5jj
         nfzQPpinN8PvJ0mUJNqo5F5o/VOdvNptKKiFruY6ELgcLlwa3+CSxXnQAGVAekVJ5NFa
         P1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920968; x=1781525768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOIvSewylSpCmuC9OVq7JPT5uWWaJG2zU5cqeF25bdA=;
        b=ir9nc9EECuMF/YqHNm9KEim1//pkfQB6JOejV2qe1YJe5K/DoEbUUXjoXfVKaVGIxU
         OtjdaMWKGvhJZ1YXVR3wJwGpJLkHXTDYTHG1N820UTLJ2n3vAFOUlnyY1YrqGYxmVjB8
         FOIdHD7EQfRdNTW9ua0GP3fjk2c63DXkxS4u7gAK9nJUXhfxJF0PVXleF+Zz1RdLouYv
         FmP8rOnwrNKnbNvmT6f4OBmT3KOrBXzEvUK3+mLX9/Yi/LgVX2qrldaqG2chE6KGNog9
         4UFG2ExM6lxUgjaAxWvoZnAAgwRlSiyiKbWpjWjGkTxmMUX3FcXruIrktodjr+W+5m1C
         /J/A==
X-Gm-Message-State: AOJu0Yx/bAKmKCRpO2Pv8a9/tEHgY1oh4W+BuL6oJ2wcBFl4po8Cxivk
	rfpzYXY17otZHhhV7cnW1CXO5Y0iQuACvza6JX9+CM1p/JLJhF6s731e
X-Gm-Gg: Acq92OHHMSrF1lNLempx0TlkPnf9RsP6uuSBJRMFxZL4HjGuMWbkf2VpyI4JmGKYEB+
	aTCFkN3Xlz0f0SPt21c+KKL/8eicaGiyiK6W2z6uDyxh7rNsyN8ot3Zorpm5lBuD893jtz9zU11
	Ydf/EJayIZvU0IDbs/4qcpp66BBP0df5WLfJ0b+JRLzFmOfRyyyOtNHSnGlWAvNwtaqNyUEm8Hn
	X4FGo1SqmDxRL4e9ql35PHPcZDan86WCwE+p/ocEvpgHvP9mHhmFYGt26tA7S5f1ZbkF2XLYWyY
	dHQVMwXJnVN9qH0PQ5jT1TtqblFVPcINXiTwUqBKMjMAAO5PWaNrCsHYvdvJ+91AZlcwGPbNZEX
	JgaM4fMAaPgRDPi+b7PCMI15NU/0lGbEGeE2aWZWXqIjV5wlRd2hmCwaG68a49iaUKlUdsYZmqi
	WPQFC9G50UuN414/BZD/rtvIsgwV4WpeY=
X-Received: by 2002:a5d:6448:0:b0:460:d18:865c with SMTP id ffacd0b85a97d-46032b61422mr15269071f8f.1.1780920967701;
        Mon, 08 Jun 2026 05:16:07 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:07 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 21/25] sched/rt: Hook HCBS migration functions
Date: Mon,  8 Jun 2026 14:15:40 +0200
Message-ID: <20260608121546.69910-22-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16722-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:email,sssup.it:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3946065618B

Hook rt-cgroup migration functions:

- select_task_rt_rq
  Always return the cpu where the task is scheduled.
- balance_rt
- put_prev_task_rt
  If a server is throttled, put_prev_task_rt is invoked and a push is
  necessary so that the task can keep running on another server if possible.
- switched_to_rt
  Keep track of the deadline server that is assigned to the task switching
  to FIFO/RR priority.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 276eebe8d0a9..964704d88ba1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -976,6 +976,10 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	struct rq *rq;
 	bool test;
 
+	/* Just return the task_cpu for processes inside task groups */
+	if (is_dl_group(rt_rq_of_se(&p->rt)))
+		goto out;
+
 	/* For anything but wake ups, just return the task_cpu */
 	if (!(flags & (WF_TTWU | WF_FORK)))
 		goto out;
@@ -1065,21 +1069,25 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	resched_curr(rq);
 }
 
-static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static int balance_rt(struct rq *global_rq, struct task_struct *p, struct rq_flags *rf)
 {
-	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
+	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq_of_rt_rq(rt_rq), p)) {
 		/*
 		 * This is OK, because current is on_cpu, which avoids it being
 		 * picked for load-balance and preemption/IRQs are still
 		 * disabled avoiding further scheduler activity on it and we've
 		 * not yet started the picking loop.
 		 */
-		rq_unpin_lock(rq, rf);
-		pull_rt_rq_task(&rq->rt);
-		rq_repin_lock(rq, rf);
+		rq_unpin_lock(global_rq, rf);
+		pull_rt_rq_task(rt_rq);
+		rq_repin_lock(global_rq, rf);
 	}
 
-	return sched_stop_runnable(rq) || sched_dl_runnable(rq) || sched_rt_runnable(rq);
+	return sched_stop_runnable(global_rq) ||
+	       sched_dl_runnable(global_rq) ||
+	       sched_rt_runnable(global_rq);
 }
 
 /*
@@ -1241,6 +1249,13 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rt_rq, p);
+
+	if (is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (dl_se->dl_throttled)
+			rt_queue_push_tasks(rt_rq);
+	}
 }
 
 /* Only try algorithms three times */
@@ -2050,12 +2065,21 @@ static void switching_to_rt(struct rq *rq, struct task_struct *p) {}
  */
 static void switched_to_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	/*
 	 * If we are running, update the avg_rt tracking, as the running time
 	 * will now on be accounted into the latter.
 	 */
 	if (task_current(rq, p)) {
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+		if (is_dl_group(rt_rq)) {
+			struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+			p->dl_server = dl_se;
+		}
+
 		return;
 	}
 
@@ -2066,7 +2090,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (task_on_rq_queued(p)) {
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
-			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
+			rt_queue_push_tasks(rt_rq);
 
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
-- 
2.54.0


