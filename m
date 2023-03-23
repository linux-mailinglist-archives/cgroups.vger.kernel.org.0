Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FE6C5DA2
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 05:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCWEAy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 00:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCWEAw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 00:00:52 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056A11F92D
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:00:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o10-20020a17090ac08a00b0023f3196fa6fso322236pjs.2
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlRHMwQCwPxTz7URsIPFYEiZ1y/NkKG6JVNDPEffcgo=;
        b=q0IiHI38SIToezuWJ5YCNMq/43EaxUo3i4AMEPHcC9bZCfWe3qfaYbxabY9EbcCoqm
         LUESQ/1v1D2aalE9SO+twkVNP5hnW+UNiSPbsUMxGnfaQG+8mDUTyeXBv18fXpGW3SWD
         GCVDR2eWTWBw72p7FFHYiZQYGqUWBUdEyjEquw53iNIuEWGhIQhSBNfbqBw3sfwQmtJy
         zq0COAvO1AYz/HqEKQJev5lhSkkjfsk/GYKhQDhBPMJgp6hmFHeDaNzuC/4om1icb3Uk
         IS34ZPkCnh/Dxdz7tz/xvLp+bFG8mdt7D5IhxCaGQj3LQws3RSkaD2yIkaXnXsqGxGWA
         GdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlRHMwQCwPxTz7URsIPFYEiZ1y/NkKG6JVNDPEffcgo=;
        b=VxjPUZujU699+1IQ6iT7Vg57+NBxESTT9zSeNk0//mqsUnL18sB7c2wYnyHtYgZ//S
         +gllux9zwcvia/nJhmgfV+P99o1q5weGBNBjFNbLhhf84rGIBrfcnBpm3cqifvDO5cJi
         zu9W4mjqTd4V+gk8HuqYfyRcZfd6lonU36xXOBjbXjdn5ZbYTQjxAhrd7h7OHKQ1yKhR
         FyUEAaTPJmW0/pXcHJXOnljqhZeQncPyzCWQYAxNR9PqDTRurAbaioXeeEvYJiK7JC6t
         1uBH6dqRX1GvZjUFRd+ruPIqY7H6iX+pFi+/lT38wa80HPAEgH9y8itRq0CbgXj7PZvz
         KyTA==
X-Gm-Message-State: AO0yUKXpjYPAkaubxBDnKd4SiZuZWyKuXrppJXr3gOUsTic4QXlYutQk
        tZTPiOOSZnH/zQwB594MYVUsxxdoGVi0bVuP
X-Google-Smtp-Source: AK7set97jrlAfVvPpHOrM2Vr0RCmWVnsZU6sMMMwHyygC2dGwvgADEuqjxobUXV27YUvQlS1Att+r/ZLiyOif2dS
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:e745:b0:1a0:4aa3:3a9a with SMTP
 id p5-20020a170902e74500b001a04aa33a9amr1983132plf.2.1679544043324; Wed, 22
 Mar 2023 21:00:43 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:31 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-2-yosryahmed@google.com>
Subject: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the percpu lock
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, when sleeping is not allowed during rstat flushing, we hold
the global rstat lock with interrupts disabled throughout the entire
flush operation. Flushing in an O(# cgroups * # cpus) operation, and
having interrupts disabled throughout is dangerous.

For some contexts, we may not want to sleep, but can be interrupted
(e.g. while holding a spinlock or RCU read lock). As such, do not
disable interrupts throughout rstat flushing, only when holding the
percpu lock. This breaks down the O(# cgroups * # cpus) duration with
interrupts disabled to a series of O(# cgroups) durations.

Furthermore, if a cpu spinning waiting for the global rstat lock, it
doesn't need to spin with interrupts disabled anymore.

If the caller of rstat flushing needs interrupts to be disabled, it's up
to them to decide that, and it should be fine to hold the global rstat
lock with interrupts disabled. There is currently a single context that
may invoke rstat flushing with interrupts disabled, the
mem_cgroup_flush_stats() call in mem_cgroup_usage(), if called from
mem_cgroup_threshold().

To make it safe to hold the global rstat lock with interrupts enabled,
make sure we only flush from in_task() contexts. The side effect of that
we read stale stats in interrupt context, but this should be okay, as
flushing in interrupt context is dangerous anyway as it is an expensive
operation, so reading stale stats is safer.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/rstat.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 831f1f472bb8..af11e28bd055 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -7,6 +7,7 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 
+/* This lock should only be held from task context */
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
@@ -210,14 +211,24 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 		/* if @may_sleep, play nice and yield if necessary */
 		if (may_sleep && (need_resched() ||
 				  spin_needbreak(&cgroup_rstat_lock))) {
-			spin_unlock_irq(&cgroup_rstat_lock);
+			spin_unlock(&cgroup_rstat_lock);
 			if (!cond_resched())
 				cpu_relax();
-			spin_lock_irq(&cgroup_rstat_lock);
+			spin_lock(&cgroup_rstat_lock);
 		}
 	}
 }
 
+static bool should_skip_flush(void)
+{
+	/*
+	 * We acquire cgroup_rstat_lock without disabling interrupts, so we
+	 * should not try to acquire from interrupt contexts to avoid deadlocks.
+	 * It can be expensive to flush stats in interrupt context anyway.
+	 */
+	return !in_task();
+}
+
 /**
  * cgroup_rstat_flush - flush stats in @cgrp's subtree
  * @cgrp: target cgroup
@@ -229,15 +240,18 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
  * This also gets all cgroups in the subtree including @cgrp off the
  * ->updated_children lists.
  *
- * This function may block.
+ * This function is safe to call from contexts that disable interrupts, but
+ * @may_sleep must be set to false, otherwise the function may block.
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	might_sleep();
+	if (should_skip_flush())
+		return;
 
-	spin_lock_irq(&cgroup_rstat_lock);
+	might_sleep();
+	spin_lock(&cgroup_rstat_lock);
 	cgroup_rstat_flush_locked(cgrp, true);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock(&cgroup_rstat_lock);
 }
 
 /**
@@ -248,11 +262,12 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
  */
 void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
 {
-	unsigned long flags;
+	if (should_skip_flush())
+		return;
 
-	spin_lock_irqsave(&cgroup_rstat_lock, flags);
+	spin_lock(&cgroup_rstat_lock);
 	cgroup_rstat_flush_locked(cgrp, false);
-	spin_unlock_irqrestore(&cgroup_rstat_lock, flags);
+	spin_unlock(&cgroup_rstat_lock);
 }
 
 /**
@@ -267,8 +282,11 @@ void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
 void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
+	if (should_skip_flush())
+		return;
+
 	might_sleep();
-	spin_lock_irq(&cgroup_rstat_lock);
+	spin_lock(&cgroup_rstat_lock);
 	cgroup_rstat_flush_locked(cgrp, true);
 }
 
@@ -278,7 +296,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(void)
 	__releases(&cgroup_rstat_lock)
 {
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock(&cgroup_rstat_lock);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
-- 
2.40.0.rc1.284.g88254d51c5-goog

