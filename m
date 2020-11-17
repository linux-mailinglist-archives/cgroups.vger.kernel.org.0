Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B762B5B66
	for <lists+cgroups@lfdr.de>; Tue, 17 Nov 2020 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKQIzo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Nov 2020 03:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgKQIzo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Nov 2020 03:55:44 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB84C0613CF
        for <cgroups@vger.kernel.org>; Tue, 17 Nov 2020 00:55:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so573240pfg.8
        for <cgroups@vger.kernel.org>; Tue, 17 Nov 2020 00:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKjsS4hTKC7rV0kYBscjT3mdhWgwWmoUJLccuKRuQEw=;
        b=bydidUtJr91S3sSScljC6vcJ0lib651urA+Tj5lAjUxiP75EFkLgI83zQXzDtsD7cz
         zkGSMnE/xutkXOicIdKijRS1oCDO8824jaNUScAYoy5SD+6m2E1TeAwe43jMJqnVA9Eq
         a5+LisK/Zryu5/0f64GX8jZpe2vC9GewxWnb6/GUtfH87qfDRl2g/DqYgjSo7bHm6580
         mT00DrXEXtyrHqeZfQ4seDdpePhplntTbDbwuyszLj4rNuRpt3esDYfB/LbfI/1b9JQQ
         3jRmNfVPYSRJsAmekwRJhakVvhAPrg7c7+OigEdtPfQp2G1d/1OYn5TAI/TVCEpYblt8
         vlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKjsS4hTKC7rV0kYBscjT3mdhWgwWmoUJLccuKRuQEw=;
        b=J47g/3NcJ0E2ij5q2/oSb67TDXRNvRsFxxzrO8xXiVAkVX5ONScQPd8BprVB/q409F
         TEVLLQc2gGSbOD0ornKXFlLacr4HgUZrllShbZ+x6ZUfN2nGkRdpsdK6I7kdgRPwV7uI
         Ea9CtGJwefi6VnYTc+DgZyG859oml7py0hssCCobZyZ0cF6bkzUWcVh0/iEi194WZ7sT
         ixvG17EJE3DFL5zDMg5dNwuF2q2IHSyn5+yQ5Qr6057OFLLka6h2DLPe4FwbGECT+YXK
         N3tbBmEz7I8HDQiGcnBKxy/XD36seOls70To239mbMs3yVxcDltISFugqn1zuxb7Qrt0
         vGwQ==
X-Gm-Message-State: AOAM5303vYksDC5a6LFnCxnuHSyqMJbl0JXdxgATKlKjPVf963bfTHNw
        DtDd0UZMLTm3CotG3geOkNJB2w==
X-Google-Smtp-Source: ABdhPJz5UobtkzqIeDYEp5tx0u0f22Gadlg1XV3iXshp2/9MbNgA+Lnw9AmynW/6yY8DzhFnQIQFkg==
X-Received: by 2002:aa7:8430:0:b029:18b:b3f5:ea4b with SMTP id q16-20020aa784300000b029018bb3f5ea4bmr17174835pfn.61.1605603343548;
        Tue, 17 Nov 2020 00:55:43 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.82])
        by smtp.gmail.com with ESMTPSA id f19sm20372258pfa.82.2020.11.17.00.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 00:55:42 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com, esyr@redhat.com,
        tglx@linutronix.de, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 RESEND] mm: memcg/slab: Rename *_lruvec_slab_state to *_lruvec_kmem_state
Date:   Tue, 17 Nov 2020 16:52:49 +0800
Message-Id: <20201117085249.24319-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
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
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 changelog in v2:
 1. Remove VM_BUG_ON suggested by Roman.

 include/linux/memcontrol.h | 18 +++++++++---------
 kernel/fork.c              |  2 +-
 mm/memcontrol.c            |  2 +-
 mm/workingset.c            |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

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
index d9cdf899c6fc..2dde734df7d1 100644
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

