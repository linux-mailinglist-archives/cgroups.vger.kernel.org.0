Return-Path: <cgroups+bounces-14040-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E8UG9yjl2mf3wIAu9opvQ
	(envelope-from <cgroups+bounces-14040-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:59:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A78163BE8
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8744C301373C
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16CD2F8BEE;
	Thu, 19 Feb 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJbH6x/3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69D2BD01B
	for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545559; cv=none; b=pyZ7QVplqTiYq7/qca3mYZS9Rqb9G3bu9+v+p8mHMjZBdwcdbw6I03+GDkc9RFDYUpIjVi7pVxrNkFhV4r2Q9tjLYSHB/6JY4dTaQNX1qOO8Y+OiLqTaeoOOFpz5/QbFxL3SB04jQSsKwzJ2AxlXLc3IKfx4rCS205xxHXU7ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545559; c=relaxed/simple;
	bh=Z1YiZxngeX3VW5b0djcHDR/mh1zdGw8bmKaEM6ahCvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFEP/ebCBu7BqMDUhuoRaYW26GRPMU6GgATrXLOV2pxS/ADle45ktvYiDfZyB32BG7veRuFQHhUIaLJVgJ2X5BYzMCNcFzu/OQ0nRqgHznipZq8JRirQIYq5TI0MmXOtuXe/30MQbX0ie3lCnSJDMHTH/D+jM0Ct+fUc5NfMu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJbH6x/3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771545553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbP57otIJy2E+y2KoxAXNaiSU96HA+1LQ4TFOW0uoFE=;
	b=fJbH6x/3/muOKYSrlxWWMrH56oixLTgf52Tfq2ZlQgBJ7xknv9l5cZhOIXQwtOk86bLiru
	8IbI/adplsn/0azSv1Rk4ulQheg4kmxwUOE+mzwZeNTYWKZOO6eCNJ49IR1b/v4DdusRaV
	QWE2/JN6Gyhyu2R50oOTjCqDnsR9Z/8=
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
To: linux-mm@kvack.org,
	mst@redhat.com,
	mhocko@suse.com,
	vbabka@suse.cz
Cc: apopple@nvidia.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	david@kernel.org,
	eperezma@redhat.com,
	gourry@gourry.net,
	jasowang@redhat.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	rppt@kernel.org,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	virtualization@lists.linux.dev,
	weixugc@google.com,
	xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	kernel-team@meta.com
Subject: [PATCH v5] mm: move pgscan, pgsteal, pgrefill to node stats
Date: Thu, 19 Feb 2026 15:58:46 -0800
Message-ID: <20260219235846.161910-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14040-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[33];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: C3A78163BE8
X-Rspamd-Action: no action

There are situations where reclaim kicks in on a system with free memory.
One possible cause is a NUMA imbalance scenario where one or more nodes are
under pressure. It would help if we could easily identify such nodes.

Move the pgscan, pgsteal, and pgrefill counters from vm_event_item to
node_stat_item to provide per-node reclaim visibility. With these counters
as node stats, the values are now displayed in the per-node section of
/proc/zoneinfo, which allows for quick identification of the affected
nodes.

/proc/vmstat continues to report the same counters, aggregated across all
nodes. But the ordering of these items within the readout changes as they
move from the vm events section to the node stats section.

Memcg accounting of these counters is preserved. The relocated counters
remain visible in memory.stat alongside the existing aggregate pgscan and
pgsteal counters.

However, this change affects how the global counters are accumulated.
Previously, the global event count update was gated on !cgroup_reclaim(),
excluding memcg-based reclaim from /proc/vmstat. Now that
mod_lruvec_state() is being used to update the counters, the global
counters will include all reclaim. This is consistent with how pgdemote
counters are already tracked.

Finally, the virtio_balloon driver is updated to use
global_node_page_state() to fetch the counters, as they are no longer
accessible through the vm_events array.

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
v5:
	- rebase onto mm/mm-new

v4: https://lore.kernel.org/linux-mm/20260219171124.19053-1-jp.kobryn@linux.dev/
	- remove unused memcg var from scan_folios()

v3: https://lore.kernel.org/linux-mm/20260218222652.108411-1-jp.kobryn@linux.dev/
	- additionally move PGREFILL to node stats

v2: https://lore.kernel.org/linux-mm/20260218032941.225439-1-jp.kobryn@linux.dev/
	- update commit message
	- add entries to memory_stats array
	- add switch cases in memcg_page_state_output_unit()

v1: https://lore.kernel.org/linux-mm/20260212045109.255391-3-inwardvessel@gmail.com/

 drivers/virtio/virtio_balloon.c |  8 ++---
 include/linux/mmzone.h          | 13 ++++++++
 include/linux/vm_event_item.h   | 13 --------
 mm/memcontrol.c                 | 56 +++++++++++++++++++++++----------
 mm/vmscan.c                     | 39 ++++++++---------------
 mm/vmstat.c                     | 26 +++++++--------
 6 files changed, 82 insertions(+), 73 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e549abe59ff..ab945532ceef 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -369,13 +369,13 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
-		    pages_to_bytes(events[PGSCAN_KSWAPD]));
+		    pages_to_bytes(global_node_page_state(PGSCAN_KSWAPD)));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
-		    pages_to_bytes(events[PGSCAN_DIRECT]));
+		    pages_to_bytes(global_node_page_state(PGSCAN_DIRECT)));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
-		    pages_to_bytes(events[PGSTEAL_KSWAPD]));
+		    pages_to_bytes(global_node_page_state(PGSTEAL_KSWAPD)));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
-		    pages_to_bytes(events[PGSTEAL_DIRECT]));
+		    pages_to_bytes(global_node_page_state(PGSTEAL_DIRECT)));
 
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e51190a55e4..546bca95ca40 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -255,6 +255,19 @@ enum node_stat_item {
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
 	PGDEMOTE_PROACTIVE,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
+	PGSTEAL_PROACTIVE,
+	PGSTEAL_ANON,
+	PGSTEAL_FILE,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
+	PGSCAN_PROACTIVE,
+	PGSCAN_ANON,
+	PGSCAN_FILE,
+	PGREFILL,
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 22a139f82d75..03fe95f5a020 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -38,21 +38,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGFREE, PGACTIVATE, PGDEACTIVATE, PGLAZYFREE,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
-		PGREFILL,
 		PGREUSE,
-		PGSTEAL_KSWAPD,
-		PGSTEAL_DIRECT,
-		PGSTEAL_KHUGEPAGED,
-		PGSTEAL_PROACTIVE,
-		PGSCAN_KSWAPD,
-		PGSCAN_DIRECT,
-		PGSCAN_KHUGEPAGED,
-		PGSCAN_PROACTIVE,
 		PGSCAN_DIRECT_THROTTLE,
-		PGSCAN_ANON,
-		PGSCAN_FILE,
-		PGSTEAL_ANON,
-		PGSTEAL_FILE,
 #ifdef CONFIG_NUMA
 		PGSCAN_ZONE_RECLAIM_SUCCESS,
 		PGSCAN_ZONE_RECLAIM_FAILED,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6fb9c999347b..0d834c47706f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -331,6 +331,19 @@ static const unsigned int memcg_node_stat_items[] = {
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
 	PGDEMOTE_PROACTIVE,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
+	PGSTEAL_PROACTIVE,
+	PGSTEAL_ANON,
+	PGSTEAL_FILE,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
+	PGSCAN_PROACTIVE,
+	PGSCAN_ANON,
+	PGSCAN_FILE,
+	PGREFILL,
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
@@ -444,17 +457,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 #endif
 	PSWPIN,
 	PSWPOUT,
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSCAN_KHUGEPAGED,
-	PGSCAN_PROACTIVE,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGSTEAL_KHUGEPAGED,
-	PGSTEAL_PROACTIVE,
 	PGFAULT,
 	PGMAJFAULT,
-	PGREFILL,
 	PGACTIVATE,
 	PGDEACTIVATE,
 	PGLAZYFREE,
@@ -1401,6 +1405,15 @@ static const struct memory_stat memory_stats[] = {
 	{ "pgdemote_direct",		PGDEMOTE_DIRECT		},
 	{ "pgdemote_khugepaged",	PGDEMOTE_KHUGEPAGED	},
 	{ "pgdemote_proactive",		PGDEMOTE_PROACTIVE	},
+	{ "pgsteal_kswapd",		PGSTEAL_KSWAPD		},
+	{ "pgsteal_direct",		PGSTEAL_DIRECT		},
+	{ "pgsteal_khugepaged",		PGSTEAL_KHUGEPAGED	},
+	{ "pgsteal_proactive",		PGSTEAL_PROACTIVE	},
+	{ "pgscan_kswapd",		PGSCAN_KSWAPD		},
+	{ "pgscan_direct",		PGSCAN_DIRECT		},
+	{ "pgscan_khugepaged",		PGSCAN_KHUGEPAGED	},
+	{ "pgscan_proactive",		PGSCAN_PROACTIVE	},
+	{ "pgrefill",			PGREFILL		},
 #ifdef CONFIG_NUMA_BALANCING
 	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
 #endif
@@ -1444,6 +1457,15 @@ static int memcg_page_state_output_unit(int item)
 	case PGDEMOTE_DIRECT:
 	case PGDEMOTE_KHUGEPAGED:
 	case PGDEMOTE_PROACTIVE:
+	case PGSTEAL_KSWAPD:
+	case PGSTEAL_DIRECT:
+	case PGSTEAL_KHUGEPAGED:
+	case PGSTEAL_PROACTIVE:
+	case PGSCAN_KSWAPD:
+	case PGSCAN_DIRECT:
+	case PGSCAN_KHUGEPAGED:
+	case PGSCAN_PROACTIVE:
+	case PGREFILL:
 #ifdef CONFIG_NUMA_BALANCING
 	case PGPROMOTE_SUCCESS:
 #endif
@@ -1562,15 +1584,15 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	/* Accumulated memory events */
 	memcg_seq_buf_print_stat(s, NULL, "pgscan", ' ',
-				 memcg_events(memcg, PGSCAN_KSWAPD) +
-				 memcg_events(memcg, PGSCAN_DIRECT) +
-				 memcg_events(memcg, PGSCAN_PROACTIVE) +
-				 memcg_events(memcg, PGSCAN_KHUGEPAGED));
+				 memcg_page_state(memcg, PGSCAN_KSWAPD) +
+				 memcg_page_state(memcg, PGSCAN_DIRECT) +
+				 memcg_page_state(memcg, PGSCAN_PROACTIVE) +
+				 memcg_page_state(memcg, PGSCAN_KHUGEPAGED));
 	memcg_seq_buf_print_stat(s, NULL, "pgsteal", ' ',
-				 memcg_events(memcg, PGSTEAL_KSWAPD) +
-				 memcg_events(memcg, PGSTEAL_DIRECT) +
-				 memcg_events(memcg, PGSTEAL_PROACTIVE) +
-				 memcg_events(memcg, PGSTEAL_KHUGEPAGED));
+				 memcg_page_state(memcg, PGSTEAL_KSWAPD) +
+				 memcg_page_state(memcg, PGSTEAL_DIRECT) +
+				 memcg_page_state(memcg, PGSTEAL_PROACTIVE) +
+				 memcg_page_state(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
 #ifdef CONFIG_MEMCG_V1
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5fa6e6bd6540..c3dc7c7befac 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1984,7 +1984,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	unsigned long nr_taken;
 	struct reclaim_stat stat;
 	bool file = is_file_lru(lru);
-	enum vm_event_item item;
+	enum node_stat_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	bool stalled = false;
 
@@ -2010,10 +2010,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
 	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
-	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, nr_scanned);
-	count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
-	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
+	mod_lruvec_state(lruvec, item, nr_scanned);
+	mod_lruvec_state(lruvec, PGSCAN_ANON + file, nr_scanned);
 
 	spin_unlock_irq(&lruvec->lru_lock);
 
@@ -2030,10 +2028,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 					stat.nr_demoted);
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
-	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, nr_reclaimed);
-	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
-	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
+	mod_lruvec_state(lruvec, item, nr_reclaimed);
+	mod_lruvec_state(lruvec, PGSTEAL_ANON + file, nr_reclaimed);
 
 	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
 					nr_scanned - nr_reclaimed);
