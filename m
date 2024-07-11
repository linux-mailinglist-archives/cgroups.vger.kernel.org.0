Return-Path: <cgroups+bounces-3617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A892E981
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD2AB20E02
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB715ECCA;
	Thu, 11 Jul 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNRBesbM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED691514ED;
	Thu, 11 Jul 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704528; cv=none; b=phMXXKYad52APW1+PPGERkz8PeqUOImjhnXGostJVrfNzmDJpVs5LJL7x/xhfjGQzYcoJLEMR7WtdxGsTgQBSEgc3TZ5PgCzhBxJyZkODamb5Mp441AZWrbwFtP576dOYUDtXQr8sCy1/1pzuiYbgEpClp/GDwF9HWSQ1meqMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704528; c=relaxed/simple;
	bh=Eb9o1Di+c/CTeNyBD8sT9k+z0JOCVeAcAfUHZWxXvBM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=q1tP3La8vdKJ1mo6WpqCdsX8bRB9B/Cwa/aV92OOZ3t62Og//3wOJ8QWevRDyb+1A2b72Duhsb+pWm/G/88rNMNzbYHvHexmazwZzPwEcc+lk043KCymAn5q6do+G70mCyt0QwiIj4ZWLmd3rjBNbRD34L7huYSj2Ery7To8b4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNRBesbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFA9C116B1;
	Thu, 11 Jul 2024 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720704527;
	bh=Eb9o1Di+c/CTeNyBD8sT9k+z0JOCVeAcAfUHZWxXvBM=;
	h=Subject:From:To:Cc:Date:From;
	b=WNRBesbMcICpfsr2BZ/g2mnbaAzrpvsuLnSDEaprlkMUKyKqo5cH/x2jQPCTuiPfI
	 zLQnrYDv+33cPLokYY8sSI5CPNtD3ehmfAE1PJpvCDqjE2vLpX3NrlBxNMJ15/rft0
	 zz0bOvk/s2+M6Krb/alRcZG4UeQj5+IJ/55iQIei8wHDFpoKeXGTcqV3AYuSN5UuVK
	 aUfu7tvQNfnc1kfgsYoGsjsqDq0GjafkdUKRUcG/h8Gnv6SPgm6AOyvXhADvxAQjl9
	 m6j2+DIkhJ0ClTolOmMKDRI0aDQgj2mwrXRcfpzyApXQzQ5kckfXCpehkUKq6Iu8uw
	 nFknN7UIze/bA==
Subject: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 11 Jul 2024 15:28:42 +0200
Message-ID: <172070450139.2992819.13210624094367257881.stgit@firesoul>
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

Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
causing all kswapdN threads to wake up simultaneously. The kswapd thread
invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
operation as part of its work. This results in kernel self-induced rstat
lock contention by waking up all kswapd threads simultaneously. Leveraging
this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.

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
V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/

 include/linux/cgroup-defs.h |    2 +
 kernel/cgroup/rstat.c       |   95 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b36690ca0d3f..a33b37514c29 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -548,6 +548,8 @@ struct cgroup {
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
 #endif
+	/* completion queue for cgrp_rstat_ongoing_flusher */
+	struct completion flush_done;
 
 	/* All ancestors including self */
 	struct cgroup *ancestors[];
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..fe2a81a310bb 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -2,6 +2,7 @@
 #include "cgroup-internal.h"
 
 #include <linux/sched/cputime.h>
+#include <linux/completion.h>
 
 #include <linux/bpf.h>
 #include <linux/btf.h>
@@ -11,6 +12,7 @@
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -279,17 +281,32 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_in_loop)
+{
+	bool locked;
+
+	locked = spin_trylock_irq(&cgroup_rstat_lock);
+	if (!locked)
+		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, true);
+	else
+		trace_cgroup_rstat_locked(cgrp, cpu_in_loop, false);
+
+	return locked;
+}
+
+static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
+				       bool check_contention)
 	__acquires(&cgroup_rstat_lock)
 {
-	bool contended;
+	bool locked = false;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
-	if (contended) {
-		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
+	if (check_contention)
+		locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
+
+	if (!locked) {
 		spin_lock_irq(&cgroup_rstat_lock);
+		trace_cgroup_rstat_locked(cgrp, cpu_in_loop, check_contention);
 	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
 static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
@@ -299,6 +316,53 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+#define MAX_WAIT	msecs_to_jiffies(100)
+/* Trylock helper that also checks for on ongoing flusher */
+static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
+{
+	struct cgroup *ongoing;
+	bool locked;
+
+	/* Check if ongoing flusher is already taking care of this, if
+	 * we are a descendant skip work, but wait for ongoing flusher
+	 * to complete work.
+	 */
+retry:
+	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
+		wait_for_completion_interruptible_timeout(
+			&ongoing->flush_done, MAX_WAIT);
+		/* TODO: Add tracepoint here */
+		return false;
+	}
+
+	locked = __cgroup_rstat_trylock(cgrp, -1);
+	if (!locked) {
+		/* Contended: Handle loosing race for ongoing flusher */
+		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
+			goto retry;
+
+		__cgroup_rstat_lock(cgrp, -1, false);
+	}
+	/* Obtained lock, record this cgrp as the ongoing flusher */
+	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (!ongoing) {
+		reinit_completion(&cgrp->flush_done);
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
+	}
+	return true; /* locked */
+}
+
+static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
+{
+	/* Detect if we are the ongoing flusher */
+	if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher)) {
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
+		complete_all(&cgrp->flush_done);
+	}
+	__cgroup_rstat_unlock(cgrp, -1);
+}
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -328,7 +392,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(cgrp, cpu, true);
 		}
 	}
 }
@@ -350,9 +414,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
 
-	__cgroup_rstat_lock(cgrp, -1);
+	if (!cgroup_rstat_trylock_flusher(cgrp))
+		return;
+
 	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 /**
@@ -368,8 +434,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+
+	if (cgroup_rstat_trylock_flusher(cgrp))
+		cgroup_rstat_flush_locked(cgrp);
+	else
+		__cgroup_rstat_lock(cgrp, -1, false);
 }
 
 /**
@@ -379,7 +448,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
@@ -401,6 +470,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 		u64_stats_init(&rstatc->bsync);
 	}
 
+	init_completion(&cgrp->flush_done);
+
 	return 0;
 }
 



