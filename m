Return-Path: <cgroups+bounces-4700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6096C7BF
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 21:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7031F1C250A9
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17871E6DE5;
	Wed,  4 Sep 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxzGiTn6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4211E6321;
	Wed,  4 Sep 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478874; cv=none; b=Adwx2NR1GitGJFx4ZnDLdkRpTb6HhFCf0EnR78aXU3nihQPLO6D/8Gt9f3oApCAFcbVZ659F6rY+mSuzEeH9n0zIhn4tQx0J9PpnjFU3+lLFsv54wkShjpPr9m1EVvh3CLY4yIYnbBO6nzLmgl900iiiB4kWucsmwgjsjU97nCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478874; c=relaxed/simple;
	bh=+P1nXsv5c2AU6eGz3Z1uqksdsy9OIBytD2R938NaV0U=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=NA4DFn2+nHSEbPwyfI4KrziIJJ2OJX1kXa+W4t8tP3wvhk5B3xb8igW7e/FCZtRX+t2vSQnn3UtIxvOhqvQHXTz48pXGNEzFXV96K8PM0aD/7ubmrgsmTmWNGSVPgqov1CMJlnnwYV+Q86QdwYuav+is+/CHyvJTOAHUnw0TyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxzGiTn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C209DC4CEC2;
	Wed,  4 Sep 2024 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725478874;
	bh=+P1nXsv5c2AU6eGz3Z1uqksdsy9OIBytD2R938NaV0U=;
	h=Subject:From:To:Cc:Date:From;
	b=RxzGiTn6T/ENHaJKp9kSrjXY1MNB45MpzR3mJjZinobgAl31xETgNcf+uafQb2nSc
	 tNCHvvwATPHV3ryifB905e91EPvdqWYQ68M1jPdecqvjChsUHOYWp5CUKXwIwD07rk
	 tuYyNnNypJbS7g1TmVqRs1pChvkLkZ6uPsUxFaKQ4VpPUojT/EGFhWBkpuvH2gT5B4
	 InxlXfo+erWk7eutXvczgPBsDcYIKENWKK6CqhJkVRJCXIFFFoDvirUBlPFqVxACyc
	 2Oez+Gkxb1kLp168M1USm1DbAJTHmxBx42mwk4ZXWZCkjV2oAEHXqvc5QmtyZ5n1Rl
	 FszWEQ5syzSbg==
Subject: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing root
 flush
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 21:41:09 +0200
Message-ID: <172547884995.206112.808619042206173396.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch reintroduces and generalizes the "stats_flush_ongoing" concept to
avoid redundant flushes if there is an ongoing flush at cgroup root level,
addressing production lock contention issues on the global cgroup rstat lock.

At Cloudflare, we observed significant performance degradation due to
lock contention on the rstat lock, primarily caused by kswapd. The
specific mem_cgroup_flush_stats() call inlined in shrink_node, which
takes the rstat lock, is particularly problematic.

On our 12 NUMA node machines, each with a kswapd kthread per NUMA node, we
noted severe lock contention on the rstat lock, causing 12 CPUs to waste
cycles spinning every time kswapd runs. Fleet-wide stats (/proc/N/schedstat)
for kthreads revealed that we are burning an average of 20,000 CPU cores
fleet-wide on kswapd, primarily due to spinning on the rstat lock.

Here's a brief overview of the issue:
- __alloc_pages_slowpath calls wake_all_kswapds, causing all kswapdN threads
  to wake up simultaneously.
- The kswapd thread invokes shrink_node (via balance_pgdat), triggering the
  cgroup rstat flush operation as part of its work.
- balance_pgdat() has a NULL value in target_mem_cgroup, causing
  mem_cgroup_flush_stats() to flush with root_mem_cgroup.