@@ -2120,9 +2116,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
 
-	if (!cgroup_reclaim(sc))
-		__count_vm_events(PGREFILL, nr_scanned);
-	count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
+	mod_lruvec_state(lruvec, PGREFILL, nr_scanned);
 
 	spin_unlock_irq(&lruvec->lru_lock);
 
@@ -4537,7 +4531,7 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 {
 	int i;
 	int gen;
-	enum vm_event_item item;
+	enum node_stat_item item;
 	int sorted = 0;
 	int scanned = 0;
 	int isolated = 0;
@@ -4545,7 +4539,6 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	int scan_batch = min(nr_to_scan, MAX_LRU_BATCH);
 	int remaining = scan_batch;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	VM_WARN_ON_ONCE(!list_empty(list));
 
@@ -4596,13 +4589,9 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	}
 
 	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
-	if (!cgroup_reclaim(sc)) {
-		__count_vm_events(item, isolated);
-		__count_vm_events(PGREFILL, sorted);
-	}
-	count_memcg_events(memcg, item, isolated);
-	count_memcg_events(memcg, PGREFILL, sorted);
-	__count_vm_events(PGSCAN_ANON + type, isolated);
+	mod_lruvec_state(lruvec, item, isolated);
+	mod_lruvec_state(lruvec, PGREFILL, sorted);
+	mod_lruvec_state(lruvec, PGSCAN_ANON + type, isolated);
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, scan_batch,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
@@ -4705,7 +4694,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	LIST_HEAD(clean);
 	struct folio *folio;
 	struct folio *next;
