Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9459631E
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 21:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiHPT1t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 15:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiHPT1s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 15:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D664A75CE6
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660678067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnL7a16+mJwGp2UKj6zOsVK1qIHxMaTCJjaKZic0ihQ=;
        b=hzC3I7zy5jMYAOi5cwlWJajl5d2b/cm1WACYqXul0naUzkd7hVmMlHe1bcAf3tkeiZORb8
        5xULLuSDYZxAlmr0txdIHp0EyyjTnHQzCEYNXq76gjD6YzT+jHNE/1d0Pb+XdWRU9WPJk5
        3/CRnG2XEhKD+Cvqi/agE2Z8oiZJcng=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-XENSStkyMmGSA0w31kKv0w-1; Tue, 16 Aug 2022 15:27:45 -0400
X-MC-Unique: XENSStkyMmGSA0w31kKv0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1BF21C1A94A;
        Tue, 16 Aug 2022 19:27:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 162671121314;
        Tue, 16 Aug 2022 19:27:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 1/3] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()
Date:   Tue, 16 Aug 2022 15:27:32 -0400
Message-Id: <20220816192734.67115-2-longman@redhat.com>
In-Reply-To: <20220816192734.67115-1-longman@redhat.com>
References: <20220816192734.67115-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity"). It
is currently used only by arm64 arch due to possible asymmetric CPU
setup. This patch extends its usage to save user provided cpumask when
sched_setaffinity() is called for all arches. With this patch applied,
user_cpus_ptr, once allocated after a call to sched_setaffinity(),
will only be freed when the task exits.

Since user_cpus_ptr is supposed to be used for "requested
affinity", there is actually no point to save current cpu affinity in
restrict_cpus_allowed_ptr() if sched_setaffinity() has never been called.
Modify the logic to set user_cpus_ptr only in sched_setaffinity() and use
it in restrict_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
if defined but not changing it.

This will be some changes in behavior for arm64 systems with asymmetric
CPUs in some corner cases. For instance, if sched_setaffinity()
has never been called and there is a cpuset change before
relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
follow what the cpuset allows but not what the previous cpu affinity
setting allows.

As a call to sched_setaffinity() will no longer clear user_cpus_ptr
but set it instead, the SCA_USER flag is no longer necessary and can
be removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 100 ++++++++++++++++++++++---------------------
 kernel/sched/sched.h |   1 -
 2 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..03053eebb22e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2848,7 +2848,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
-	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2907,14 +2906,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	if (flags & SCA_USER)
-		user_mask = clear_user_cpus_ptr(p);
-
-	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
-
-	kfree(user_mask);
-
-	return ret;
+	return affine_move_task(rq, p, rf, dest_cpu, flags);
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2949,8 +2941,10 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
 /*
  * Change a given task's CPU affinity to the intersection of its current
- * affinity mask and @subset_mask, writing the resulting mask to @new_mask
- * and pointing @p->user_cpus_ptr to a copy of the old mask.
+ * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
+ * If user_cpus_ptr is defined, use it as the basis for restricting CPU
+ * affinity or use cpu_online_mask instead.
+ *
  * If the resulting mask is empty, leave the affinity unchanged and return
  * -EINVAL.
  */
@@ -2958,16 +2952,10 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 				     struct cpumask *new_mask,
 				     const struct cpumask *subset_mask)
 {
-	struct cpumask *user_mask = NULL;
 	struct rq_flags rf;
 	struct rq *rq;
 	int err;
-
-	if (!p->user_cpus_ptr) {
-		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
-		if (!user_mask)
-			return -ENOMEM;
-	}
+	bool not_empty;
 
 	rq = task_rq_lock(p, &rf);
 
@@ -2981,25 +2969,21 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		goto err_unlock;
 	}
 
-	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+
+	if (p->user_cpus_ptr)
+		not_empty = cpumask_and(new_mask, p->user_cpus_ptr, subset_mask);
+	else
+		not_empty = cpumask_and(new_mask, cpu_online_mask, subset_mask);
+
+	if (!not_empty) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
 
-	/*
-	 * We're about to butcher the task affinity, so keep track of what
-	 * the user asked for in case we're able to restore it later on.
-	 */
-	if (user_mask) {
-		cpumask_copy(user_mask, p->cpus_ptr);
-		p->user_cpus_ptr = user_mask;
-	}
-
 	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
-	kfree(user_mask);
 	return err;
 }
 
@@ -3049,34 +3033,27 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
- * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
- * @p->user_cpus_ptr.
+ * call to force_compatible_cpus_allowed_ptr().
  *
  * It is the caller's responsibility to serialise this with any calls to
  * force_compatible_cpus_allowed_ptr(@p).
  */
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
-	struct cpumask *user_mask = p->user_cpus_ptr;
-	unsigned long flags;
+	const struct cpumask *user_mask = p->user_cpus_ptr;
+
+	if (!user_mask)
+		user_mask = cpu_online_mask;
 
 	/*
-	 * Try to restore the old affinity mask. If this fails, then
-	 * we free the mask explicitly to avoid it being inherited across
-	 * a subsequent fork().
+	 * Try to restore the old affinity mask with __sched_setaffinity().
+	 * Cpuset masking will be done there too.
 	 */
-	if (!user_mask || !__sched_setaffinity(p, user_mask))
-		return;
-
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	user_mask = clear_user_cpus_ptr(p);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-
-	kfree(user_mask);
+	__sched_setaffinity(p, user_mask, false);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
@@ -8079,10 +8056,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
+	struct cpumask *user_mask = NULL;
 
 	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
 		return -ENOMEM;
@@ -8098,8 +8076,33 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
+
+	/*
+	 * Save the user requested mask into user_cpus_ptr if save_mask set.
+	 * pi_lock is used for protecting user_cpus_ptr.
+	 */
+	if (save_mask && !p->user_cpus_ptr) {
+		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+
+		if (!user_mask) {
+			retval = -ENOMEM;
+			goto out_free_new_mask;
+		}
+	}
+	if (save_mask) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&p->pi_lock, flags);
+		if (!p->user_cpus_ptr) {
+			p->user_cpus_ptr = user_mask;
+			user_mask = NULL;
+		}
+
+		cpumask_copy(p->user_cpus_ptr, mask);
+		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	}
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8113,6 +8116,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 		goto again;
 	}
 
+	kfree(user_mask);
 out_free_new_mask:
 	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
@@ -8156,7 +8160,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	retval = __sched_setaffinity(p, in_mask);
+	retval = __sched_setaffinity(p, in_mask, true);
 out_put_task:
 	put_task_struct(p);
 	return retval;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..15eefcd65faa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2283,7 +2283,6 @@ extern struct task_struct *pick_next_task_idle(struct rq *rq);
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
-#define SCA_USER		0x08
 
 #ifdef CONFIG_SMP
 
-- 
2.31.1

