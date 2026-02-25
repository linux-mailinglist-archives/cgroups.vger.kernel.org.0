Return-Path: <cgroups+bounces-14335-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BRTL5GrnmntWgQAu9opvQ
	(envelope-from <cgroups+bounces-14335-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:58:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E4193D6F
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69193095575
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8DB30C37A;
	Wed, 25 Feb 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CD5nOqQI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEAE304BDF
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006122; cv=none; b=Cu4yAkckf7VUFCGikR2F4kqUBJcl8Gk4HxDBHcwic7Sx1E6muy07eaC2/3H/C76Iw22FypaIOt7XWFjKEyTbwLWUJ5nYaqdmvh1W8FzbVTfhhOnHnuycKtwpfFCwbFrx6RDpxmHhWbXj2H3H+H3HxqD/ov9qY9B56t4WOLX8L6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006122; c=relaxed/simple;
	bh=q5GNu88ibdKx8MpiuDMplPMbU2D1/ejWOvGMPSbq5qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/CdC72YCqViGNdK6E97mt6RE9Yic+MF8ZeS1fjO7J7gziJo7b0A6utnFNXJYwt49L3M2VScfn4Sfg81OX//MOZCvuc9pN3IIWsFQld0lyfw9fhhCt9kXi4ct5g43VZzXcktVX/fRYkY+1T0XVGFtqolO2aX/ELjGRml/xNwAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CD5nOqQI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772006118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTdOluh/9ylRlwKeMfFMFMRs1I9w1KAVDyJhidoOplQ=;
	b=CD5nOqQI65WZlCilX9JxR763nIPiLXhMzo181x0A+UZvQG539bn3/Bf1vLd4XjyO648g7r
	pDzAtti5pwfaRYRjt5uJsHPiiierKn4tF0OY8MJyMuV2EVhB4GRHO58I90dncYVAtJLaT5
	uT7NLi8UNeviY7GklvqibH74CI9pARI=
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
Subject: [PATCH v5 23/32] mm: do not open-code lruvec lock
Date: Wed, 25 Feb 2026 15:53:06 +0800
Message-ID: <2d0bafe7564e17ece46dfd58197af22ce57017dc.1772005110.git.zhengqi.arch@bytedance.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14335-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linux.dev:email,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:mid,bytedance.com:email]
X-Rspamd-Queue-Id: 3E8E4193D6F
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

Now we have lruvec_unlock(), lruvec_unlock_irq() and
lruvec_unlock_irqrestore(), but no the paired lruvec_lock(),
lruvec_lock_irq() and lruvec_lock_irqsave().

There is currently no use case for lruvec_lock_irqsave(), so only
introduce lruvec_lock_irq(), and change all open-code places to use
this helper function. This looks cleaner and prepares for reparenting
LRU pages, preventing user from missing RCU lock calls due to
open-code lruvec lock.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/memcontrol.h |  5 +++++
 mm/vmscan.c                | 38 +++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0fdfb8044458e..c7c207a830c50 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1499,6 +1499,11 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
 }
 
+static inline void lruvec_lock_irq(struct lruvec *lruvec)
+{
+	spin_lock_irq(&lruvec->lru_lock);
+}
+
 static inline void lruvec_unlock(struct lruvec *lruvec)
 {
 	spin_unlock(&lruvec->lru_lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 024ff870b1a03..08ed278115f70 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2002,7 +2002,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	nr_taken = isolate_lru_folios(nr_to_scan, lruvec, &folio_list,
 				     &nr_scanned, sc, lru);
@@ -2012,7 +2012,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	mod_lruvec_state(lruvec, item, nr_scanned);
 	mod_lruvec_state(lruvec, PGSCAN_ANON + file, nr_scanned);
 
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	if (nr_taken == 0)
 		return 0;
@@ -2029,7 +2029,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	mod_lruvec_state(lruvec, item, nr_reclaimed);
 	mod_lruvec_state(lruvec, PGSTEAL_ANON + file, nr_reclaimed);
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
 					nr_scanned - nr_reclaimed);
 
@@ -2108,7 +2108,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	nr_taken = isolate_lru_folios(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2117,7 +2117,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	mod_lruvec_state(lruvec, PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	while (!list_empty(&l_hold)) {
 		struct folio *folio;
@@ -2173,7 +2173,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
@@ -3794,9 +3794,9 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 		}
 
 		if (walk->batched) {
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec_lock_irq(lruvec);
 			reset_batch_size(walk);
-			spin_unlock_irq(&lruvec->lru_lock);
+			lruvec_unlock_irq(lruvec);
 		}
 
 		cond_resched();
@@ -3956,7 +3956,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	if (seq < READ_ONCE(lrugen->max_seq))
 		return false;
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 
@@ -3971,7 +3971,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 		if (inc_min_seq(lruvec, type, swappiness))
 			continue;
 
-		spin_unlock_irq(&lruvec->lru_lock);
+		lruvec_unlock_irq(lruvec);
 		cond_resched();
 		goto restart;
 	}
@@ -4006,7 +4006,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
 unlock:
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	return success;
 }
@@ -4697,7 +4697,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	scanned = isolate_folios(nr_to_scan, lruvec, sc, swappiness, &type, &list);
 
@@ -4706,7 +4706,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (evictable_min_seq(lrugen->min_seq, swappiness) + MIN_NR_GENS > lrugen->max_seq)
 		scanned = 0;
 
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	if (list_empty(&list))
 		return scanned;
@@ -4744,9 +4744,9 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched) {
 		walk->lruvec = lruvec;
-		spin_lock_irq(&lruvec->lru_lock);
+		lruvec_lock_irq(lruvec);
 		reset_batch_size(walk);
-		spin_unlock_irq(&lruvec->lru_lock);
+		lruvec_unlock_irq(lruvec);
 	}
 
 	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
@@ -5178,7 +5178,7 @@ static void lru_gen_change_state(bool enabled)
 		for_each_node(nid) {
 			struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec_lock_irq(lruvec);
 
 			VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 			VM_WARN_ON_ONCE(!state_is_valid(lruvec));
@@ -5186,12 +5186,12 @@ static void lru_gen_change_state(bool enabled)
 			lruvec->lrugen.enabled = enabled;
 
 			while (!(enabled ? fill_evictable(lruvec) : drain_evictable(lruvec))) {
-				spin_unlock_irq(&lruvec->lru_lock);
+				lruvec_unlock_irq(lruvec);
 				cond_resched();
-				spin_lock_irq(&lruvec->lru_lock);
+				lruvec_lock_irq(lruvec);
 			}
 
-			spin_unlock_irq(&lruvec->lru_lock);
+			lruvec_unlock_irq(lruvec);
 		}
 
 		cond_resched();
-- 
2.20.1


