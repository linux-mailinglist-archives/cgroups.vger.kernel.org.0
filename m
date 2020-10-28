Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9CA29DA38
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 00:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgJ1XRS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 19:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgJ1XRN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 19:17:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B9C0613CF
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 16:17:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i26so779278pgl.5
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFOCR0z2k088YX66ZBfrxJZH18ogpQbHQLbfk8+8CYU=;
        b=t0Q+e2FBNi/gftNkFBdCTLi3hN6RhvPuqrjrAeVOgKjK0yetO6ZVmJ9PoviQAZiAav
         2uQ4+Vj+6OJ2rDvCyt2uyBu3twAoqDxpPQ6HKCdcNsfQt3fKQ2VVySd+/O7ZhT+omSvS
         qZb5XlF2ct60QyTPLgt0a8Lieq3qhoMKPpQRDi4d7p/5pbyAiEwESnQWV9cwbVPkgwyk
         BAyL5QTuIq0WENXagPIbA0m6crAXFshFYRKBVua2yDvn4vjkUGv3eanVsknBQaVhtaiA
         ZmBGY8UiNIxoTPgMxz+0ofvcOYRNPR4a6i82osws4JKcgiLpHKTuugXL6LkqKE3r0k7B
         z0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFOCR0z2k088YX66ZBfrxJZH18ogpQbHQLbfk8+8CYU=;
        b=b8LPT0zWB5nm5dKGYCx7q+kDPV7PNoa2b9Fhirf2zzxeUykjDr0LXX8y95cyBoqj04
         6pF2ne+6WWTHkhsLnK7vUCq7E7pgdz3QLZuYXlpJRrgL4COkqqdzb73g2OS++KKYa/lJ
         POhG6ZXBps3Jk+IGHwnXZ1nidHovkqQCSfOTNdG8rZWWWlmtRZ8g+mfNbTKtBmnosz3g
         /2go4tAgdPu3gKd/2lnRsPY/7khOn34leK+XkP9e8tSg0ibQWaVIxxtuP8fJuTonlA4a
         rT5Vrke4Gue3sVA85/Ly7S+fj1gVowlDReqhHgPPKl3+wh0UTNFSyst2f2OmEbbQ/bQ2
         w4GQ==
X-Gm-Message-State: AOAM532bRbDTOpfye97yznDxDJgd1Jfj734hHcq+E4hfPkHJKhmqYGA9
        l9KENSh2leEeOkWVX86jbVf5EzzLKPQpLBRb
X-Google-Smtp-Source: ABdhPJw85ywrViQDutYz7H0AcVWUMgaMzewvZdsi2bR6wV3akldT5YSxgNVzdtytLLB0N19+6b94gg==
X-Received: by 2002:a63:4d45:: with SMTP id n5mr4488139pgl.389.1603857072734;
        Tue, 27 Oct 2020 20:51:12 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id s8sm3412273pjn.46.2020.10.27.20.51.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:51:12 -0700 (PDT)
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
Subject: [PATCH v2] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
Date:   Wed, 28 Oct 2020 11:50:13 +0800
Message-Id: <20201028035013.99711-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We can reuse the code of mem_cgroup_lruvec() to simplify the code
of the mem_cgroup_page_lruvec().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 changelog in v2:
 1. Move mem_cgroup_node_lruvec to memcontrol.c to avoid abuse.

 include/linux/memcontrol.h | 41 ++++-------------------------
 mm/memcontrol.c            | 53 ++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 52 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 95807bf6be64..bbdc694d26b1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -445,48 +445,17 @@ void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
 
-static struct mem_cgroup_per_node *
+static inline struct mem_cgroup_per_node *
 mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 {
 	return memcg->nodeinfo[nid];
 }
 
-/**
- * mem_cgroup_lruvec - get the lru list vector for a memcg & node
- * @memcg: memcg of the wanted lruvec
- *
- * Returns the lru list vector holding pages for a given @memcg &
- * @node combination. This can be the node lruvec, if the memory
- * controller is disabled.
- */
-static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
-					       struct pglist_data *pgdat)
-{
-	struct mem_cgroup_per_node *mz;
-	struct lruvec *lruvec;
-
-	if (mem_cgroup_disabled()) {
-		lruvec = &pgdat->__lruvec;
-		goto out;
-	}
-
-	if (!memcg)
-		memcg = root_mem_cgroup;
-
-	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
-	lruvec = &mz->lruvec;
-out:
-	/*
-	 * Since a node can be onlined after the mem_cgroup was created,
-	 * we have to be prepared to initialize lruvec->pgdat here;
-	 * and if offlined then reonlined, we need to reinitialize it.
-	 */
-	if (unlikely(lruvec->pgdat != pgdat))
-		lruvec->pgdat = pgdat;
-	return lruvec;
-}
+struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
+				 struct pglist_data *pgdat);
 
-struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
+struct lruvec *mem_cgroup_page_lruvec(struct page *page,
+				      struct pglist_data *pgdat);
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bbd40c5af61e..28095a1711aa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1332,18 +1332,15 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
-/**
- * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
- * @page: the page
- * @pgdat: pgdat of the page
- *
- * This function relies on page->mem_cgroup being stable - see the
- * access rules in commit_charge().
+/*
+ * Note: Do not use this function directly. Please use mem_cgroup_lruvec()
+ * or mem_cgroup_page_lruvec() instead.
  */
-struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
+static struct lruvec *
+__mem_cgroup_node_lruvec(struct mem_cgroup *memcg, struct pglist_data *pgdat,
+			 int nid)
 {
 	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
 	if (mem_cgroup_disabled()) {
@@ -1351,20 +1348,15 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 		goto out;
 	}
 
-	memcg = page->mem_cgroup;
-	/*
-	 * Swapcache readahead pages are added to the LRU - and
-	 * possibly migrated - before they are charged.
-	 */
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	mz = mem_cgroup_page_nodeinfo(memcg, page);
+	mz = mem_cgroup_nodeinfo(memcg, nid);
 	lruvec = &mz->lruvec;
 out:
 	/*
 	 * Since a node can be onlined after the mem_cgroup was created,
-	 * we have to be prepared to initialize lruvec->zone here;
+	 * we have to be prepared to initialize lruvec->pgdat here;
 	 * and if offlined then reonlined, we need to reinitialize it.
 	 */
 	if (unlikely(lruvec->pgdat != pgdat))
@@ -1372,6 +1364,35 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	return lruvec;
 }
 
+/**
+ * mem_cgroup_lruvec - get the lru list vector for a memcg & node
+ * @memcg: memcg of the wanted lruvec
+ *
+ * Returns the lru list vector holding pages for a given @memcg &
+ * @node combination. This can be the node lruvec, if the memory
+ * controller is disabled.
+ */
+struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
+				 struct pglist_data *pgdat)
+{
+	return __mem_cgroup_node_lruvec(memcg, pgdat, pgdat->node_id);
+}
+
+/**
+ * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
+ * @page: the page
+ * @pgdat: pgdat of the page
+ *
+ * This function relies on page->mem_cgroup being stable - see the
+ * access rules in commit_charge().
+ */
+struct lruvec *mem_cgroup_page_lruvec(struct page *page,
+				      struct pglist_data *pgdat)
+{
+	return __mem_cgroup_node_lruvec(page->mem_cgroup, pgdat,
+					page_to_nid(page));
+}
+
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
-- 
2.20.1

