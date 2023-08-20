Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BE781EB2
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHTP0E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjHTP0A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:26:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CD5468B
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:23:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso25173775e9.0
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544988; x=1693149788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UPdbmyLLc1ipw9o/7F1VeIHdpT9gV7/ciY4+2ZsAW4=;
        b=hKCFQLMTQfJ8hQf4OWiVjz3/Hob4S8QXHGiw8/XkhceP3YSkh5ksHmpWkd4d5tIto1
         UbwYz64hRV0P2OH/JZxKvJqECb/rZRS6rYWScs4tGyWpjF8bC7DKcSKN28yX4mBGmFSq
         MAhp8l+moKgHuKPNWShKAxkzuQfkY3zz2NgRdEBrA2qxIN7JUfet959J5L6q92SVsT1N
         GUlw53xfkT6/HymUKwlTDwQ7q6Mu9LsqA0N1lKFzzzv4aADrING0MdShBKF5rsHfL+w2
         MmZFhgf57VNzYqBj1GID9jgdOneAbysoc1gd1lO96zRNscFcQJcdnvuTkcpm2tbwiX+4
         W1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544988; x=1693149788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UPdbmyLLc1ipw9o/7F1VeIHdpT9gV7/ciY4+2ZsAW4=;
        b=Yw/gWJgdjSRKogjX3BIRpY7dPDQMWhx0oCxnRKrwLENKJQDrCZLKkRWqlPtCUXw1nD
         z0XWXpLECwm6teJFWvYC54bxwfgEJEd2TlCOmN73gnkCX9zdl7ZMQieJCf7P+ML/VV6Z
         Wf1lVxcSn6Bih4x/BaGnofAF72uNgnDQRheMyT9U2ge15ypMIvc24QnJ5/NztahxzUcA
         N8YTWRA91gZTNBl3h/1GZhI7b2cANe0j32oc0zDKtb32EAFnZZh4tw2sxEZv9C6Rf8I0
         qyfLNSO/4tNxt+k8H7bNa8Xh9YMMfaCn/8ZNzqPtSQpfYT+rxVb9C0gvGPzW/Hi0Z6Pt
         IaYg==
X-Gm-Message-State: AOJu0YypcXo4HzNIGvl8VR96n0h4Rveun1uOGpzIBdtzkXgcV1NsU4v4
        D6UMX5NnQoaC0LNwdQpMjWPQ2Sn66feeZi6SuPQ=
X-Google-Smtp-Source: AGHT+IEd0xo+85GVEA/yqLAIzchZpG27H5AfdEElsaenjqaR8jM67rn/TBVQ0cS6SWtxf2Hz0GKwQQ==
X-Received: by 2002:adf:e74e:0:b0:313:e8b6:1699 with SMTP id c14-20020adfe74e000000b00313e8b61699mr2801988wrn.55.1692544988346;
        Sun, 20 Aug 2023 08:23:08 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm9527466wrm.37.2023.08.20.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:23:08 -0700 (PDT)
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
Date:   Sun, 20 Aug 2023 16:22:57 +0100
Message-Id: <20230820152258.518128-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152258.518128-1-qyousef@layalina.io>
References: <20230820152258.518128-1-qyousef@layalina.io>
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
index 7c17742d359c..91fe1d6418e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1798,6 +1798,8 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int dl_bw_alloc(int cpu, u64 dl_bw);
+extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8a8c9220f4d8..da2a2906a826 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8814,7 +8814,7 @@ int task_can_attach(struct task_struct *p,
 
 		if (unlikely(cpu >= nr_cpu_ids))
 			return -EINVAL;
-		ret = dl_cpu_busy(cpu, p);
+		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
 	}
 
 out:
@@ -9099,7 +9099,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_cpu_busy(cpu, NULL);
+		int ret = dl_bw_check_overflow(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fced55d6e8da..de45e4d2c61f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2898,26 +2898,38 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
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
@@ -2925,6 +2937,21 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
 
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
index 6312f1904825..5061093d9baa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -349,7 +349,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_cpu_busy(int cpu, struct task_struct *p);
+extern int  dl_bw_check_overflow(int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 
-- 
2.34.1

