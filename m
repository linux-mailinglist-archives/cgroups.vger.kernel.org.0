Return-Path: <cgroups+bounces-16715-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cPbgF1yzJmqNbQIAu9opvQ
	(envelope-from <cgroups+bounces-16715-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:19:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26765612E
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hnf03Ug1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16715-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16715-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29C6E3030528
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872338A722;
	Mon,  8 Jun 2026 12:16:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B5379C48
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920964; cv=none; b=dgAYu6OFI00S3Z9KmMqNNqjuQIoCuoccTyk3qcN80CHez/6r4lnDN665DeF7NTyEiWheRYOVfuwzT9S5GE2CvZE2RsmW1F6iy88zRRgh8Omr77wGJX8d2mKZH5sA6xfYxkKJX7pMM6MANd8AkLfT1pzQ60M7YOrS5j58eXLH6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920964; c=relaxed/simple;
	bh=mpexrv9BBxJTWzc0utwv/vwSsLvDN6O0bgb2ctyPub8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPk9H/c1xdFed1k5sDtTBl3wP5HH8iK9L0WX/6bwk8U4xX/IIGUqNF3U+tQnVe/1/EI92ERBjIBUnGwGcCcuRYdTstIV6lLCIhyMOUQdb5rGcruQhKAoG8mlbD98WIMO6ruhBCfbM89oaM0IohTRDLq+qLxdUpksMzh5+WhPLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnf03Ug1; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so34655545e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920959; x=1781525759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVhlGSJa1Vn6iJfAbUGEfqSaevJCYRft5zj2SU3HYyE=;
        b=hnf03Ug1QDHYbMG91ePwbPn9Z9t3fZ20fiSAAAkqFBOx9H5exPB7Lq3sP5xwdebZ48
         ukR8xYFta9Ta81P6VsXbaYjT9SEm6yXpdgmuK8N42pMiF3lQFyw0SqFtz7zgdOYdpqe+
         PIV0TpBeoWOUVlbPFx7ihmlHmtqIVsBnhv5VRHN4RPMcyh2Ww+8jPLANK29oNJHoowD4
         1/WtOztaWHRt40KJ1HVQ7toMyaYfXiPDPeoIH+aiEcVGHxdJbwJGppLzFkZyms6Upbi1
         mVaeVFHa8Hqcasd2Y53dfQnvS9INN9XA9IsFarCigmT0Tqdx6mYh/rZgGjcRqmPZqMXe
         5ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920959; x=1781525759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVhlGSJa1Vn6iJfAbUGEfqSaevJCYRft5zj2SU3HYyE=;
        b=ghxnth5Jbc73ezS70RXeEi0YxpN3tzmHbZ+FJtw3u9EWqzZpWFn+3snZ4xr2NQUfuF
         DaB1Wm6KAdtYHcRLWCMMF0CoC/obEGjSfaGldz3cBW9L/714IW8HYRD4XBax5kfJeXsp
         rEaLYIN6yti35mzEHUc4UtYScFw0jU/8dsqptZsKyfyXAStK27I/iTUAcvnaDlSW6W2S
         ahsVp5nVp2V2IVVjvtS5zRgsh5KIQtLXyOuK2Yrdv189hm/UWT/G9t67lmJ4wXrovEqV
         eMWUvfBepvxNHPk2eBPpinJmSBhn/lJrsr7cKPIfgAz2cDRwkqp5bcLVHsn+GrZsAGeP
         q0Dg==
X-Gm-Message-State: AOJu0Yw/bpCV6IIo52dlLL63Tepsi0yRkXImBJhq/AQ/B3FhjdhFC0sz
	Kso331HKJslzrvKc66CF07uOxPVFXDzvZBQRcWtWIs5uhX1slOekXFMI
X-Gm-Gg: Acq92OHGGjfDAQBY3yA/zhykKh53snv5CzG+LbnZVgmsKFozMn7QaWEl4awzqrTiLtk
	VoKA8fhsV/RDzYFkI5JCNobMSFcHAUZDLIpSYSyuXTTT4a1VItKSAFmLTTe5yhUb1ZuIAPXY/ri
	SofefUG7PkG8dx48n9c8Ibaqlbfdgb8w2DEoGgydRfUVoTkLQp/rCqxqpYeJlvAIYwGG3+z03JG
	1DzixW0MjYcTZs+1e6D3TxCSW2tNl8m/JCBg+U9Q/JUX3AK/XWn0JamGjRdkw6CNeZmF284r+MX
	OXhjZAiBp1xBiugh40HcYdccE/KYIT+jM8cDgLBfqobGNkVNvzBtC39uyuuXQgfnOfcVUwXqDne
	ROb3apa+bVt3iixypcE8CemjysOTONHg0C16MjV2+dz+UhRCeksWk0XjNs/zzt7lCXiFynOWeCg
	FRiK9KQbWtyTcG+dFD9MTxjSy6+c0MatY=
X-Received: by 2002:a05:600c:1c1f:b0:490:b189:212d with SMTP id 5b1f17b1804b1-490c2631948mr252757195e9.33.1780920959367;
        Mon, 08 Jun 2026 05:15:59 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:59 -0700 (PDT)
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
Subject: [RFC PATCH v6 12/25] sched/rt: Add {alloc/unregister/free}_rt_sched_group
Date: Mon,  8 Jun 2026 14:15:31 +0200
Message-ID: <20260608121546.69910-13-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16715-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sssup.it:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A26765612E

Add allocation and deallocation code for rt-cgroups.

Declare dl_server specific functions (only skeleton, but no
implementation yet), needed by the deadline servers to be called when
trying to schedule.

Initialize a cgroup's active context to that of its parent.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 156 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dbba7a57d6f1..a6adf21772a6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -120,24 +120,176 @@ struct dl_bandwidth *dl_bandwidth_write(struct task_group *tg)

 void unregister_rt_sched_group(struct task_group *tg)
 {
+	int i;
+
+	if (!rt_group_sched_enabled())
+		return;
+
+	if (!tg->dl_se || !tg->rt_rq)
+		return;

+	for_each_possible_cpu(i) {
+		if (!tg->dl_se[i] || !tg->rt_rq[i])
+			continue;
+
+		if (tg->dl_se[i]->dl_runtime)
+			dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
+	}
 }

 void free_rt_sched_group(struct task_group *tg)
 {
+	int i;
+	unsigned long flags;
+
 	if (!rt_group_sched_enabled())
 		return;
+
+	if (!tg->dl_se || !tg->rt_rq)
+		return;
+
+	for_each_possible_cpu(i) {
+		if (!tg->dl_se[i] || !tg->rt_rq[i])
+			continue;
+
+		/*
+		 * Shutdown the dl_server and free it
+		 *
+		 * Since the dl timer is going to be cancelled,
+		 * we risk to never decrease the running bw...
+		 * Fix this issue by changing the group runtime
+		 * to 0 immediately before freeing it.
+		 */
+		if (tg->dl_se[i]->dl_runtime)
+			dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
+
+		raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
+		hrtimer_cancel(&tg->dl_se[i]->dl_timer);
+		raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);
+		kfree(tg->dl_se[i]);
+
+		/* Free the local per-cpu runqueue */
+		kfree(rq_of_rt_rq(tg->rt_rq[i]));
+	}
+
+	kfree(tg->rt_rq);
+	kfree(tg->dl_se);
 }

