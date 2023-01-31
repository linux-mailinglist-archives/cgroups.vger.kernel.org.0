Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC16683923
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 23:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjAaWR3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 17:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaWR2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 17:17:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854F46157;
        Tue, 31 Jan 2023 14:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D26B6172A;
        Tue, 31 Jan 2023 22:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3060FC4339E;
        Tue, 31 Jan 2023 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203446;
        bh=ELfyS2nEQLpVpTwQYA/Y76BnsftBMsvCjEcLwiHp7V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfTuawChPCNl9Geuhr0xvy93l5JDQisVlKYHhjH/PfAaEzwpic+WNs3QMvLjz93I0
         WOrnIvHvp81Y3wCqXP4jLx48EN45G9jZxuM2l7EofC6G0X9VeoszRHJ+QCSEZYJaZ5
         ra4tk+7dO/u7a8vCq0Aw9iOCSq3lipvtj+wcDtJweZVxO1w//nQtG/59RA6sHZPvKt
         XY3PVrGHBw+yA5zPqPCNG/eao/QPJ6RxpN+yCjaYrPN4dtH+WZE1VMGKzPpPhJBAJQ
         gpArYGeEzyBb8EIQ7ehvR5aklzi7yKQ2yVjAXW3JTXY+08g8MRfQHiozQ+0jYuQWaq
         e0ddTf9L2Vrcg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter offline CPUs
Date:   Tue, 31 Jan 2023 22:17:18 +0000
Message-Id: <20230131221719.3176-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230131221719.3176-1-will@kernel.org>
References: <20230131221719.3176-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

There is a difference in behaviour between CPUSET={y,n} that is now
wrecking havoc with {relax,force}_compatible_cpus_allowed_ptr().

Specifically, since commit 8f9ea86fdf99 ("sched: Always preserve the
user requested cpumask")  relax_compatible_cpus_allowed_ptr() is
calling __sched_setaffinity() unconditionally.

But the underlying problem goes back a lot further, possibly to
commit: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}") which
switched cpuset_cpus_allowed() from cs->cpus_allowed to
cs->effective_cpus.

The problem is that for CPUSET=y cpuset_cpus_allowed() will filter out
all offline CPUs. For tasks that are part of a (!root) cpuset this is
then later fixed up by the cpuset hotplug notifiers that re-evaluate
and re-apply cs->effective_cpus, but for (normal) tasks in the root
cpuset this does not happen and they will forever after be excluded
from CPUs onlined later.

As such, rewrite cpuset_cpus_allowed() to return a wider mask,
including the offline CPUs.

Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230117160825.GA17756@willie-the-truck
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/cgroup/cpuset.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a29c0b13706b..8552cc2c586a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3683,23 +3683,52 @@ void __init cpuset_init_smp(void)
 	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
+static const struct cpumask *__cs_cpus_allowed(struct cpuset *cs)
+{
+	const struct cpumask *cs_mask = cs->cpus_allowed;
+	if (!parent_cs(cs))
+		cs_mask = cpu_possible_mask;
+	return cs_mask;
+}
+
+static void cs_cpus_allowed(struct cpuset *cs, struct cpumask *pmask)
+{
+	do {
+		cpumask_and(pmask, pmask, __cs_cpus_allowed(cs));
+		cs = parent_cs(cs);
+	} while (cs);
+}
+
 /**
  * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
  * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
  *
- * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
- * attached to the specified @tsk.  Guaranteed to return some non-empty
- * subset of cpu_online_mask, even if this means going outside the
- * tasks cpuset.
+ * Description: Returns the cpumask_var_t cpus_allowed of the cpuset attached
+ * to the specified @tsk.  Guaranteed to return some non-empty intersection
+ * with cpu_online_mask, even if this means going outside the tasks cpuset.
  **/
 
 void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 {
 	unsigned long flags;
+	struct cpuset *cs;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	guarantee_online_cpus(tsk, pmask);
+	rcu_read_lock();
+
+	cs = task_cs(tsk);
+	do {
+		cpumask_copy(pmask, task_cpu_possible_mask(tsk));
+		cs_cpus_allowed(cs, pmask);
+
+		if (cpumask_intersects(pmask, cpu_online_mask))
+			break;
+
+		cs = parent_cs(cs);
+	} while (cs);
+
+	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
-- 
2.39.1.456.gfc5497dd1b-goog

