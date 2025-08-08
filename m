Return-Path: <cgroups+bounces-9044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83834B1EBAC
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E1C1C24F31
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F2285041;
	Fri,  8 Aug 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2PyJG9K"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBB28369A
	for <cgroups@vger.kernel.org>; Fri,  8 Aug 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666446; cv=none; b=VXhDkF6Ihq4QqRk4/0moL1JxGJlJSFVrvxaA+MBp5f4cA3U8LdfyAQGCttDoLZ1w7grjfRl+ZPCeke74avk5eB7Y4BNyPrLWmxigcU7rErkVJkD8Hf2w34WeOzSFa8dn/+WkV17LN07siuPhaZBKdseg8BZqW8b3OfXexogi2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666446; c=relaxed/simple;
	bh=KhnDnewWmNF5LBNjEEZdjlT1+NiVfMU/hEwiwCzSkY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys1A+C84MPmiNFa2o0KMKvEMXxcloMH8ZGMZW0BbBOALvRaZkULaaD2E5vUN6Bp9WtufB7abo1G9InnHlYP4PPI4dGHqNrKxeK3xJjISVLmhwfDL7hZhMfhiKhMClofrN6GpOt/kmEA0RrfoheLBduAK5tsgNr1chpk0fmSEj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2PyJG9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxJEYuuRH3QK9/Cdhoov2KDfqFceQ8tv5+6IbkX7B5U=;
	b=g2PyJG9K1/+plU+PPZo1kG61lq5ivDUPFM8hhPaDbl7dyAUtxsq2LyyyDXW93rBAN2ws0W
	xrw5/djAYemEU3cbx5h/BkiYWeDSdyeAaJFnQmihPocNEUFInkr7V01gMp9nHJLaI/xbnX
	9SXqfhs3SWpeMfURclVMLfXr9X3WSS0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-JK_dUM0TP86Dh_KVi_TrBw-1; Fri,
 08 Aug 2025 11:20:39 -0400
X-MC-Unique: JK_dUM0TP86Dh_KVi_TrBw-1
X-Mimecast-MFC-AGG-ID: JK_dUM0TP86Dh_KVi_TrBw_1754666434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96322180028C;
	Fri,  8 Aug 2025 15:20:34 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48E23180029B;
	Fri,  8 Aug 2025 15:20:28 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 12/18] tick/nohz: Introduce tick_nohz_full_update_cpus() to update tick_nohz_full_mask
Date: Fri,  8 Aug 2025 11:19:55 -0400
Message-ID: <20250808152001.20245-3-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When the list of HK_FLAG_KERNEL_NOISE housekeeping CPUs are changed,
we will need to update tick_nohz_full_mask so that dynticks can work
correctly. Introduce a new tick_nohz_full_update_cpus() function
that can be called at run time to update tick_nohz_full_mask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/tick.h     | 2 ++
 kernel/time/tick-sched.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa36d..34907c0b632c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -272,6 +272,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
 extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
+extern void tick_nohz_full_update_cpus(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
@@ -297,6 +298,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 static inline void tick_nohz_full_kick_cpu(int cpu) { }
 static inline void __tick_nohz_task_switch(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
+static inline void tick_nohz_full_update_cpus(cpumask_var_t cpumask) { return false; }
 #endif
 
 static inline void tick_nohz_task_switch(void)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 87b26a4471e7..9204808b7a55 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -604,6 +604,12 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
+/* Get the new set of run-time nohz CPU list from cpuset */
+void tick_nohz_full_update_cpus(cpumask_var_t cpumask)
+{
+	cpumask_copy(tick_nohz_full_mask, cpumask);
+}
+
 bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
-- 
2.50.0


