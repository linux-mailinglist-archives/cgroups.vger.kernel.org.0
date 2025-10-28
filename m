Return-Path: <cgroups+bounces-11269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540BC15191
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8895C1C25A32
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CC343214;
	Tue, 28 Oct 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xBN0+Xgv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64D339705
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660302; cv=none; b=eUmPZZvJx/rYM5iqqWyfk7Pp6CeW6N3XuunZOGv8vbQs07Ldt7btZM+sTEbmHFCqJ/safXPwjIcoWY7HOLeQD0S3HHYFmog9f6GEan7gNm38zlyaXXEvahz8VUGLfkYCPrqcCki/NHwUOqbbW/HSX3jdTtkW+Dfp3fTfOeQGEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660302; c=relaxed/simple;
	bh=JiM3ipnlBJOzX0zcLtp9ixiYB7jD4RiHN2hmztb9BG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE1c2Nnq46Fywd6jiu3HuE7hecZTDIXbmgQDgMxV12jxHgULTvabXBWwjlzE8yW/dE8NrA9PZg3NZubHYeDrIVCitwDtmwRORbZmLaKtOMQeArk7PBlncBE0e9trwgN42M+Dj6nT8EitMFFViUaGGWxalTXgBUgJ1DOre5qCYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBN0+Xgv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1RiVu6Vt2llYHxIz14p3hNB1v2Bo6KqNLmF3dplOT8=;
	b=xBN0+XgvMzEZ0CVS0wiMq+TSAfwuuche1Bos4yWYPX1Tui4h8RXSxjPTErRLvGhdCYqgHW
	DM2gjYat2LC4eZVWnOU0yZ14JQwberQ4wxKRvzyduIgakeP7D7tFGbwE/FVTMn/ZQp7TeB
	2CuDjqJ1RidrsBxK6dAHAxAMERleDos=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 24/26] mm: memcontrol: refactor memcg_reparent_objcgs()
Date: Tue, 28 Oct 2025 21:58:37 +0800
Message-ID: <21f6b42ec2441372bdfb540d2e7e0fef770c0f6c.1761658311.git.zhengqi.arch@bytedance.com>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

Refactor the memcg_reparent_objcgs() to facilitate subsequent reparenting
LRU folios here.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memcontrol.c | 37 +++++++++++++++++++++++++++----------
 mm/vmscan.c     |  1 -
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7969dd93d858a..ee98c9e8fdcea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -206,24 +206,41 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+static void __memcg_reparent_objcgs(struct mem_cgroup *src,
+				    struct mem_cgroup *dst)
 {
 	struct obj_cgroup *objcg, *iter;
-	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
-
-	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
-
-	spin_lock_irq(&objcg_lock);
 
+	objcg = rcu_replace_pointer(src->objcg, NULL, true);
 	/* 1) Ready to reparent active objcg. */
-	list_add(&objcg->list, &memcg->objcg_list);
+	list_add(&objcg->list, &src->objcg_list);
 	/* 2) Reparent active objcg and already reparented objcgs to parent. */
-	list_for_each_entry(iter, &memcg->objcg_list, list)
-		WRITE_ONCE(iter->memcg, parent);
+	list_for_each_entry(iter, &src->objcg_list, list)
+		WRITE_ONCE(iter->memcg, dst);
 	/* 3) Move already reparented objcgs to the parent's list */
-	list_splice(&memcg->objcg_list, &parent->objcg_list);
+	list_splice(&src->objcg_list, &dst->objcg_list);
+}
+
+static void reparent_locks(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_lock_irq(&objcg_lock);
+}
 
+static void reparent_unlocks(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
 	spin_unlock_irq(&objcg_lock);
+}
+
+static void memcg_reparent_objcgs(struct mem_cgroup *src)
+{
+	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
+	struct mem_cgroup *dst = parent_mem_cgroup(src);
+
+	reparent_locks(src, dst);
+
+	__memcg_reparent_objcgs(src, dst);
+
+	reparent_unlocks(src, dst);
 
 	percpu_ref_kill(&objcg->refcnt);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ee7fb96b8aeb..82c4cc6edbca5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2649,7 +2649,6 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			  lruvec_memcg(lruvec));
 }
 
-
 #ifdef CONFIG_MEMCG
 static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
 				enum lru_list lru)
-- 
2.20.1


