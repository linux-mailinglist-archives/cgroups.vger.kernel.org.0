Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD510591660
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiHLUkF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiHLUkE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 16:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 178F5B516D
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660336803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqyrfeLupdUdlxK6qwPAJTHZA2QeCAteefpYRfYcff4=;
        b=I0ZMdQO7957xOsmzzgguCGWhlVxNLDcQvRXRLfH4LofF+d0LkFLZsICBahUDYajs9hTPAg
        znhXoL/vcFiVlh8HvEhi8Ya7skiMgYuq7UKVd8xryMtGlttALPEt26r3jjMenDV/Wq5N1P
        rPJ+dG41pZnwdPHaoj4VeVz/22MRgHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-Pl2ifT6KMtCIKA1plcfuRw-1; Fri, 12 Aug 2022 16:39:59 -0400
X-MC-Unique: Pl2ifT6KMtCIKA1plcfuRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F2E7185A79C;
        Fri, 12 Aug 2022 20:39:58 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B192FC15BA6;
        Fri, 12 Aug 2022 20:39:57 +0000 (UTC)
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
Subject: [PATCH v3 1/3] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()
Date:   Fri, 12 Aug 2022 16:39:27 -0400
Message-Id: <20220812203929.364341-2-longman@redhat.com>
In-Reply-To: <20220812203929.364341-1-longman@redhat.com>
References: <20220812203929.364341-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity"). It
is currently used only by arm64 arch due to possible asymmetric cpu
setup. This patch extends its usage to save user provided cpumask when
sched_setaffinity() is called for all arches.

To preserve the existing arm64 use case, a new cpus_affinity_set flag is
added to differentiate if user_cpus_ptr is set up by sched_setaffinity()
or by force_compatible_cpus_allowed_ptr(). user_cpus_ptr
set by sched_setaffinity() has priority and won't be
overwritten by force_compatible_cpus_allowed_ptr() or
relax_compatible_cpus_allowed_ptr().

As a call to sched_setaffinity() will no longer clear user_cpus_ptr
but set it instead, the SCA_USER flag is no longer necessary and can
be removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 71 +++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h  |  1 -
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..cf7206a9b29a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -816,6 +816,7 @@ struct task_struct {
 
 	unsigned int			policy;
 	int				nr_cpus_allowed;
+	int				cpus_affinity_set;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
 	cpumask_t			cpus_mask;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..7e2576068331 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2601,6 +2601,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		return -ENOMEM;
 
 	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	dst->cpus_affinity_set = src->cpus_affinity_set;
 	return 0;
 }
 
@@ -2848,7 +2849,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
-	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2907,14 +2907,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 
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
@@ -2988,19 +2981,24 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 
 	/*
 	 * We're about to butcher the task affinity, so keep track of what
-	 * the user asked for in case we're able to restore it later on.
+	 * the user asked for in case we're able to restore it later on
+	 * unless it has been set before by sched_setaffinity().
 	 */
-	if (user_mask) {
+	if (user_mask && !p->cpus_affinity_set) {
 		cpumask_copy(user_mask, p->cpus_ptr);
 		p->user_cpus_ptr = user_mask;
+		user_mask = NULL;
 	}
 
-	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+	err = __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
 
-err_unlock:
-	task_rq_unlock(rq, p, &rf);
+free_user_mask:
 	kfree(user_mask);
 	return err;
+
+err_unlock:
+	task_rq_unlock(rq, p, &rf);
+	goto free_user_mask;
 }
 
 /*
@@ -3049,7 +3047,7 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
@@ -3067,9 +3065,10 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 	/*
 	 * Try to restore the old affinity mask. If this fails, then
 	 * we free the mask explicitly to avoid it being inherited across
-	 * a subsequent fork().
+	 * a subsequent fork() unless it is set by sched_setaffinity().
 	 */
-	if (!user_mask || !__sched_setaffinity(p, user_mask))
+	if (!user_mask || !__sched_setaffinity(p, user_mask, false) ||
+	    p->cpus_affinity_set)
 		return;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
@@ -8079,10 +8078,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
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
@@ -8098,8 +8098,38 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
+
+	/*
+	 * Save the user requested mask into user_cpus_ptr
+	 */
+	if (save_mask && !p->user_cpus_ptr) {
+alloc_again:
+		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+
+		if (!user_mask) {
+			retval = -ENOMEM;
+			goto out_free_new_mask;
+		}
+	}
+	if (save_mask) {
+		struct rq_flags rf;
+		struct rq *rq = task_rq_lock(p, &rf);
+
+		if (unlikely(!p->user_cpus_ptr && !user_mask)) {
+			task_rq_unlock(rq, p, &rf);
+			goto alloc_again;
+		}
+		if (!p->user_cpus_ptr) {
+			p->user_cpus_ptr = user_mask;
+			user_mask = NULL;
+		}
+
+		cpumask_copy(p->user_cpus_ptr, mask);
+		p->cpus_affinity_set = 1;
+		task_rq_unlock(rq, p, &rf);
+	}
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8113,6 +8143,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 		goto again;
 	}
 
+	kfree(user_mask);
 out_free_new_mask:
 	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
@@ -8156,7 +8187,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
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

