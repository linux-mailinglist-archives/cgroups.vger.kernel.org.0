Return-Path: <cgroups+bounces-16052-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANB+Ac6SC2ohJgUAu9opvQ
	(envelope-from <cgroups+bounces-16052-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 00:29:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8C57471B
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC8C300D859
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018BC3ACF0E;
	Mon, 18 May 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MfDbF6Ay"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACC15A85A
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143338; cv=none; b=E51P5QgRYBYJwhNqCKjotWqPbymT3g9y8PtwljJr2eHGRXqOfEccBA2Yh+HLxBajG7BxP8rF9ZG3a5hx27p6z+T+aK/TjFzXjWAzAta7o/ApcUl+nRhSrm+gJoyNgPtRIVpEA1rY1RC1QmCAD9N6JOZo7mUZYFa7DE5JV0bgi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143338; c=relaxed/simple;
	bh=uJ0VK4F5yC8vNUcCmMnztcbgZaBAf7KTcL5Du4Wkmj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5HFoAFQ4ZCqhEGO4QyTucH7WLrXE4TCTdsrGQcVOrR1+V1l5FwcxiTiQmdsZoJ5mqVX3f5rTrpDFr1QtFNWbRCAaPLR+QcroDFOVm/vE+Yp9B690AGuqjSU4ByQoP4rCdrRRhfZysLw6VOtOMZUVBUzm8JbJb3tU6vQSXhCCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MfDbF6Ay; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779143333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eNkqK2A55he/AkNTcmEivfEujicKPHNpUvazuTitr7U=;
	b=MfDbF6AyWkNiedUaGRpVlVBH78K8WfmWXypNTh15kLqzTYdIwlwYP58CInVnc9uPKO+56C
	nQdhXnWAwVry7m6A1aKupi+6zoMg0mIk9UF0vVnWlvlz7UCJBHPhYJEp5Q0cFxG6krnLjb
	0z9m95s//rNavmPx3tyEWbJdtnlOq9c=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg pointer
Date: Mon, 18 May 2026 15:28:27 -0700
Message-ID: <20260518222827.110696-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16052-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: EDE8C57471B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
per-node type") split a memcg's single obj_cgroup into one per NUMA
node, but the per-CPU obj_stock_pcp still keys cached_objcg by
pointer. Cross-NUMA workloads now see a drain on every refill and a
miss on every consume that targets a sibling per-node objcg of the
same memcg, producing the 67.7% stress-ng switch-mq regression
reported by LKP.

stock->nr_bytes are fungible across per-node objcgs of one memcg.
Treat the cache as keyed by memcg in __consume_obj_stock() and
__refill_obj_stock() so siblings share the reserve. Compare via
READ_ONCE(objcg->memcg) directly: pointer-compare only, no deref, so
the rcu_read_lock contract on obj_cgroup_memcg() does not apply.

Sharing the reserve without re-caching means bytes funded by one
per-node objcg's slow path can be consumed/freed under a different
sibling, leaving sub-page residue on whichever sibling was cached at
drain time. The pre-existing obj_cgroup_release() path would WARN and
silently drop that residue, leaking up to nr_node_ids * (PAGE_SIZE - 1)
bytes per memcg lifecycle from the page_counter. Forward the residue
into a per-node objcg of the same (post-reparent) memcg at release time
instead, so it can be reconciled later via a refill atomic_xchg or
another release; the chain terminates at root_mem_cgroup, whose
page_counter has no enforced limit.

Please note that this is temporary fix and will be reverted when
per-node kmem accounting is introduced.

Update the stale invariant comment on __account_obj_stock().

Qi Zheng built a specialized reproducer [1] for the corner case and
confirmed the fix.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Link: https://lore.kernel.org/19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev/ [1]
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Debugged-by: Qi Zheng <qi.zheng@linux.dev>
---

Changes since v2:
https://lore.kernel.org/20260517194308.952655-1-shakeel.butt@linux.dev/
- Instead of handling sub-page charged residue at refill time, let's handle it
  at the obj_cgroup_release time.

Changes since v1:
https://lore.kernel.org/20260515171953.2224503-1-shakeel.butt@linux.dev/
- Fix the rcu warning (Sashiko).
- Fix the page counter possible underflow warning (Sashiko).

 mm/memcontrol.c | 69 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d978e18b9b2d..a547ec7c42d1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -142,14 +142,24 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
+	unsigned int sub_bytes;
 	unsigned long flags;
 
 	/*
-	 * At this point all allocated objects are freed, and
-	 * objcg->nr_charged_bytes can't have an arbitrary byte value.
-	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
+	 * At this point all allocated objects are freed, but
+	 * objcg->nr_charged_bytes can still hold either
+	 *   - (x * PAGE_SIZE)  if a small-alloc/drain race left whole pages
+	 *     stranded (see the historical sequence below), or
+	 *   - any sub-page residue, now that the stock is keyed by memcg and
+	 *     sibling per-node objcgs share its reserve: bytes consumed by
+	 *     one sibling can spill into another sibling's nr_charged_bytes
+	 *     when the stock is drained.
 	 *
-	 * The following sequence can lead to it:
+	 * Uncharge the page-aligned portion from this objcg's (post-reparent)
+	 * memcg, and forward any sub-page residue into a per-node objcg of
+	 * the same memcg so it can be reconciled later instead of being lost.
+	 *
+	 * Historical race producing the (x * PAGE_SIZE) case:
 	 * 1) CPU0: objcg == stock->cached_objcg
 	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
 	 *          PAGE_SIZE bytes are charged
@@ -160,23 +170,33 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	 *          92 bytes are added to stock->nr_bytes
 	 * 6) CPU0: stock is flushed,
 	 *          92 bytes are added to objcg->nr_charged_bytes
-	 *
-	 * In the result, nr_charged_bytes == PAGE_SIZE.
-	 * This page will be uncharged in obj_cgroup_release().
 	 */
 	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
-	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
 	nr_pages = nr_bytes >> PAGE_SHIFT;
+	sub_bytes = nr_bytes & (PAGE_SIZE - 1);
 
-	if (nr_pages) {
+	if (nr_pages || sub_bytes) {
 		struct mem_cgroup *memcg;
 
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
-		memcg1_account_kmem(memcg, -nr_pages);
-		if (!mem_cgroup_is_root(memcg))
-			memcg_uncharge(memcg, nr_pages);
-		mem_cgroup_put(memcg);
+		rcu_read_lock();
+		memcg = obj_cgroup_memcg(objcg);
+
+		if (nr_pages) {
+			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			memcg1_account_kmem(memcg, -nr_pages);
+			if (!mem_cgroup_is_root(memcg))
+				memcg_uncharge(memcg, nr_pages);
+		}
+
+		if (sub_bytes && !mem_cgroup_is_root(memcg)) {
+			struct obj_cgroup *fwd;
+
+			fwd = rcu_dereference(
+				memcg->nodeinfo[numa_node_id()]->objcg);
+			if (fwd)
+				atomic_add(sub_bytes, &fwd->nr_charged_bytes);
+		}
+		rcu_read_unlock();
 	}
 
 	spin_lock_irqsave(&objcg_lock, flags);
@@ -3152,7 +3172,12 @@ static void unlock_stock(struct obj_stock_pcp *stock)
 		local_unlock(&obj_stock.lock);
 }
 
-/* Call after __refill_obj_stock() to ensure stock->cached_objg == objcg */
+/*
+ * Call after __consume_obj_stock() / __refill_obj_stock(). The stock may be
+ * cached for a sibling per-node objcg of the same memcg; in that case the
+ * vmstat batching slot does not match objcg and we fallthrough to the
+ * direct path.
+ */
 static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
@@ -3210,7 +3235,11 @@ static bool __consume_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock,
 				unsigned int nr_bytes)
 {
-	if (objcg == READ_ONCE(stock->cached_objcg) &&
+	struct obj_cgroup *cached = READ_ONCE(stock->cached_objcg);
+
+	/* Sibling per-node objcgs share the reserve. */
+	if ((cached == objcg ||
+	     (cached && READ_ONCE(cached->memcg) == READ_ONCE(objcg->memcg))) &&
 	    stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		return true;
@@ -3318,6 +3347,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 			       unsigned int nr_bytes,
 			       bool allow_uncharge)
 {
+	struct obj_cgroup *cached;
 	unsigned int nr_pages = 0;
 
 	if (!stock) {
@@ -3327,7 +3357,10 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 		goto out;
 	}
 
-	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
+	cached = READ_ONCE(stock->cached_objcg);
+	/* Direct READ_ONCE due to just pointer comparison. */
+	if (cached != objcg &&
+	    (!cached || READ_ONCE(cached->memcg) != READ_ONCE(objcg->memcg))) {
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
-- 
2.53.0-Meta


