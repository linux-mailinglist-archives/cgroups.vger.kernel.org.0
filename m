Return-Path: <cgroups+bounces-14659-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIHdEJNxqWnH7AAAu9opvQ
	(envelope-from <cgroups+bounces-14659-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:05:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 622552113AC
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10DC13051B7E
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E06339C639;
	Thu,  5 Mar 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ujqCsOj+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B4340D91
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711894; cv=none; b=qCu9Mg3Gpf0mkFBsfkdXWD+lMS2ebg7tWAlo+ycslc418nySAAD9VjA5CF/L8WDbwIDXVg96Mo5G5d/FllrAOJL1hbpdVOfUWOE1Cq1qP9opl8+01D8k3TybbLIbNo8rxTPINDWBcznCVcgtABYbg2PrK6YlGVuqlCyIkwiID+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711894; c=relaxed/simple;
	bh=q5GNu88ibdKx8MpiuDMplPMbU2D1/ejWOvGMPSbq5qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQcD532qoaVeqj1LauZQYKnW8GygM+xhGk7uW8jp4pxY4Hyn8/axQp+V95GIHHYp/hCc1men0BAgUonK3hV3nPR1+9morVzix7SFyBwgc4UieGmydhSmaY7dVucqwXDeTY7DeZtw8RxlBv64ZHp1Q9byHJdnW7VWkiLUh5iBA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ujqCsOj+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772711890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTdOluh/9ylRlwKeMfFMFMRs1I9w1KAVDyJhidoOplQ=;
	b=ujqCsOj+84waaPYa2xYnno8KBb/Qm+dSd/c6JqZOkI6RM+gFwqp6n2JuRJqkK1rcXXat4H
	XjgzQd8S7LX3qY7gbhceVX88qiX6+EqxKpZnCPnBj5ocrSlYGlx22GDbCpMj1ZDk1S27TU
	fDyhVT+ARwZLcmddSa0x3SdCYBNT9VQ=
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
Subject: [PATCH v6 23/33] mm: do not open-code lruvec lock
Date: Thu,  5 Mar 2026 19:52:41 +0800
Message-ID: <2d0bafe7564e17ece46dfd58197af22ce57017dc.1772711148.git.zhengqi.arch@bytedance.com>
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
X-Rspamd-Queue-Id: 622552113AC
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
	TAGGED_FROM(0.00)[bounces-14659-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,bytedance.com:mid,bytedance.com:email,oracle.com:email]
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


