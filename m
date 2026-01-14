Return-Path: <cgroups+bounces-13203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDED1E7E9
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BCA309AC12
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA6396B7F;
	Wed, 14 Jan 2026 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q96h2Xw2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE138A705
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390579; cv=none; b=JbG64m87OxQkfa7YGebIWicWhx11YX6De2BxpZL1SZXPtDBwI+5LD3MEL81y6yjuoRTZf2ugSiek4uFf8SxpHyFTmtuQZPLwDqre8mXPvsOR+wD24AjNl1gLORqV5LcuYdG1ntedNxSerlnEFwE8XHfAuVfWeiu0TlE9cs9GN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390579; c=relaxed/simple;
	bh=0XbaueQOyVVuQAkOOpetBOVaZX5zNrMw/q2bAD17MmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9OUVvcT+FlXv5MIXj04YWAWojWNmxtIHLWstmVnfesXp5NkrWbsiwt7TPmBdpqdsWxznCKfCWNeJ9r7mAx1ni7F/oHW2oE8mex37lFALHYFVSJIqGVTFVHZTXubXSdM8kNGjVToePXtiXdLvOfxoPX3NckblaPNpAfZC6nJVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q96h2Xw2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCn71o4CGVG6ZCimcBHoYvDX6iNx84ttSjck4drbD9c=;
	b=Q96h2Xw2FW89SLH/7JvVfXdzJRpn9+6lVcUlq55C3OXjGlnp637HPE+22QxBSQ77rM7yha
	3Sw67e034q/9edHVNRxG3QNikHhUw4iSAMurkyZnCcIiTfUHRWAE1njcGzgltkUpE6TFfq
	cGAVi5cmgo6AsI55+TYXghSBv9ZzWr8=
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
	yosry.ahmed@linux.dev,
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
Subject: [PATCH v3 27/30] mm: memcontrol: refactor memcg_reparent_objcgs()
Date: Wed, 14 Jan 2026 19:32:54 +0800
Message-ID: <843e9537bf6b99cc7f19744a6f53b92338c96bfe.1768389889.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a1573600d4188..70583394f421f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -208,15 +208,12 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memcg,
+							 struct mem_cgroup *parent)
 {
 	struct obj_cgroup *objcg, *iter;
-	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
-
-	spin_lock_irq(&objcg_lock);
-
 	/* 1) Ready to reparent active objcg. */
 	list_add(&objcg->list, &memcg->objcg_list);
 	/* 2) Reparent active objcg and already reparented objcgs to parent. */
@@ -225,7 +222,29 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
+	return objcg;
+}
+
+static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+	spin_lock_irq(&objcg_lock);
+}
+
+static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
 	spin_unlock_irq(&objcg_lock);
+}
+
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+
+	reparent_locks(memcg, parent);
+
+	objcg = __memcg_reparent_objcgs(memcg, parent);
+
+	reparent_unlocks(memcg, parent);
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.20.1