+static inline void __rt_rq_free(struct rt_rq **rt_rq)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		kfree(rq_of_rt_rq(rt_rq[i]));
+	}
+
+	kfree(rt_rq);
+}
+
+DEFINE_FREE(rt_rq_free, struct rt_rq **, if (_T) __rt_rq_free(_T))
+
+static inline void __dl_se_free(struct sched_dl_entity **dl_se)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		kfree(dl_se[i]);
+	}
+
+	kfree(dl_se);
+}
+
+DEFINE_FREE(dl_se_free, struct sched_dl_entity **, if (_T) __dl_se_free(_T))
+
+static int __alloc_rt_sched_group_data(struct task_group *tg) {
+	/* Instantiate automatic cleanup in event of kalloc fail */
+	struct rt_rq **tg_rt_rq __free(rt_rq_free) = NULL;
+	struct sched_dl_entity **tg_dl_se __free(dl_se_free) = NULL;
+	struct sched_dl_entity *dl_se __free(kfree) = NULL;
+	struct rq *s_rq __free(kfree) = NULL;
+	int i;
+
+	tg_rt_rq = kcalloc(nr_cpu_ids, sizeof(struct rt_rq *), GFP_KERNEL);
+	if (!tg_rt_rq)
+		return 0;
+
+	tg_dl_se = kcalloc(nr_cpu_ids,
+			   sizeof(struct sched_dl_entity *), GFP_KERNEL);
+	if (!tg_dl_se)
+		return 0;
+
+	for_each_possible_cpu(i) {
+		s_rq = kzalloc_node(sizeof(struct rq),
+				    GFP_KERNEL, cpu_to_node(i));
+		if (!s_rq)
+			return 0;
+
+		dl_se = kzalloc_node(sizeof(struct sched_dl_entity),
+				     GFP_KERNEL, cpu_to_node(i));
+		if (!dl_se)
+			return 0;
+
+		tg_rt_rq[i] = &no_free_ptr(s_rq)->rt;
+		tg_dl_se[i] = no_free_ptr(dl_se);
+	}
+
+	tg->rt_rq = no_free_ptr(tg_rt_rq);
+	tg->dl_se = no_free_ptr(tg_dl_se);
+
+	return 1;
+}
+
+static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se, struct rq_flags *rf);
+
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 {
+	struct sched_dl_entity *dl_se;
+	struct rq *s_rq;
+	int i;
+
 	if (!rt_group_sched_enabled())
 		return 1;

+	/* Allocate all necessary resources beforehand */
+	if (!__alloc_rt_sched_group_data(tg))
+		return 0;
+
+	/* Initialize the allocated resources now. */
+	scoped_guard(raw_spinlock_irq, dl_bw_lock_of_tg(parent)) {
+		init_dl_bandwidth(&tg->dl_bandwidth, 0, RUNTIME_INF,
+				  dl_bandwidth_read(parent)->active_context);
+	}
+
+	for_each_possible_cpu(i) {
+		s_rq = rq_of_rt_rq(tg->rt_rq[i]);
+		dl_se = tg->dl_se[i];
+
+		init_rt_rq(&s_rq->rt);
+		s_rq->cpu = i;
+		s_rq->rt.tg = tg;
+
+		init_dl_entity(dl_se);
+		dl_se->dl_runtime = 0;
+		dl_se->dl_deadline = 0;
+		dl_se->dl_period = 0;
+		dl_se->runtime = 0;
+		dl_se->deadline = 0;
+		dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+		dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
+		dl_se->dl_server = 1;
+		dl_server_init(dl_se, &cpu_rq(i)->dl, s_rq, rt_server_pick);
+	}
+
 	return 1;
 }

-#else /* !CONFIG_RT_GROUP_SCHED: */
+static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	return NULL;
+}
+
+#else /* !CONFIG_RT_GROUP_SCHED */

 void unregister_rt_sched_group(struct task_group *tg) { }

@@ -147,7 +299,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 {
 	return 1;
 }
-#endif /* !CONFIG_RT_GROUP_SCHED */
+#endif /* CONFIG_RT_GROUP_SCHED */

 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
--
2.54.0


