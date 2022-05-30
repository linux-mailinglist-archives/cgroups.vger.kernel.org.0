Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9451F5375F0
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiE3HvR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiE3HuY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 03:50:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDF472202
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:50:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so9617543plk.8
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXoATc+zbrMinz5NUa5ozUC0jOTcvkPC5pLx07yWbkQ=;
        b=2EM02glyaZI9nPq2vkW6z3/AzXTv1u6Z3Rb2QQefVH2nhduDyPrtPjKRtHjq9g90FL
         /CXIjNPgSxLJM/RId9CYNnMZuVQ2pkO7ccabdIFa4HHSHA22NFUd7VSEbTAmRcx/C6Pq
         1pdgBVjlr98ujtH4tl4OIxO4C9vjDL2OV1l6eX7q5T7QIEW73W0PuuVZ0rsRAwIrHCPg
         S5PL5p6FQyEYK+6qwGC/x1J2tkW2NOXpHu8+XmlEjKSJrbZ7iHrjCEv2VhtwhI52Hprp
         /qpQJFNAyYI3aTojFpHR+FncgU4BMwjh8nFipSkRzIzlSa7UB+xBxhdfY6PXixqlVlL5
         l6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXoATc+zbrMinz5NUa5ozUC0jOTcvkPC5pLx07yWbkQ=;
        b=d01HMMbKyDKTOwveaac8Ad20CbbC0vAixgTYQWSr4p6sRzpLD99kson4uojqT/CADT
         ZgUsI+BrOp4E983co5KdRBJGYN1MQ1V35Ng0eoMsNMrG/ILylK6e1ZY/Nkmuon+n668g
         lRxEwy5FZfCnFLJQS1a1RZMFj5JF7Ct5rLjK4ZKMGDHGB0i2twB6ynEOQdi0B0NYQ1nN
         PlLIL7mm7rxJL5x5yzMRvMOW+7o4xE9svGt4ljwhsdhGaeWTFhx0GwO0bA+aoXlKkWvS
         rRZ6Xqs7GyEKc/GzwqbesAhmz2SU48NdmmjI+5wbPFjNBg9tCyyJOgCLjmVAkn4kKY92
         DOKg==
X-Gm-Message-State: AOAM5315/iRujTsbzy/W37QrSdEZNtrGryTsYgvF7emW/06nApsSWWXd
        D106qz7UIIJAJAA8TqHWX0ZPxQ==
X-Google-Smtp-Source: ABdhPJzFO2bdmj87yqsVCuzBbqGlQwZx7W2PblGMZx3/l+70EpZyp1xSqrhLdvRzm2ZSRWn7pRspng==
X-Received: by 2002:a17:902:d4c7:b0:162:4625:ecad with SMTP id o7-20020a170902d4c700b001624625ecadmr30734418plg.79.1653897022979;
        Mon, 30 May 2022 00:50:22 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b001616c3bd5c2sm8421381pls.162.2022.05.30.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:50:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 01/11] mm: memcontrol: remove dead code and comments
Date:   Mon, 30 May 2022 15:49:09 +0800
Message-Id: <20220530074919.46352-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since no-hierarchy mode is deprecated after

  commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode")

so parent_mem_cgroup() cannot return a NULL except root memcg, however, root
memcg cannot be offline, so it is safe to drop the check of returned value
of parent_mem_cgroup().  Remove those dead code.

The comments in memcg_offline_kmem() above memcg_reparent_list_lrus() are
out of date since

  commit 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")

There is no ordering requirement between memcg_reparent_list_lrus() and
memcg_reparent_objcgs(), so remove those outdated comments.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  3 +--
 mm/memcontrol.c            | 16 ----------------
 mm/vmscan.c                |  6 +-----
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..0833be256134 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
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
index 598fece89e2b..13da256ff2e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3622,17 +3622,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		return;
 
 	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
 	memcg_reparent_objcgs(memcg, parent);
-
-	/*
-	 * After we have finished memcg_reparent_objcgs(), all list_lrus
-	 * corresponding to this cgroup are guaranteed to remain empty.
-	 * The ordering is imposed by list_lru_node->lock taken by
-	 * memcg_reparent_list_lrus().
-	 */
 	memcg_reparent_list_lrus(memcg, parent);
 }
 #else
@@ -6593,10 +6583,6 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 		return;
 
 	parent = parent_mem_cgroup(memcg);
-	/* No parent means a non-hierarchical mode on v1 memcg */
-	if (!parent)
-		return;
-
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
 		memcg->memory.elow = READ_ONCE(memcg->memory.low);
@@ -7050,8 +7036,6 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 			break;
 		}
 		memcg = parent_mem_cgroup(memcg);
-		if (!memcg)
-			memcg = root_mem_cgroup;
 	}
 	return memcg;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..8c6054e06087 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -409,13 +409,9 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 {
 	int i, nid;
 	long nr;
-	struct mem_cgroup *parent;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct shrinker_info *child_info, *parent_info;
 
-	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
 	/* Prevent from concurrent shrinker_info expand */
 	down_read(&shrinker_rwsem);
 	for_each_node(nid) {
-- 
2.11.0

