Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF364D59E
	for <lists+cgroups@lfdr.de>; Thu, 15 Dec 2022 04:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLODcl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 22:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLODci (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 22:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F18254375
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 19:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671075109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/pLznPGQVdkseYoFw2OMUXPOTJl7XFp+0+LqLupem4=;
        b=A5l3Yp0IYh7jB5T04zh0ldDq0/a9tDNuk5RCgLG+Nkgo0FTKPjwtskhUYRv9MiyLq+ifHW
        AEGBWadcGcpr4BlZr1qYuFLcUzYmeySKgxgJYZnzuPXcQJurIXUHSVQGGjiQDlCEMgU1K3
        Femu0LawMLrtoUIqmN6+tkFHkQl+xRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-Ufz3riySO5yZc8WkBp7EUA-1; Wed, 14 Dec 2022 22:31:46 -0500
X-MC-Unique: Ufz3riySO5yZc8WkBp7EUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B953D85D060;
        Thu, 15 Dec 2022 03:31:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42B11400D796;
        Thu, 15 Dec 2022 03:31:45 +0000 (UTC)
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
Subject: [PATCH v4 2/2] blk-cgroup: Flush stats at blkgs destruction path
Date:   Wed, 14 Dec 2022 22:31:32 -0500
Message-Id: <20221215033132.230023-3-longman@redhat.com>
In-Reply-To: <20221215033132.230023-1-longman@redhat.com>
References: <20221215033132.230023-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
cgroup_rstat_flush() is only called at css_release_work_fn() which
is called when the blkcg reference count reaches 0. This circular
dependency will prevent blkcg and some blkgs from being freed after
they are made offline.

It is less a problem if the cgroup to be destroyed also has other
controllers like memory that will call cgroup_rstat_flush() which will
clean up the reference count. If block is the only controller that uses
rstat, these offline blkcg and blkgs may never be freed leaking more
and more memory over time.

To prevent this potential memory leak, a new cgroup_rstat_css_cpu_flush()
function is added to flush stats for a given css and cpu. This new
function will be called at blkgs destruction path, blkcg_destroy_blkgs(),
whenever there are still pending stats to be flushed. This will release
the references to blkgs allowing them to be freed and indirectly allow
the freeing of blkcg.

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c     | 16 ++++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ca28306aa1b1..a2a1081d9d1d 100644
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
@@ -1093,6 +1095,20 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 
 	might_sleep();
 
+	/*
+	 * Flush all the non-empty percpu lockless lists to release the
+	 * blkg references held by those lists which, in turn, will
+	 * allow those blkgs to be freed and release their references to
+	 * blkcg. Otherwise, they may not be freed at all becase of this
+	 * circular dependency resulting in memory leak.
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

