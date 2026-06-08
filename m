Return-Path: <cgroups+bounces-16713-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZAOZOh2zJmqCbQIAu9opvQ
	(envelope-from <cgroups+bounces-16713-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:18:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAF65610F
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:18:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TmBwjHDx;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16713-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16713-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9410C30234C5
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AD37AA72;
	Mon,  8 Jun 2026 12:16:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9637C92A
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920962; cv=none; b=ZJxqSpraXqUL2cdhlQzYzJXH+KrgthyTMQXjnflGCoMDtsGMh84LQtdf77AMolgQ4Wh48xz6lEB9m+IoW+SWx0EMn6jJ2SwLgswrwVV2h3iKQ3AMrxsnsDteTCxeiRSTpTxyusNR6aRoSOANzyVsmtnaH6LfDKvHRTGD3MppWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920962; c=relaxed/simple;
	bh=l7/2jOFeBJhQNf2GhvMwDBVsIZzI9+ePozibbqh9nsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZWYj9Bp6ymk2bkM2pwHyV4aQiN4OgB+ZbanLh/L6VdkAWpuuLpJ1ap9b8e4S1i5L1OBJpCbN3ANjXNlBxJQV5fGtDvgzzHPb9yBnFUw1O9LW3pUfJa5QvBFuUpPAtOGWEwmIQjcAVMHS1BsPD1R+99j6tmB1l0jlzcLb2AWOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmBwjHDx; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso2942772f8f.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920958; x=1781525758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0yT2Aj62az0wIP5mZB6k9It5mchAon7rR5a4sHBIVw=;
        b=TmBwjHDxf79PmLytvgLrD4ZbR6OA7SQ8yTStDmLfjnikQz53RC7QGmOj78cc+XheQf
         XXMUIA2bHa/rEYDluqFiEhMHoPNTc3DNRMeZHLnDzsqumawWl10vGz5ZTrkjq6QHvhQP
         BIXiIbMUyNOxqOxKiG2tTo9sMqdd2CPQe/XwCEHuOMeia0J9nINTrosWssfIsJaKkaJM
         D/bzGXPEz4MobwlBomnl4VTVjvo+enrjpRQsj18/A9BeeIXtE7fJSyI4k23FVrHqjEZ/
         ocU+b0/ionkalV+lfysdQiAjosFY49WVSOHcFeuVgAlwij4Vq0a15kX+GigEahShlyte
         4yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920958; x=1781525758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0yT2Aj62az0wIP5mZB6k9It5mchAon7rR5a4sHBIVw=;
        b=rL9NH+sMEhT23k2GrtwevzgAynp+fMyYWv9fyRmQ0Hje3Hc2T/pI5IHzw1rm90r740
         g8n/vmKTwgCaSw9P9fw6Aa3yu2JPNeB+PiFLs+dkFBBCBBYBLZhKZSkLzcik0kgbWtRb
         D9frE/ukzVGgqmDJ8KOoK/fwuuTEkqABc+jjJB/lKisz9SNO3vLISddg8v0BmjYZiHHn
         Kds1HV69TKSwSmkV0IMWJJpJPNsatkpXpg+rXgmSdPwFI+vO0xeQIldA+wKqnMKlyUEp
         qY4hZJyUl5LUyXACptCLhUlAGq00YMB1BIDpO1UP13mnsG8C76XNebtv/OUgIdbpzm8y
         cu2Q==
X-Gm-Message-State: AOJu0Yw9Cg0Q32DwJLhgMYG0Em96kevvN4uV02m5jOSurVHl1nAXa/qu
	gf3/aBeolGGnNFPSaUiK18KXtyYfaPbhWeG7EiKZlWIMA1RoQRx7qjEq
X-Gm-Gg: Acq92OEuCF7HW9R/rRNemIEFiR2XirPRAnrYitpSG3Z+3vuWxiqtEyVKuTqwvHIaQaK
	vuWtrTIUaoYZCQiMLnbPCYUpoPai5nV60yUgBCrkEPG7NQXZB1wNB3iiKMmedjkTr1iIMqw5R+J
	4QKpdJh9NGpaUZB8MQ6x180ZR7d226yD5hrJ+JK8uHWNm03V9AVxvIW50HIblhabGOERNgySid4
	3m3MynKfGCbeCDPVTPsivQ7Iwn3koFd1oSykN/NJdjKobMwfZ5WfsXoZ3k+oQkdbzwSmmpqKYaq
	2ctPQr3dZJtQgkqViLNS7ZlBCE4yrWqnCPwFCKSPmpZy49ZnHhWZ4CUqhyf0TFAj9IFy89iKA3x
	HKRB2o/DklLWYMhPWo4AXMBYuA1OpZyXY4y6BOA0PAAAth052jLY2jHEzSMMOXBx22iQbg0zjw4
	LMsakwGBw7zR3t53IWQKtpmE9+06W71sw=
X-Received: by 2002:adf:f750:0:b0:45e:d8dc:922e with SMTP id ffacd0b85a97d-4603063a8ccmr17387986f8f.20.1780920958441;
        Mon, 08 Jun 2026 05:15:58 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:58 -0700 (PDT)
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
Subject: [RFC PATCH v6 11/25] sched/deadline: Add dl_init_tg
Date: Mon,  8 Jun 2026 14:15:30 +0200
Message-ID: <20260608121546.69910-12-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16713-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sssup.it:email,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95BAF65610F

From: luca abeni <luca.abeni@santannapisa.it>

Add dl_init_tg to initialize and/or update a rt-cgroup dl_server and to
also account the allocated bandwidth. This function is currently unhooked
and will be later used to allocate bandwidth to rt-cgroups.

Add lock guard for raw_spin_rq_lock_irq for cleaner code.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/deadline.c | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  5 +++++
 2 files changed, 36 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 673c6f2b5ece..afadc3521bc0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -335,6 +335,37 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
 	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
+{
+	struct rq *rq = container_of_const(dl_se->dl_rq, struct rq, dl);
+	int is_active;
+	u64 new_bw;
+
+	guard(raw_spin_rq_lock_irq)(rq);
+	is_active = dl_se->my_q->rt.rt_nr_running > 0;
+
+	update_rq_clock(rq);
+	dl_server_stop(dl_se);
+
+	new_bw = to_ratio(rt_period, rt_runtime);
+	dl_rq_change_utilization(rq, dl_se, new_bw);
+
+	dl_se->dl_runtime  = rt_runtime;
+	dl_se->dl_deadline = rt_period;
+	dl_se->dl_period   = rt_period;
+
+	dl_se->runtime = 0;
+	dl_se->deadline = 0;
+
+	dl_se->dl_bw = new_bw;
+	dl_se->dl_density = new_bw;
+
+	if (is_active)
+		dl_server_start(dl_se);
+}
+#endif
+
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ba87be1c98f..58f67093145e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -425,6 +425,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
 		    struct rq *served_rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
+extern void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period);
 
 extern void fair_server_init(struct rq *rq);
 extern void ext_server_init(struct rq *rq);
@@ -2044,6 +2045,10 @@ static inline struct rq *_this_rq_lock_irq(struct rq_flags *rf) __acquires_ret
 	return rq;
 }
 
+DEFINE_LOCK_GUARD_1(raw_spin_rq_lock_irq, struct rq,
+		    raw_spin_rq_lock_irq(_T->lock),
+		    raw_spin_rq_unlock_irq(_T->lock))
+
 #ifdef CONFIG_NUMA
 
 enum numa_topology_type {
-- 
2.54.0


