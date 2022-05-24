Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4771A532321
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiEXG1V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 02:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiEXG1T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 02:27:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95C72210
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l14so15958313pjk.2
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Snuh9kH4iZm3sviSaP28BB2r1eDnnNjUUortMndKLbU=;
        b=0PirmXF7o8ixOp2Gap1kFE0YZXnIJC6frN43iRyf5aoypM1dWTfeQieGP0WOA+VK2C
         fBNRoSeyGbR0xXtit0xqBhE2UQCsFHRLLbFEajJk1QEqetMQH6u8LN1TAr/6cFwWAVHP
         tZW3tMMIO8LaVtAFpQqIV2kLiC1sLhYqsswdewCSRp9NyRlqKn17NU9wpnfSXDWSYFRj
         8YMhndotc/k5AE9hW9d3ihLS1YqG0hkZNwwwkfv9b7X9eVDkdPRKe9R2lt76FzM4FSJI
         n7his0xOGjmqBmYNm80AG01800cKPXywYJBosOpj36gQ3cTpW/CaSwiOjXz8wjYEBzKt
         obSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Snuh9kH4iZm3sviSaP28BB2r1eDnnNjUUortMndKLbU=;
        b=eiaNmWXIyxlQJveVc6zEHwLEUTKkbQlN42fSLPtIohOWVFfc5VNnUhKIC1+JXiutmo
         sYcbMpdBVl7dVJGdm2yV+NWT9F1Mgop9yGc1p90Ni9deEog87aiHGAKEyfYiN2n0mW/5
         +ghUPqufCrN1z2gSTmOvq7IFHeEUWcmawLtcDRPUe6HRGD+cEAefcy/AsQFF7dCTGkMw
         S/u5Mnyzt3YCcWqvpWS6A4CWdFW6DPfzB/7V0eaSY3W8IukLUz/kaKfgE8SpdADiU+SK
         vQNlvvRlixqwa08tDwv3ZxslH/ntDiqiSRboyOqPf3Yt3YWhPAXRiMtkObpvhpkyHWI/
         vaWA==
X-Gm-Message-State: AOAM533+DonAQhE69u2JivoVi6M1epPQ31VVk5vyeGOB4eB3wCibMFBv
        Qna9YxUxFrX4A2+I/efD04OyeQ==
X-Google-Smtp-Source: ABdhPJzjHagZRT6kX9J4hdRChv9TYsas2yUTDw3/NgMRdwNEtdr1pWT0pzzStyqD12/f5A5zeK4pfQ==
X-Received: by 2002:a17:902:9349:b0:158:a6f7:e280 with SMTP id g9-20020a170902934900b00158a6f7e280mr25975740plp.155.1653373636644;
        Mon, 23 May 2022 23:27:16 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem usage
Date:   Tue, 24 May 2022 14:05:41 +0800
Message-Id: <20220524060551.80037-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Pagecache pages are charged at the allocation time and holding a
reference to the original memory cgroup until being reclaimed.
Depending on the memory pressure, specific patterns of the page
sharing between different cgroups and the cgroup creation and
destruction rates, a large number of dying memory cgroups can be
pinned by pagecache pages. It makes the page reclaim less efficient
and wastes memory.

We can convert LRU pages and most other raw memcg pins to the objcg
direction to fix this problem, and then the page->memcg will always
point to an object cgroup pointer.

Therefore, the infrastructure of objcg no longer only serves
CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
can reuse it to charge pages.

We know that the LRU pages are not accounted at the root level. But
the page->memcg_data points to the root_mem_cgroup. So the
page->memcg_data of the LRU pages always points to a valid pointer.
But the root_mem_cgroup dose not have an object cgroup. If we use
obj_cgroup APIs to charge the LRU pages, we should set the
page->memcg_data to a root object cgroup. So we also allocate an
object cgroup for the root_mem_cgroup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  5 ++--
 mm/memcontrol.c            | 60 +++++++++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..ff1c1dd7e762 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -315,10 +315,10 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
