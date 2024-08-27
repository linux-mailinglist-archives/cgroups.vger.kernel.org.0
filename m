Return-Path: <cgroups+bounces-4494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A829601AC
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 08:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1751A283536
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 06:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA1155300;
	Tue, 27 Aug 2024 06:29:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB0148FE5;
	Tue, 27 Aug 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740144; cv=none; b=hDZs3Ct18W7IGPd7VYFEY0lLTdTDsXJ9Rkh6UgKlI5VT0A2qrRRetnp7jMnljd9IrxJW6ihPJQg4OY2Q3tgz14tgt/04ZtxFJtl+xRSVcUnXU/NRXfYtc13N7qq6szYNIudfrsrsc4qoae/vuvP3fEXaWuFG2woXV7E7uRpcmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740144; c=relaxed/simple;
	bh=njUIEpqvTgq7WgFyeHqjBAjRs8jP8RdL/IRk3R9A/9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5sqNeCxPjFzUxC42f+gFzRyRO8v70vXhT9OQCgcAmvAcdaESjmUoocAKCmypj5SK7B4uaNWkJFYzxZRonU2IzTMASSnSdigTbWnKp/0Ivqdp+EzTG1B1okxvoHfbt9SgQAV6kpFuZHoLDojMrkvB4MhkyQiJ47FgFzUu7pMjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtHdC32Q8zfbdL;
	Tue, 27 Aug 2024 14:26:55 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id BA0311402DE;
	Tue, 27 Aug 2024 14:28:58 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 14:28:58 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next 03/12] cgroup/cpuset: move memory_pressure to cpuset-v1.c
Date: Tue, 27 Aug 2024 06:21:02 +0000
Message-ID: <20240827062111.580296-4-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827062111.580296-1-chenridong@huawei.com>
References: <20240827062111.580296-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Collection of memory_pressure can be enabled by writing 1 to the cpuset
file 'memory_pressure_enabled', which is only for cpuset-v1. Therefore,
move the corresponding code to cpuset-v1.c.

