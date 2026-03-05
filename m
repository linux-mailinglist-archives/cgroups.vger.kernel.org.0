Return-Path: <cgroups+bounces-14661-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHFmCwdyqWnH7AAAu9opvQ
	(envelope-from <cgroups+bounces-14661-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:07:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4428B2114AB
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 551BE3082F10
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BA39E6C4;
	Thu,  5 Mar 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3sQKY7Z"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD639E6C9
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711919; cv=none; b=qdKQAKIfR6i6qCJb3l3IzeryjgsAjSKCHEmGjqughpPXA+NHC0REZOqTPkQRd9lUy0tQZAtuTuvXuBZbj1hVBNBN5zbhOFNDcoTszLVa1UjkfAUK1ttk9u2oH5RGuGuOqCDVU3iH+14lslVAc1A5C50fHlPE47DFa6m9Yvwz1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711919; c=relaxed/simple;
	bh=H1jeheqKqppr6y+XHcdS73CV2RT+AIZwbgMzziim2bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oImjI7JLDyReG01B1XN0PLZI+F0xuYIlFH10s/ScY1LWOdjG3oluMZOWpa19awcZUSw4vK92GnqfRojFPXEDdE88MbT8IkPp3Y+PTeuD2RIjeNhvaMphxnhyZtYu5GHkOOXxkWP9Ka3DZT03yQQmnYIrm2AI+/RR4K7wf6ZDh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3sQKY7Z; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772711914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usUS7HG6u84XSS4hIIZlOhBunMjn2SlwVU6f8o31p/g=;
	b=h3sQKY7ZYBCeKu/SV7widnxjYzrIiMVtKJE3hixVtQhv9zpuf5kpJtq2SQX6egs833WiZJ
	6270SI5L7rxFuGG+Q7w27N0RI8tLPlrU9+fpfgFRmF3CxaQcpCJnaAsBvOi/Nk/fhET4zH
	gOHt1l7Qs7IVBzi6unUAdGIE8RAG9eI=
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
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 25/33] mm: vmscan: prepare for reparenting traditional LRU folios
Date: Thu,  5 Mar 2026 19:52:43 +0800
Message-ID: <a92d217a9fc82bd0c401210204a095caaf615b1c.1772711148.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772711148.git.zhengqi.arch@bytedance.com>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4428B2114AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14661-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,bytedance.com:mid,bytedance.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,oracle.com:email]
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

To resolve the dying memcg issue, we need to reparent LRU folios of child
memcg to its parent memcg. For traditional LRU list, each lruvec of every
memcg comprises four LRU lists. Due to the symmetry of the LRU lists, it
is feasible to transfer the LRU lists from a memcg to its parent memcg
during the reparenting process.

This commit implements the specific function, which will be used during
the reparenting process.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/swap.h | 21 +++++++++++++++++++++
 mm/swap.c            | 33 +++++++++++++++++++++++++++++++++
 mm/vmscan.c          | 19 -------------------
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 00ce4c5e6e714..64af9462ae8af 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -548,6 +548,8 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 
 	return READ_ONCE(memcg->swappiness);
 }
+
+void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid);
 #else
 static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 {
@@ -612,5 +614,24 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+/* for_each_managed_zone_pgdat - helper macro to iterate over all managed zones in a pgdat up to
+ * and including the specified highidx
+ * @zone: The current zone in the iterator
+ * @pgdat: The pgdat which node_zones are being iterated
+ * @idx: The index variable
+ * @highidx: The index of the highest zone to return
+ *
+ * This macro iterates through all managed zones up to and including the specified highidx.
+ * The zone iterator enters an invalid state after macro call and must be reinitialized
+ * before it can be used again.
+ */
+#define for_each_managed_zone_pgdat(zone, pgdat, idx, highidx)	\
+	for ((idx) = 0, (zone) = (pgdat)->node_zones;		\
+	    (idx) <= (highidx);					\
+	    (idx)++, (zone)++)					\
+		if (!managed_zone(zone))			\
+			continue;				\
+		else
+
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/swap.c b/mm/swap.c
index d5bfe6a76ca45..e255be6a0f34f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1090,6 +1090,39 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
+#ifdef CONFIG_MEMCG
+static void lruvec_reparent_lru(struct lruvec *child_lruvec,
+				struct lruvec *parent_lruvec,
+				enum lru_list lru, int nid)
+{
+	int zid;
+	struct zone *zone;
+
+	if (lru != LRU_UNEVICTABLE)
+		list_splice_tail_init(&child_lruvec->lists[lru], &parent_lruvec->lists[lru]);
+
+	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
+		unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
+
+		mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
+	}
+}
+
+void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid)
+{
+	enum lru_list lru;
+	struct lruvec *child_lruvec, *parent_lruvec;
+
+	child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+	parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
+	parent_lruvec->anon_cost += child_lruvec->anon_cost;
+	parent_lruvec->file_cost += child_lruvec->file_cost;
+
+	for_each_lru(lru)
+		lruvec_reparent_lru(child_lruvec, parent_lruvec, lru, nid);
+}
+#endif
+
 static const struct ctl_table swap_sysctl_table[] = {
 	{
 		.procname	= "page-cluster",
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 08ed278115f70..606b4ecf77ef3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -269,25 +269,6 @@ static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
 }
 #endif
 
-/* for_each_managed_zone_pgdat - helper macro to iterate over all managed zones in a pgdat up to
- * and including the specified highidx
- * @zone: The current zone in the iterator
- * @pgdat: The pgdat which node_zones are being iterated
- * @idx: The index variable
- * @highidx: The index of the highest zone to return
- *
- * This macro iterates through all managed zones up to and including the specified highidx.
- * The zone iterator enters an invalid state after macro call and must be reinitialized
- * before it can be used again.
- */
-#define for_each_managed_zone_pgdat(zone, pgdat, idx, highidx)	\
-	for ((idx) = 0, (zone) = (pgdat)->node_zones;		\
-	    (idx) <= (highidx);					\
-	    (idx)++, (zone)++)					\
-		if (!managed_zone(zone))			\
-			continue;				\
-		else
-
 static void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
 {
-- 
2.20.1