+#endif
 	struct obj_cgroup __rcu *objcg;
 	/* list of inherited objcgs, protected by objcg_lock */
 	struct list_head objcg_list;
-#endif
 
 	MEMCG_PADDING(_pad2_);
 
@@ -851,8 +851,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
  * parent_mem_cgroup - find the accounting parent of a memcg
  * @memcg: memcg whose parent to find
  *
- * Returns the parent memcg, or NULL if this is the root or the memory
- * controller is in legacy no-hierarchy mode.
+ * Returns the parent memcg, or NULL if this is the root.
  */
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 598fece89e2b..6de0d3e53eb1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -254,9 +254,9 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static DEFINE_SPINLOCK(objcg_lock);
 
+#ifdef CONFIG_MEMCG_KMEM
 bool mem_cgroup_kmem_disabled(void)
 {
 	return cgroup_memory_nokmem;
@@ -265,12 +265,10 @@ bool mem_cgroup_kmem_disabled(void)
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
 
-static void obj_cgroup_release(struct percpu_ref *ref)
+static void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
-	unsigned long flags;
 
 	/*
 	 * At this point all allocated objects are freed, and
@@ -284,9 +282,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	 * 3) CPU1: a process from another memcg is allocating something,
 	 *          the stock if flushed,
 	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
-	 * 5) CPU0: we do release this object,
+	 * 4) CPU0: we do release this object,
 	 *          92 bytes are added to stock->nr_bytes
-	 * 6) CPU0: stock is flushed,
+	 * 5) CPU0: stock is flushed,
 	 *          92 bytes are added to objcg->nr_charged_bytes
 	 *
 	 * In the result, nr_charged_bytes == PAGE_SIZE.
@@ -298,6 +296,19 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+}
+#else
+static inline void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
+{
+}
+#endif
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
+	unsigned long flags;
+
+	obj_cgroup_release_bytes(objcg);
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
@@ -326,10 +337,10 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
-				  struct mem_cgroup *parent)
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
@@ -348,6 +359,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	percpu_ref_kill(&objcg->refcnt);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * A lot of the calls to the cache allocation functions are expected to be
  * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
@@ -3589,21 +3601,12 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg;
-
 	if (cgroup_memory_nokmem)
 		return 0;
 
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		return 0;
 
-	objcg = obj_cgroup_alloc();
-	if (!objcg)
-		return -ENOMEM;
-
-	objcg->memcg = memcg;
-	rcu_assign_pointer(memcg->objcg, objcg);
-
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg->id.id;
@@ -3613,27 +3616,19 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup *parent;
-
 	if (cgroup_memory_nokmem)
 		return;
 
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		return;
 
-	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
-	memcg_reparent_objcgs(memcg, parent);
-
 	/*
 	 * After we have finished memcg_reparent_objcgs(), all list_lrus
 	 * corresponding to this cgroup are guaranteed to remain empty.
 	 * The ordering is imposed by list_lru_node->lock taken by
 	 * memcg_reparent_list_lrus().
 	 */
-	memcg_reparent_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent_mem_cgroup(memcg));
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5116,8 +5111,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5179,6 +5174,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct obj_cgroup *objcg;
 
 	if (memcg_online_kmem(memcg))
 		goto remove_id;
@@ -5191,6 +5187,13 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
+	objcg = obj_cgroup_alloc();
+	if (!objcg)
+		goto free_shrinker;
+
+	objcg->memcg = memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -5199,6 +5202,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   2UL*HZ);
 	return 0;
+free_shrinker:
+	free_shrinker_info(memcg);
 offline_kmem:
 	memcg_offline_kmem(memcg);
 remove_id:
@@ -5226,6 +5231,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
+	memcg_reparent_objcgs(memcg);
 	memcg_offline_kmem(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
-- 
2.11.0

