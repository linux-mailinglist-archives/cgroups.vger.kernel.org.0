Return-Path: <cgroups+bounces-12400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6B1CC660C
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E243021FA4
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF1339701;
	Wed, 17 Dec 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZrvJVvvW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01C338F5B
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956653; cv=none; b=qZUMMqGYDbIUUs+zc2HXWA8Y5FSeZAqed6jIDk2LD5gfgQ/rhzGKDdTNibV4DTceDTtHqAB+lnoBIyXK8xLWwwamPlkgy7NYBy652NQjEhNLZvxzvbpHjyCs5+mhU+yLJraszD10vB1XcrhnyaqHfZJlDYbir1STCSIXwXkff9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956653; c=relaxed/simple;
	bh=bIUIaX7AaZAWTGaQIgLVs77/5oKLusC8ZUMhKNKwwpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSXuWMogl6/DR5n0Zce2i4i4T1n27hUwaIZdwedoSDrbw5nkGVpLWtpZwbanOcZ3UqS9BBx77vmuW1OstAWjeAK+GkfFmv7r3qgESUlETpeCn0kk5SrCgpCQkK+d8q1dr7FkwfiDALso67iRvU/0N3oWCuejkYS++CStFfJJq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZrvJVvvW; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cb8NWIyZ/ts5sKA8lazTxoYJ+MrmJmaOEPm0Hg1IF8Q=;
	b=ZrvJVvvWuNeMXQL9pMRHM4uWZyvvIGS4eeGanGz2oB/X+b3VfcEuyVIps/0tthZkAdqdER
	WYYXtlOzeXulJisgMUeJS2MAmu/yMhGhzaCnO4JeGiEvFWXmp/3gOQMVYWVe8xAjW17tZ+
	omsRM5kP270T8TDwabvlJGBS3joq4mA=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 10/28] writeback: prevent memory cgroup release in writeback module
Date: Wed, 17 Dec 2025 15:27:34 +0800
Message-ID: <d2863fabba49a16572a84163e42cbce64aee27c9.1765956025.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 fs/fs-writeback.c                | 22 +++++++++++-----------
 include/linux/memcontrol.h       |  9 +++++++--
 include/trace/events/writeback.h |  3 +++
 mm/memcontrol.c                  | 14 ++++++++------
 4 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5dd6e89a6d29e..2e57b7e2b4453 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -279,15 +279,13 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
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
@@ -979,16 +977,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	css = mem_cgroup_css_from_folio(folio);
+	css = get_mem_cgroup_css_from_folio(folio);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!css_is_online(css))
-		return;
+		goto out;
 
 	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-		return;
+		goto out;
 	}
 
 	if (id == wbc->wb_lcand_id)
@@ -1001,6 +999,8 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 776d9be1f446a..bc526e0d37e0b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -895,7 +895,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_folio(struct folio *folio);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1549,9 +1549,14 @@ static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
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
index 311a341e6fe42..f5bfe8c1a160a 100644
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
index 431b3154c70c5..131f940c03fa0 100644
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


