Return-Path: <cgroups+bounces-16705-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h/cbOT+zJmqIbQIAu9opvQ
	(envelope-from <cgroups+bounces-16705-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:19:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2A65611B
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:19:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="MBmR/Zkb";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16705-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16705-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1BD305777D
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC83793D5;
	Mon,  8 Jun 2026 12:15:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112E37998C
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920953; cv=none; b=FMtiy252a8eaONArzPt+Z+jEKA5JkyO8hS0S4LU4fNPposZBxldIgaFlzB/Q5WFtz++uDsIpDrasRTVhaDzlJSEMj7dHefEVnxf+EeUFr4uiQwOXf0fwE5Mdu5NtmNWwqqWqvGnSac8cpEQ499MeobuQuyoK4ABbkoxnVSwyYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920953; c=relaxed/simple;
	bh=rgXOYVc0DI3aXh/5+n+s9LzuQgPbNm+N8WAVL2wfAT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsWw20GMDhLXOpnusOGSI1wF1rvaKj9g6clbc1VOoORBbIleb/R7pGvJVVZ9xpGi7S2Wb81ATVKyZUNm38dZwnUtDyzqrpnmuVuje9YjYUzygvTz5C8XQfEI5VKASp6dJEZc5geM5zK+/SvQacCZs17rPaKkRu+BxrM8DaN93tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBmR/Zkb; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2178724f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920950; x=1781525750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLJJ4ZrsmzvR8fpp1788yY7mK5hc0zSHwTxr8F7vRWU=;
        b=MBmR/ZkbyuiXYKlyyr5sP/v2WnJYNMKO+zHrd6lWQ3GHEbWSzFQuKM+AcHYObymleB
         JX+3j7JAJ5Dp9F1sebFJC2QClOfdT0WIOGi5f9gm/3UsFdtTX2eVkEtM9+6cbdR7kGYU
         IRhiYApV/IGhoZ77eyL13hocRbS9/v4CGFkHMY4X9RnA5bILAZa6idAgXQ5EroKak0ez
         X5kusjt75XHS8SAHZSiyN+IgqoDmI8DUoHdjgy1PL1+sNFeqK02YKQWMIo7g1zd7Qdbg
         eMzjfb647u9NHllKpff28w3NA5wGU6Uci9Xgq9qiRsESNGEpDBDztvAjCAlbo0iKnlAe
         cYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920950; x=1781525750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLJJ4ZrsmzvR8fpp1788yY7mK5hc0zSHwTxr8F7vRWU=;
        b=bLO806E9+8JFZrLcQaGmXuRcTWQ0XOIvIinjqYFrEtj+KkCWL9H4M88Djexki655F3
         vYI7Luj1/E6hGLU+HdAR/2pfVwFDs38o17aXAB7w4T8Tqcgn1na8SNZZ9wdNxnPjv6o6
         V+mfBgpI8pRd9jifip8nJAZlS9UyZ0xMM47yDSsM633ymBrHrRdfS0Ucy304KG+vTEEv
         lGBr11tEJ42ub9kSRir/QibhN7HDuXyfdtj5FsIpxgNwTrxtGKx3wPaIkd64Jd2/3ZVD
         SsU/1SoNOXlO12XPh0ogr2WDEmrOTVa280YekYiopthH/kiG8g+HgP68uf4Jiomd0u6f
         d3Dw==
X-Gm-Message-State: AOJu0YxmrYCmqCjh4Ubn0tICO51zDnK9OVUoknV1XQ8pnWgOi2zeeCqZ
	QuVxVrQZJGCcceQ5gLpauCfdnfK81QXjm/cTgJ+50iyf3noatqp0u8iw
X-Gm-Gg: Acq92OGPw3PEyFWLOHLaWMEwlMZUZvwl1bS2+I4wNX5iAZgfqPAYJUaTyda5VHfhpkd
	QTUuVnv0Sj9EtlSfMIgBM1h21GPfbNuckDcFWEfG6XFn38cd42ecw8p+m0y5YnS4RngOpNrQGf+
	dnTt8a56hvZAxz+PwvSBqpxzOnlS7C60iSaNrxTSA5JZbic2yqwKHhfwEnePzdwvrKdvLsYV9Re
	xXkNkPmBrFvIMnoYSDNuIS7GCmxaALop5SJ0mOCXxKZcuLlwrlFfOiI4R9wTkvZcQ95V+DGuCXR
	q/7HcozLmyea3iqMofZ/jj7/g64dTxYGzhn71BzvbaJWSXBRXhp8Kgv/ECZEJk/ymA/VSPTTXaJ
	iS8d+ZFym7IdEDgz0VaNyzIeBlTAwbqzuOlvfjmCOnK7RfpCNS1BoExbbhtgbWdRMcxZB4m+Wcp
	5qFPjogEEBNDzCaZllLE5Dg/vSXEqZxa0=
X-Received: by 2002:adf:e848:0:b0:460:cfc:eb24 with SMTP id ffacd0b85a97d-460304fec2bmr19705651f8f.22.1780920950442;
        Mon, 08 Jun 2026 05:15:50 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:50 -0700 (PDT)
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
Subject: [RFC PATCH v6 03/25] sched/deadline: Do not access dl_se->rq directly
Date: Mon,  8 Jun 2026 14:15:22 +0200
Message-ID: <20260608121546.69910-4-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16705-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,santannapisa.it:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47D2A65611B

From: luca abeni <luca.abeni@santannapisa.it>

Make deadline.c code access the runqueue of a scheduling entity saved in
the sched_dl_entity data structure. This allows future patches to save
different runqueues in sched_dl_entity other than the global runqueues.

Move dl_server_apply_params call in sched_init_dl_servers as the rq_of_dl_se
function will return the correct deadline entity only if the dl_server flag
is set.

Add a WARN_ON on the return value of dl_server_apply_params in
sched_init_dl_servers as this function may fail if the kernel is not
configured correctly.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ddfd6bc63ab1..63e88ecdd5ed 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -869,7 +869,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * and arm the defer timer.
 	 */
 	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
-	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
+	    dl_time_before(rq_clock(rq), dl_se->deadline - dl_se->runtime)) {
 		if (!is_dl_boosted(dl_se)) {
 
 			/*
@@ -1170,11 +1170,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 			 * of time. The dl_server_min_res serves as a limit to avoid
 			 * forwarding the timer for a too small amount of time.
 			 */
-			if (dl_time_before(rq_clock(dl_se->rq),
+			if (dl_time_before(rq_clock(rq),
 					   (dl_se->deadline - dl_se->runtime - dl_server_min_res))) {
 
 				/* reset the defer timer */
-				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
+				fw = dl_se->deadline - rq_clock(rq) - dl_se->runtime;
 
 				hrtimer_forward_now(timer, ns_to_ktime(fw));
 				return HRTIMER_RESTART;
@@ -1185,7 +1185,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
 
-		if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
+		if (!dl_task(rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 			resched_curr(rq);
 
 		__push_dl_task(rq, rf);
@@ -1481,7 +1481,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
-		replenish_dl_new_period(dl_se, dl_se->rq);
+		replenish_dl_new_period(dl_se, rq);
 
 		if (idle)
 			dl_se->dl_defer_idle = 1;
@@ -1578,14 +1578,14 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	if (dl_se->dl_server_active && dl_se->dl_runtime && dl_se->dl_defer)
-		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+		update_curr_dl_se(rq_of_dl_se(dl_se), dl_se, delta_exec);
 }
 
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
 	if (dl_se->dl_server_active && dl_se->dl_runtime)
-		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+		update_curr_dl_se(rq_of_dl_se(dl_se), dl_se, delta_exec);
 }
 
 /*
@@ -1794,7 +1794,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  */
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
-	struct rq *rq = dl_se->rq;
+	struct rq *rq;
 
 	dl_se->dl_defer_idle = 0;
 	if (!dl_server(dl_se) || dl_se->dl_server_active || !dl_se->dl_runtime)
@@ -1803,16 +1803,16 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	/*
 	 * Update the current task to 'now'.
 	 */
+	rq = rq_of_dl_se(dl_se);
 	rq->donor->sched_class->update_curr(rq);
-
 	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
 		return;
 
 	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
-	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
-		resched_curr(dl_se->rq);
+	if (!dl_task(rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
+		resched_curr(rq);
 }
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
@@ -1856,9 +1856,9 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
 		dl_se->dl_server = 1;
+		WARN_ON(dl_server_apply_params(dl_se, runtime, period, 1));
+
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 
@@ -1867,9 +1867,9 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
 		dl_se->dl_server = 1;
+		WARN_ON(dl_server_apply_params(dl_se, runtime, period, 1));
+
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 #endif
@@ -1895,7 +1895,7 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 {
 	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	u64 new_bw = to_ratio(period, runtime);
-	struct rq *rq = dl_se->rq;
+	struct rq *rq = rq_of_dl_se(dl_se);
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
 	unsigned long cap;
@@ -1971,7 +1971,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		p = dl_task_of(dl_se);
 		rq = task_rq_lock(p, &rf);
 	} else {
-		rq = dl_se->rq;
+		rq = rq_of_dl_se(dl_se);
 		rq_lock(rq, &rf);
 	}
 
-- 
2.54.0


