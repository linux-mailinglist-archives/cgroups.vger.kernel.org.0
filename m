Return-Path: <cgroups+bounces-12416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE7CC666D
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C5E311336D
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72F3446D2;
	Wed, 17 Dec 2025 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AXc74V+X"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123D344058
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956859; cv=none; b=O8K87GxhFZ/Vc82oUhivzgHap14HjYOgEoz0JDx9aJLu83jM5WpXonZgkZN1WljBTpOdA7q9I2/KFiu6JRzUbYzdfEvrOq7yIW4gzuperDnSWz6sQYkG4NMjVCeEJB+3DAVOqnwe5taRV9lkLON5kEMWTIpTEgnn3TXzKWqUNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956859; c=relaxed/simple;
	bh=ApGhz8PrqdtnYhglElt3PQ8WpfkLuxmUgCZ4HCQcF7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AreATwyJx+55DvOiBC2949CFB2O+D/Nlrc2dH+ppYj1SoLmXF5S6ez2nY9fZcTIRWAbFfDq865AsfLmIlFKHHNIoGd5kih1FBuxXDRwPeAVDleIOGbSfa/2ZCWNKf9YpQY8DvDX7ZlMUx6Ah4v1T6e81Fh8MxjcH9ZleYzMQlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AXc74V+X; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV6q27Ww1Pi8gdjbSvPXKtgD9Ua4KYVSU4hxepzaQ/c=;
	b=AXc74V+X5J85APZtey4ZYmzvZIJ2n7TB8CPnOTzJ7cjlFcn2vZ3x3ewYMJKyeAZsbiEzDu
	FKOiBmq0kxoybbzgvggqr2RteHqX3hID9EFLyHUtckL6onKDbRzk9Ec261fXIQOpz1aFq2
	eiGoRqCmHtDMmXsNBl3TymksjA3OhxA=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 26/28] mm: memcontrol: refactor memcg_reparent_objcgs()
Date: Wed, 17 Dec 2025 15:27:50 +0800
Message-ID: <8e4dff3139390fc0f18546a770d2b35c9c148b8b.1765956026.git.zhengqi.arch@bytedance.com>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

Refactor the memcg_reparent_objcgs() to facilitate subsequent reparenting
LRU folios here.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memcontrol.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 930dacd6ce31a..3daa99a0c65fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -206,24 +206,41 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+static inline void __memcg_reparent_objcgs(struct mem_cgroup *src,
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
+static inline void reparent_locks(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_lock_irq(&objcg_lock);
+}
 
+static inline void reparent_unlocks(struct mem_cgroup *src, struct mem_cgroup *dst)
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
-- 
2.20.1


