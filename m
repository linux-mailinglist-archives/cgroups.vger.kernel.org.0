Return-Path: <cgroups+bounces-17636-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PjANHQNnUGoYyQIAu9opvQ
	(envelope-from <cgroups+bounces-17636-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE48736F56
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ctctuR/1";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17636-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17636-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 975DA3019FF4
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DAB3672B3;
	Fri, 10 Jul 2026 03:29:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33480367293
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:29:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654141; cv=none; b=evXOltQyUBgKh1dh2yuf3NKaESK7TWJ7YZ/Nf93XyHNAZw/S4uvcYBrS00gz5SpThLgr+9+hfETlIj3skkvRfe68zyYE/1ziRUj8acqH865puelFLTFCkf667t045vkFYVGhA2Gmc7loid2GmxYl4R6nsVT0dpMrVQKDyOzXSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654141; c=relaxed/simple;
	bh=/7g5rPjTXZCVa2/uRZYg9xonGTIXf23dBk7iXIO7Ns0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wym8fHKf8iCNOp8wCNatq+OmBJ+mj4QgX5P366eA8x82GJXoMe2VzJ3wFYjCiob1R8MtJ2zlq2C8S0BJ9RhY4U03GQEZJcviKKW3kehf/X5mGmTatDQwrs1+COxzmCYnWJpqC2Y7mfqfX5ownjZ225U0ql+O7SOhpfwWUyzi/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctctuR/1; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so5830295ad.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654140; x=1784258940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdWcLivIGaN7u5tA3Cryx3dVQvByPYpqsiikxpuxuiQ=;
        b=ctctuR/1r3DuO1xZ+F+26ZuVuh9k62emAj6nfw8tg4tNihn5UI3STRkKRb7pJEHgKO
         gTg8x9kqXW+KRyQ7hLsgTCUsuxyHRHJ1qz2/ibVxZFUgRqxU98LpMP7OVP9mtfG8WCJu
         Kwf8nz/PZ7JkWKLwoDFxFWzgTG6mq/V3ofvtzsQ9TUT61VYhBXSaDN55rZSWLYdfxsE/
         9hG6mKhIQuie5XEYE7PcILmUD/t7gytXx8qzqrxLF4li2f8zcCSdJxFJX6sBDNdSqAVU
         z6IEDwN9h8XvV1ZXOPqPtTprZDy/g+52goUjSwKSI4dP24HyBdIxgU/DqWx4/MKdsFi9
         tVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654140; x=1784258940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CdWcLivIGaN7u5tA3Cryx3dVQvByPYpqsiikxpuxuiQ=;
        b=rJFeRbtIvNdDeNsxyYHs92AYsspgL1zpY6dECdURjfP0RjXZQ4mJGLL2EYs6jOUSaM
         U2neUtpRFWsOIUFA5PpTCyC21odd8/lubzOlKqcxnQkWTWEnmE5BbEkFevMSRS4Z0BXY
         HFeXP5wDq/x03qgYB+j3AQrrQ94AzUwmkOeqj28T4HdTG1Qh8MnPIL014QI9BHe3l5na
         3sjGcL8QQiPDo75m0KDuJHUhkcorz3Yjwur07RweKbevfMtHqkaaWlEPvrpH0/8G15Jl
         leEtX7NpykoAJjuAeXhX/5vraNhcoK66gETIWwlDaIIP3A2YuO9ZOfeifQsLp3fuv7Dg
         r5Gg==
X-Forwarded-Encrypted: i=1; AHgh+RrWjVaQNa6Sz4Jwe2JXe5hxBOiml90FUflNQ9THw46ePjS6BrGVIb4n7ggrzQfTrPVwgiIiHUtZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YWIS/RgtGrczJCtJhPBaXdybPoEESg2nfpT+kXwM3O6S6KD/
	/3AUoPIDY/P0KusN32zUKGHLD/LxYeXHiiih0Q3s+6Ii2cOipkjbdKuP
X-Gm-Gg: AfdE7cmWF8mjwG8xH4AF62PAiNkTTF2qra+byO70qEs1P/DcAAAhLJwWAR72QWAnMls
	u1FsKUFJlh/owzLlZqNB1SUx5Z5ghY6suVHmkHB7yh6jsuDRMSa5Z8rLQvaqwvvYsA28/V7X0hc
	dJS2GNkciqIobV0vWOfPiClAMMH0qgbpooSPf6xSS/zoPGyx1G49tx2mVabX9AvMvsGNFsKNR+x
	doZYnjJL8CROzYTE8o4Ji8Lu3Fn2kyy/uzKs1BTxg4SeGTe2tGy2aKNh6z9fkZCshTg33remmxp
	h24/ogcHjeZFnFNvNeNBVxHlDDD+yvTcvwUHDqMUU8ylKQAfd0Zh6TvFTuozrK3ZWiIkif6acWk
	TPMVOYwrbZXc+9alffiL/D+uJji2orzTrGHk9OLmOwUynr3XEZYd005gGgnyJmw6nPgR37yE2sl
	WA7BL0SOal8HQ=
X-Received: by 2002:a17:903:22c1:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2ccea37ace4mr104298875ad.15.1783654139660;
        Thu, 09 Jul 2026 20:28:59 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:28:59 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:15 +0800
Subject: [PATCH v4 04/11] context_tracking: allow runtime per-CPU user
 tracking enable/disable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-4-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17636-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CE48736F56

ct_cpu_track_user() and the context_tracking_key static key are currently
restricted to boot-time use: the key is __ro_after_init and the function
is __init with __initdata state.  This prevents enabling nohz_full context
tracking for CPUs isolated at runtime via cpuset partitions.

Split ct_cpu_track_user() into three functions:

  ct_cpu_track_user(cpu)      - sets per_cpu(context_tracking.active) and
                                increments context_tracking_key; callable
                                at runtime with the CPU offline.

  ct_cpu_untrack_user(cpu)    - reverses the above; for de-isolation.

  ct_cpu_track_user_init(cpu) - __init wrapper; calls ct_cpu_track_user()
                                and handles TIF_NOHZ / tasklist setup.

Change context_tracking_key from DEFINE_STATIC_KEY_FALSE_RO to
DEFINE_STATIC_KEY_FALSE so that static_branch_inc/dec() can be called
after the __ro_after_init window closes.

Update tick_nohz_init() to call ct_cpu_track_user_init() so boot
behaviour is unchanged.

This is a prerequisite for DHM (Dynamic Housekeeping Management) runtime
CPU noise isolation without boot parameters.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/context_tracking.h |  2 ++
 kernel/context_tracking.c        | 38 ++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c         |  2 +-
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..735d353d87560 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
+extern void __init ct_cpu_track_user_init(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c00..a81d9f8b85eed 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
@@ -674,14 +674,44 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+/**
+ * ct_cpu_track_user - enable context tracking for a CPU
+ * @cpu: target CPU (must be offline when called at runtime)
+ *
+ * Marks @cpu as actively tracking user/kernel transitions and increments
+ * the context_tracking_key refcount.  Safe to call at runtime provided
+ * the CPU is offline so no context-tracking readers are active on it.
+ */
+void ct_cpu_track_user(int cpu)
 {
-	static __initdata bool initialized = false;
-
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
 		static_branch_inc(&context_tracking_key);
 	}
+}
+EXPORT_SYMBOL_GPL(ct_cpu_track_user);
+
+/**
+ * ct_cpu_untrack_user - disable context tracking for a CPU
+ * @cpu: target CPU (must be offline when called)
+ *
+ * Reverses ct_cpu_track_user().  The CPU must be offline so that no
+ * context-tracking readers are active on it.
+ */
+void ct_cpu_untrack_user(int cpu)
+{
+	if (per_cpu(context_tracking.active, cpu)) {
+		per_cpu(context_tracking.active, cpu) = false;
+		static_branch_dec(&context_tracking_key);
+	}
+}
+EXPORT_SYMBOL_GPL(ct_cpu_untrack_user);
+
+void __init ct_cpu_track_user_init(int cpu)
+{
+	static __initdata bool initialized = false;
+
+	ct_cpu_track_user(cpu);
 
 	if (initialized)
 		return;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7c..ba7adc671c580 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -677,7 +677,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		ct_cpu_track_user(cpu);
+		ct_cpu_track_user_init(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,

-- 
2.43.0


