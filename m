Return-Path: <cgroups+bounces-15550-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCCDLNi08WmjjwEAu9opvQ
	(envelope-from <cgroups+bounces-15550-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 09:35:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAA849089B
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CBF23023DC0
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496C33A029;
	Wed, 29 Apr 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P0oDga2E"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EE26A0D5
	for <cgroups@vger.kernel.org>; Wed, 29 Apr 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447901; cv=none; b=N+Iozi+DMsxHVm5JZYzm/D4ClalK+07Ro4niDLF8DtX/QyZSEGpW/HY3iI4c99HwGlNgLIHxxDW+Tjo0HFBaa+Sr44KBxasrQFt2XUNyl8mUQzMExw3HBKN2WmVGZYfSV/cosYnmBHsVtZ15FZ1u6m91+3KUCVrthaR+eCkOmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447901; c=relaxed/simple;
	bh=LsBdepRuwPEtf5E5DTsTcKqi+0wHGthfMqaCb0VgeME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhG3hM5QoTZYdThoW40P9n4f+ExaHa1pbiG14ozn5egG8Ydn96j6vcI65+FwNeDdR9/IRZVzwnr4orTrDZs0iWbP7gCOnbUfSteIvvz0G5tj+uB5mtjfA+5oi+5+uYqB47gj+HLmDMpwrTrtYKmKhyvWao07IywrHWsQ7sWspy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P0oDga2E; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777447887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ba1LXb+IR29BnqyJkHs6D8UuBSkwHRvSb38v34WKljk=;
	b=P0oDga2EeBVjBCpvBe1o82imEYp5QLXUHXJZic1IoN2Eh6SeNpSzcrcVW16/okCxYCWw17
	Wt5/+k7+K5PbfkfsbZfjV9y5qLUy5+YLYNVSlfILmMTu9JoejlARkoF8a2YIdK7B98NldS
	5DeHAI+clLgNOUHojxRkOyESm8PLEhs=
From: Qi Zheng <qi.zheng@linux.dev>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	yosry@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3] mm: memcontrol: fix rcu unbalance in get_non_dying_memcg_end()
Date: Wed, 29 Apr 2026 15:31:05 +0800
Message-ID: <20260429073105.44472-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0AAA849089B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15550-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]

From: Qi Zheng <zhengqi.arch@bytedance.com>

Currently, get_non_dying_memcg_start() and get_non_dying_memcg_end() both
evaluate cgroup_subsys_on_dfl(memory_cgrp_subsys) independently to
determine whether to acquire or release the RCU read lock.

However, the result of cgroup_subsys_on_dfl() can change dynamically at
runtime due to cgroup hierarchy rebinding (e.g., when the memory
controller is moved between cgroup v1 and v2 hierarchies). This can cause
the following warning:

 =====================================
 WARNING: bad unlock balance detected!
 7.0.0-next-20260420+ #83 Tainted: G        W
 -------------------------------------
 memcg-repro/270 is trying to release lock (rcu_read_lock) at:
 [<ffffffff815f57f7>] rcu_read_unlock+0x17/0x60
 but there are no more locks to release!

 other info that might help us debug this:
 1 lock held by memcg-repro/270:
  #0: ffff888102fa2088 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x285/0x880

 stack backtrace:
 CPU: 0 UID: 0 PID: 270 Comm: memcg-repro Tainted: G        W           7.0.0-next-20260420+ #
 Tainted: [W]=WARN
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
 Call Trace:
  <TASK>
  ? rcu_read_unlock+0x17/0x60
  dump_stack_lvl+0x77/0xb0
  print_unlock_imbalance_bug+0xe0/0xf0
  ? rcu_read_unlock+0x17/0x60
  lock_release+0x21d/0x2a0
  rcu_read_unlock+0x1c/0x60
  do_pte_missing+0x233/0xb40
  __handle_mm_fault+0x80e/0xcd0
  handle_mm_fault+0x146/0x310
  do_user_addr_fault+0x303/0x880
  exc_page_fault+0x9b/0x270
  asm_exc_page_fault+0x26/0x30
 RIP: 0033:0x5590e4eb41ea
 Code: 61 cc 66 0f 6f e0 66 0f 61 c2 66 0f db cd 66 0f 69 e2 66 0f 6f d0 66 0f 69 d4 66 0f 61 0
 RSP: 002b:00007ffcad25f030 EFLAGS: 00010202
 RAX: 00005590e4eb8010 RBX: 00007ffcad260f7d RCX: 00007f73c474d44d
 RDX: 00005590e4eb80a0 RSI: 00005590e4eb503c RDI: 000000000000000f
 RBP: 00005590e4eb70a0 R08: 0000000000000000 R09: 00007f73c483a680
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffcad25f180 R14: 00005590e4eb6dd8 R15: 00007f73c4869020
  </TASK>
 ------------[ cut here ]------------

Fix this by explicitly tracking the RCU lock state, ensuring that
rcu_read_unlock() in get_non_dying_memcg_end() is strictly paired with
the lock acquisition, regardless of any runtime rebinding events.

Fixes: 8285917d6f38 ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
Changes in v3:
 - fix -Werror=uninitialized (pointed by Sashiko)
 - collect Reviewed-by

Changes in v2:
 - remove unnessary rcu_locked setting under !CONFIG_MEMCG_V1
   (pointed by Shakeel Butt)
 - collect Acked-by

 mm/memcontrol.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3d98ab41f1f1..c03d4787d4668 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -805,12 +805,17 @@ static long memcg_state_val_in_pages(int idx, long val)
  * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race with
  * reparenting of non-hierarchical state_locals.
  */
-static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
+static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg,
+							   bool *rcu_locked)
 {
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	/* Rebinding can cause this value to be changed at runtime */
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		*rcu_locked = false;
 		return memcg;
+	}
 
 	rcu_read_lock();
+	*rcu_locked = true;
 
 	while (memcg_is_dying(memcg))
 		memcg = parent_mem_cgroup(memcg);
@@ -818,20 +823,21 @@ static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *me
 	return memcg;
 }
 
-static inline void get_non_dying_memcg_end(void)
+static inline void get_non_dying_memcg_end(bool rcu_locked)
 {
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!rcu_locked)
 		return;
 
 	rcu_read_unlock();
 }
 #else
-static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
+static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg,
+							   bool *rcu_locked)
 {
 	return memcg;
 }
 
-static inline void get_non_dying_memcg_end(void)
+static inline void get_non_dying_memcg_end(bool rcu_locked)
 {
 }
 #endif
@@ -865,12 +871,14 @@ static void __mod_memcg_state(struct mem_cgroup *memcg,
 void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val)
 {
+	bool rcu_locked = false;
+
 	if (mem_cgroup_disabled())
 		return;
 
-	memcg = get_non_dying_memcg_start(memcg);
+	memcg = get_non_dying_memcg_start(memcg, &rcu_locked);
 	__mod_memcg_state(memcg, idx, val);
-	get_non_dying_memcg_end();
+	get_non_dying_memcg_end(rcu_locked);
 }
 
 #ifdef CONFIG_MEMCG_V1
@@ -933,14 +941,15 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
+	bool rcu_locked = false;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = get_non_dying_memcg_start(pn->memcg);
+	memcg = get_non_dying_memcg_start(pn->memcg, &rcu_locked);
 	pn = memcg->nodeinfo[pgdat->node_id];
 
 	__mod_memcg_lruvec_state(pn, idx, val);
 
-	get_non_dying_memcg_end();
+	get_non_dying_memcg_end(rcu_locked);
 }
 
 /**
-- 
2.20.1


