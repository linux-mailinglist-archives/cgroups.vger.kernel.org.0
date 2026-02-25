Return-Path: <cgroups+bounces-14338-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMTvEQ+rnmntWgQAu9opvQ
	(envelope-from <cgroups+bounces-14338-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:55:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE70193CE1
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D240E3023D5C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763F530C62B;
	Wed, 25 Feb 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZeOMM2O6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183930C37A
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006150; cv=none; b=YwmlocI31uPp9XNgpfouM72wEAW66ZnubiUDJ2SfJlYSw3KEuA/J4rYhrMu4T3RIvnQaSiGKMUOzWFM/lh5Sm5zEs5chRsMjGwZlEZf+1/DYyCZ4xpAPHgUaDVfyE1oq7Oov3CZ0LA7CJuZGprubd+SYsun3RPheEziwYQoHYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006150; c=relaxed/simple;
	bh=qBkqsgTOCMLemM85WeDRnLHxP4I3vGwJ576cBtjYN9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPNoSGWpzcIquS240072nayQG1Idq+tFXGvcFhuLUk4y8hmnzfDjE769r4/rYIDQE0ceJMiwPgCMETLKPpMrApGKGxBHmcCLvs27L5RlbK+wGGSaM9QacbrcBH1A3xduRJA3vzcMVQdZVdZLKKMkPaPHWV6Qm0mNIN/ZIGxLCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZeOMM2O6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772006146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNVJ4KS5apbdFZdhuZeNuYa2gU+wA/pVS6ou2uf08Uw=;
	b=ZeOMM2O6lffKGpMbd5vY044IPm5WaXE3DeSbB5bI0T3EFE9Uiygw78c+QwB8NYIV/J5AI3
	eqyc9DJIINYh94Fv0kW6mdRf1/ryXYIRFCxVdXed03cSsmMywm48PuSxTy01rBTo0pRSJF
	Z59B6tdVmMhzkjlJF/6m8HbYFzxRZqs=
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
Subject: [PATCH v5 26/32] mm: vmscan: prepare for reparenting MGLRU folios
Date: Wed, 25 Feb 2026 15:53:09 +0800
Message-ID: <e75050354cdbc42221a04f7cf133292b61105548.1772005110.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772005110.git.zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14338-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,bytedance.com:mid,bytedance.com:email,oracle.com:email]
X-Rspamd-Queue-Id: DFE70193CE1
X-Rspamd-Action: no action

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
Acked-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/mmzone.h |  17 +++++
 mm/vmscan.c            | 142 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 546bca95ca40c..e7a8cd41619b2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -637,6 +637,9 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg);
 void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
 void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
+void max_lru_gen_memcg(struct mem_cgroup *memcg, int nid);
+bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg, int nid);
+void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid);
 
 #else /* !CONFIG_LRU_GEN */
 
@@ -677,6 +680,20 @@ static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 {
 }
 
