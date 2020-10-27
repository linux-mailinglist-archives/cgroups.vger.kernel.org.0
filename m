Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190E829A614
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 09:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508681AbgJ0IDp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 04:03:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40452 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508679AbgJ0IDj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 04:03:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id j5so339720plk.7
        for <cgroups@vger.kernel.org>; Tue, 27 Oct 2020 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcP1qCO+NxV4ZfTtTYq+9NLHwEqCtxnTam0h3E0eXoY=;
        b=ldzMtw/9aoBNu1NB1gYXBiySt/fmyfIdYqovv3lB+Khh/+hI0IBXFQUEpvIN9McZNz
         z1OfclFxVWOlxOv6eyKxiYNP84Z9/k53WzIkHOOme5HItxqZrw3poX87ZcKT8BZmcXny
         0zD6i8b9iYMQ31vz6dwG6zVXvOPpaH8S9UENtwmf/O2j+K+FpzKEk9npn8NYZratmrwO
         LJzA3fHzBoQMJTjxFr23ghu7QjOY9FLRtF2VjKfAREtrrWeNputyCME8katlLf0A0pL4
         EXQ9aU6tuyu1SqHU0tYDKNI8b2paDbWhksM/SCbkTCuz2LAGj+Hq3jiafOpvIgCGHbMi
         QhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcP1qCO+NxV4ZfTtTYq+9NLHwEqCtxnTam0h3E0eXoY=;
        b=ENO+bw6EiZdXFYYrwuAIpx8wQ9gyK79PTbIWjJ8ncKarOzqYg41ux1pXcdNum+qXXi
         oLAMlddXSjpMt+XvU2lw4VRVmj7EQWtry+e9Ucn7AqSI2UIjLCvZr2SQpHCv9LbBWNcB
         OnfA4XxRrbzd47ZxdY+4hmKZk6FD+ZPxuJhgTbqixfenmq7Xy1PDTnpIa7wI6YS59cZh
         ydWPdQMJqX6280Has46+2iqDdAH3i33fwCX+wSpbrSwMG0Zb78tWjCNIeWxHY4Ndq436
         YbGHfXmbNnm4gPpKrXmbQ/p947wEjjbVzoen3hLQ48nJv2eX8pvwY0rqfXCLMPvGg+V0
         j2Zw==
X-Gm-Message-State: AOAM531qoOp2XQk+Bi5moPNHXNOI6qEiidbxhNp0OZVScBQSG7MRz1YY
        rq0s5anfXVvUJFX4ziufVbND4Q==
X-Google-Smtp-Source: ABdhPJwcAbffc6htWbV7MxS/83vNzm6AujW6V0vE+GjnoU5Zb2sPH+c74AGETf8TVykW/jNgYO3VLw==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr914987pjp.211.1603785818068;
        Tue, 27 Oct 2020 01:03:38 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id p8sm1039580pgs.34.2020.10.27.01.03.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:03:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/5] mm: memcg/slab: Rename *_lruvec_slab_state to *_lruvec_kmem_state
Date:   Tue, 27 Oct 2020 16:02:54 +0800
Message-Id: <20201027080256.76497-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201027080256.76497-1-songmuchun@bytedance.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The *_lruvec_slab_state is also suitable for pages allocated from buddy,
not just for the slab objects. But the function name seems to tell us that
only slab object is applicable. So we can rename the keyword of slab to
kmem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 18 +++++++++---------
 kernel/fork.c              |  2 +-
 mm/memcontrol.c            |  3 ++-
 mm/workingset.c            |  8 ++++----
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d7e339bf72dc..95807bf6be64 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -793,15 +793,15 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
-void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
+void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
 
-static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
+static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 					 int val)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__mod_lruvec_slab_state(p, idx, val);
+	__mod_lruvec_kmem_state(p, idx, val);
 	local_irq_restore(flags);
 }
 
@@ -1227,7 +1227,7 @@ static inline void mod_lruvec_page_state(struct page *page,
 	mod_node_page_state(page_pgdat(page), idx, val);
 }
 
-static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
+static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 					   int val)
 {
 	struct page *page = virt_to_head_page(p);
@@ -1235,7 +1235,7 @@ static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
 	__mod_node_page_state(page_pgdat(page), idx, val);
 }
 
-static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
+static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 					 int val)
 {
 	struct page *page = virt_to_head_page(p);
@@ -1330,14 +1330,14 @@ static inline void __dec_lruvec_page_state(struct page *page,
 	__mod_lruvec_page_state(page, idx, -1);
 }
 
-static inline void __inc_lruvec_slab_state(void *p, enum node_stat_item idx)
+static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
-	__mod_lruvec_slab_state(p, idx, 1);
+	__mod_lruvec_kmem_state(p, idx, 1);
 }
 
-static inline void __dec_lruvec_slab_state(void *p, enum node_stat_item idx)
+static inline void __dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
-	__mod_lruvec_slab_state(p, idx, -1);
+	__mod_lruvec_kmem_state(p, idx, -1);
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
diff --git a/kernel/fork.c b/kernel/fork.c
index 4b328aecabb2..4fb0bbc3b041 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -384,7 +384,7 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
 	else
-		mod_lruvec_slab_state(stack, NR_KERNEL_STACK_KB,
+		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c0c27bee23ad..22b4fb941b54 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -866,7 +866,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		__mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
-void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
+void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 {
 	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
 	struct mem_cgroup *memcg;
@@ -2920,6 +2920,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	VM_BUG_ON(!virt_addr_valid(p));
 	page = virt_to_head_page(p);
 
 	/*
diff --git a/mm/workingset.c b/mm/workingset.c
index 50d53f3699e4..2c707c92dd89 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -445,12 +445,12 @@ void workingset_update_node(struct xa_node *node)
 	if (node->count && node->count == node->nr_values) {
 		if (list_empty(&node->private_list)) {
 			list_lru_add(&shadow_nodes, &node->private_list);
-			__inc_lruvec_slab_state(node, WORKINGSET_NODES);
+			__inc_lruvec_kmem_state(node, WORKINGSET_NODES);
 		}
 	} else {
 		if (!list_empty(&node->private_list)) {
 			list_lru_del(&shadow_nodes, &node->private_list);
-			__dec_lruvec_slab_state(node, WORKINGSET_NODES);
+			__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
 		}
 	}
 }
@@ -541,7 +541,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	}
 
 	list_lru_isolate(lru, item);
-	__dec_lruvec_slab_state(node, WORKINGSET_NODES);
+	__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
 
 	spin_unlock(lru_lock);
 
@@ -564,7 +564,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 * shadow entries we were tracking ...
 	 */
 	xas_store(&xas, NULL);
-	__inc_lruvec_slab_state(node, WORKINGSET_NODERECLAIM);
+	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.20.1

