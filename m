Return-Path: <cgroups+bounces-17780-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WozDDwvVmrk0wAAu9opvQ
	(envelope-from <cgroups+bounces-17780-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:44:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB07754B02
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Vfw4wVy4;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17780-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17780-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF1283009089
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD879384235;
	Tue, 14 Jul 2026 12:44:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAED378D64
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 12:44:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033081; cv=none; b=jwpWNdM86ZW/isHAihTHXEdF4ZouU35H/CoJKw46Qjbrtij2pVPS6oD7DFDfaYKaL2UlfzfAz02v97uHnzJNra9QpcsIUJa7TEtS45bDVbYQ/VY1sn5wJqIEJ43F/rl1D1C5qbr90wAumSkyeKwiNeg585nkBE4yxUKwRxrm55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033081; c=relaxed/simple;
	bh=UDMGl+NchJmNqRQFdjRgGeXOP2yiFKcr6jrvX+VusAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fylTWVGKDGCAlcR9hzE8UdMBt+QpfkRvHkVJM/SiOx3tfNLBA97oH/yZwbX12OSMB+oRRJ/sQ/x+Q1nG3v15nDhVFxkZBA43AgFwQmJkStnWkwxlajWdLqoZB2nouMz8NZCWcoRTkd2FHb+uytk9IIppwBTKwEHFTCY781ueGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vfw4wVy4; arc=none smtp.client-ip=91.218.175.181
Message-ID: <25a94af5-1dbe-4ab4-b47d-fb49987bfcd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784033076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL2BuBErJSR+msyoMlTQpeX2tgyYFMJLBrTouVN+o3E=;
	b=Vfw4wVy4dFED07nvt6oOpMkXirev2Y5GMxKO5ot6QfOqKJyPHMsdi4giItxcH80oClK6xP
	5UglsrKFeXrW34PiHzsomYxK4+ifqhq3VTgN8mGFL/rnG6aQRdHl6tSw7NIPegyx5yPDDI
	RbSVA//0HtXp7v6qjpAxaIHb4J6CP6g=
Date: Tue, 14 Jul 2026 13:44:03 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm/vmscan: reduce lru_lock contention via
 vmstat-derived scan-balance cost
To: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chrisl@kernel.org, nphamcs@gmail.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, rientjes@google.com,
 kernel-team@meta.com
References: <20260713163443.3562378-1-usama.arif@linux.dev>
 <20260713163443.3562378-3-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260713163443.3562378-3-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:chrisl@kernel.org,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:rientjes@google.com,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17780-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,kvack.org,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAB07754B02



On 13/07/2026 17:34, Usama Arif wrote:
> The anon/file scan balance in get_scan_count() is driven by two scalars
> in struct lruvec, anon_cost and file_cost, accumulated by every reclaim
> producer under lruvec->lru_lock. The acquisition sites for cost work
> specifically are:
> 
>   - shrink_inactive_list() re-takes lru_lock at function exit purely
>     to call lru_note_cost_unlock_irq() with (nr_pageout, nr_scanned -
>     nr_reclaimed). One acquisition per inactive shrink.
>   - shrink_active_list() does the same with (0, nr_rotated). One
>     acquisition per active shrink.
>   - workingset_refault() takes the lock via folio_lruvec_lock_irq()
>     purely to record the refault cost. One acquisition per refault.
>   - prepare_scan_control() takes lru_lock just to snapshot the two
>     scalars into sc->{anon,file}_cost.
>   - lru_note_cost_unlock_irq() itself walks parent_lruvec and
>     re-acquires lru_lock on each ancestor to propagate the update,
>     adding O(memcg-depth) acquisitions per producer call.
> 
> This hurts because lru_lock is already a heavy contention point on
> memory-heavy workloads: every isolate_lru_folios(), move_folios_to_lru()
> and folio_add_lru() takes it. The cost work itself is trivial (two
> scalar bumps and one comparison), but it contends with and causes
> contention for actual LRU manipulation. The parent_lruvec() walk also
> multiplies cost-update overhead by memcg hierarchy depth.
> 
> Replace the producer-side accumulators with a read-side accumulator fed
> from per-LRU vmstat counters. The old producer formula was:
> 
>   cost = nr_io * SWAP_CLUSTER_MAX + nr_rotated
> 
> Add explicit node_stat counters for the producer-local inputs:
> 
>   PGRECLAIM_PAGEOUT_{ANON,FILE} - reclaim-driven pageout submissions
>                                   (formerly stat.nr_pageout, weighted
>                                   by SWAP_CLUSTER_MAX).
>   PGROTATE_{ANON,FILE}          - reclaim-driven rotations, bumped from
>                                   both shrink_inactive_list (by
>                                   nr_scanned - nr_reclaimed) and
>                                   shrink_active_list (by nr_rotated),
>                                   unweighted.
> 
> WORKINGSET_RESTORE_{ANON,FILE} already captures the refault IO that
> lru_note_cost_refault() used to bill.
> 
> In prepare_scan_control() the raw cost signal is recomputed lock-free of
> lru_lock from monotonic counters:
> 
>   now = (PGRECLAIM_PAGEOUT_X + WORKINGSET_RESTORE_X) * SWAP_CLUSTER_MAX
>         + PGROTATE_X
> 
> The delta against a per-lruvec prev_cost[] snapshot is folded into
> cost_accum[]. Since one vmstat delta can cover many producer events
> between reclaim passes, halve cost_accum[] until the total is back
> within the lrusize/4 bound instead of halving only once.
> 
> Moving accumulation and decay to the reclaim side also improves the cost
> model across reclaim gaps. With producer-side decay, events that happen
> while reclaim is idle still age each other before reclaim ever samples
> the costs. If a workload refaults a large anon set and then a smaller
> file set before reclaim runs again, the later file activity can age the
> earlier anon activity out of the cost model. The new scheme observes the
> whole between-reclaim delta and decays anon and file proportionally, so
> the scan-balance history better represents what happened since the last
> reclaim pass.
> 
> A dedicated per-lruvec spinlock, cost_lock, serialises the prev_cost
> RMW, the accumulator update, and the halving check against concurrent
> reclaimers in the same memcg+node.
> 
> Hierarchy aggregation is now implicit in the vmstat accounting. The
> producer-side parent_lruvec() walk and lru_reparent_memcg() cost splice
> existed only because anon_cost/file_cost were private lruvec fields. With
> the cost expressed as lruvec vmstats, rstat propagates the underlying
> counters through the memcg hierarchy and prepare_scan_control() consumes
> the same ratelimited rstat view as the surrounding reclaim heuristics.
> 
> memcg-v1's memory.stat anon_cost/file_cost is now sourced from
> cost_accum[] instead of the removed lruvec anon_cost/file_cost fields.
> The reported values only refresh when prepare_scan_control() runs and
> are bounded at ~lrusize/4 by the halving loop; the scan-balance signal
> they express is unchanged.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  include/linux/mmzone.h | 11 +++++--
>  include/linux/swap.h   |  3 --
>  mm/memcontrol-v1.c     |  4 +--
>  mm/memcontrol.c        |  4 +++
>  mm/mmzone.c            |  1 +
>  mm/swap.c              | 69 ----------------------------------------
>  mm/vmscan.c            | 72 ++++++++++++++++++++++++++++++++++++------
>  mm/vmstat.c            |  4 +++
>  mm/workingset.c        |  5 ---
>  9 files changed, 82 insertions(+), 91 deletions(-)
> 

The patch will need the below fixlet so that the counters keep incrementing
for MGLRU as well. The counters themselves are not actually used by MGLRU,
so this is just for observability. This was reported by sashiko, Thanks
Andrew for pointing this out!


From 0fd35b49112cc0d689741f04c485283e6dce3326 Mon Sep 17 00:00:00 2001
From: Usama Arif <usama.arif@linux.dev>
Date: Tue, 14 Jul 2026 05:18:16 -0700
Subject: [PATCH] [fixlet] mm/vmscan: increment pgreclaim_pageout_* and
 pgrotate_* for MGLRU

/proc/vmstat and per-memcg memory.stat expose pgreclaim_pageout_*
and pgrotate_* directly (memcg_node_stat_items in memcontrol.c
forwards them per-memcg). Without this fix they stay at 0 whenever
reclaim runs through MGLRU, misreporting observability.

Under pure MGLRU the scan-balance signal itself is not consumed (both
prepare_scan_control() and get_scan_count() are short-circuited on the
MGLRU paths, and MGLRU's own type/tier selection comes from
read_ctrl_pos() on lrugen->{avg_refaulted,avg_total,refaulted,evicted},
not from anon_cost/file_cost), so this fix is about observability.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/vmscan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 279f78b7a0e4..2da36374bb4a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4867,7 +4867,8 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	struct reclaim_stat stat;
 	struct lru_gen_mm_walk *walk;
 	int scanned, reclaimed;
-	int isolated = 0, type, type_scanned;
+	int isolated = 0, nr_isolated = 0, type, type_scanned;
+	unsigned long total_reclaimed = 0, total_pageout = 0;
 	bool skip_retry = false;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
@@ -4879,6 +4880,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	scanned = isolate_folios(nr_to_scan, lruvec, sc, swappiness,
 				 &list, &isolated, &type, &type_scanned);
+	nr_isolated = isolated;
 
 	/* Scanning may have emptied the oldest gen, flush it */
 	if (scanned)
@@ -4891,6 +4893,8 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false, memcg);
 	sc->nr_reclaimed += reclaimed;
+	total_reclaimed += reclaimed;
+	total_pageout += stat.nr_pageout;
 	/* Retry pass is only meant for clean folios without new isolation */
 	if (isolated)
 		handle_reclaim_writeback(isolated, pgdat, sc, &stat);
@@ -4944,6 +4948,13 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 		goto retry;
 	}
 
+	if (total_pageout)
+		mod_lruvec_state(lruvec, PGRECLAIM_PAGEOUT_ANON + type,
+				 total_pageout);
+	if (nr_isolated > total_reclaimed)
+		mod_lruvec_state(lruvec, PGROTATE_ANON + type,
+				 nr_isolated - total_reclaimed);
+
 	return scanned;
 }
 
-- 
2.53.0-Meta