+static inline void max_lru_gen_memcg(struct mem_cgroup *memcg, int nid)
+{
+}
+
+static inline bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg, int nid)
+{
+	return true;
+}
+
+static inline
+void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid)
+{
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 struct lruvec {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 606b4ecf77ef3..0fb81fb7985e2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4408,6 +4408,148 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
 }
 
+bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg, int nid)
+{
+	struct lruvec *lruvec = get_lruvec(memcg, nid);
+	int type;
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
+			return false;
+	}
+
+	return true;
+}
+
+static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
+				      struct lruvec *lruvec)
+{
+	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
+	int swappiness = mem_cgroup_swappiness(memcg);
+	DEFINE_MAX_SEQ(lruvec);
+	bool success = false;
+
+	/*
+	 * We are not iterating the mm_list here, updating mm_state->seq is just
+	 * to make mm walkers work properly.
+	 */
+	if (mm_state) {
+		spin_lock(&mm_list->lock);
+		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
+		if (max_seq > mm_state->seq) {
+			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
+			success = true;
+		}
+		spin_unlock(&mm_list->lock);
+	} else {
+		success = true;
+	}
+
+	if (success)
+		inc_max_seq(lruvec, max_seq, swappiness);
+}
+
+/*
+ * We need to ensure that the folios of child memcg can be reparented to the
+ * same gen of the parent memcg, so the gens of the parent memcg needed be
+ * incremented to the MAX_NR_GENS before reparenting.
+ */
+void max_lru_gen_memcg(struct mem_cgroup *memcg, int nid)
+{
+	struct lruvec *lruvec = get_lruvec(memcg, nid);
+	int type;
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
+			try_to_inc_max_seq_nowalk(memcg, lruvec);
+			cond_resched();
+		}
+	}
+}
+
+/*
+ * Compared to traditional LRU, MGLRU faces the following challenges:
+ *
+ * 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
+ *    number of generations of the parent and child memcg may be different,
+ *    so we cannot simply transfer MGLRU folios in the child memcg to the
+ *    parent memcg as we did for traditional LRU folios.
+ * 2. The generation information is stored in folio->flags, but we cannot
+ *    traverse these folios while holding the lru lock, otherwise it may
+ *    cause softlockup.
+ * 3. In walk_update_folio(), the gen of folio and corresponding lru size
+ *    may be updated, but the folio is not immediately moved to the
+ *    corresponding lru list. Therefore, there may be folios of different
+ *    generations on an LRU list.
+ * 4. In lru_gen_del_folio(), the generation to which the folio belongs is
+ *    found based on the generation information in folio->flags, and the
+ *    corresponding LRU size will be updated. Therefore, we need to update
+ *    the lru size correctly during reparenting, otherwise the lru size may
+ *    be updated incorrectly in lru_gen_del_folio().
+ *
+ * Finally, we choose a compromise method, which is to splice the lru list in
+ * the child memcg to the lru list of the same generation in the parent memcg
+ * during reparenting.
+ *
+ * The same generation has different meanings in the parent and child memcg,
+ * so this compromise method will cause the LRU inversion problem. But as the
+ * system runs, this problem will be fixed automatically.
+ */
+static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec *parent_lruvec,
+				     int zone, int type)
+{
+	struct lru_gen_folio *child_lrugen, *parent_lrugen;
+	enum lru_list lru = type * LRU_INACTIVE_FILE;
+	int i;
+
+	child_lrugen = &child_lruvec->lrugen;
+	parent_lrugen = &parent_lruvec->lrugen;
+
+	for (i = 0; i < get_nr_gens(child_lruvec, type); i++) {
+		int gen = lru_gen_from_seq(child_lrugen->max_seq - i);
+		long nr_pages = child_lrugen->nr_pages[gen][type][zone];
+		int child_lru_active = lru_gen_is_active(child_lruvec, gen) ? LRU_ACTIVE : 0;
+		int parent_lru_active = lru_gen_is_active(parent_lruvec, gen) ? LRU_ACTIVE : 0;
+
+		/* Assuming that child pages are colder than parent pages */
+		list_splice_init(&child_lrugen->folios[gen][type][zone],
+				 &parent_lrugen->folios[gen][type][zone]);
+
+		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
+		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
+			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
+
+		if (lru_gen_is_active(child_lruvec, gen) != lru_gen_is_active(parent_lruvec, gen)) {
+			__update_lru_size(child_lruvec, lru + child_lru_active, zone, -nr_pages);
+			__update_lru_size(parent_lruvec, lru + parent_lru_active, zone, nr_pages);
+		}
+	}
+}
+
+void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid)
+{
+	struct lruvec *child_lruvec, *parent_lruvec;
+	int type, zid;
+	struct zone *zone;
+	enum lru_list lru;
+
+	child_lruvec = get_lruvec(memcg, nid);
+	parent_lruvec = get_lruvec(parent, nid);
+
+	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1)
+		for (type = 0; type < ANON_AND_FILE; type++)
+			__lru_gen_reparent_memcg(child_lruvec, parent_lruvec, zid, type);
+
+	for_each_lru(lru) {
+		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
+			unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
+
+			mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
+		}
+	}
+}
+
 #endif /* CONFIG_MEMCG */
 
 /******************************************************************************
-- 
2.20.1


