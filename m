Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD52A6657
	for <lists+cgroups@lfdr.de>; Wed,  4 Nov 2020 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKDO12 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 09:27:28 -0500
Received: from m12-16.163.com ([220.181.12.16]:41277 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKDO12 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 4 Nov 2020 09:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=+7b6f
        oOiP5Z9YBXE2KwaQcndnG3JikUcOzlmE2YTnls=; b=fS4axkMErEOzoG9saGOnX
        bIQbf3lUfxOnbHkqEOBpybEr7XmzYxwHLvd1l0rxjIT3k9cLPGdX6ZXHoiI51PhV
        Eri9QeKQopNabCeE6LuhYrJcwSSQcenN46qOnA0THPFKLNcAyMznz/ZTKGkby0m0
        GN32nARCTwKsOs2D1oWVn8=
Received: from localhost (unknown [101.86.211.214])
        by smtp12 (Coremail) with SMTP id EMCowADnFGrMuaJffmFhJw--.17147S2;
        Wed, 04 Nov 2020 22:25:17 +0800 (CST)
Date:   Wed, 4 Nov 2020 22:25:16 +0800
From:   Hui Su <sh_def@163.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201104142516.GA106571@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EMCowADnFGrMuaJffmFhJw--.17147S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4UAryrJFyrGry7Kr15Arb_yoW5ur4xpF
        ZxJ3W3A398JrWYgr1xta1q9a4fZa1xJw43Jr17Jw1SyF13K34Fq3W2kr1rJFWUuF9ayrnr
        trZ0kr18G3yqvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0iiDUUUUU=
X-Originating-IP: [101.86.211.214]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitw3SX1aEGR9xmQAAsL
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_page_lruvec() in memcontrol.c and
mem_cgroup_lruvec() in memcontrol.h is very similar
except for the param(page and memcg) which also can be
convert to each other.

So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/memcontrol.h | 18 +++++++++++++++--
 mm/memcontrol.c            | 40 --------------------------------------
 2 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e391e3c56de5..a586363fb766 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -457,9 +457,10 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 /**
  * mem_cgroup_lruvec - get the lru list vector for a memcg & node
  * @memcg: memcg of the wanted lruvec
+ * @pgdat: pglist_data
  *
  * Returns the lru list vector holding pages for a given @memcg &
- * @node combination. This can be the node lruvec, if the memory
+ * @pgdat combination. This can be the node lruvec, if the memory
  * controller is disabled.
  */
 static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
@@ -489,7 +490,20 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	return lruvec;
 }
 
-struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
+/**
+ * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
+ * @page: the page
+ * @pgdat: pgdat of the page
+ *
+ * This function relies on page->mem_cgroup being stable.
+ */
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
+						struct pglist_data *pgdat)
+{
+	struct mem_cgroup *memcg = page->mem_cgroup;
+
+	return mem_cgroup_lruvec(memcg, pgdat);
+}
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3dcbf24d2227..9d4e1150b194 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1330,46 +1330,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
-/**
- * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
- * @page: the page
- * @pgdat: pgdat of the page
- *
- * This function relies on page->mem_cgroup being stable - see the
- * access rules in commit_charge().
- */
-struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
-{
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	if (mem_cgroup_disabled()) {
-		lruvec = &pgdat->__lruvec;
-		goto out;
-	}
-
-	memcg = page->mem_cgroup;
-	/*
-	 * Swapcache readahead pages are added to the LRU - and
-	 * possibly migrated - before they are charged.
-	 */
-	if (!memcg)
-		memcg = root_mem_cgroup;
-
-	mz = mem_cgroup_page_nodeinfo(memcg, page);
-	lruvec = &mz->lruvec;
-out:
-	/*
-	 * Since a node can be onlined after the mem_cgroup was created,
-	 * we have to be prepared to initialize lruvec->zone here;
-	 * and if offlined then reonlined, we need to reinitialize it.
-	 */
-	if (unlikely(lruvec->pgdat != pgdat))
-		lruvec->pgdat = pgdat;
-	return lruvec;
-}
-
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
-- 
2.29.0


