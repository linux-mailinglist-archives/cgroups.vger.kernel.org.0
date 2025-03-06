Return-Path: <cgroups+bounces-6862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBCBA54D19
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47090175C68
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6F17AE1D;
	Thu,  6 Mar 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Keec7+Vm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A31624F5
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270275; cv=none; b=kCxr9uLaE0NHmov4kukOf11Iw1b/Lpk3o5E6ZlwR9DYyaGeODWhDOiA4DUw9WYHGwKp94WmX/yeDNsg8fXUzzNFLkmGUrEeB/1f4Myh3e07095Nit+8i6qro1ZP8ceuKEDoNFHcVxkGe7Hf0NzfVbCyfwP3U1IrE/8RFto6/7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270275; c=relaxed/simple;
	bh=LXp/fN9+DHszGyDRFM3VkrhJz2PUhILAWSbGRUnQ5+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ97weEIqeBR0tfQkt4Rv4+4oCRcIF/ktV3njoeuHPPdWTp/jfdS9GaLLD0hjcd+1HVMMqGS4C6dBe8eRNa/naluHM4nX4b9SqE8GwKMckB/mr7enYYRUMuiL+/UNGuZhU7RwqLCKbRwNfyMZbC0rrb2iYWm195B3ubekb65Src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Keec7+Vm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8MV1C1a2+zK79i0XF4CH5NW5o5w8GpCx5XUFIKxutk=;
	b=Keec7+VmJ4vBkbek223HfQw0GVypcN+UJNZE0la8qmXPbfhAm0nyAnd0uodGLf4Yw6Pewb
	x0qpwfhw5hVqqvI8txI4qfJ0KK6I68vHyoVhEYQbXnzwpN6Oo9aP2/nhggSsuzcyURlkYn
	NLQoQ92EZhCpQ+T/P1LuqRK1hehB970=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-4CUEoW-2PAyefy3l-ZCPKQ-1; Thu, 06 Mar 2025 09:10:55 -0500
X-MC-Unique: 4CUEoW-2PAyefy3l-ZCPKQ-1
X-Mimecast-MFC-AGG-ID: 4CUEoW-2PAyefy3l-ZCPKQ_1741270255
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b93cf715so147606285a.2
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270255; x=1741875055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8MV1C1a2+zK79i0XF4CH5NW5o5w8GpCx5XUFIKxutk=;
        b=FtnHgDVLc0zN4Cj2S92te3ZGLStzLaWQVvHIFVKaiRXmBZ+n5tLprrmROmLkGZEIfB
         9TnPl15AP3fhwzI30NTDfEoIShe/veWPcxKFvTIY7Gpli+hLyaEfinmxT+D6vPQYHgxs
         I52MbFezx/Un0kp2BJI8Fi6Z9VA3auOeFsecXV+ggs27Sbs3AtxDjadC6vuDK7VdV595
         yCMGVspYcf5wpeFWuqAnEGSlqe26WUwj2NchKsTeuDj2vMVm74u29vAZMzIqLTuZex6Z
         vXU+UGLMAfYPmmjtr9YRVxQP9v7/SYjZCLdWk1JCS92IsgM5DQiJ1lNkprd85wxz6p8e
         O83Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3BUJ7g7mNN7dD6AH9QocCxtGqWeZbizUuwmch2IWwCP//yymxRCUK5lcBWPkTfZVoPzGq3gUG@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJioKCqCvCr7cPADpPQdl+j+nrwIq6rno03UZ6HeW5TyDsfp2
	tDZUE3KDP0bbTX3fVtZ8C5KP3W5dBAOc61oiq06BZsvVRxK0evvLMVeXeTHZENvsOdbeggO8Giq
	VsN0t5Yr0Zldgx7AmQs0fXEiox5Y13lAKzOSjKDyeNwysnrlAfl3HjMQ=
X-Gm-Gg: ASbGncsupm3XBpKSEKZtpTrfgB2e+d/xJ/lHWrm409mOsq4w2+OD7u4w3PDAxjgZ7H3
	+bqydlwVHSBMSfr4F61dL7oxY3OX69p3+CbzxFirc+h2aCf9CpdK3jsTVyLjM+5LJ/qKjOfy6XN
	y+q5Y0vgFTr0Zh3W9/IOv+MA3Z4dm97kbdXLRWUxMMxm4J4nVqRRxoFMYmhRawA/0Dz0MoyyI2Q
	17Uq9RmlruuYCuJhuc3k05VOAtHTXwKVtRjWrv4Xpv/dOmHWdo8z+K/q0Ua3/2tCJSKvrazl6Qy
	F1MuFd5nxcVOxJyOeWx8q1qeHRKYW4K4Aq+mNwOos30KGsr7Y9MJugmyCfOZSZkkYs90KSQtnIV
	SAS9y
