Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D24596325
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 21:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiHPT1y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 15:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbiHPT1x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 15:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346375CCA
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660678072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrkR6gNIt4tudGoTdGvYpSQ89WyxuEjYmnoEsRj/ibE=;
        b=QKWQlt81ifSvXkX1nv0jnHe1yJUw+JZiW9KyEfw0vtdvsbucUbBIn2oC4MImUXp1WOq8UQ
        662TdfuDw3sVjJE0+HHqPzwBVdCxhXbaYjuNWt2TJQJ7TlZPciXNwVlZOxIVh94uIMoJsH
        slzZRgbM4WbvTET/l/RCJLqEjgZJ0/A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-6LvNpOjKNiah0ya12T15xQ-1; Tue, 16 Aug 2022 15:27:46 -0400
X-MC-Unique: 6LvNpOjKNiah0ya12T15xQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7190A1C1A946;
        Tue, 16 Aug 2022 19:27:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE4E91121314;
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
Subject: [PATCH v5 2/3] sched: Provide copy_user_cpus_mask() to copy out user mask
Date:   Tue, 16 Aug 2022 15:27:33 -0400
Message-Id: <20220816192734.67115-3-longman@redhat.com>
In-Reply-To: <20220816192734.67115-1-longman@redhat.com>
References: <20220816192734.67115-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since accessing the content of the user_cpus_ptr requires lock protection
to ensure its validity, provide a helper function copy_user_cpus_mask()
to facilitate its reading.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..f2b0340c094e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1830,6 +1830,7 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effec
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
+extern struct cpumask *copy_user_cpus_mask(struct task_struct *p, struct cpumask *user_mask);
 extern void release_user_cpus_ptr(struct task_struct *p);
 extern int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask);
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03053eebb22e..a0987784913e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2618,6 +2618,25 @@ void release_user_cpus_ptr(struct task_struct *p)
 	kfree(clear_user_cpus_ptr(p));
 }
 
+/*
+ * Return the copied mask pointer or NULL if user mask not available.
+ * Acquiring pi_lock for read access protection.
+ */
+struct cpumask *copy_user_cpus_mask(struct task_struct *p,
+				    struct cpumask *user_mask)
+{
+	struct cpumask *mask = NULL;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	if (p->user_cpus_ptr) {
+		cpumask_copy(user_mask, p->user_cpus_ptr);
+		mask = user_mask;
+	}
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return mask;
+}
+
 /*
  * This function is wildly self concurrent; here be dragons.
  *
-- 
2.31.1

