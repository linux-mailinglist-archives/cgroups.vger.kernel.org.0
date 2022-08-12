Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E159165F
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiHLUkG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHLUkF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 16:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC4E3B5171
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660336803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTybH4D4WwOeqo3rN415vbeLaTvaxhsUDN/KB9esUqw=;
        b=hWG9LNFswjTO52SCpmolgUQs+b48IeYYVw581gLvISdnyqabZ7sFnkx4WxCvX/qnSgpnpf
        /ceTCUt6akz16tTTUSMchduBbg+B8E6mq1X1nJ/1MEKieuMY20esb2uA+hB/4zAA4ZQnWH
        jo6eFwSMrrD77Y2rFa26Ra5q8HutRCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-wpjNd6xdOL6kePHvfDkgYw-1; Fri, 12 Aug 2022 16:39:59 -0400
X-MC-Unique: wpjNd6xdOL6kePHvfDkgYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D3DB1857F02;
        Fri, 12 Aug 2022 20:39:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E51CC15BA6;
        Fri, 12 Aug 2022 20:39:58 +0000 (UTC)
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
Subject: [PATCH v3 2/3] sched: Provide copy_user_cpus_mask() to copy out user mask
Date:   Fri, 12 Aug 2022 16:39:28 -0400
Message-Id: <20220812203929.364341-3-longman@redhat.com>
In-Reply-To: <20220812203929.364341-1-longman@redhat.com>
References: <20220812203929.364341-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cf7206a9b29a..e06bc1cbccca 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1831,6 +1831,7 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effec
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
+extern struct cpumask *copy_user_cpus_mask(struct task_struct *p, struct cpumask *user_mask);
 extern void release_user_cpus_ptr(struct task_struct *p);
 extern int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask);
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7e2576068331..4d3b10e91e1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2619,6 +2619,24 @@ void release_user_cpus_ptr(struct task_struct *p)
 	kfree(clear_user_cpus_ptr(p));
 }
 
+/*
+ * Return the copied mask pointer or NULL if user mask not available.
+ */
+struct cpumask *copy_user_cpus_mask(struct task_struct *p,
+				    struct cpumask *user_mask)
+{
+	struct rq_flags rf;
+	struct rq *rq = task_rq_lock(p, &rf);
+	struct cpumask *mask = NULL;
+
+	if (p->user_cpus_ptr) {
+		cpumask_copy(user_mask, p->user_cpus_ptr);
+		mask = user_mask;
+	}
+	task_rq_unlock(rq, p, &rf);
+	return mask;
+}
+
 /*
  * This function is wildly self concurrent; here be dragons.
  *
-- 
2.31.1