X-Received: by 2002:a05:620a:2b96:b0:7c3:d79c:9c41 with SMTP id af79cd13be357-7c3d8e65e88mr1377356985a.25.1741270255209;
        Thu, 06 Mar 2025 06:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPm2LiZgeTapeQ0CT+twt6oVCSWpc9DToEkJrQ8VVx+C5dqhcQTY9tZvJ2sVdV7BX/IR1LFg==
X-Received: by 2002:a05:620a:2b96:b0:7c3:d79c:9c41 with SMTP id af79cd13be357-7c3d8e65e88mr1377353685a.25.1741270254949;
        Thu, 06 Mar 2025 06:10:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:52 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 3/8] sched/deadline: Generalize unique visiting of root domains
Date: Thu,  6 Mar 2025 14:10:11 +0000
Message-ID: <20250306141016.268313-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bandwidth checks and updates that work on root domains currently employ
a cookie mechanism for efficiency. This mechanism is very much tied to
when root domains are first created and initialized.

Generalize the cookie mechanism so that it can be used also later at
runtime while updating root domains. Also, additionally guard it with
sched_domains_mutex, since domains need to be stable while updating them
(and it will be required for further dynamic changes).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/deadline.h |  3 +++
 kernel/sched/deadline.c        | 23 +++++++++++++----------
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        |  2 +-
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 3a912ab42bb5..6ec578600b24 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -37,4 +37,7 @@ extern void dl_clear_root_domain(struct root_domain *rd);
 
 #endif /* CONFIG_SMP */
 
+extern u64 dl_cookie;
+extern bool dl_bw_visited(int cpu, u64 cookie);
+
 #endif /* _LINUX_SCHED_DEADLINE_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ab565a151355..339434271cba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,14 +166,14 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+static inline bool dl_bw_visited(int cpu, u64 cookie)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
-	if (rd->visit_gen == gen)
+	if (rd->visit_cookie == cookie)
 		return true;
 
-	rd->visit_gen = gen;
+	rd->visit_cookie = cookie;
 	return false;
 }
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+static inline bool dl_bw_visited(int cpu, u64 cookie)
 {
 	return false;
 }
@@ -3171,15 +3171,18 @@ DEFINE_SCHED_CLASS(dl) = {
 #endif
 };
 
-/* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
-static u64 dl_generation;
+/*
+ * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
+ * sched_domains_mutex.
+ */
+u64 dl_cookie;
 
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
-	u64 gen = ++dl_generation;
+	u64 cookie = ++dl_cookie;
 	struct dl_bw *dl_b;
 	int cpu, cpus, ret = 0;
 	unsigned long flags;
@@ -3192,7 +3195,7 @@ int sched_dl_global_validate(void)
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
 
-		if (dl_bw_visited(cpu, gen))
+		if (dl_bw_visited(cpu, cookie))
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
@@ -3229,7 +3232,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
-	u64 gen = ++dl_generation;
+	u64 cookie = ++dl_cookie;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -3240,7 +3243,7 @@ void sched_dl_do_global(void)
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
 
-		if (dl_bw_visited(cpu, gen)) {
+		if (dl_bw_visited(cpu, cookie)) {
 			rcu_read_unlock_sched();
 			continue;
 		}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..8cebe71d2bb1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 	int ret;
 
 	mutex_lock(&mutex);
+	sched_domains_mutex_lock();
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
@@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 		sysctl_sched_rt_period = old_period;
 		sysctl_sched_rt_runtime = old_runtime;
 	}
+	sched_domains_mutex_unlock();
 	mutex_unlock(&mutex);
 
 	return ret;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..c978abe38c07 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -998,7 +998,7 @@ struct root_domain {
 	 * Also, some corner cases, like 'wrap around' is dangerous, but given
 	 * that u64 is 'big enough'. So that shouldn't be a concern.
 	 */
-	u64 visit_gen;
+	u64 visit_cookie;
 
 #ifdef HAVE_RT_PUSH_IPI
 	/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 296ff2acfd32..44093339761c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -568,7 +568,7 @@ static int init_rootdomain(struct root_domain *rd)
 	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
 
-	rd->visit_gen = 0;
+	rd->visit_cookie = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
-- 
2.48.1


