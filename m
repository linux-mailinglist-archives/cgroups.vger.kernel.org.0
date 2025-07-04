Return-Path: <cgroups+bounces-8693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C9AF9A53
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 20:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846F91CC08A5
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671220D4E7;
	Fri,  4 Jul 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpDvoNA4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8899213E90
	for <cgroups@vger.kernel.org>; Fri,  4 Jul 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652507; cv=none; b=PetYFMIbbcahwyXKxZXVb3jzhuCNsN01qsu2hPBZa8WuhtnC64r+Dg6Au0uGEz2N3XVhMSPm11xTfcd6M4+xzI6DUTlxMo5TUfnQnMkVt7tcoTsD+UoSY3JVMl963mP1IXp5McvfA7TdYNjsDG1McDdid40Gt41MAUJrB/pJNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652507; c=relaxed/simple;
	bh=WO6mw96rtG+PsrUZ9A2/gnnDa6FLcQR5KLhDps+rbsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iba31kJpIPMm8WtkipuLkZTI77o6gO5YIMyMcqqdfeS2NYKu/7vZWrYLewNuzqTWXneFAaZQ0id6xUBTmbbEzi8afPM6T3VzNfdowdewxwGo9Qrbaz+JF5aoAiyQp7eTItDF6/BkIf1Nf6EXFX3NoCYj8a4DJSQR0WSsfTq9y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpDvoNA4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751652502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IUCnL5ShriRssnzfhZZCtfMUKijajnRif2tS8Mc/KV4=;
	b=cpDvoNA4639C1FQwJ3Ko0yKz4qRNkmDxim1biLagKr3UupA4hCTwVq1rLNGj2GF2IW9fne
	V0a7gyARHUNejika5U8c5z1TjTt7cuCzmar36TmjPeqcQ8fANQvXp2M0oY3/WmBMX12iHl
	F1d0UlSfaykA6GpYiCTCsiCANnKyDJ4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3] cgroup: llist: avoid memory tears for llist_node
Date: Fri,  4 Jul 2025 11:08:04 -0700
Message-ID: <20250704180804.3598503-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Before the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
safe"), the struct llist_node is expected to be private to the one
inserting the node to the lockless list or the one removing the node
from the lockless list. After the mentioned commit, the llist_node in
the rstat code is per-cpu shared between the stacked contexts i.e.
process, softirq, hardirq & nmi. It is possible the compiler may tear
the loads or stores of llist_node. Let's avoid that.

KCSAN reported the following race:

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 60 UID: 0 PID: 5425 ... 6.16.0-rc3-next-20250626 #1 NONE
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: ...
 ==================================================================
 ==================================================================
 BUG: KCSAN: data-race in css_rstat_flush / css_rstat_updated
 write to 0xffffe8fffe1c85f0 of 8 bytes by task 1061 on cpu 1:
  css_rstat_flush+0x1b8/0xeb0
  __mem_cgroup_flush_stats+0x184/0x190
  flush_memcg_stats_dwork+0x22/0x50
  process_one_work+0x335/0x630
  worker_thread+0x5f1/0x8a0
  kthread+0x197/0x340
  ret_from_fork+0xd3/0x110
  ret_from_fork_asm+0x11/0x20
 read to 0xffffe8fffe1c85f0 of 8 bytes by task 3551 on cpu 15:
  css_rstat_updated+0x81/0x180
  mod_memcg_lruvec_state+0x113/0x2d0
  __mod_lruvec_state+0x3d/0x50
  lru_add+0x21e/0x3f0
  folio_batch_move_lru+0x80/0x1b0
  __folio_batch_add_and_move+0xd7/0x160
  folio_add_lru_vma+0x42/0x50
  do_anonymous_page+0x892/0xe90
  __handle_mm_fault+0xfaa/0x1520
  handle_mm_fault+0xdc/0x350
  do_user_addr_fault+0x1dc/0x650
  exc_page_fault+0x5c/0x110
  asm_exc_page_fault+0x22/0x30
 value changed: 0xffffe8fffe18e0d0 -> 0xffffe8fffe1c85f0

