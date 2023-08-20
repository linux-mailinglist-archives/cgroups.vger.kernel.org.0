Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83918781E86
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHTPZD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjHTPZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:25:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214A46BB
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:24:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3197f632449so2187591f8f.1
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692545071; x=1693149871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaxLnXj6CSu0JECaIuCK7iN7q8DLhZrRhTDtYUVhsxU=;
        b=B0eJ35u0jB3YbM/3MdETgojB9UhAcOThaK0X1V1JQexUgfdZU+WsYUOjNjQeFiSzNv
         4nDVbpUMz1TSI1mPvsKmsBkddlaZPMe9X7aVL9WTp79Aq9Zn2b+gviKkqFHUxCZ35Wt5
         2DbvT8GBRoOddIsj3OWDi9U63bEd4PtfBdpw/6ynKyT2fnsverLJvGlXLQByWUeHXSpX
         ca7MW2FPlfmDSM+HqDzUkjFqYueaJhOgOUTAckD/ynx9zEtIEs+2DnthiNfGSntbiiis
         /6OsPTSVUjxqjpcG/M2FR1AF8L2kbeCv8P7ED/PkqNT/xFoGOXnvQtFTSVwN+GzrMvJY
         fezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692545071; x=1693149871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaxLnXj6CSu0JECaIuCK7iN7q8DLhZrRhTDtYUVhsxU=;
        b=aO09K0Qpk7d7LVFpFFdVTGCeb8VyF1j7UuW+IQA+/Hfaa3vC6MaWTP03lvuI+wLDDC
         DRWU/iAjbAzzdo1ci3P44BVab9xcbDCYjSJX26R35+5tlTYUnPzbZOoXubLFAvipf8Yt
         lMVPlBDknztmnWygU0En8ag29HI23zKbCZhD64qkqgGZCpuCVkcSBpROgJDNq0vgiDog
         +YKBbu3PfTrkdHYJhJHsy0H0jTQcXOinJYmfFOlC4ieyjV2rLeuyKt/brhJFwjP0e76D
         B+3/BfshO1ngrGjOjGWHnGoo8/ptrw9yz6cUeE3eJx+em7ICSaWhW4mBYK5ueIejAU1D
         5GYw==
X-Gm-Message-State: AOJu0YzExnD7xqwEZmJRsng9ITigwhQR0rHwRrsHJalFgKVsAkdgvMJx
        4gXzQc/yhrpUw9a1yaZ08FbHUA==
X-Google-Smtp-Source: AGHT+IEHc6aZ7JHsZhp34vjGABYvMy0lSZKXtnQjPoat0eVfVlibBYWPbNcDubzDLCQJZlgif1TSWQ==
X-Received: by 2002:a5d:4ed2:0:b0:315:ae39:27c with SMTP id s18-20020a5d4ed2000000b00315ae39027cmr3295451wrv.70.1692545071095;
        Sun, 20 Aug 2023 08:24:31 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d4fcb000000b003141e629cb6sm9419257wrw.101.2023.08.20.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:24:30 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 5/6] sched/deadline: Create DL BW alloc, free & check overflow interface
Date:   Sun, 20 Aug 2023 16:24:16 +0100
Message-Id: <20230820152417.518806-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152417.518806-1-qyousef@layalina.io>
References: <20230820152417.518806-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

commit 85989106feb734437e2d598b639991b9185a43a6 upstream.

While moving a set of tasks between exclusive cpusets,
cpuset_can_attach() -> task_can_attach() calls dl_cpu_busy(..., p) for
DL BW overflow checking and per-task DL BW allocation on the destination
root_domain for the DL tasks in this set.

This approach has the issue of not freeing already allocated DL BW in
the following error cases:

(1) The set of tasks includes multiple DL tasks and DL BW overflow
    checking fails for one of the subsequent DL tasks.

(2) Another controller next to the cpuset controller which is attached
    to the same cgroup fails in its can_attach().

To address this problem rework dl_cpu_busy():

(1) Split it into dl_bw_check_overflow() & dl_bw_alloc() and add a
    dedicated dl_bw_free().

(2) dl_bw_alloc() & dl_bw_free() take a `u64 dl_bw` parameter instead of
    a `struct task_struct *p` used in dl_cpu_busy(). This allows to
    allocate DL BW for a set of tasks too rather than only for a single
    task.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 85989106feb734437e2d598b639991b9185a43a6)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched.h   |  2 ++
 kernel/sched/core.c     |  4 ++--
 kernel/sched/deadline.c | 53 +++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h    |  2 +-
 4 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..b2e30fbbeef0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1847,6 +1847,8 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int dl_bw_alloc(int cpu, u64 dl_bw);
+extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8a8dbb2dac03..6963fc4ef897 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9108,7 +9108,7 @@ int task_can_attach(struct task_struct *p,
 
 		if (unlikely(cpu >= nr_cpu_ids))
 			return -EINVAL;
-		ret = dl_cpu_busy(cpu, p);
+		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
 	}
 
 out:
@@ -9393,7 +9393,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_cpu_busy(cpu, NULL);
+		int ret = dl_bw_check_overflow(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 98154a93e05d..9ce9810861ba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3037,26 +3037,38 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int dl_cpu_busy(int cpu, struct task_struct *p)
+enum dl_bw_request {
+	dl_bw_req_check_overflow = 0,
+	dl_bw_req_alloc,
+	dl_bw_req_free
+};
+
+static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags, cap;
+	unsigned long flags;
 	struct dl_bw *dl_b;
-	bool overflow;
+	bool overflow = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cap = dl_bw_capacity(cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
 
-	if (!overflow && p) {
-		/*
-		 * We reserve space for this task in the destination
-		 * root_domain, as we can't fail after this point.
-		 * We will free resources in the source root_domain
-		 * later on (see set_cpus_allowed_dl()).
-		 */
-		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+	if (req == dl_bw_req_free) {
+		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
+	} else {
+		unsigned long cap = dl_bw_capacity(cpu);
+
+		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
+
+		if (req == dl_bw_req_alloc && !overflow) {
+			/*
+			 * We reserve space in the destination
+			 * root_domain, as we can't fail after this point.
+			 * We will free resources in the source root_domain
+			 * later on (see set_cpus_allowed_dl()).
+			 */
+			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
+		}
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3064,6 +3076,21 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
 
 	return overflow ? -EBUSY : 0;
 }
+
+int dl_bw_check_overflow(int cpu)
+{
+	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+}
+
+int dl_bw_alloc(int cpu, u64 dl_bw)
+{
+	return dl_bw_manage(dl_bw_req_alloc, cpu, dl_bw);
+}
+
+void dl_bw_free(int cpu, u64 dl_bw)
+{
+	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
+}
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f18460f62f0..00201a55b17d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -330,7 +330,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_cpu_busy(int cpu, struct task_struct *p);
+extern int  dl_bw_check_overflow(int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 
-- 
2.34.1

