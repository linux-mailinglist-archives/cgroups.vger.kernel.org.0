Return-Path: <cgroups+bounces-13246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2DD24026
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264F4308B629
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460D3271E3;
	Thu, 15 Jan 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lm2WJvf6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33223624A4
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473907; cv=none; b=Vt/EzTVRjEGM5p+mfa1hBAULojJcPq5G7fV58M/ROz0+lTmb3WsBtKZ8heU3S8A/BNBVBZ2pxPZFrIAB1CzQxgCmY8t5QnhjFasGyjjGJW7LYpGU8IomyBhWl7yT74F0sL6Y/F1eq+BgPOr71JJTuL6IS0Onh4fzFQxFJxqA0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473907; c=relaxed/simple;
	bh=s95oR5aVdsmGeLaeafLLG4cq5VR4MyR68EWUNAGRCcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKwEBJRaEjfvNBK1iQxUS4WC2fA9BQIdDf4QLPfQhJWaeQxEpI5XoMZ7jKfGD4Al4BHZMUA3gXUVVmObTqiZnrUcSDTr3OyeXNOP6BBYxd3l05oGZFQFTIGm7zrlMf2uvr0ilqWN4ZpLVhzRyUjFfdHeim294CCINbFoIUPtbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lm2WJvf6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768473901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLIFIOyWqYN3PmkXuq0N2mr92XQ1neHYGXezRRaTTrs=;
	b=lm2WJvf6qTegKG7MdxdW+Y5SP8hIXdeQ1TjGe2H1Kwj5kc39uQZrjHtOWQv4e8K3dfT320
	jsRwhPHng6BBn02joaa1i31xS8uucFCisjw1TmbIc3KD00CVJzlRaSon8SsP6nhBRr7aIg
	c9lSCwlvLjxaHCPcVEMvm3aIlnCkc2I=
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
Subject: [PATCH v3 26/30 fix] mm: mglru: do not call update_lru_size() during reparenting
Date: Thu, 15 Jan 2026 18:44:44 +0800
Message-ID: <20260115104444.85986-1-qi.zheng@linux.dev>
In-Reply-To: <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
References: <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Only non-hierarchical lruvec_stats->state_local needs to be reparented,
so handle it in reparent_state_local(), and remove the unreasonable
update_lru_size() call in __lru_gen_reparent_memcg().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 56714f3bc6f88..5e7a32e3cffbc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4544,7 +4544,6 @@ static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec
 				     int zone, int type)
 {
 	struct lru_gen_folio *child_lrugen, *parent_lrugen;
-	enum lru_list lru = type * LRU_INACTIVE_FILE;
 	int i;
 
 	child_lrugen = &child_lruvec->lrugen;
@@ -4553,7 +4552,6 @@ static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec
 	for (i = 0; i < get_nr_gens(child_lruvec, type); i++) {
 		int gen = lru_gen_from_seq(child_lrugen->max_seq - i);
 		long nr_pages = child_lrugen->nr_pages[gen][type][zone];
-		int dst_lru_active = lru_gen_is_active(parent_lruvec, gen) ? LRU_ACTIVE : 0;
 
 		/* Assuming that child pages are colder than parent pages */
 		list_splice_init(&child_lrugen->folios[gen][type][zone],
@@ -4562,8 +4560,6 @@ static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec
 		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
 		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
 			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
-
-		update_lru_size(parent_lruvec, lru + dst_lru_active, zone, nr_pages);
 	}
 }
 
@@ -4575,15 +4571,21 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 		struct lruvec *child_lruvec, *parent_lruvec;
 		int type, zid;
 		struct zone *zone;
+		enum lru_list lru;
 
 		child_lruvec = get_lruvec(memcg, nid);
 		parent_lruvec = get_lruvec(parent, nid);
 
-		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
+		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1)
 			for (type = 0; type < ANON_AND_FILE; type++)
 				__lru_gen_reparent_memcg(child_lruvec, parent_lruvec, zid, type);
-			mem_cgroup_update_lru_size(parent_lruvec, LRU_UNEVICTABLE, zid,
-				mem_cgroup_get_zone_lru_size(child_lruvec, LRU_UNEVICTABLE, zid));
+
+		for_each_lru(lru) {
+			for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
+				unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
+
+				mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
+			}
 		}
 	}
 }
-- 
2.20.1