$ ./scripts/faddr2line vmlinux css_rstat_flush+0x1b8/0xeb0
css_rstat_flush+0x1b8/0xeb0:
init_llist_node at include/linux/llist.h:86
(inlined by) llist_del_first_init at include/linux/llist.h:308
(inlined by) css_process_update_tree at kernel/cgroup/rstat.c:148
(inlined by) css_rstat_updated_list at kernel/cgroup/rstat.c:258
(inlined by) css_rstat_flush at kernel/cgroup/rstat.c:389

$ ./scripts/faddr2line vmlinux css_rstat_updated+0x81/0x180
css_rstat_updated+0x81/0x180:
css_rstat_updated at kernel/cgroup/rstat.c:90 (discriminator 1)

These are expected race and a simple READ_ONCE/WRITE_ONCE resolves these
reports. However let's add comments to explain the race and the need for
memory barriers if stronger guarantees are needed.

More specifically the rstat updater and the flusher can race and cause a
scenario where the stats updater skips adding the css to the lockless
list but the flusher might not see those updates done by the skipped
updater. This is benign race and the subsequent flusher will flush those
stats and at the moment there aren't any rstat users which are not fine
with this kind of race. However some future user might want more
stricter guarantee, so let's add appropriate comments to ease the job of
future users.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
---

Changes since v2:
- Removed data_race() as explained and requested by Paul.
- Squashed into one patch.
http://lore.kernel.org/20250703200012.3734798-1-shakeel.butt@linux.dev

Changes since v1:
- Added comments explaining race and the need for memory barrier as
  requested by Tejun
- Added comments as a separate patch.
http://lore.kernel.org/20250626190550.4170599-1-shakeel.butt@linux.dev

 include/linux/llist.h |  6 +++---
 kernel/cgroup/rstat.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 27b17f64bcee..607b2360c938 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -83,7 +83,7 @@ static inline void init_llist_head(struct llist_head *list)
  */
 static inline void init_llist_node(struct llist_node *node)
 {
-	node->next = node;
+	WRITE_ONCE(node->next, node);
 }
 
 /**
@@ -97,7 +97,7 @@ static inline void init_llist_node(struct llist_node *node)
  */
 static inline bool llist_on_list(const struct llist_node *node)
 {
-	return node->next != node;
+	return READ_ONCE(node->next) != node;
 }
 
 /**
@@ -220,7 +220,7 @@ static inline bool llist_empty(const struct llist_head *head)
 
 static inline struct llist_node *llist_next(struct llist_node *node)
 {
-	return node->next;
+	return READ_ONCE(node->next);
 }
 
 /**
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c8a48cf83878..981e2f77ad4e 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -60,6 +60,12 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
  * Atomically inserts the css in the ss's llist for the given cpu. This is
  * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
  * will be processed at the flush time to create the update tree.
+ *
+ * NOTE: if the user needs the guarantee that the updater either add itself in
+ * the lockless list or the concurrent flusher flushes its updated stats, a
+ * memory barrier is needed before the call to css_rstat_updated() i.e. a
+ * barrier after updating the per-cpu stats and before calling
+ * css_rstat_updated().
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
@@ -86,7 +92,12 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 		return;
 
 	rstatc = css_rstat_cpu(css, cpu);
-	/* If already on list return. */
+	/*
+	 * If already on list return. This check is racy and smp_mb() is needed
+	 * to pair it with the smp_mb() in css_process_update_tree() if the
+	 * guarantee that the updated stats are visible to concurrent flusher is
+	 * needed.
+	 */
 	if (llist_on_list(&rstatc->lnode))
 		return;
 
@@ -148,6 +159,21 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
 	while ((lnode = llist_del_first_init(lhead))) {
 		struct css_rstat_cpu *rstatc;
 
+		/*
+		 * smp_mb() is needed here (more specifically in between
+		 * init_llist_node() and per-cpu stats flushing) if the
+		 * guarantee is required by a rstat user where etiher the
+		 * updater should add itself on the lockless list or the
+		 * flusher flush the stats updated by the updater who have
+		 * observed that they are already on the list. The
+		 * corresponding barrier pair for this one should be before
+		 * css_rstat_updated() by the user.
+		 *
+		 * For now, there aren't any such user, so not adding the
+		 * barrier here but if such a use-case arise, please add
+		 * smp_mb() here.
+		 */
+
 		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
 		__css_process_update_tree(rstatc->owner, cpu);
 	}
-- 
2.47.1


