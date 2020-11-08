Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008992AABE4
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgKHP0k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 10:26:40 -0500
Received: from m12-13.163.com ([220.181.12.13]:34084 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHP0k (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 10:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=vi3Bj
        fzpqssVUtirGQmg9J3S/o92w2Pdis4J9PzyuEA=; b=LR99cRZns097oGxzgUbGR
        7KE9mcPJVTRCuG6VwZtTjH/ZxYSu8Ep5ls1k8VD6cVygCRVrZ20KDGC0ieAQ40DC
        SCrWZCc4DRWEpPzTLY4LMfkfXiWVtGYGDMcKfwFQp8C6VndvC0UDjtG4rCGEuJEe
        hFo380z8ezfUdAFqcT8MTE=
Received: from localhost (unknown [101.86.208.122])
        by smtp9 (Coremail) with SMTP id DcCowAAHZwOrAqhfgSskPg--.40498S2;
        Sun, 08 Nov 2020 22:37:31 +0800 (CST)
Date:   Sun, 8 Nov 2020 22:37:31 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Cc:     sh_def@163.com
Subject: [PATCH v2] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201108143731.GA74138@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowAAHZwOrAqhfgSskPg--.40498S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4UJr4DZr1UKrW7tr1kZrb_yoW5tF43pF
        ZxG3W3Z398JrWYqr4xta1q9a4fZa1xJw43Jr17Jw1IvF13K340q3W2kr1rXFWUuFySyrnr
        trZ0kr18G3yqvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRRT5JUUUUU=
X-Originating-IP: [101.86.208.122]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbifwvWX1r6mir7KwAAs9
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_page_lruvec() in memcontrol.c and
mem_cgroup_lruvec() in memcontrol.h is very similar
except for the param(page and memcg) which also can be
convert to each other.

So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().

v1->v2:
use page_memcg() instead of 'page->mem_cgroup'.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/memcontrol.h | 16 +++++++++++++--
 mm/memcontrol.c            | 40 --------------------------------------
 2 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e391e3c56de5..727af7c74e91 100644
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
@@ -489,7 +490,18 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
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
+	return mem_cgroup_lruvec(page_memcg(page), pgdat);
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


