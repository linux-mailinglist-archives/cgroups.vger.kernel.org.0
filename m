Return-Path: <cgroups+bounces-17329-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7r5VEOxuPmogGAkAu9opvQ
	(envelope-from <cgroups+bounces-17329-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 14:22:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9156CCEFF
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 14:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=H9G0z0kK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17329-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17329-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6083A300D447
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63C3F44C8;
	Fri, 26 Jun 2026 12:20:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BD3DCD9C
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 12:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476437; cv=none; b=pksedmvXlvJMDuuRVMkoBzJz1tvy1m8redn86/J2NtQ8d4qP5DUTKJPuD1YeDxJHc5HrtapmMqWE5yRrs05s3ycmJCYbHdCgSvm9tiuIPIsrfwrlMnFINRapvmxaYIXpFsbaXsKGrH7FKcxS5KqS65f+6S0NrQzIp03+5mzFn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476437; c=relaxed/simple;
	bh=CHUxhB4oTwoW9nv3x9KNYImaCjfhnbnFHEqpWC6FDp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1k+FEqyBR20GcJiXYa+txX4nbhO6Qejhh9NkoKPpWnYtPMYvlnyDi+9jYJ4WG4/w/tUacNLkanrc48rjgWZSamUOXws5vR/DEpvfJiQRpAx3xJxmc2p/Naa7d3mL4LRnt0SVy8z6ktrctqJqAWN/8JR7lNQACTvg+tkcoxqnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H9G0z0kK; arc=none smtp.client-ip=91.218.175.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782476432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoAtTMQo3B+qJWHvarDJ+128I/oTBrgnEVCi66cyc6s=;
	b=H9G0z0kK0TRBT5TgV4keKOwjYwunMk2yU5M/rVUaI8NxUTYMP+Peu0pYl0olvX6pJeIYlu
	ZvqG5U0h7NcpnDJ1F4C2oVyHE/Gzi6cIh1tlZrgx3il/5leNHltNElQzOnBqkB9BJ+50vR
	XfcQbp/LBkIH4xCT3ZsD3sV71jRa8C4=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	youngjun.park@lge.com,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	rientjes@google.com,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [RFC 1/1] mm/vmscan: reduce lru_lock contention via vmstat-derived scan-balance cost
Date: Fri, 26 Jun 2026 05:19:47 -0700
Message-ID: <20260626122009.75334-2-usama.arif@linux.dev>
In-Reply-To: <20260626122009.75334-1-usama.arif@linux.dev>
References: <20260626122009.75334-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17329-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:chrisl@kernel.org,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:rientjes@google.com,m:kernel-team@meta.com,m:usama.arif@linux.dev,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,kvack.org,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A9156CCEFF

The anon/file scan balance in get_scan_count() is driven by two scalars
in struct lruvec, anon_cost and file_cost, accumulated by every reclaim
producer under lruvec->lru_lock. The acquisition sites for cost work
specifically are:

  - shrink_inactive_list() re-takes lru_lock at function exit purely
    to call lru_note_cost_unlock_irq() with (nr_pageout, nr_scanned -
    nr_reclaimed). One acquisition per inactive shrink.
  - shrink_active_list() does the same with (0, nr_rotated). One
    acquisition per active shrink.
  - workingset_refault() takes the lock via folio_lruvec_lock_irq()
    purely to record the refault cost. One acquisition per refault.
  - prepare_scan_control() takes lru_lock just to snapshot the two
    scalars into sc->{anon,file}_cost.
  - lru_note_cost_unlock_irq() itself walks parent_lruvec and
    re-acquires lru_lock on each ancestor to propagate the update,
    adding O(memcg-depth) acquisitions per producer call.

This hurts because lru_lock is already a heavy contention point on
memory-heavy workloads: every isolate_lru_folios(), move_folios_to_lru()
and folio_add_lru() takes it. The cost work itself is trivial (two
scalar bumps and one comparison), but it contends with and causes
contention for actual LRU manipulation. The parent_lruvec() also walks
multiplies cost-update overhead by memcg hierarchy depth.

Replace the producer-side accumulators with a read-side accumulator fed
from per-LRU vmstat counters. The old producer formula was:

  cost = nr_io * SWAP_CLUSTER_MAX + nr_rotated

Add explicit node_stat counters for the producer-local inputs:

  PGRECLAIM_PAGEOUT_{ANON,FILE} - reclaim-driven pageout submissions
                                  (formerly stat.nr_pageout, weighted
                                  by SWAP_CLUSTER_MAX).
  PGROTATE_{ANON,FILE}          - reclaim-driven rotations, bumped from
                                  both shrink_inactive_list (by
                                  nr_scanned - nr_reclaimed) and
                                  shrink_active_list (by nr_rotated),
                                  unweighted.

WORKINGSET_RESTORE_{ANON,FILE} already captures the refault IO that
lru_note_cost_refault() used to bill.

In prepare_scan_control() the raw cost signal is recomputed lock-free of
lru_lock from monotonic counters:

  now = (PGRECLAIM_PAGEOUT_X + WORKINGSET_RESTORE_X) * SWAP_CLUSTER_MAX
        + PGROTATE_X

The delta against a per-lruvec prev_cost[] snapshot is folded into
cost_accum[]. The lrusize/4 halving threshold is preserved, but the
decay check now happens at the read site instead of on every producer
update.

A dedicated per-lruvec spinlock, cost_lock, serialises the prev_cost
RMW, the accumulator update, and the halving check against concurrent
reclaimers in the same memcg+node.

Hierarchy aggregation is now implicit in the vmstat accounting. The
producer-side parent_lruvec() walk and lru_reparent_memcg() cost splice
existed only because anon_cost/file_cost were private lruvec fields. With
the cost expressed as lruvec vmstats, rstat propagates the underlying
counters through the memcg hierarchy and prepare_scan_control() consumes
the same ratelimited rstat view as the surrounding reclaim heuristics.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/mmzone.h | 11 +++++--
 include/linux/swap.h   |  3 --
 mm/memcontrol-v1.c     |  4 +--
 mm/memcontrol.c        |  4 +++
 mm/mmzone.c            |  1 +
 mm/swap.c              | 69 ------------------------------------------
 mm/vmscan.c            | 64 +++++++++++++++++++++++++++++++++------
 mm/vmstat.c            |  4 +++
 mm/workingset.c        |  5 ---
 9 files changed, 74 insertions(+), 91 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca2712187147..0627622a5184 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -323,6 +323,10 @@ enum node_stat_item {
 	PGSCAN_PROACTIVE,
 	PGSCAN_ANON,
 	PGSCAN_FILE,
+	PGRECLAIM_PAGEOUT_ANON,
+	PGRECLAIM_PAGEOUT_FILE,
+	PGROTATE_ANON,
+	PGROTATE_FILE,
 	PGREFILL,
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
@@ -763,9 +767,12 @@ struct lruvec {
 	 * These track the cost of reclaiming one LRU - file or anon -
 	 * over the other. As the observed cost of reclaiming one LRU
 	 * increases, the reclaim scan balance tips toward the other.
+	 * Updated and decayed at prepare_scan_control() time; cost_lock
+	 * serialises that update.
 	 */
-	unsigned long			anon_cost;
-	unsigned long			file_cost;
+	unsigned long			prev_cost[ANON_AND_FILE];
+	unsigned long			cost_accum[ANON_AND_FILE];
+	spinlock_t			cost_lock;
 	/* Non-resident age, driven by LRU movement */
 	atomic_long_t			nonresident_age;
 	/* Refaults at the time of last reclaim cycle */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6d72778e6cc3..d35a4761ebd7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -309,9 +309,6 @@ extern unsigned long totalreserve_pages;
 
 
 /* linux/mm/swap.c */
-void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
-		unsigned int nr_io, unsigned int nr_rotated);
-void lru_note_cost_refault(struct folio *);
 void folio_add_lru(struct folio *);
 void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
 void mark_page_accessed(struct page *);
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 765069211567..c7a52bb68f4c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1988,8 +1988,8 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		for_each_online_pgdat(pgdat) {
 			mz = memcg->nodeinfo[pgdat->node_id];
 
-			anon_cost += mz->lruvec.anon_cost;
-			file_cost += mz->lruvec.file_cost;
+			anon_cost += mz->lruvec.cost_accum[WORKINGSET_ANON];
+			file_cost += mz->lruvec.cost_accum[WORKINGSET_FILE];
 		}
 		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
 		seq_buf_printf(s, "file_cost %lu\n", file_cost);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af08232..3c068ebefd97 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -419,6 +419,10 @@ static const unsigned int memcg_node_stat_items[] = {
 	PGSCAN_PROACTIVE,
 	PGSCAN_ANON,
 	PGSCAN_FILE,
+	PGRECLAIM_PAGEOUT_ANON,
+	PGRECLAIM_PAGEOUT_FILE,
+	PGROTATE_ANON,
+	PGROTATE_FILE,
 	PGREFILL,
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 0c8f181d9d50..17139db4d291 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -78,6 +78,7 @@ void lruvec_init(struct lruvec *lruvec)
 
 	memset(lruvec, 0, sizeof(struct lruvec));
 	spin_lock_init(&lruvec->lru_lock);
+	spin_lock_init(&lruvec->cost_lock);
 	zswap_lruvec_state_init(lruvec);
 
 	for_each_lru(lru)
diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8..74b281778cbc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -272,73 +272,6 @@ void folio_rotate_reclaimable(struct folio *folio)
 	folio_batch_add_and_move(folio, lru_move_tail);
 }
 
-void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
-		unsigned int nr_io, unsigned int nr_rotated)
-		__releases(lruvec->lru_lock)
-		__releases(rcu)
-{
-	unsigned long cost;
-
-	/*
-	 * Reflect the relative cost of incurring IO and spending CPU
-	 * time on rotations. This doesn't attempt to make a precise
-	 * comparison, it just says: if reloads are about comparable
-	 * between the LRU lists, or rotations are overwhelmingly
-	 * different between them, adjust scan balance for CPU work.
-	 */
-	cost = nr_io * SWAP_CLUSTER_MAX + nr_rotated;
-	if (!cost) {
-		spin_unlock_irq(&lruvec->lru_lock);
-		rcu_read_unlock();
-		return;
-	}
-
-	for (;;) {
-		unsigned long lrusize;
-
-		/* Record cost event */
-		if (file)
-			lruvec->file_cost += cost;
-		else
-			lruvec->anon_cost += cost;
-
-		/*
-		 * Decay previous events
-		 *
-		 * Because workloads change over time (and to avoid
-		 * overflow) we keep these statistics as a floating
-		 * average, which ends up weighing recent refaults
-		 * more than old ones.
-		 */
-		lrusize = lruvec_page_state(lruvec, NR_INACTIVE_ANON) +
-			  lruvec_page_state(lruvec, NR_ACTIVE_ANON) +
-			  lruvec_page_state(lruvec, NR_INACTIVE_FILE) +
-			  lruvec_page_state(lruvec, NR_ACTIVE_FILE);
-
-		if (lruvec->file_cost + lruvec->anon_cost > lrusize / 4) {
-			lruvec->file_cost /= 2;
-			lruvec->anon_cost /= 2;
-		}
-
-		spin_unlock_irq(&lruvec->lru_lock);
-		lruvec = parent_lruvec(lruvec);
-		if (!lruvec) {
-			rcu_read_unlock();
-			break;
-		}
-		spin_lock_irq(&lruvec->lru_lock);
-	}
-}
-
-void lru_note_cost_refault(struct folio *folio)
-{
-	struct lruvec *lruvec;
-
-	lruvec = folio_lruvec_lock_irq(folio);
-	lru_note_cost_unlock_irq(lruvec, folio_is_file_lru(folio),
-				folio_nr_pages(folio), 0);
-}
-
 static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
@@ -1164,8 +1097,6 @@ void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int
 
 	child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 	parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
-	parent_lruvec->anon_cost += child_lruvec->anon_cost;
-	parent_lruvec->file_cost += child_lruvec->file_cost;
 
 	for_each_lru(lru)
 		lruvec_reparent_lru(child_lruvec, parent_lruvec, lru, nid);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e8a90911bf88..6d187f0f8bf8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2043,10 +2043,13 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	mod_lruvec_state(lruvec, item, nr_reclaimed);
 	mod_lruvec_state(lruvec, PGSTEAL_ANON + file, nr_reclaimed);
+	if (stat.nr_pageout)
+		mod_lruvec_state(lruvec, PGRECLAIM_PAGEOUT_ANON + file,
+				 stat.nr_pageout);
+	if (nr_scanned > nr_reclaimed)
+		mod_lruvec_state(lruvec, PGROTATE_ANON + file,
+				 nr_scanned - nr_reclaimed);
 
-	lruvec_lock_irq(lruvec);
-	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
-					nr_scanned - nr_reclaimed);
 	handle_reclaim_writeback(nr_taken, pgdat, sc, &stat);
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			nr_scanned, nr_reclaimed, &stat, sc->priority, file);
@@ -2152,9 +2155,9 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	count_vm_events(PGDEACTIVATE, nr_deactivate);
 	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	if (nr_rotated)
