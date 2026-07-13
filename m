Return-Path: <cgroups+bounces-17735-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/wEFMUUVWoNjwAAu9opvQ
	(envelope-from <cgroups+bounces-17735-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:39:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7C74DAD9
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:39:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=haNkL20k;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17735-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17735-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05787311CFC1
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684443800C;
	Mon, 13 Jul 2026 16:35:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E8C428828
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 16:35:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960503; cv=none; b=mdBRUaTKWmigIxQmuOMPwv4kC91KwqBRuWkqAAg9/vlfghVnwPwWYTEn5E+jRvtiV4McXvW114GcN5dbfho7XfBvGRcthDZdzVnBoyHdfgN6X8o8iIIXIhJj28lLkPiEefcpOvVivmvImj3IIeeT3ktdECAWFBtD+1Z4Y8fIqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960503; c=relaxed/simple;
	bh=PxmHAwDQbClWeCLoWqc9/9f6I+Cuqfvjaw6ziNUyfjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKP/MfR8GlZ6sBB37Yh/7JDC/F5hoIU19fPYQDadf+ov4qDE5AG4RB/DTSVMD/JamVUsaPTnbyCuiS6dfxSHYZ183Edi/PznHgnZjGcCMekJtIjOGclQ+xuDuhVWCXVvygQbyMoUUja/xafrlxjxxCF3u9MTq7Mr2sFTyusnWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=haNkL20k; arc=none smtp.client-ip=95.215.58.180
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783960489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGVzZk+EZbjQt/HAvFA/+T9A3SExi5ynlWA6au9+tbw=;
	b=haNkL20kKANlYAa3K530QRSumtDpsJOOmJ7WWp1z+ekDmIZu6uxpyI/FPsopzKnfJLJbnU
	uvnI8Ebv+PdEiIt6zc6p7Y1ikMfAnYwqzIho94yJcOo9oq1EVfWSlVAgo9caBqRn7nOUID
	2AJXdXvpYLB07RdsFgwYRn+oZoBXD84=
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
Subject: [PATCH v2 0/2] mm/vmscan: reduce lru_lock contention via vmstat-derived scan-balance cost
Date: Mon, 13 Jul 2026 09:34:15 -0700
Message-ID: <20260713163443.3562378-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:chrisl@kernel.org,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:hannes@cmpxchg.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:rientjes@google.com,m:kernel-team@meta.com,m:usama.arif@linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,kvack.org,vger.kernel.org,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17735-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DC7C74DAD9

The anon/file scan balance heuristic in get_scan_count() is fed by two
scalars in struct lruvec (anon_cost, file_cost) that every reclaim
producer updates under lruvec->lru_lock. The cost-recording work
itself is trivial, but it both contends for and contributes to
contention on lru_lock - which is often a contention point on
memory-pressured workloads. Specifically:

- shrink_inactive_list() re-acquires lru_lock at function exit just
  to call lru_note_cost_unlock_irq().
- shrink_active_list() does the same after rotation accounting.
- workingset_refault() takes folio_lruvec_lock_irq() purely to
  record the refault cost.
- prepare_scan_control() snapshots anon_cost/file_cost under
  lru_lock.
- lru_note_cost_unlock_irq() itself walks parent_lruvec() and
  re-acquires lru_lock on every ancestor, multiplying the cost
  of every update by memcg-hierarchy depth.

This series removes those producer-side acquisitions entirely. The
producer-local inputs (PGROTATE_*, PGRECLAIM_PAGEOUT_*) become
per-LRU vmstat counters; WORKINGSET_RESTORE_* already captures the
refault input. prepare_scan_control() reads the raw cost signal
lock-free from those vmstats and folds the delta into a per-lruvec
accumulator. A dedicated per-lruvec cost_lock, not touched by
isolate_lru_folios(), move_folios_to_lru(), or folio_add_lru(),
serialises the accumulator RMW and the lrusize/4 halving check.
Hierarchy aggregation is implicit in rstat propagation, so the
parent_lruvec() walk and the lru_reparent_memcg() cost-splice both
disappear.

Moving accumulation and decay to the reclaim side also improves the
cost model across reclaim gaps. With producer-side decay, events that
happen while reclaim is idle still age each other before reclaim ever
samples the costs. If a workload refaults a large anon set and then a
smaller file set before reclaim runs again, the later file activity can
age the earlier anon activity out of the cost model. The new scheme
observes the whole between-reclaim delta and decays anon and file
proportionally, so the scan-balance history better represents what
happened since the last reclaim pass.

Trade-offs:
  - Cost reads see rstat-aggregated values that can lag until periodic /
    reader-triggered flushing.
  - Per-lruvec footprint grows by 2 unsigned longs + a spinlock,
    which is a small cost.

== Numbers ==

Tested on a 176-core, 256 GB host. The benchmark drives sustained
swap-out/refault inside a tight memcg using vm-scalability/usemem:

  usemem -n 16 --prealloc --prefault --random $((256*1024*1024))

run inside a two-level memcg with memory.max=512M on the leaf
(4 GB anon working set has to fit in 512 MB -> continuous
shrink_inactive_list + workingset_refault). A 16 GB swap file
is used. Measurement is a 30 s `perf lock record -a` window
over otherwise-idle hardware.

Workload rates are identical on both kernels (the bench drives the
same memory pressure):

                          baseline    patched      delta
  pgscan_direct  / s      172,662     171,817      ~0%
  pgsteal_direct / s       67,162      66,306      ~0%
  workingset_refault_anon / s
                           40,696      39,830      ~0%

perf lock contention (total wait per 30 s window):

  Lock Name                Before      After     % change
  shrink_lruvec+0x770     722.84 ms    0         -100% (eliminated)
        (= lru_note_cost_unlock_irq)
  workingset_refault+0x167 385.26 ms   0         -100% (eliminated)
        (= lru_note_cost_refault)
  shrink_node+0x4ad       689.43 ms    26.95 ms  -96%
  shrink_active_list      208.34 ms    15.97 ms  -92%
  lru_add_drain_cpu+0x34    1.96 s    917.71 ms  -53%

  Total LRU lock wait      ~4.23 s     ~1.66 s   -61%

The two specific contention sites the patch removes
(shrink_lruvec+0x770 = lru_note_cost_unlock_irq;
workingset_refault+0x167 = lru_note_cost_refault) are completely
absent from the patched perf-lock-contention output.
Secondary reductions in shrink_node, shrink_active_list,
lru_add_drain_cpu and pgrefill/pgactivate look like knock-on
effects from removing the cost-recording overhead and the
parent_lruvec walk.

The remaining ~1.66 s of LRU lock wait on the patched kernel is
dominated by the per-CPU pagevec drain (lru_add_drain_cpu) and the
main reclaim path in shrink_lruvec.

The numbers above can be reproduced using the script in [1].

== Series structure ==

  1. mm/vmstat, mm/memcontrol: add _monotonic vmstat readers
     Non-clamping siblings of lruvec_page_state() / node_page_state() /
     global_node_page_state() for callers that snapshot a
     monotonically-incremented counter and subtract two samples.
     Unsigned modular subtraction on the raw wrapping value stays
     correct across a signed-long overflow that the existing clamp
     would otherwise turn into a huge spurious delta (a real hazard
     on 32-bit).

  2. mm/vmscan: reduce lru_lock contention via vmstat-derived
     scan-balance cost
     The optimization described above; samples PGROTATE_*,
     PGRECLAIM_PAGEOUT_* and WORKINGSET_RESTORE_* via
     lruvec_page_state_monotonic() from patch 1.

== Alternatives considered ==

1. cost_lock for both producer and consumer (no vmstat indirection):
   Keep the producer loop, just swap lru_lock for a new per-lruvec
   cost_lock. Decouples cost from LRU manipulation, but producers
   still synchronously contend on cost_lock, the parent_lruvec()
   walk is still required (O(memcg-depth) acquisitions per recording,
   now on cost_lock), and lru_reparent_memcg() still needs explicit
   cost-splice. We can do much better and this series removes the
   producer lock entirely and gets hierarchy propagation for "free"
   via rstat.

2. Attempt to switch to using MGLRU's scan model:
   MGLRU has no anon_cost/file_cost at all. It replaces the cost
   heuristic with generation-based aging: per-LRU sequence numbers
   (min_seq/max_seq) age folios into generations, and the
   older-generation type is the one to scan. So
   lru_note_cost_unlock_irq() / lru_note_cost_refault() are simply
   not called when lru_gen_enabled() — by design it sidesteps every
   concern this patch addresses.
   But MGLRU is not a substitute for fixing classic LRU:
     - It relies on a lot of things including per-lruvec generation
       lists, bloom filters, mm_struct walk infrastructure, working-set
       protection tiers and a whole sysfs interface. Replacing
       classic LRU's cost recording with the MGLRU model would
       mean dragging in all of that.
     - It changes scan-balance semantics, not just the locking, so
       it's a heuristic change we would need to evaluate separately.
       There are known regressions (database/anon-heavy workloads
       sensitive to swappiness, or file-cache-dominated workloads
       where MGLRU's bloom-filter protection differs from classic
       refault tracking).
   This series keeps classic LRU's scan-balance model and fixes where
   its cost history is sampled and aged.

3. Atomic cost counter:
   lrusize/4 halving has no clean atomic form, and the parent
   walk still has to run explicitly. Reusing vmstats gives per-CPU
   aggregation AND rstat hierarchy propagation for free.

4. Drop cost_lock from the existing patch and reuse lru_lock in the
   consumer (prepare_scan_control()):
   Saves 1 lock space per lruvec but re-couples the cost path to LRU
   manipulation, though just from the consumer side this time.
   prepare_scan_control() runs at the start of every shrink_lruvec()
   cycle, so under sustained memory pressure it would take lru_lock
   on the hot path and block isolate_lru_folios() /
   move_folios_to_lru() / folio_add_lru() i.e. when reclaim is
   in flight. A dedicated cost_lock is never taken by anyone except
   the consumer cost calculation.

[1] https://gist.github.com/uarif1/a4eb33a86c5b2d7bbc55b42f0956e884

v1 -> v2: https://lore.kernel.org/all/20260706122954.3552990-1-usama.arif@linux.dev/
- Sample via the newly introduced lruvec_page_state_monotonic()
  to fix a 32-bit delta underflow when the underlying signed
  long wraps past LONG_MAX (Johannes and sashiko)

RFC -> v1: https://lore.kernel.org/all/20260626122009.75334-1-usama.arif@linux.dev/
- Document in coverletter and commit message  how the read-side vmstat accumulator
  improves cost-model aging across reclaim gaps (Johannes)
- Fully decay the cost_accum below lrusize / 4 using a while loop (sashiko)
 
Usama Arif (2):
  mm/vmstat, mm/memcontrol: add _monotonic vmstat readers
  mm/vmscan: reduce lru_lock contention via vmstat-derived scan-balance
    cost

 include/linux/memcontrol.h |  8 +++++
 include/linux/mmzone.h     | 11 ++++--
 include/linux/swap.h       |  3 --
 include/linux/vmstat.h     | 16 +++++++++
 mm/memcontrol-v1.c         |  4 +--
 mm/memcontrol.c            | 40 +++++++++++++++++++++
 mm/mmzone.c                |  1 +
 mm/swap.c                  | 69 ------------------------------------
 mm/vmscan.c                | 72 ++++++++++++++++++++++++++++++++------
 mm/vmstat.c                | 15 ++++++++
 mm/workingset.c            |  5 ---
 11 files changed, 153 insertions(+), 91 deletions(-)

-- 
2.53.0-Meta