The kernel previously addressed this with a "stats_flush_ongoing" concept,
which was removed in commit 7d7ef0a4686a ("mm: memcg: restore subtree stats
flushing"). This patch reintroduces and generalizes the concept to apply to
all users of cgroup rstat, not just memcg.

In this patch only a root cgroup can become the ongoing flusher, as this solves
the production issue. Letting other levels becoming ongoing flusher cause root
cgroup to contend on the lock again.

Some in-kernel users of the cgroup_rstat_flush() API depend on waiting for the
flush to complete before continuing. This patch introduce the call
cgroup_rstat_flush_relaxed() and use it in those cases that can live with
slightly inaccurate flushes.

This change significantly reduces lock contention, especially in
environments with multiple NUMA nodes, thereby improving overall system
performance.

Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---

V9: https://lore.kernel.org/all/172245504313.3147408.12138439169548255896.stgit@firesoul/
V8: https://lore.kernel.org/all/172139415725.3084888.13770938453137383953.stgit@firesoul
V7: https://lore.kernel.org/all/172070450139.2992819.13210624094367257881.stgit@firesoul
V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/

 block/blk-cgroup.c     |    2 +
 include/linux/cgroup.h |    1 +
 kernel/cgroup/rstat.c  |   92 ++++++++++++++++++++++++++++++++++++++++++++----
 mm/memcontrol.c        |    2 +
 4 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..e12061fc3832 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1200,7 +1200,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		cgroup_rstat_flush_relaxed(blkcg->css.cgroup);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..4f11b5721500 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -691,6 +691,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(struct cgroup *cgrp);
+void cgroup_rstat_flush_relaxed(struct cgroup *cgrp);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a06b45272411..91559ba3b187 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,8 @@
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
+static struct task_struct *cgrp_rstat_ongoing_flusher_ID = NULL;
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -299,6 +301,67 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+static inline bool cgroup_is_root(struct cgroup *cgrp)
+{
+	return cgroup_parent(cgrp) == NULL;
+}
+
+/**
+ * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
+ * @cgrp: target cgroup
+ *
+ * Function return value follow trylock semantics. Returning true when lock is
+ * obtained. Returning false when not locked and it detected flushing can be
+ * skipped as another ongoing flusher is taking care of the flush.
+ *
+ * For callers that depend on flush completing before returning a strict option
+ * is provided.
+ */
+static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool strict)
+{
+	struct cgroup *ongoing;
+
+	if (strict)
+		goto lock;
+
+	/*
+	 * Check if ongoing flusher is already taking care of this.  Descendant
+	 * check is necessary due to cgroup v1 supporting multiple root's.
+	 */
+	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (ongoing && cgroup_is_descendant(cgrp, ongoing))
+		return false;
+
+	/* Grab right to be ongoing flusher */
+	if (!ongoing && cgroup_is_root(cgrp)) {
+		struct cgroup *old;
+
+		old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
+		if (old) {
+			/* Lost race for being ongoing flusher */
+			if (cgroup_is_descendant(cgrp, old))
+				return false;
+		}
+		/* Due to lock yield combined with strict mode record ID */
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);
+	}
+lock:
+	__cgroup_rstat_lock(cgrp, -1);
+
+	return true;
+}
+
+static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
+{
+	if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher) &&
+	    READ_ONCE(cgrp_rstat_ongoing_flusher_ID) == current) {
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, NULL);
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
+	}
+
+	__cgroup_rstat_unlock(cgrp, -1);
+}
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -333,6 +396,17 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	}
 }
 
+static void __cgroup_rstat_flush(struct cgroup *cgrp, bool strict)
+{
+	might_sleep();
+
+	if (!cgroup_rstat_trylock_flusher(cgrp, strict))
+		return;
+
+	cgroup_rstat_flush_locked(cgrp);
+	cgroup_rstat_unlock_flusher(cgrp);
+}
+
 /**
  * cgroup_rstat_flush - flush stats in @cgrp's subtree
  * @cgrp: target cgroup
@@ -348,11 +422,12 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	might_sleep();
+	__cgroup_rstat_flush(cgrp, true);
+}
 
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+void cgroup_rstat_flush_relaxed(struct cgroup *cgrp)
+{
+	__cgroup_rstat_flush(cgrp, false);
 }
 
 /**
@@ -368,8 +443,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+
+	if (cgroup_rstat_trylock_flusher(cgrp, false))
+		cgroup_rstat_flush_locked(cgrp);
+	else
+		__cgroup_rstat_lock(cgrp, -1);
 }
 
 /**
@@ -379,7 +457,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..be2022f27b5f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -876,7 +876,7 @@ static void do_flush_stats(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	cgroup_rstat_flush_relaxed(memcg->css.cgroup);
 }
 
 /*



