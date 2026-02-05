Return-Path: <cgroups+bounces-13707-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHlzHYdhhGng2gMAu9opvQ
	(envelope-from <cgroups+bounces-13707-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:23:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EADF0981
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B71309B50A
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A1395247;
	Thu,  5 Feb 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ge7ayrB/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF638F94B
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282268; cv=none; b=gkWwAatGO37P2+kQVWWo+3TQHIGfVD/9ABA5GH1RC8OEGvuidBU075iYSNx77iU2D+xOXcxra0Tjomj56Fv5tzQFcVtLja76nEFyHhTvBH7LEu5vTbBXle7fdFP7cLnSZXpdyEKyKlkTNgXbbK11QhnaY46tawUB2t8HmUr8IOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282268; c=relaxed/simple;
	bh=fuqNF5h8gQBIQ9SkLIuF6VJ89PP8j4UIpZXCj72QQRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2s0cunULUtpi5baUXGBwwNJm8y6TNnVrKBrdo3aa+Kl3+/1unncTk9dUKozDLnEycYdfj5d52vjpjL+wuHqCGn8qzOvvBVluhX0J0TWmOR04kHYU4WT66T9ArV2lQR8/u9jrte6D6sHOpg65PjSKeo85Sht4h5ifYHeLqna1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ge7ayrB/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770282266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls+hag+nayM3jVEUHM7mMc/ZdZhfxjGBqG8YziQOeV0=;
	b=ge7ayrB/6XH5mXU0e0ui+Q+ALLtpaCYFheRfONVoZGF1Dts/2ae2rBNbgmYJUMGfTxq+WE
	zyvmBk3l8vjp2AsYA2kWMpu27/Bl/esjeTWjb9g9IKeYbgzJ4+br3wEdWxQG5NfbvRkc4c
	Uf7uIU+IORKfBbCi3dkcufr7hDlPdEM=
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
	bhe@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 23/31] mm: do not open-code lruvec lock
Date: Thu,  5 Feb 2026 17:01:42 +0800
Message-ID: <679b1c28f5ee8f40911195d7984b287c5da39e05.1770279888.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1770279888.git.zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13707-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,bytedance.com:mid,bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim]
X-Rspamd-Queue-Id: C8EADF0981
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
index f1556759d0d3f..4b6f20dc694ba 100644
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
index 6a7eacd39bc5f..f904231e33ec0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2003,7 +2003,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	nr_taken = isolate_lru_folios(nr_to_scan, lruvec, &folio_list,
 				     &nr_scanned, sc, lru);
@@ -2015,7 +2015,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
 
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	if (nr_taken == 0)
 		return 0;
@@ -2034,7 +2034,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
 					nr_scanned - nr_reclaimed);
 
@@ -2113,7 +2113,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	lru_add_drain();
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	nr_taken = isolate_lru_folios(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
@@ -2124,7 +2124,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 		__count_vm_events(PGREFILL, nr_scanned);
 	count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	while (!list_empty(&l_hold)) {
 		struct folio *folio;
@@ -2180,7 +2180,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
@@ -3801,9 +3801,9 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 		}
 
 		if (walk->batched) {
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec_lock_irq(lruvec);
 			reset_batch_size(walk);
-			spin_unlock_irq(&lruvec->lru_lock);
+			lruvec_unlock_irq(lruvec);
 		}
 
 		cond_resched();
@@ -3962,7 +3962,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	if (seq < READ_ONCE(lrugen->max_seq))
 		return false;
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 
@@ -3977,7 +3977,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 		if (inc_min_seq(lruvec, type, swappiness))
 			continue;
 
-		spin_unlock_irq(&lruvec->lru_lock);
+		lruvec_unlock_irq(lruvec);
 		cond_resched();
 		goto restart;
 	}
@@ -4012,7 +4012,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
 unlock:
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	return success;
 }
@@ -4708,7 +4708,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	spin_lock_irq(&lruvec->lru_lock);
+	lruvec_lock_irq(lruvec);
 
 	scanned = isolate_folios(nr_to_scan, lruvec, sc, swappiness, &type, &list);
 
@@ -4717,7 +4717,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (evictable_min_seq(lrugen->min_seq, swappiness) + MIN_NR_GENS > lrugen->max_seq)
 		scanned = 0;
 
-	spin_unlock_irq(&lruvec->lru_lock);
+	lruvec_unlock_irq(lruvec);
 
 	if (list_empty(&list))
 		return scanned;
@@ -4755,9 +4755,9 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
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
@@ -5195,7 +5195,7 @@ static void lru_gen_change_state(bool enabled)
 		for_each_node(nid) {
 			struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec_lock_irq(lruvec);
 
 			VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 			VM_WARN_ON_ONCE(!state_is_valid(lruvec));
@@ -5203,12 +5203,12 @@ static void lru_gen_change_state(bool enabled)
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


