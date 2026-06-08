Return-Path: <cgroups+bounces-16724-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UL3nNhO1Jmo2bgIAu9opvQ
	(envelope-from <cgroups+bounces-16724-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:26:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4465625C
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pYWVUIOt;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16724-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16724-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB82230A8184
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F023C1F40;
	Mon,  8 Jun 2026 12:16:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EE3BCD34
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920972; cv=none; b=V4hHv1bNRe8XW7QwPkEKCNjI14l/IlU3b5CLDNwIBt9TP7FJ8tHuU8rrPusbgzoKLJuzB1K3fQfbqixZ5LY+nBsDF7QqcWPAuQE4FsRA1MU+pDV8vRUZeMoSinYHZ0L/W+bLxniLrqtx2SZVM4tPfvKl2F3nK+TAcZYLhmD4wTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920972; c=relaxed/simple;
	bh=FaDubOoH7dsOeXM2Hn0EEIBjQF2nxAfMMPK3pnb2MTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSIJRYGoXOc+k2RUsYCrPlxPIUnO25uwUL3lZW5TN/6qPNVfYYXmJPgKOdt50a9gtcpPH+5dmViepOi5HAThUdESyskoxaZys2D+2QQEhJsjET0eel45gVQoIR6iUeJLKLiL0HKxJ1BPKN8St4jVYdOkbYO+Pk23FDRkAsk3+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYWVUIOt; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1956691f8f.2
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920968; x=1781525768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KNwOSXF/MHMJ4z938tfpzy14/zc4Yo7RxXmK9ytG1M=;
        b=pYWVUIOtKnwUaxFmjZXqWJmLbqpvWO6MdR6+ukJFYuk7injJ4Ftvgv7G7A7l46dYnS
         ik38HpvlaBDHaWy8cNTfliNBYJIhSs2EgzSGO4WzNHMGEmfIawECd4XFhVpb7i2mwOBL
         Bp2LEjNpyV8BZojMttVlDSUPc+b+vPkTDk9aM9mrWum6tpjMla0IqyWdz1Wls5kQPKXb
         UvT+ZZfaVCC0TwKk7aVQhWnBPup5TyQBGHP3UYlj4rhTdV192qUyOzMaC5H00rzGxf/P
         pOlRFutV+ZnAQwYxBJPKODujppk+uAjnQsWnTMiD8qS95d8Zym3Ovd/exEJ8krOB3mUT
         VMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920968; x=1781525768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KNwOSXF/MHMJ4z938tfpzy14/zc4Yo7RxXmK9ytG1M=;
        b=bz82ILJnQFinB6gzs40BFGTrQ0rBkz/dMmHQ3Mh18XCzojEXPqBWgW10BrYA5PmfU9
         QoHg+saUYdkDD6MyHgqyVhCI4CDyrnSC3V0HTw6wzb1bHKwJES5XTugU7TklXw0hDG2Z
         euvXcMUT+a34oVnQZ6XgN9g96Cl/5dQJbbFHeadlCbM/lz0XwWylKRc/k2hcLLvne9cd
         07YEZqRq1hVt31srjzaoIwiBILo5x2VFg53eKp3ZYk8ZYVeN++hLd/5s/nWT7fxOLQSU
         ObhIU3NflQEhIr0r9bTXbyxjXWeT4Hx46iM9qE9CnnwTcJSbRJ1liDRFWxOL7+X8Myb/
         iWIw==
X-Gm-Message-State: AOJu0YzYSNn24kcMhxN6Jc6MBmW402MIFBdlU0HIDq/Ne5WuzuqCHfxl
	++Jz33baR6/B4dNg2pDr/9N0yistxd4USXBvoNny4bKTHkB5IoYS5k8hOxW/2Mix
X-Gm-Gg: Acq92OHUvU9y4kIdbfoGFp9RiHWlK1eiFC328ClLQv+0fjtI8LDq0rNmGTap+xxYLL1
	MyVzhUCFEhodFa6pYgCaKLGmA6Icf9nkSrRTr/6KyEkA4c90K9OL0nxbEuWy40a/tD4sfhAceOV
	zs9NCY4zoWWjNnd3bFO+M0s0pJuJ7OIBaWSL6RlOpO0kpWD75kVlTO66Nu1pT6TsF471iUvW5v9
	cyvkz9OpdVCyxZyTOcx0oY6qPLJpcqb1dt4aAg84530neSlkq4PSyXtYbO6fDMjg9OFKw4jk03R
	3z76gTH1UlPkiRDmSnMEhNcUMeq1YwAqkCq6mQ7UoiZt3ZsEOv6GRdjRRHl53bSVJG1cnLwrXRs
	WQd0cPtyq+Wz26SJUqzrkUVBu0Rhs31x9z45PZNZLVYLwi8AZ0rKaA3KAzE+FiGI3pcpSS2oUiW
	3ck1aByOCPMwJoZEb5vFcSFWfrdc5cy6I=
X-Received: by 2002:a05:600c:a088:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-490c25fc129mr246357485e9.16.1780920968525;
        Mon, 08 Jun 2026 05:16:08 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:08 -0700 (PDT)
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
Subject: [RFC PATCH v6 22/25] sched/core: Execute enqueued balance callbacks when changing allowed CPUs
Date: Mon,  8 Jun 2026 14:15:41 +0200
Message-ID: <20260608121546.69910-23-yurand2000@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16724-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FE4465625C

From: luca abeni <luca.abeni@santannapisa.it>

Execute balancing callbacks when setting the affinity of a task, since
the HCBS scheduler may request balancing of throttled dl_servers to fully
utilize the server's bandwidth.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ad1efe1dca7..9e337f0090b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2933,6 +2933,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
 	    (task_current_donor(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
+		struct balance_callback *head;

 		if ((flags & SCA_MIGRATE_ENABLE) &&
 		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
@@ -2951,11 +2952,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}

 		preempt_disable();
+		head = splice_balance_callbacks(rq);
 		task_rq_unlock(rq, p, rf);
 		if (push_task) {
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    p, &rq->push_work);
 		}
+		balance_callbacks(rq, head);
 		preempt_enable();

 		if (complete)
@@ -3010,6 +3013,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	}

 	if (task_on_cpu(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
+		struct balance_callback *head;
+
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -3023,16 +3028,19 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			p->migration_flags &= ~MDF_PUSH;

 		preempt_disable();
+		head = splice_balance_callbacks(rq);
 		task_rq_unlock(rq, p, rf);
 		if (!stop_pending) {
 			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 					    &pending->arg, &pending->stop_work);
 		}
+		balance_callbacks(rq, head);
 		preempt_enable();

 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
 	} else {
+		struct balance_callback *head;

 		if (!is_migration_disabled(p)) {
 			if (task_on_rq_queued(p))
@@ -3043,7 +3051,12 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 				complete = true;
 			}
 		}
+
+		preempt_disable();
+		head = splice_balance_callbacks(rq);
 		task_rq_unlock(rq, p, rf);
+		balance_callbacks(rq, head);
+		preempt_enable();

 		if (complete)
 			complete_all(&pending->done);
--
2.54.0


