Return-Path: <cgroups+bounces-3383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B69199AF
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 23:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3491C21F1E
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCFB193064;
	Wed, 26 Jun 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6ieFS/G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43E18FDBC;
	Wed, 26 Jun 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436712; cv=none; b=CqULanFm5SeV2SLz8MBtMIgKz1TA5d3kmAgLaxMC+jFM2dGRIm8bT1vE9yFP1fNatWcTLcjH+ZKnpRQ+y0M6CptoLMBIl6C0TGgt4vol66JL0BZOsPAAJxr0TGkYQFiWCKunp9gjMcY/L3A03ESq/4n6G8d6hk83uc0Qv5j+ZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436712; c=relaxed/simple;
	bh=Fte+YSeQ6XczvTdXOJBvpZBjnXsFCrrzsvBXG8KQyNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfwbUvHPc0RQKfm4AeuPyvfHYuN3C2UQpIn4Nl/ODXx7chTyiI/d/a2/Ph+11ohM+Zthwk383wIUWTBw4w9FDlF5Hgb5EdhzjJJymWTARQnWJk3ritWIL1t9wPiSFdLAygpVKEs8LxAmSAXBvpvf9lRoJ+C9SOOGMw0BOJvT+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6ieFS/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14138C116B1;
	Wed, 26 Jun 2024 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719436712;
	bh=Fte+YSeQ6XczvTdXOJBvpZBjnXsFCrrzsvBXG8KQyNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U6ieFS/Gcvr/Hq+fX5/rvTxKhR3jGqMx0im4R27mH/nGauoRKT5VTGnP7y5HVDzup
	 +bUJ8hqgjtZjY/LZMEJp0jkB8XzNG5R6CAfS+q3b6wemm+2yeUuIqMIxzIuOK938D5
	 dCGLA+5hAmyoFTfS2jZlbpmr+YbSagD4g97N3TSOZbtB1B7bdNtKdK+H9GFj2RiSnm
	 2N9patZYlTspjkhwtJjoFdUHn5mW8Fk4amKFkpU4At9vZJLmW206/lxzwrl3REFDyd
	 XhKmRbX0quGF2pGiU2wxcl9lfok6v/GC479XV7oUHYvmQTq5h1OVnuCcyqKvvzpbKo
	 5RxRJnJPSOEKg==
Subject: [PATCH V3 2/2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 23:18:27 +0200
Message-ID: <171943668946.1638606.1320095353103578332.stgit@firesoul>
In-Reply-To: <171943667611.1638606.4158229160024621051.stgit@firesoul>
References: <171943667611.1638606.4158229160024621051.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Avoid lock contention on the global cgroup rstat lock caused by kswapd
starting on all NUMA nodes simultaneously. At Cloudflare, we observed
massive issues due to kswapd and the specific mem_cgroup_flush_stats()
call inlined in shrink_node, which takes the rstat lock.

On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
we noted severe lock contention on the rstat lock. This contention
causes 12 CPUs to waste cycles spinning every time kswapd runs.
Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
due to spinning on the rstat lock.

To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
empty, __alloc_pages_slowpath calls wake_all_kswapds(), causing all
kswapdN threads to wake up simultaneously. The kswapd thread invokes
shrink_node (via balance_pgdat) triggering the cgroup rstat flush
operation as part of its work. This results in kernel self-induced rstat
lock contention by waking up all kswapd threads simultaneously.
Leveraging this detail: balance_pgdat() have NULL value in
target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
root_mem_cgroup.

To avoid this kind of thundering herd problem, kernel previously had a
"stats_flush_ongoing" concept, but this was removed as part of commit
7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
reintroduce and generalized the concept to apply to all users of cgroup
rstat, not just memcg.

If there is an ongoing rstat flush, and current cgroup is a descendant,
then it is unnecessary to do the flush. For callers to still see updated
stats, wait for ongoing flusher to complete before returning, but add
timeout as stats are already inaccurate given updaters keeps running.

Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/

 kernel/cgroup/rstat.c |   61 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 2a42be3a9bb3..f21e6b1109a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -2,6 +2,7 @@
 #include "cgroup-internal.h"
 
 #include <linux/sched/cputime.h>
+#include <linux/completion.h>
 
 #include <linux/bpf.h>
 #include <linux/btf.h>
@@ -11,6 +12,8 @@
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static struct cgroup *cgrp_rstat_ongoing_flusher;
+static DECLARE_COMPLETION(cgrp_rstat_flusher_done);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -346,6 +349,44 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	}
 }
 
+#define MAX_WAIT	msecs_to_jiffies(100)
+/* Trylock helper that also checks for on ongoing flusher */
+static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
+{
+retry:
+	bool locked = __cgroup_rstat_trylock(cgrp, -1);
+	if (!locked) {
+		struct cgroup *cgrp_ongoing;
+
+		/* Lock is contended, lets check if ongoing flusher is already
+		 * taking care of this, if we are a descendant.
+		 */
+		cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+		if (!cgrp_ongoing)
+			goto retry;
+
+		if (cgroup_is_descendant(cgrp, cgrp_ongoing)) {
+			wait_for_completion_interruptible_timeout(
+				&cgrp_rstat_flusher_done, MAX_WAIT);
+
+			return false;
+		}
+		__cgroup_rstat_lock(cgrp, -1, false);
+	}
+	/* Obtained lock, record this cgrp as the ongoing flusher */
+	reinit_completion(&cgrp_rstat_flusher_done);
+	WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
+
+	return true; /* locked */
+}
+
+static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
+{
+	WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
+	complete_all(&cgrp_rstat_flusher_done);
+	__cgroup_rstat_unlock(cgrp, -1);
+}
+
 /**
  * cgroup_rstat_flush - flush stats in @cgrp's subtree
  * @cgrp: target cgroup
@@ -361,18 +402,13 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	bool locked;
-
 	might_sleep();
 
-	locked = __cgroup_rstat_trylock(cgrp, -1);
-	if (!locked) {
-		/* Opportunity to ongoing flush detection */
-		__cgroup_rstat_lock(cgrp, -1, false);
-	}
+	if (!cgroup_rstat_trylock_flusher(cgrp))
+		return;
 
 	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 /**
@@ -388,8 +424,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1, true);
-	cgroup_rstat_flush_locked(cgrp);
+
+	if (cgroup_rstat_trylock_flusher(cgrp))
+		cgroup_rstat_flush_locked(cgrp);
+	else
+		__cgroup_rstat_lock(cgrp, -1, true);
 }
 
 /**
@@ -399,7 +438,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)