+		mod_lruvec_state(lruvec, PGROTATE_ANON + file, nr_rotated);
 
-	lruvec_lock_irq(lruvec);
-	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
@@ -2303,12 +2306,53 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);
 
 	/*
-	 * Determine the scan balance between anon and file LRUs.
+	 * Determine the scan balance between anon and file LRUs from per-LRU
+	 * vmstat counters. The raw cost per side is:
+	 *
+	 *	PGROTATE	   - reclaim-driven rotations, bumped from both
+	 *			     shrink_inactive_list and shrink_active_list
+	 *			     (CPU work).
+	 *	PGRECLAIM_PAGEOUT  - reclaim-driven pageout IO.
+	 *	WORKINGSET_RESTORE - refaults of previously-workingset pages.
+	 *
+	 * The two IO terms are weighted by SWAP_CLUSTER_MAX to reflect the
+	 * higher cost of an IO over a rotation.
+	 *
+	 * Reads are lock-free per-cpu sum collations, rstat-aggregated up
+	 * the memcg hierarchy by mem_cgroup_flush_stats_ratelimited() above.
+	 *
+	 * The delta against prev_cost is folded into cost_accum, which is
+	 * halved on both sides whenever their sum exceeds lrusize/4.
+	 * cost_lock serialises concurrent reclaimers in the same memcg+node.
 	 */
