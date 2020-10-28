Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A401829D944
	for <lists+cgroups@lfdr.de>; Wed, 28 Oct 2020 23:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgJ1Wua (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389564AbgJ1WuN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 18:50:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616CC0613D1
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 15:50:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b3so700820pfo.2
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l11fDl4Fq8T2pP6ahb6hX5LVHhC/PeAhLkamA9ns5Ro=;
        b=QqsjQXInft72OQYfP146sQ7qXQee2XfBGLyb+DEaD05o6VsMPBa58ZPQD8Q2dWXcfo
         rKjTON9Q0FmZSazxEHhEgYu9omkImsZX6NFGJazpjDs/Jv6lpHThith2PtVqtBRGzJ0Q
         xsPWq5tbDQGNg0rC9VwFjARLGirb6X4ZaT5IiaTnnNG5eUzhrj2yuAHMlRtEt72BciMB
         uPD5KN3DC8PYpDNz7r6a5fFWpOPeFE13YBbt9aks/263bb5Fffl3tg7ZIuBrZyr4buNj
         eIiwkAV9032BYShK3hc+ZSp7kUFFO0qES3VpGpF9tLReHGOoW8tUcXk5NHPF9IjXAKvV
         +eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l11fDl4Fq8T2pP6ahb6hX5LVHhC/PeAhLkamA9ns5Ro=;
        b=MDK5RiYBxRtFCnXckHKXIFGEuyo5qcptkhzvzy/BHbyougmfnz5IO1WQma8FMeJRzc
         pfcKIoi9YEDNM8KatcZX0y7SoX+iWo0OeXP/qAW7rSkHdpOkX9xJUT+4Ntk5dcUzID3d
         zuPkujoaWHiUabnPtC8Yx3vp2TJtPiA4XaTP4WkHMMsPjuO3ACphZK25gKMN3K+KorkG
         mfXkftZCpQ3bRjeEFu4BaS/TCDCMj7h21/P+JR5VMj6FVR1KcbVrT4dCaa4bx3XQpUnZ
         rl7IpmrdXckV3kDh1u8FQP7OqEGsQ+zSMlugrXfsfdIJqiaeH36eG32WlE+zwbjuRwHD
         TWqw==
X-Gm-Message-State: AOAM531B6rMbo2UyIJC7RTwFZzIsatsfGW6eFaObmWs+rl3rec9XIk7l
        ZE02SW/1oiuEbvluK/18bulMx7F3wcA7u7zg
X-Google-Smtp-Source: ABdhPJycyfczOyPNeFxM2C2gUkjDTpqdx5AYk95FzEjXctEmnDLNsmfKgddVG/v5Nu9GC47RlLjxzA==
X-Received: by 2002:aa7:801a:0:b029:15d:55ba:d11e with SMTP id j26-20020aa7801a0000b029015d55bad11emr4661607pfi.10.1603857065090;
        Tue, 27 Oct 2020 20:51:05 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id s8sm3412273pjn.46.2020.10.27.20.50.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:51:04 -0700 (PDT)
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
Subject: [PATCH v2] mm: memcg/slab: Rename *_lruvec_slab_state to *_lruvec_kmem_state
Date:   Wed, 28 Oct 2020 11:50:12 +0800
Message-Id: <20201028035013.99711-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
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