-	enum vm_event_item item;
+	enum node_stat_item item;
 	struct reclaim_stat stat;
 	struct lru_gen_mm_walk *walk;
 	bool skip_retry = false;
@@ -4769,10 +4758,8 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 					stat.nr_demoted);
 
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
-	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, reclaimed);
-	count_memcg_events(memcg, item, reclaimed);
-	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
+	mod_lruvec_state(lruvec, item, reclaimed);
+	mod_lruvec_state(lruvec, PGSTEAL_ANON + type, reclaimed);
 
 	spin_unlock_irq(&lruvec->lru_lock);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 86b14b0f77b5..44bbb7752f11 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1276,6 +1276,19 @@ const char * const vmstat_text[] = {
 	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
 	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
 	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
+	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
+	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
+	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
+	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
+	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
+	[I(PGSTEAL_FILE)]			= "pgsteal_file",
+	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
+	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
+	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
+	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
+	[I(PGSCAN_ANON)]			= "pgscan_anon",
+	[I(PGSCAN_FILE)]			= "pgscan_file",
+	[I(PGREFILL)]				= "pgrefill",
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
@@ -1318,21 +1331,8 @@ const char * const vmstat_text[] = {
 	[I(PGMAJFAULT)]				= "pgmajfault",
 	[I(PGLAZYFREED)]			= "pglazyfreed",
 
-	[I(PGREFILL)]				= "pgrefill",
 	[I(PGREUSE)]				= "pgreuse",
-	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
-	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
-	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
-	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
-	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
-	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
-	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
-	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
 	[I(PGSCAN_DIRECT_THROTTLE)]		= "pgscan_direct_throttle",
-	[I(PGSCAN_ANON)]			= "pgscan_anon",
-	[I(PGSCAN_FILE)]			= "pgscan_file",
-	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
-	[I(PGSTEAL_FILE)]			= "pgsteal_file",
 
 #ifdef CONFIG_NUMA
 	[I(PGSCAN_ZONE_RECLAIM_SUCCESS)]	= "zone_reclaim_success",
-- 
2.47.3