-	spin_lock_irq(&target_lruvec->lru_lock);
-	sc->anon_cost = target_lruvec->anon_cost;
-	sc->file_cost = target_lruvec->file_cost;
-	spin_unlock_irq(&target_lruvec->lru_lock);
+	spin_lock(&target_lruvec->cost_lock);
+	for (int f = 0; f <= 1; f++) {
+		unsigned long now, delta;
+
+		now = lruvec_page_state(target_lruvec, PGROTATE_ANON + f) +
+		      (lruvec_page_state(target_lruvec,
+					 PGRECLAIM_PAGEOUT_ANON + f) +
+		       lruvec_page_state(target_lruvec,
+					 WORKINGSET_RESTORE_BASE + f)) *
+				SWAP_CLUSTER_MAX;
+		delta = now - target_lruvec->prev_cost[f];
+		target_lruvec->prev_cost[f] = now;
+		target_lruvec->cost_accum[f] += delta;
+	}
+	unsigned long lrusize =
+		lruvec_page_state(target_lruvec, NR_INACTIVE_ANON) +
+		lruvec_page_state(target_lruvec, NR_ACTIVE_ANON) +
+		lruvec_page_state(target_lruvec, NR_INACTIVE_FILE) +
+		lruvec_page_state(target_lruvec, NR_ACTIVE_FILE);
+
+	if (target_lruvec->cost_accum[WORKINGSET_ANON] +
+	    target_lruvec->cost_accum[WORKINGSET_FILE] > lrusize / 4) {
+		target_lruvec->cost_accum[WORKINGSET_ANON] /= 2;
+		target_lruvec->cost_accum[WORKINGSET_FILE] /= 2;
+	}
+	sc->anon_cost = target_lruvec->cost_accum[WORKINGSET_ANON];
+	sc->file_cost = target_lruvec->cost_accum[WORKINGSET_FILE];
+	spin_unlock(&target_lruvec->cost_lock);
 
 	/*
 	 * Target desirable inactive:active list ratios for the anon
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..2dfed5e9b64d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1289,6 +1289,10 @@ const char * const vmstat_text[] = {
 	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
 	[I(PGSCAN_ANON)]			= "pgscan_anon",
 	[I(PGSCAN_FILE)]			= "pgscan_file",
+	[I(PGRECLAIM_PAGEOUT_ANON)]		= "pgreclaim_pageout_anon",
+	[I(PGRECLAIM_PAGEOUT_FILE)]		= "pgreclaim_pageout_file",
+	[I(PGROTATE_ANON)]			= "pgrotate_anon",
+	[I(PGROTATE_FILE)]			= "pgrotate_file",
 	[I(PGREFILL)]				= "pgrefill",
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
diff --git a/mm/workingset.c b/mm/workingset.c
index f351798e723a..7ac2b88c80ae 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -584,11 +584,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	/* Folio was active prior to eviction */
 	if (workingset) {
 		folio_set_workingset(folio);
-		/*
-		 * XXX: Move to folio_add_lru() when it supports new vs
-		 * putback
-		 */
-		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
 out:
-- 
2.53.0-Meta


