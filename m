Return-Path: <cgroups+bounces-12414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6FCC6636
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FFE3098A08
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42961343216;
	Wed, 17 Dec 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqyO8smi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC513431F5
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956836; cv=none; b=UzccFVjeD24hIHPF1zLlL4CCNgc7pDh+xGPbXlw3qW9R34GQoDZnJLd7B2LJj8xOQa5cA5aNsEqhxYfWW8w+g91KCa1vk1W8jqoDVfKBqHOTlmkOqkbh/ZiWMZhhVv2zxB5laqHjAYRTu2FWRXPC+H8iXDVZbE1xHfsGyBkiWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956836; c=relaxed/simple;
	bh=d1uvfBYPvgUMKuoz46yjDNePoh2ydg4Ri+wGNDlR2WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ2/vsNFFSZz+orF+//9B6Zd1o34wkGIZNYbY3CXsUog37oOe1tV2OODTTMrjXo0BoHu60BQkFORS88M5zqHZ/PUwKyKl/tYExN78fKla7pubzzk14SEObyEckBm2N5RtyPdyx9g6SCT/QCQulhF1tU7ceTUp3hcEQ2WQlIXh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqyO8smi; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOMfKFXTzfX2R2XpU+f1ml9Q+i3fk14KvQzSfKjMTSY=;
	b=fqyO8smiuddWbVlG0vZAYnu6k2elDEhHFJPXEaCWp6peGVZcY6pMReFkk9h4m3bVD6QPdn
	shz0rtopSn/vAxHqNv0DClGCEw4T5XSRRwgSQh5i2gVr6Kn3qlit2xtndhCGfKu2Siggu+
	Cy42Gx14dN+VV6cgtHLhEVoRabHM4vI=
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
Subject: [PATCH v2 24/28] mm: vmscan: prepare for reparenting traditional LRU folios
Date: Wed, 17 Dec 2025 15:27:48 +0800
Message-ID: <800faf905149ee1e1699d9fd319842550d343f43.1765956026.git.zhengqi.arch@bytedance.com>
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

To reslove the dying memcg issue, we need to reparent LRU folios of child
memcg to its parent memcg. For traditional LRU list, each lruvec of every
memcg comprises four LRU lists. Due to the symmetry of the LRU lists, it
is feasible to transfer the LRU lists from a memcg to its parent memcg
during the reparenting process.

This commit implements the specific function, which will be used during
the reparenting process.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/vmscan.c            | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75ef7c9f9307f..08132012aa8b8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -366,6 +366,10 @@ enum lruvec_flags {
 	LRUVEC_NODE_CONGESTED,
 };
 
+#ifdef CONFIG_MEMCG
+void lru_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst);
+#endif /* CONFIG_MEMCG */
+
 #endif /* !__GENERATING_BOUNDS_H */
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 814498a2c1bd6..5fd0f97c3719c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2648,6 +2648,44 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			  lruvec_memcg(lruvec));
 }
 
+#ifdef CONFIG_MEMCG
+static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
+				enum lru_list lru)
+{
+	int zid;
+	struct mem_cgroup_per_node *mz_src, *mz_dst;
+
+	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
+	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
+
+	if (lru != LRU_UNEVICTABLE)
+		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
+		mz_src->lru_zone_size[zid][lru] = 0;
+	}
+}
+
+void lru_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+
+	for_each_node(nid) {
+		enum lru_list lru;
+		struct lruvec *src_lruvec, *dst_lruvec;
+
+		src_lruvec = mem_cgroup_lruvec(src, NODE_DATA(nid));
+		dst_lruvec = mem_cgroup_lruvec(dst, NODE_DATA(nid));
+		dst_lruvec->anon_cost += src_lruvec->anon_cost;
+		dst_lruvec->file_cost += src_lruvec->file_cost;
+
+		for_each_lru(lru)
+			lruvec_reparent_lru(src_lruvec, dst_lruvec, lru);
+	}
+}
+#endif
+
 #ifdef CONFIG_LRU_GEN
 
 #ifdef CONFIG_LRU_GEN_ENABLED
-- 
2.20.1


