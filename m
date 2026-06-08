Return-Path: <cgroups+bounces-16725-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lpr7CM60JmoqbgIAu9opvQ
	(envelope-from <cgroups+bounces-16725-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E956656231
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UUVa6xcl;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16725-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16725-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463B63044B99
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0D3C3441;
	Mon,  8 Jun 2026 12:16:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214333BF678
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920973; cv=none; b=TGH1gEAeHwQN7T/xaax6/GCgsicTxIPcl3n4bSHqgO7a4jy2rpqNn5l868gXKtkoXj5oO9eAHM2aMheWvE4D9XU8RJdWpGspTTdFDQrk1kVQirFKzjpxMSeXkMeWXupJFufrjaG90TbxM22ThmhOg6rFR26xb8jvVc/BpDi2X/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920973; c=relaxed/simple;
	bh=BYQW8jJLIb415FaGZ/DHcSKEWD0PzRzsPjdJ7m5EWpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5hPvmqG0A/98/yTTrzwU23Zp8V5vPxm2Io1KcGN0N8o2LzBxAp1Zuij8deYwPKgsyYF+DRYFt4nDx0VfRCBhYuTlcEstVJt9E8U0xE0lg+mgd8fONo3q0rTdV5QbLaJnJhNlT7wfFGfjWpLP4SqfiMpl095+1BXrKYq/jdhUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUVa6xcl; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2178949f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920969; x=1781525769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/E0eBSATwh3f1Xuk/npu4WDtAq8O6nFLmGZ8AjsGbA=;
        b=UUVa6xclWQ7dsXoXP8UoWGSuppGoLKxvUdnuWYpHVbTSJVAxFGleARyj5pf8Uc/ADd
         6RNAFifRoviOySYhZy3yPf4tL8aoKs0V/r8YPkeS1iS0CtrdRdO1ASz9HOV2fu3Tuja1
         feyLRYYgBtg9v76/zKPuQGcy2GhWcCBKtC50Ut+8fdz2bzkWyoqlhEWutwaofOI8VdWg
         W+go91tf0XhvDP95GyYHfGJAdT8ARAadZWa5M4/j6isicTpiNzH7aL5YhCw9dMyXXoQ4
         pdjU/BVMw+Wei+v8ZQjzvYJPZw2XRFkdS6yM6WE3+VH+dvEi2IcAdTLM2LVpEBExM5cz
         cQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920969; x=1781525769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/E0eBSATwh3f1Xuk/npu4WDtAq8O6nFLmGZ8AjsGbA=;
        b=pHbuu4cQHJUlZ9+3ovgShDS150M+3T4LaM3yH0DZpumY/OiBj9NyTjH/hVT6Ft6YMr
         CUz10I8H+UsvTZvLmTrihadvhgO0yKmeXRoMRcIJoUpwf0PzUARghL69X6WbVo3UTjDR
         xoyIHcTrizo88EuPzGBnDFx9JpMkAYw9FmqyrL6egJdpC1DOhoUQHSBjwkKmWLEWJryL
         pk3qSksgDUEO33rhy7F++n9OlExFUU0xVYohXXmfsSLy7PdnV7M/CdHKs/ImHkJpStIu
         zuP1Nh/sWhnOmnbZKvIceSBnILh26+XaqCpZ7+oklAZEvCIZDhGzhKIZIYM6E4J67ob8
         qtbA==
X-Gm-Message-State: AOJu0YxfarKU5vuFByujjegO1pyG//IxRYmxgFeFpz2J9dl7HSboHMvs
	BlUWAsCofmGVpYkIuexgUfQvVcF4uZDxlgKabhiCz6/ECxJblK5ln9gS
X-Gm-Gg: Acq92OFJ36vtFyEpzdtgbHyV445fUDDxJaF5ZUfhScwhrziaFRqT96iAkQpCv/HiJTE
	GqghT++eYNkaAqt8scSjKBErYhcveGeuw9EgXFXshRUfu4pFR5q70fksB9rhVl6koILzFKOzUxB
	RPu9TlSjsYnjEqsWq8LFgridWcmyQ49MjOZW1sUg9lBcVmNKNcn+nVGzcRJ0yZV0l8d5u0HncVZ
	+nFZuPW0XM8zdC+MWFm2moMvYfklVC71ZsaDB/sT0a2U5defTgGqQbv0vcNWx5QQzko3eTgIhpk
	Mh/5X8t4ArAQuzynf1m2cwkXh87/U3Un0oJkC87FYXFnbAJPdywtVQ5qgM1N2Im8KW6tkWeFcHF
	9CeN8TKuPr3+Q6x579/N0eCg/Te3dMnS6DlP/y0Hfuqerlb8Ny0pcbAnJmzODAkMylRofD0sCFo
	QgbQsGddLb7dbkcEA0vp27E/Deq6npk0w=
X-Received: by 2002:a05:600c:1f83:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-490c2621a5cmr257900725e9.33.1780920969326;
        Mon, 08 Jun 2026 05:16:09 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:09 -0700 (PDT)
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
Subject: [RFC PATCH v6 23/25] sched/rt: Try pull task on empty server pick.
Date: Mon,  8 Jun 2026 14:15:42 +0200
Message-ID: <20260608121546.69910-24-yurand2000@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16725-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E956656231

Try to pull task on a server with an empty runqueue before returning NULL (and
thus shutting down).

---

When all the servers of a cgroup are throttled, work is pending, and any one of
the servers is replenished, it may happen that the runqueue is empty and thus
the replenished server is immediately shut down.

The server may try to pull a task so that the cgroup could consume its
allocated runtime as soon as it is replenished.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 964704d88ba1..f672ef17e5d1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -285,14 +285,22 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq);
+static void pull_rt_task(struct rq *);
 
 static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 {
 	struct rt_rq *rt_rq = &dl_se->my_q->rt;
+	struct rq *global_rq = global_rq_of_rt_rq(rt_rq);
 	struct task_struct *p;
 
-	if (!sched_rt_runnable(dl_se->my_q))
-		return NULL;
+	if (!sched_rt_runnable(dl_se->my_q)) {
+		rq_unpin_lock(global_rq, rf);
+		pull_rt_task(rq_of_rt_rq(rt_rq));
+		rq_repin_lock(global_rq, rf);
+
+		if (!sched_rt_runnable(dl_se->my_q))
+			return NULL;
+	}
 
 	p = rt_task_of(pick_next_rt_entity(rt_rq));
 
-- 
2.54.0


