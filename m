Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051CF64BC41
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 19:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiLMSpp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 13:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiLMSpn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 13:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079A24BD9
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670957105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+iH+gyUSP9RmZybF0rRU4rA5/id1U9+eBsl2PUnAPQ=;
        b=YP5lnMduBFZ6I4jUYCaTX44pr3sGK8e8jIJw7ETVcFG0uil2Ay6Ux+3oPx0q9xIauDu7RZ
        bcDg68Y7NvU7w/gRFRHbbFcDmwAylfx79mjv8t9fIwVM8vuWgFSdQW2ZLA7J7nTl+mfuv2
        PV9W9dEnzDVPorBwCDwYCuUjeIlZCgA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-cFUaBO_WOZqWlEoTA3QSDA-1; Tue, 13 Dec 2022 13:45:00 -0500
X-MC-Unique: cFUaBO_WOZqWlEoTA3QSDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E001C008A7;
        Tue, 13 Dec 2022 18:44:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8242C15BA0;
        Tue, 13 Dec 2022 18:44:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-block v3 2/2] blk-cgroup: Flush stats at blkgs destruction path
Date:   Tue, 13 Dec 2022 13:44:46 -0500
Message-Id: <20221213184446.50181-3-longman@redhat.com>
In-Reply-To: <20221213184446.50181-1-longman@redhat.com>
References: <20221213184446.50181-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As noted by Michal, the blkg_iostat_set's in the lockless list
hold reference to blkg's to protect against their removal. Those
blkg's hold reference to blkcg. When a cgroup is being destroyed,
cgroup_rstat_flush() is only called at css_release_work_fn() which is
called when the blkcg reference count reaches 0. This circular dependency
will prevent blkcg from being freed until some other events cause
cgroup_rstat_flush() to be called to flush out the pending blkcg stats.

To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
function to flush stats for a given css and cpu and call it at the blkgs
destruction path, blkcg_destroy_blkgs(), whenever there are still some
pending stats to be flushed. This will ensure that blkcg reference
count can reach 0 ASAP.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c     | 15 +++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ca28306aa1b1..ddd27a714d3e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1084,6 +1084,8 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  */
 static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
+	int cpu;
+
 	/*
 	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
 	 * references gone.
@@ -1093,6 +1095,19 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 
 	might_sleep();
 
+	/*
+	 * Flush all the non-empty percpu lockless lists so as to release
+	 * the blkg references held by those lists which, in turn, may
+	 * allow the blkgs to be freed and release their references to
+	 * blkcg speeding up its freeing.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+
+		if (!llist_empty(lhead))
+			cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
+	}
+
 	spin_lock_irq(&blkcg->lock);
 
 	while (!hlist_empty(&blkcg->blkg_list)) {
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 528bd44b59e2..6c4e66b3fa84 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -766,6 +766,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
+void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 793ecff29038..2e44be44351f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -281,6 +281,24 @@ void cgroup_rstat_flush_release(void)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+/**
+ * cgroup_rstat_css_cpu_flush - flush stats for the given css and cpu
+ * @css: target css to be flush
+ * @cpu: the cpu that holds the stats to be flush
+ *
+ * A lightweight rstat flush operation for a given css and cpu.
+ * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
+ * isn't used.
+ */
+void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+
+	raw_spin_lock_irq(cpu_lock);
+	css->ss->css_rstat_flush(css, cpu);
+	raw_spin_unlock_irq(cpu_lock);
+}
+
 int cgroup_rstat_init(struct cgroup *cgrp)
 {
 	int cpu;
-- 
2.31.1

