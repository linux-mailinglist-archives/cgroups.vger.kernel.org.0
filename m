Return-Path: <cgroups+bounces-11254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E76C150C2
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886381C23101
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337BB338922;
	Tue, 28 Oct 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bp6a9gAz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293E330D25
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660194; cv=none; b=ILuWp5+LQwroZudP4awpCYI+YSugMyySyOys0VYzST9dCsZYjeZSbxKrwWgrsG3s/xOEnZ4FDnC/olfyxsI38JLtDRWMDqUFYzUY+jrb7syGne0XDhWteFjWe3FvbR4Lv9+9VDNOTm1vzkkwpwc0zBwQhRP460Shv+sfC0G+1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660194; c=relaxed/simple;
	bh=c7aS0B7Q4aI8qvE0o1ujFPvYKq8OZ4jgeruzo0A6oMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Jjt/QBPAf6V+y0X076P3P8sr6hAcACeD9NjvRjk/GKu0HT+j5v/KyNzcdgjvUYns8cF45PN5SdDZ9adUgXYjma0ZIllfPqlh99rDJOXD+0apIZihOBUAm/lilZGhHMFG0jsl1BZOAmnfkqksxuvHrWkwAmVNTKBCVLtCWzWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bp6a9gAz; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdeP1C9lZUf/BHy9VyO6H/2ZkQY+8y2qy7tx97P5h/I=;
	b=bp6a9gAztickZhcVXAzCYe6KGXExJZWpvLQghvCnTrMnB8k9/ms5522DdHvjaBQXwl1RP/
	1YHo2+jDweAPtLcq9U1Cb3e57rrqkh4/RyV+G7msuW0Jz/HOa8JsbwwuEnjip7pOA7mM6l
	35opjXquzD26S/pjcE8ZenFRa/5aYXs=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 09/26] writeback: prevent memory cgroup release in writeback module
Date: Tue, 28 Oct 2025 21:58:22 +0800
Message-ID: <c1d571a61dcd8591da86e5dc036175f076cfbf1d.1761658310.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the function get_mem_cgroup_css_from_folio()
and the rcu read lock are employed to safeguard against the release
of the memory cgroup.

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/fs-writeback.c                | 22 +++++++++++-----------
 include/linux/memcontrol.h       |  9 +++++++--
 include/trace/events/writeback.h |  3 +++
 mm/memcontrol.c                  | 14 ++++++++------
 4 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fee..afd81fb8100cb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -269,15 +269,13 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
-		if (folio) {
-			memcg_css = mem_cgroup_css_from_folio(folio);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-		} else {
-			/* must pin memcg_css, see wb_get_create() */
+		/* must pin memcg_css, see wb_get_create() */
+		if (folio)
+			memcg_css = get_mem_cgroup_css_from_folio(folio);
+		else
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-			css_put(memcg_css);
-		}
+		wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+		css_put(memcg_css);
 	}
 
 	if (!wb)
@@ -968,16 +966,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	css = mem_cgroup_css_from_folio(folio);
+	css = get_mem_cgroup_css_from_folio(folio);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!(css->flags & CSS_ONLINE))
-		return;
+		goto out;
 
 	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-		return;
+		goto out;
 	}
 
 	if (id == wbc->wb_lcand_id)
@@ -990,6 +988,8 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9fdbd4970021d..174e52d8e7039 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -895,7 +895,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_folio(struct folio *folio);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1577,9 +1577,14 @@ static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 	if (mem_cgroup_disabled())
 		return;
 
+	if (!folio_memcg_charged(folio))
+		return;
+
+	rcu_read_lock();
 	memcg = folio_memcg(folio);
-	if (unlikely(memcg && &memcg->css != wb->memcg_css))
+	if (unlikely(&memcg->css != wb->memcg_css))
 		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
+	rcu_read_unlock();
 }
 
 void mem_cgroup_flush_foreign(struct bdi_writeback *wb);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index c08aff044e807..3680828727f23 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -295,7 +295,10 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+
+		rcu_read_lock();
 		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
+		rcu_read_unlock();
 	),
 
 	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1da3ad77054d3..aa8945c4ee383 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -241,7 +241,7 @@ DEFINE_STATIC_KEY_FALSE(memcg_bpf_enabled_key);
 EXPORT_SYMBOL(memcg_bpf_enabled_key);
 
 /**
- * mem_cgroup_css_from_folio - css of the memcg associated with a folio
+ * get_mem_cgroup_css_from_folio - acquire a css of the memcg associated with a folio
  * @folio: folio of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -251,14 +251,16 @@ EXPORT_SYMBOL(memcg_bpf_enabled_key);
  * If memcg is bound to a traditional hierarchy, the css of root_mem_cgroup
  * is returned.
  */
-struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio)
+struct cgroup_subsys_state *get_mem_cgroup_css_from_folio(struct folio *folio)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
-	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		memcg = root_mem_cgroup;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return &root_mem_cgroup->css;
 
-	return &memcg->css;
+	memcg = get_mem_cgroup_from_folio(folio);
+
+	return memcg ? &memcg->css : &root_mem_cgroup->css;
 }
 
 /**
-- 
2.20.1


