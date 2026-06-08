Return-Path: <cgroups+bounces-16706-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1paEIGzJmqqbQIAu9opvQ
	(envelope-from <cgroups+bounces-16706-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C065614C
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JBl8UfJf;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16706-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16706-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE28A3068FD4
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705C37AA74;
	Mon,  8 Jun 2026 12:15:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB7379EE6
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920956; cv=none; b=ZAoTahdwxYbySVrc2FWmr9o7hsKDuX1Zqlu3CdVXdveJ1k/H1M6hNOPL85/mYokRDdTE48cvqLjgy0Gh41xwwpCCyUXby9HQvXGKV/BiU6uH6xa2l6kKzbSy1WVxYe4mTghoQGBIoI2IgdjLRdLqp8uvsesFfwe6gnBocEm0eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920956; c=relaxed/simple;
	bh=Fk6uyIEWShVizL/+ulsie+vw2RG/38LGEd2khZSyBdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKhyG7AyzLYdLqd5r5m63HTroIX+QF/UXLle6rundCYp/ucvQO1awAhs/DvMFGJEzNo0tTQuDqnODusJHpBWdRxvwjfhQ1fVNkVINobmKrDb0HoZSqSlKEtDqqllIiGHagqvPzc4LFTnH1mPUNQYsIzSd1kb1WJnHpd8KZwxwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBl8UfJf; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so25904955e9.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920951; x=1781525751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/+5kyst+IWx470x1SiW1/Gwa7Y3Y1pD8ZiaQxMDkvk=;
        b=JBl8UfJf56erOYn+VsJ/JLcGYdi7hfxUFMoK6OsnlwZwiUC1Q/d6Xo4LckHHn7wJR+
         8hdZGU5i1UEz7OjCcrNMmRmbc16GEuvOgs94RGMYwqwg6BeqrFgT8yh4ifq0TUbLeJ/i
         swSteMK0qYNl/Z6ifkUKmG7SpWw4/NGKoAqWrEGwvN7d1oO7ezB04/Wo/quUHqAC0JZu
         j4KRenEN5PvgpdZBkAit4UO6qBvZZEtyLQ0cNMsGhmksJDa9XiQv8sHb5W7+G1SE1c3c
         59QTmi8rPhOHjHNXEYkzgMS9/wSiVG7iUSE6G0oGrnKGCn/GCTrbHARrf4TNEayL8qeE
         jldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920951; x=1781525751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/+5kyst+IWx470x1SiW1/Gwa7Y3Y1pD8ZiaQxMDkvk=;
        b=KwEcjRJ0qwROGkx7MgGD92/7pVr7/3h0jh5RlVWz9KcSSktflfDHYrG7/E5lVLIF96
         IZhgrd5++xrPnh2Iy1/rQMYMQAuorbtpkClxHMCjK8ooHX4WAT5CuK+fAAnI8sO3UUae
         UzLAVllFdLb56RNONeJADlbeU5hKd60CPJEm0Z6LJy2coc3n1R8qmus7CbeBARhk5AYg
         Q+i2DSHK2vvXS8YqISmpZ7OzO6UvhDWJgRZnUajv2CIkqIflMPg+uXItk2pPBS4tvaYn
         bEP+/FhIkhEHifhIsXt2iEmKF0o8VVfsTYUrKmOamkmxIOvTJJTEoM1rT8+XMPb/Ieiw
         ljEw==
X-Gm-Message-State: AOJu0YxGjdop0L+H1uyBIVm2xHORxlvmj/V71bVvbTWvCekZlxxMzQ7Z
	xDv9J5hc0Q1W/QDrsSE7LjOFFUbt98384IF6Shr2NuHtCri00s08fM0C
X-Gm-Gg: Acq92OGZi0envoHX5vH3rAy5Kss90lLByqXd8mAzlDprzIQQltv5fEUcMZifwmW5sSV
	yyZf//DgBmG2Zm1F21nczQVoJyDbOW+lVKGJRH6/wDyn2Q1DeUZLg4xZ4qS4DhrUBvSLzH9mGBW
	4zytJyxjpcz9D2tkIlOvApVT7NTLjCsqoUeXMk/ST6wwJpu6dweAc90dwPi8T6Bqt6n8xoh1/K5
	HmF77g3UBOhoKC9bYXv+T13KZ4fbDcbadpir+vwyJszsVmuYVAgoPYA6jqQFBX90Zw6r0eC0Tie
	EYpyS+5RDwtWkGYr/4VMnK6MpL7a7Q/dptMIQHXJGP2i0RnVF8Gy/Wv5GZgOcbgqBVMOKDoogdH
	PEcNw1SoXRZ+n4PUNt2JPgONWFOezkZGQgOEd4R1rjpr61yVV0JlZiHHbFhxHjfDxNokTK5dHlV
	7InG12LSyLRY40oE8RJ/9MXaeztKvnBEA=
X-Received: by 2002:a05:600d:848a:b0:490:b4e5:ce7e with SMTP id 5b1f17b1804b1-490c26e1afbmr142063105e9.25.1780920951249;
        Mon, 08 Jun 2026 05:15:51 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:51 -0700 (PDT)
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
Subject: [RFC PATCH v6 04/25] sched/deadline: Distinguish between dl_rq and my_q
Date: Mon,  8 Jun 2026 14:15:23 +0200
Message-ID: <20260608121546.69910-5-yurand2000@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16706-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 979C065614C

From: luca abeni <luca.abeni@santannapisa.it>

Split the single runqueue pointer in sched_dl_entity into two separate
pointers, following the existing pattern used by sched_rt_entity:

- dl_rq: Points to the deadline runqueue where this entity is queued
         (global runqueue).
- my_q:  Points to the runqueue that this entity serves (for servers).

This distinction is currently redundant for the fair_server and ext_servers
(both point to the same CPU's structures), but is essential for future RT
cgroup support where deadline servers will be queued on the global dl_rq while
serving tasks from cgroup-specific runqueues.

Update rq_of_dl_se() to use container_of_const() to recover the global rq from
dl_rq, and update fair.c and ext.c to explicitly use my_q (local rq) when
accessing the served runqueue.

Update dl_server_init() to take a dl_rq pointer (use to retrieve the
global runqueue where the dl_server is scheduled) and a rq pointer (for
the local runqueue served by the server).

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 include/linux/sched.h   |  6 ++++--
 kernel/sched/deadline.c | 17 ++++++++++++-----
 kernel/sched/ext.c      |  4 ++--
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/sched.h    |  3 ++-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee06cba5c6f5..411ffe9b34b3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -733,9 +733,11 @@ struct sched_dl_entity {
 	 * Bits for DL-server functionality. Also see the comment near
 	 * dl_server_update().
 	 *
-	 * @rq the runqueue this server is for
+	 * @dl_rq the runqueue on which this entity is (to be) queued
+	 * @my_q  the runqueue "owned" by this entity
 	 */
-	struct rq			*rq;
+	struct dl_rq                    *dl_rq;
+	struct rq                       *my_q;
 	dl_server_pick_f		server_pick_task;

 #ifdef CONFIG_RT_MUTEXES
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 63e88ecdd5ed..b3059658a74a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -65,10 +65,12 @@ static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)

 static inline struct rq *rq_of_dl_se(struct sched_dl_entity *dl_se)
 {
-	struct rq *rq = dl_se->rq;
+	struct rq *rq;

 	if (!dl_server(dl_se))
 		rq = task_rq(dl_task_of(dl_se));
+	else
+		rq = container_of_const(dl_se->dl_rq, struct rq, dl);

 	return rq;
 }
@@ -1817,11 +1819,14 @@ void dl_server_start(struct sched_dl_entity *dl_se)

 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	struct rq *rq;
+
 	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;

-	trace_sched_dl_server_stop_tp(dl_se, cpu_of(dl_se->rq),
-				      dl_get_type(dl_se, dl_se->rq));
+	rq = rq_of_dl_se(dl_se);
+	trace_sched_dl_server_stop_tp(dl_se, cpu_of(rq),
+				      dl_get_type(dl_se, rq));
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
@@ -1830,10 +1835,12 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active = 0;
 }

-void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
+		    struct rq *served_rq,
 		    dl_server_pick_f pick_task)
 {
-	dl_se->rq = rq;
+	dl_se->dl_rq = dl_rq;
+	dl_se->my_q  = served_rq;
 	dl_se->server_pick_task = pick_task;
 }

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65631e577ee9..306bd22a4731 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3252,7 +3252,7 @@ ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 	if (!scx_enabled())
 		return NULL;

-	return do_pick_task_scx(dl_se->rq, rf, true);
+	return do_pick_task_scx(dl_se->my_q, rf, true);
 }

 /*
@@ -3264,7 +3264,7 @@ void ext_server_init(struct rq *rq)

 	init_dl_entity(dl_se);

-	dl_server_init(dl_se, rq, ext_server_pick_task);
+	dl_server_init(dl_se, &rq->dl, rq, ext_server_pick_task);
 }

 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ebec186f982..2bc749ae9203 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9315,7 +9315,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 static struct task_struct *
 fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 {
-	return pick_task_fair(dl_se->rq, rf);
+	return pick_task_fair(dl_se->my_q, rf);
 }

 void fair_server_init(struct rq *rq)
@@ -9324,7 +9324,7 @@ void fair_server_init(struct rq *rq)

 	init_dl_entity(dl_se);

-	dl_server_init(dl_se, rq, fair_server_pick_task);
+	dl_server_init(dl_se, &rq->dl, rq, fair_server_pick_task);
 }

 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d..970386ce4dbf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -412,7 +412,8 @@ extern void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
-extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
+		    struct rq *served_rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);

--
2.54.0


