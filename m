Return-Path: <cgroups+bounces-11268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26866C1516A
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 606BC4F46DF
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82E338F56;
	Tue, 28 Oct 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVxvyEdK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6493396E1
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660294; cv=none; b=SVFjlR18PmSAU/o3Lubmg8L1R5gHhWyCa6mZe8iY0ZvTKzltTQ2ht2uhI9Tv1LFjayc3nwHrK+vi3rrcXouIk4AgKiWRJ1OFAnz3lvDwGuiOfC4g25Lf/wU2/lIS2dKhvGD4eAdKWAzSa2QRqu0Lz5T//OddmyQ/qcgj/tteeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660294; c=relaxed/simple;
	bh=EKDh1bG6TFboUMyykCUwFenrp6Gkt0w8MiIp22DFWIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqZk6w0dzDcmcfK+mSzs+LubcArkZ3H4mYgDwtrP1k3ejxM08cSILqUJwHIrWyKFIX37j/pcHuDzWicGN0NIYsEnvqvaLXkDxW+4Ri6T/iNQxADi5BoiePBteKCrW2qk39DF4XG95duiwZ8DT/4WZfNzi6fBTGaH4ujFflnCfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVxvyEdK; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NlFh6JZBSK01bz7xFAPu6gc4AMfcAw/edRnb/5hy/w=;
	b=rVxvyEdKqZsKYbizlGoj5w1+xNdO0odOM+rCoiyzALnMIy7ike96ihWGIzWYiy4tbbGDIM
	MFwF4TLRfWcQFpmKN7ZvRLWlEEuHXF3FEA3g8mCAQJ9g4p+yLKsbKZDNT459dRFG2IZcSB
	B8MqCIlQiBRG+tgkrW4RswTqYCqY1Y8=
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
Subject: [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
Date: Tue, 28 Oct 2025 21:58:36 +0800
Message-ID: <cdcedd284f5706c557bb6f53858b8c2ac2815ecb.1761658311.git.zhengqi.arch@bytedance.com>
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

Similar to traditional LRU folios, in order to solve the dying memcg
problem, we also need to reparenting MGLRU folios to the parent memcg when
memcg offline.

However, there are the following challenges:

1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
   number of generations of the parent and child memcg may be different,
   so we cannot simply transfer MGLRU folios in the child memcg to the
   parent memcg as we did for traditional LRU folios.
2. The generation information is stored in folio->flags, but we cannot
   traverse these folios while holding the lru lock, otherwise it may
   cause softlockup.
3. In walk_update_folio(), the gen of folio and corresponding lru size
   may be updated, but the folio is not immediately moved to the
   corresponding lru list. Therefore, there may be folios of different
   generations on an LRU list.
4. In lru_gen_del_folio(), the generation to which the folio belongs is
   found based on the generation information in folio->flags, and the
   corresponding LRU size will be updated. Therefore, we need to update
   the lru size correctly during reparenting, otherwise the lru size may
   be updated incorrectly in lru_gen_del_folio().

Finally, this patch chose a compromise method, which is to splice the lru
list in the child memcg to the lru list of the same generation in the
parent memcg during reparenting. And in order to ensure that the parent
memcg has the same generation, we need to increase the generations in the
parent memcg to the MAX_NR_GENS before reparenting.

Of course, the same generation has different meanings in the parent and
child memcg, this will cause confusion in the hot and cold information of
folios. But other than that, this method is simple enough, the lru size
is correct, and there is no need to consider some concurrency issues (such
as lru_gen_del_folio()).

To prepare for the above work, this commit implements the specific
functions, which will be used during reparenting.

Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Suggested-by: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mmzone.h | 16 ++++++++
 mm/vmscan.c            | 86 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d8776e5b6747..0a71bf015d12b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -628,6 +628,9 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg);
 void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
 void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
+void max_lru_gen_memcg(struct mem_cgroup *memcg);
+bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg);
+void lru_gen_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst);
 
 #else /* !CONFIG_LRU_GEN */
 
@@ -668,6 +671,19 @@ static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 {
 }
 
+static inline void max_lru_gen_memcg(struct mem_cgroup *memcg)
+{
+}
+
+static inline bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
+static inline void lru_gen_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 struct lruvec {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7aa8e1472d10d..3ee7fb96b8aeb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4468,6 +4468,92 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
 }
 
+bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg)
+{
+	int nid;
+
+	for_each_node(nid) {
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		int type;
+
+		for (type = 0; type < ANON_AND_FILE; type++) {
+			if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * We need to ensure that the folios of child memcg can be reparented to the
+ * same gen of the parent memcg, so the gens of the parent memcg needed be
+ * incremented to the MAX_NR_GENS before reparenting.
+ */
+void max_lru_gen_memcg(struct mem_cgroup *memcg)
+{
+	int nid;
+
+	for_each_node(nid) {
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		int type;
+
+		for (type = 0; type < ANON_AND_FILE; type++) {
+			while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
+				DEFINE_MAX_SEQ(lruvec);
+
+				inc_max_seq(lruvec, max_seq, mem_cgroup_swappiness(memcg));
+				cond_resched();
+			}
+		}
+	}
+}
+
+static void __lru_gen_reparent_memcg(struct lruvec *src_lruvec, struct lruvec *dst_lruvec,
+				     int zone, int type)
+{
+	struct lru_gen_folio *src_lrugen, *dst_lrugen;
+	enum lru_list lru = type * LRU_INACTIVE_FILE;
+	int i;
+
+	src_lrugen = &src_lruvec->lrugen;
+	dst_lrugen = &dst_lruvec->lrugen;
+
+	for (i = 0; i < get_nr_gens(src_lruvec, type); i++) {
+		int gen = lru_gen_from_seq(src_lrugen->max_seq - i);
+		int nr_pages = src_lrugen->nr_pages[gen][type][zone];
+		int src_lru_active = lru_gen_is_active(src_lruvec, gen) ? LRU_ACTIVE : 0;
+		int dst_lru_active = lru_gen_is_active(dst_lruvec, gen) ? LRU_ACTIVE : 0;
+
+		list_splice_tail_init(&src_lrugen->folios[gen][type][zone],
+				      &dst_lrugen->folios[gen][type][zone]);
+
+		WRITE_ONCE(src_lrugen->nr_pages[gen][type][zone], 0);
+		WRITE_ONCE(dst_lrugen->nr_pages[gen][type][zone],
+			   dst_lrugen->nr_pages[gen][type][zone] + nr_pages);
+
+		__update_lru_size(src_lruvec, lru + src_lru_active, zone, -nr_pages);
+		__update_lru_size(dst_lruvec, lru + dst_lru_active, zone, nr_pages);
+	}
+}
+
+void lru_gen_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+
+	for_each_node(nid) {
+		struct lruvec *src_lruvec, *dst_lruvec;
+		int type, zone;
+
+		src_lruvec = get_lruvec(src, nid);
+		dst_lruvec = get_lruvec(dst, nid);
+
+		for (zone = 0; zone < MAX_NR_ZONES; zone++)
+			for (type = 0; type < ANON_AND_FILE; type++)
+				__lru_gen_reparent_memcg(src_lruvec, dst_lruvec, zone, type);
+	}
+}
+
 #endif /* CONFIG_MEMCG */
 
 /******************************************************************************
-- 
2.20.1


