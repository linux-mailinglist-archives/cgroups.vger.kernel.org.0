Return-Path: <cgroups+bounces-3577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A3292B73F
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478E4B22AF2
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE64C158A02;
	Tue,  9 Jul 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKVJSBeu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC391158201;
	Tue,  9 Jul 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524053; cv=none; b=pHHzjfQA8fnZZ/XoqEA27VVDZA34cosLuSu6vOQWx3bNRAVXA7ndHrXdhvmp0u5nQkivOTlu2CwAIE9XIG9xRCF/UKivaU7e7vbszyRt40UOv3YyeTpbjLYjvM6Q2iN6Igj2qgKEQu9fY/e8Q01zwrhDEhoYUbAZCo0AbnyAUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524053; c=relaxed/simple;
	bh=uzbwOmcXWAlo++p7zYdgl6a5JDjwKTDeVm3y97WXpRs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=r8vLAqeLLxWPG16OZF0BzmCY6hz7WepNpCSyTDJaWAQLH6dHR//HkfLCkcXeiLhAFmeDHcbjgvxfiLozVCjMah6uyIlj22B0vNaLsybJeaXO1WuZHJUp90eDJjNBLdWmoNogXgefCqmqNzo9hcO0wGHQP0t3vKiCbyNdQHEdDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKVJSBeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE6C4AF0A;
	Tue,  9 Jul 2024 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720524053;
	bh=uzbwOmcXWAlo++p7zYdgl6a5JDjwKTDeVm3y97WXpRs=;
	h=Subject:From:To:Cc:Date:From;
	b=fKVJSBeu3Vmjb5cOTxW9wcwD7v5mXK3Lsj6k9G/5/AtIReEs3tHgrFjN8367bxsrB
	 t5aWZDqo6wDTUYRHvSGTX2MEgDpS7zbiwT+a9Nhy+XMqZxmclzP6aX4C+EEQefSPeg
	 E/vKIo6nm4Px2pkODEjDc5pvuio8AYaWYj1rsYyyvg+73Va8NR8j/eI6jJM8VZg+nV
	 OxSSWo4VzDCvFq7Ikd7SqLnup3V21zqQGRnPVYPsx2ujaWguj4xe11DgvUkmkbBsIy
	 sXnhpjyVJpMu1lOJNDGMHMoJVqIsEzVyv/5GkHA27SvByv+RC/gJKmmSD7VWxn77HZ
	 VedNpi0qPK1Jw==
Subject: [PATCH V6] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2024 13:20:48 +0200
Message-ID: <172052399087.2357901.4955042377343593447.stgit@firesoul>
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
V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/

 include/linux/cgroup-defs.h |    2 +
 kernel/cgroup/rstat.c       |   95 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 84 insertions(+), 13 deletions(-)

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
index fb8b49437573..d0b9b8bf275d 100644
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
 
@@ -279,17 +281,30 @@ __bpf_hook_end();
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
+		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, !locked);
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
+	if (!locked)
 		spin_lock_irq(&cgroup_rstat_lock);
-	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
+
+	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, !locked);
 }
 
 static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
@@ -299,6 +314,53 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+#define MAX_WAIT	msecs_to_jiffies(100)
+/* Trylock helper that also checks for on ongoing flusher */
+static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
+{
+	struct cgroup *cgrp_ongoing;
+	bool locked;
+
+	/* Check if ongoing flusher is already taking care of this, if
+	 * we are a descendant skip work, but wait for ongoing flusher
+	 * to complete work.
+	 */
+retry:
+	cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)) {
+		wait_for_completion_interruptible_timeout(
+			&cgrp_ongoing->flush_done, MAX_WAIT);
+		/* TODO: Add tracepoint here */
+		return false;
+	}
+
+	locked = __cgroup_rstat_trylock(cgrp, -1);
+	if (!locked) {
+		/* Contended: Handle loosing race for ongoing flusher */
+		if (!cgrp_ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
+			goto retry;
+
+		__cgroup_rstat_lock(cgrp, -1, false);
+	}
+	/* Obtained lock, record this cgrp as the ongoing flusher */
+	cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (!cgrp_ongoing) {
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
@@ -328,7 +390,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(cgrp, cpu, true);
 		}
 	}
 }
@@ -350,9 +412,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
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
@@ -368,8 +432,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
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
@@ -379,7 +446,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
@@ -401,6 +468,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 		u64_stats_init(&rstatc->bsync);
 	}
 
+	init_completion(&cgrp->flush_done);
+
 	return 0;
 }
 



