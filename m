Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93285532A6
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbiFUM5t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350896AbiFUM5r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 08:57:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3019C2F
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:57:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k14so959566plh.4
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EillBei8kFa/6bw4XJ6MyIzznZyI10pUVH5tAnTdeuw=;
        b=Jv9GaHJN86Q1C8Y+YpP2HCf9JPFImIvPmz0BU9q0OZd0+4E84aO4jvX7w2JJE8HLii
         xXvy2BsIyrtipyPfO3JiQ1L4gabF6BNM/uSE7D/v4vl5Vc36NMI2yEg+YZ5KSpNsGptU
         HO2lidk6QI25ifAr3ya3fadEcyz9Zbz8Qo1Yg9d9O1CQjjvVGXgpg23fllv4PPkdtuY7
         rKxObA5Q8AuofZlnIdgY5syfjw3uLfKsvjs7i/wXGnHIM/h1h8t1/P4ZXW1c8yFLligG
         siardVDC/TnIZX7H68y5GKiYC9yQyG4FPJP7v8L66B47QZvSC5zmsPVyqmAM4Ajp6REh
         K7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EillBei8kFa/6bw4XJ6MyIzznZyI10pUVH5tAnTdeuw=;
        b=oOiI1M5xnWZ1kb+RZHFhrRSnYDILVigs7xtufMVR4N+2CkGpFLLm9WTqjNwtVYRTYB
         u9WsX7D+nLuUL/yfIwMJTXjtqljF82TxxDAlnfshCqlwY9L4u86hhANBhp4W76uB4uFr
         TH6nE9L4f6cmkn9u33DqjB/tP7EbEDbXicaJNJq3uGD4R+GFY2QzyCwInOY94mw0XxNA
         C1OOe4RWjIXO/fzWQ+lS1Ag7ezlF78IzeFU25QRgCZ38xV4syxwQXMC9cMqrNsQmxhfD
         FZLg1j68EZIhFTj43qxoianHkmX90s9PdOoahw1tqmvOEHruQmaikQVAod9/kM76jIQv
         It4w==
X-Gm-Message-State: AJIora+byFWAkB1GXlir36rZdCK8ulB8S0IVKUf44TfIYC0cnGwTQEpz
        6p8E0m/vRhYAYT/QhPsW6SeFjA==
X-Google-Smtp-Source: AGRyM1tSXaqiZZOhIChBYioUnW0DVCRqwFclVFY428N7/E3eP36ixMt0VVOaIjmyV7ksj0qm20VtAQ==
X-Received: by 2002:a17:902:c2c6:b0:168:d8ce:90b2 with SMTP id c6-20020a170902c2c600b00168d8ce90b2mr29357788pla.110.1655816265091;
        Tue, 21 Jun 2022 05:57:45 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:57:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 01/11] mm: memcontrol: remove dead code and comments
Date:   Tue, 21 Jun 2022 20:56:48 +0800
Message-Id: <20220621125658.64935-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  3 +--
 mm/memcontrol.c            | 12 ------------
 mm/vmscan.c                |  6 +-----
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4d31ce55b1c0..318d8880d62a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -866,8 +866,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
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
index 163492b9efa9..fc706d6fc265 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3684,17 +3684,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
@@ -7195,8 +7185,6 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 			break;
 		}
 		memcg = parent_mem_cgroup(memcg);
-		if (!memcg)
-			memcg = root_mem_cgroup;
 	}
 	return memcg;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 88fce64cfa96..b68b0216424d 100644
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

