Return-Path: <cgroups+bounces-11267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A701C15185
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16193A3CC0
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB934166C;
	Tue, 28 Oct 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WK8tb2Ee"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE821578F
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660286; cv=none; b=L/1KBy8YgtMMSezjK58fA1TpDk3uwlaGhvrq2vD629Wj5QxgLignUERJHFqXLJJEacAkrNSn/zZe9bfOo9BsOMqPqdBQXNzNquHVbr3JiBU1BgmddKJTisUtDJcKJ+BabJQvAivS4WO/7u5NwAyiWj1isPYX6+kjbTabrolmkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660286; c=relaxed/simple;
	bh=tQPVFYoqRrmI1p/WiQPQYEXxJTCm73j5VaCKJSaWw/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPBdT252PQFSCUmQfAYKcCgEL20rtJgR8DxBfshblR1inoFoKqV/ubFiVgpM8zKXs/qu+qBynK3Wo+QYED8g+uw/mrNvGS/sppiwpmVkCnxj32840KWHFCOobf+h736t1ClAik2VH0TQpPBpC3myoNGgUgJQib+1amJma+5iJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WK8tb2Ee; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f58KJTzXSs4X+PWy8zQk6jO+YawoCWN3pSg57esT6X0=;
	b=WK8tb2EePZkDDXUBHA8X88Oky6gXYUGXPse40fNXgFJHtOyOpwiA5y2uY/2VpOK8KvPNgg
	VlXvf/E84wkSoXZBGSZplP19r6Ar3cyL356W88MS4D4kSi6MltL6XLjkKUacyXhIf+LeFQ
	PdHFCQeViZJqPv2MfDtugYoYaxGFSEE=
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
Subject: [PATCH v1 22/26] mm: vmscan: prepare for reparenting traditional LRU folios
Date: Tue, 28 Oct 2025 21:58:35 +0800
Message-ID: <77c64e29b70bad6ca303e0e591624f9cdf2a750b.1761658311.git.zhengqi.arch@bytedance.com>
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

To reslove the dying memcg issue, we need to reparent LRU folios of child
memcg to its parent memcg. For traditional LRU list, each lruvec of every
memcg comprises four LRU lists. Due to the symmetry of the LRU lists, it
is feasible to transfer the LRU lists from a memcg to its parent memcg
during the reparenting process.

This commit implements the specific function, which will be used during
the reparenting process.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/vmscan.c            | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4398e027f450e..0d8776e5b6747 100644
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
index 676e6270e5b45..7aa8e1472d10d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2649,6 +2649,45 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
 			  lruvec_memcg(lruvec));
 }
 
+
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