Currently, the 'fmeter_init' and 'fmeter_getrate' functions are called
at cpuset.c, so expose them to cpuset.c.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |   7 ++
 kernel/cgroup/cpuset-v1.c       | 134 ++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 134 --------------------------------
 3 files changed, 141 insertions(+), 134 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index ffea3eefebdf..7911c86bf012 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -238,4 +238,11 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+/*
+ * cpuset-v1.c
+ */
+
+void fmeter_init(struct fmeter *fmp);
+int fmeter_getrate(struct fmeter *fmp);
+
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index bdec4b196986..e7d137ff57cf 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -1,3 +1,137 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include "cpuset-internal.h"
+
+/*
+ * Frequency meter - How fast is some event occurring?
+ *
+ * These routines manage a digitally filtered, constant time based,
+ * event frequency meter.  There are four routines:
+ *   fmeter_init() - initialize a frequency meter.
+ *   fmeter_markevent() - called each time the event happens.
+ *   fmeter_getrate() - returns the recent rate of such events.
+ *   fmeter_update() - internal routine used to update fmeter.
+ *
+ * A common data structure is passed to each of these routines,
+ * which is used to keep track of the state required to manage the
+ * frequency meter and its digital filter.
+ *
+ * The filter works on the number of events marked per unit time.
+ * The filter is single-pole low-pass recursive (IIR).  The time unit
+ * is 1 second.  Arithmetic is done using 32-bit integers scaled to
+ * simulate 3 decimal digits of precision (multiplied by 1000).
+ *
+ * With an FM_COEF of 933, and a time base of 1 second, the filter
+ * has a half-life of 10 seconds, meaning that if the events quit
+ * happening, then the rate returned from the fmeter_getrate()
+ * will be cut in half each 10 seconds, until it converges to zero.
+ *
+ * It is not worth doing a real infinitely recursive filter.  If more
+ * than FM_MAXTICKS ticks have elapsed since the last filter event,
+ * just compute FM_MAXTICKS ticks worth, by which point the level
+ * will be stable.
+ *
+ * Limit the count of unprocessed events to FM_MAXCNT, so as to avoid
+ * arithmetic overflow in the fmeter_update() routine.
+ *
+ * Given the simple 32 bit integer arithmetic used, this meter works
+ * best for reporting rates between one per millisecond (msec) and
+ * one per 32 (approx) seconds.  At constant rates faster than one
+ * per msec it maxes out at values just under 1,000,000.  At constant
+ * rates between one per msec, and one per second it will stabilize
+ * to a value N*1000, where N is the rate of events per second.
+ * At constant rates between one per second and one per 32 seconds,
+ * it will be choppy, moving up on the seconds that have an event,
+ * and then decaying until the next event.  At rates slower than
+ * about one in 32 seconds, it decays all the way back to zero between
+ * each event.
+ */
+
+#define FM_COEF 933		/* coefficient for half-life of 10 secs */
+#define FM_MAXTICKS ((u32)99)   /* useless computing more ticks than this */
+#define FM_MAXCNT 1000000	/* limit cnt to avoid overflow */
+#define FM_SCALE 1000		/* faux fixed point scale */
+
+/* Initialize a frequency meter */
+void fmeter_init(struct fmeter *fmp)
+{
+	fmp->cnt = 0;
+	fmp->val = 0;
+	fmp->time = 0;
+	spin_lock_init(&fmp->lock);
+}
+
+/* Internal meter update - process cnt events and update value */
+static void fmeter_update(struct fmeter *fmp)
+{
+	time64_t now;
+	u32 ticks;
+
+	now = ktime_get_seconds();
+	ticks = now - fmp->time;
+
+	if (ticks == 0)
+		return;
+
+	ticks = min(FM_MAXTICKS, ticks);
+	while (ticks-- > 0)
+		fmp->val = (FM_COEF * fmp->val) / FM_SCALE;
+	fmp->time = now;
+
+	fmp->val += ((FM_SCALE - FM_COEF) * fmp->cnt) / FM_SCALE;
+	fmp->cnt = 0;
+}
+
+/* Process any previous ticks, then bump cnt by one (times scale). */
+static void fmeter_markevent(struct fmeter *fmp)
+{
+	spin_lock(&fmp->lock);
+	fmeter_update(fmp);
+	fmp->cnt = min(FM_MAXCNT, fmp->cnt + FM_SCALE);
+	spin_unlock(&fmp->lock);
+}
+
+/* Process any previous ticks, then return current value. */
+int fmeter_getrate(struct fmeter *fmp)
+{
+	int val;
+
+	spin_lock(&fmp->lock);
+	fmeter_update(fmp);
+	val = fmp->val;
+	spin_unlock(&fmp->lock);
+	return val;
+}
+
+/*
+ * Collection of memory_pressure is suppressed unless
+ * this flag is enabled by writing "1" to the special
+ * cpuset file 'memory_pressure_enabled' in the root cpuset.
+ */
+
+int cpuset_memory_pressure_enabled __read_mostly;
+
+/*
+ * __cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
+ *
+ * Keep a running average of the rate of synchronous (direct)
+ * page reclaim efforts initiated by tasks in each cpuset.
+ *
+ * This represents the rate at which some task in the cpuset
+ * ran low on memory on all nodes it was allowed to use, and
+ * had to enter the kernels page reclaim code in an effort to
+ * create more free memory by tossing clean pages or swapping
+ * or writing dirty pages.
+ *
+ * Display to user space in the per-cpuset read-only file
+ * "memory_pressure".  Value displayed is an integer
+ * representing the recent rate of entry into the synchronous
+ * (direct) page reclaim by any task attached to the cpuset.
+ */
+
+void __cpuset_memory_pressure_bump(void)
+{
+	rcu_read_lock();
+	fmeter_markevent(&task_cs(current)->fmeter);
+	rcu_read_unlock();
+}
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 61763dd70de5..17f7984a41f5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2990,107 +2990,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
-/*
- * Frequency meter - How fast is some event occurring?
- *
- * These routines manage a digitally filtered, constant time based,
- * event frequency meter.  There are four routines:
- *   fmeter_init() - initialize a frequency meter.
- *   fmeter_markevent() - called each time the event happens.
- *   fmeter_getrate() - returns the recent rate of such events.
- *   fmeter_update() - internal routine used to update fmeter.
- *
- * A common data structure is passed to each of these routines,
- * which is used to keep track of the state required to manage the
- * frequency meter and its digital filter.
- *
- * The filter works on the number of events marked per unit time.
- * The filter is single-pole low-pass recursive (IIR).  The time unit
- * is 1 second.  Arithmetic is done using 32-bit integers scaled to
- * simulate 3 decimal digits of precision (multiplied by 1000).
- *
- * With an FM_COEF of 933, and a time base of 1 second, the filter
- * has a half-life of 10 seconds, meaning that if the events quit
- * happening, then the rate returned from the fmeter_getrate()
- * will be cut in half each 10 seconds, until it converges to zero.
- *
- * It is not worth doing a real infinitely recursive filter.  If more
- * than FM_MAXTICKS ticks have elapsed since the last filter event,
- * just compute FM_MAXTICKS ticks worth, by which point the level
- * will be stable.
- *
- * Limit the count of unprocessed events to FM_MAXCNT, so as to avoid
- * arithmetic overflow in the fmeter_update() routine.
- *
- * Given the simple 32 bit integer arithmetic used, this meter works
- * best for reporting rates between one per millisecond (msec) and
- * one per 32 (approx) seconds.  At constant rates faster than one
- * per msec it maxes out at values just under 1,000,000.  At constant
- * rates between one per msec, and one per second it will stabilize
- * to a value N*1000, where N is the rate of events per second.
- * At constant rates between one per second and one per 32 seconds,
- * it will be choppy, moving up on the seconds that have an event,
- * and then decaying until the next event.  At rates slower than
- * about one in 32 seconds, it decays all the way back to zero between
- * each event.
- */
-
-#define FM_COEF 933		/* coefficient for half-life of 10 secs */
-#define FM_MAXTICKS ((u32)99)   /* useless computing more ticks than this */
-#define FM_MAXCNT 1000000	/* limit cnt to avoid overflow */
-#define FM_SCALE 1000		/* faux fixed point scale */
-
-/* Initialize a frequency meter */
-static void fmeter_init(struct fmeter *fmp)
-{
-	fmp->cnt = 0;
-	fmp->val = 0;
-	fmp->time = 0;
-	spin_lock_init(&fmp->lock);
-}
-
-/* Internal meter update - process cnt events and update value */
-static void fmeter_update(struct fmeter *fmp)
-{
-	time64_t now;
-	u32 ticks;
-
-	now = ktime_get_seconds();
-	ticks = now - fmp->time;
-
-	if (ticks == 0)
-		return;
-
-	ticks = min(FM_MAXTICKS, ticks);
-	while (ticks-- > 0)
-		fmp->val = (FM_COEF * fmp->val) / FM_SCALE;
-	fmp->time = now;
-
-	fmp->val += ((FM_SCALE - FM_COEF) * fmp->cnt) / FM_SCALE;
-	fmp->cnt = 0;
-}
-
-/* Process any previous ticks, then bump cnt by one (times scale). */
-static void fmeter_markevent(struct fmeter *fmp)
-{
-	spin_lock(&fmp->lock);
-	fmeter_update(fmp);
-	fmp->cnt = min(FM_MAXCNT, fmp->cnt + FM_SCALE);
-	spin_unlock(&fmp->lock);
-}
-
-/* Process any previous ticks, then return current value. */
-static int fmeter_getrate(struct fmeter *fmp)
-{
-	int val;
-
-	spin_lock(&fmp->lock);
-	fmeter_update(fmp);
-	val = fmp->val;
-	spin_unlock(&fmp->lock);
-	return val;
-}
-
 static struct cpuset *cpuset_attach_old_cs;
 
 /*
@@ -4780,39 +4679,6 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
-/*
- * Collection of memory_pressure is suppressed unless
- * this flag is enabled by writing "1" to the special
- * cpuset file 'memory_pressure_enabled' in the root cpuset.
- */
-
-int cpuset_memory_pressure_enabled __read_mostly;
-
-/*
- * __cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
- *
- * Keep a running average of the rate of synchronous (direct)
- * page reclaim efforts initiated by tasks in each cpuset.
- *
- * This represents the rate at which some task in the cpuset
- * ran low on memory on all nodes it was allowed to use, and
- * had to enter the kernels page reclaim code in an effort to
- * create more free memory by tossing clean pages or swapping
- * or writing dirty pages.
- *
- * Display to user space in the per-cpuset read-only file
- * "memory_pressure".  Value displayed is an integer
- * representing the recent rate of entry into the synchronous
- * (direct) page reclaim by any task attached to the cpuset.
- */
-
-void __cpuset_memory_pressure_bump(void)
-{
-	rcu_read_lock();
-	fmeter_markevent(&task_cs(current)->fmeter);
-	rcu_read_unlock();
-}
-
 #ifdef CONFIG_PROC_PID_CPUSET
 /*
  * proc_cpuset_show()
-- 
2.34.1


