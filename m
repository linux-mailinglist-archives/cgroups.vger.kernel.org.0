Return-Path: <cgroups+bounces-2539-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F68A72AA
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD461F21845
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE268134CD4;
	Tue, 16 Apr 2024 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBTGA/j4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98950134433;
	Tue, 16 Apr 2024 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289905; cv=none; b=DJfenTjdETCQEVgJda860L8ShI6LGm6KhkE2xw/+SsBwYRu+61Pjwi95VMpVeXHGb/qDHD2CZF27Wzq3KE308i0TCHWmCOVuMCXLbOtdXqgLVswHGvbf3p3nhnqKiDsquTjEgvZbzTGP8LZuTibS5vBQ9FU0w+WCAT1FG7aR7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289905; c=relaxed/simple;
	bh=xykn9xlAKIRlCdpBDJjUFA6u/Fh4oeaFhP6Oe5BJZ9w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOZet7CEiS9THFD9w6v5DpK/KnksXQhlmTOtl47Z8+adlRULND+7dlStWMFICv41GnYev1G5X6a7Wjt9QRZB9yvUd3SgNdvcxC7WOGCIl7yJfuCfJVDGwCRRdGak4dKJUcfLGhrymjx70TQBoGii38Pq+mdbaLQBQq392l+V/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBTGA/j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0820FC2BD11;
	Tue, 16 Apr 2024 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713289905;
	bh=xykn9xlAKIRlCdpBDJjUFA6u/Fh4oeaFhP6Oe5BJZ9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rBTGA/j4eYXaha1zep2XsWqQMo/7AuaFqKvR+9ztUt384qlMMGAN+2aCqPtF1UGaK
	 U2ZPG0IxNZ5eBgCilfLyWL7Af8dqomP8JBPxoNHkHEQrQ9yumvgnBhvEkzyfFooiYh
	 UfuchUwUlMiYHINfQ1r4Of3CW93zlTmy08apcPnyltNYZTekRluD60kr7Yi5rvjlco
	 eKvF5OPmD8pQ46Zmo4DAUT/lv+uhsTwiXWRXDTCWzlfR2mmHCpoiw3Bnwu4NSLAo0f
	 BbHg1J8OD7NoRHbsi3B6F+e5OyqeUQ1cNugA+Vu+KrvrJNxx1NXzHZ2s1+sDQcTf3h
	 yFyl/RclpMJmg==
Subject: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Date: Tue, 16 Apr 2024 19:51:40 +0200
Message-ID: <171328990014.3930751.10674097155895405137.stgit@firesoul>
In-Reply-To: <171328983017.3930751.9484082608778623495.stgit@firesoul>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch aims to reduce userspace-triggered pressure on the global
cgroup_rstat_lock by introducing a mechanism to limit how often reading
stat files causes cgroup rstat flushing.

In the memory cgroup subsystem, memcg_vmstats_needs_flush() combined with
mem_cgroup_flush_stats_ratelimited() already limits pressure on the
global lock (cgroup_rstat_lock). As a result, reading memory-related stat
files (such as memory.stat, memory.numa_stat, zswap.current) is already
a less userspace-triggerable issue.

However, other userspace users of cgroup_rstat_flush(), such as when
reading io.stat (blk-cgroup.c) and cpu.stat, lack a similar system to
limit pressure on the global lock. Furthermore, userspace can easily
trigger this issue by reading those stat files.

Typically, normal userspace stats tools (e.g., cadvisor, nomad, systemd)
spawn threads that read io.stat, cpu.stat, and memory.stat (even from the
same cgroup) without realizing that on the kernel side, they share the
same global lock. This limitation also helps prevent malicious userspace
applications from harming the kernel by reading these stat files in a
tight loop.

To address this, the patch introduces cgroup_rstat_flush_ratelimited(),
similar to memcg's mem_cgroup_flush_stats_ratelimited().

Flushing occurs per cgroup (even though the lock remains global) a
variable named rstat_flush_last_time is introduced to track when a given
cgroup was last flushed. This variable, which contains the jiffies of the
flush, shares properties and a cache line with rstat_flush_next and is
updated simultaneously.

For cpu.stat, we need to acquire the lock (via cgroup_rstat_flush_hold)
because other data is read under the lock, but we skip the expensive
flushing if it occurred recently.

Regarding io.stat, there is an opportunity outside the lock to skip the
flush, but inside the lock, we must recheck to handle races.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 block/blk-cgroup.c          |    2 +
 include/linux/cgroup-defs.h |    1 +
 include/linux/cgroup.h      |    3 +-
 kernel/cgroup/rstat.c       |   60 ++++++++++++++++++++++++++++++++++++++++++-
 mm/memcontrol.c             |    1 +
 5 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a..4156fedbb910 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1162,7 +1162,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		cgroup_rstat_flush_ratelimited(blkcg->css.cgroup);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..366dc644e075 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -509,6 +509,7 @@ struct cgroup {
 	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
 	 */
 	struct cgroup	*rstat_flush_next;
+	unsigned long	rstat_flush_last_time;
 
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..8622b222453e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -689,7 +689,8 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_hold(struct cgroup *cgrp);
+int cgroup_rstat_flush_hold(struct cgroup *cgrp);
+int cgroup_rstat_flush_ratelimited(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(struct cgroup *cgrp);
 
 /*
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a90d68a7c27f..8c71af67b197 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -193,6 +193,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	/* Push @root to the list first before pushing the children */
 	head = root;
 	root->rstat_flush_next = NULL;
+	root->rstat_flush_last_time = jiffies;
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
@@ -261,12 +262,15 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 
 	lockdep_assert_held(&cgroup_rstat_lock);
 
+	cgrp->rstat_flush_last_time = jiffies;
+
 	for_each_possible_cpu(cpu) {
 		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
 
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
+			pos->rstat_flush_last_time = jiffies;
 			cgroup_base_stat_flush(pos, cpu);
 			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
@@ -309,6 +313,49 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
+#define FLUSH_TIME	msecs_to_jiffies(50)
+
+/**
+ * cgroup_rstat_flush_ratelimited - limit pressure on global lock (cgroup_rstat_lock)
+ * @cgrp: target cgroup
+ *
+ * Trade accuracy for less pressure on global lock. Only use this when caller
+ * don't need 100% up-to-date stats.
+ *
+ * Userspace stats tools spawn threads reading io.stat, cpu.stat and memory.stat
+ * from same cgroup, but kernel side they share same global lock.  This also
+ * limit malicious userspace from hurting kernel by reading these stat files in
+ * a tight loop.
+ *
+ * This function exit early if flush recently happened.
+ *
+ * Returns 1 if flush happened
+ */
+int cgroup_rstat_flush_ratelimited(struct cgroup *cgrp)
+{
+	int res = 0;
+
+	might_sleep();
+
+	/* Outside lock: check if this flush and lock can be skipped */
+	if (time_before(jiffies,
+			READ_ONCE(cgrp->rstat_flush_last_time) + FLUSH_TIME))
+		return 0;
+
+	__cgroup_rstat_lock(cgrp, -1);
+
+	/* Recheck inside lock, do flush after enough time have passed */
+	if (time_after(jiffies,
+		       cgrp->rstat_flush_last_time + FLUSH_TIME)) {
+		cgroup_rstat_flush_locked(cgrp);
+		res = 1;
+	}
+
+	__cgroup_rstat_unlock(cgrp, -1);
+
+	return res;
+}
+
 /**
  * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
  * @cgrp: target cgroup
@@ -317,13 +364,22 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
  * paired with cgroup_rstat_flush_release().
  *
  * This function may block.
+ *
+ * Returns 1 if flush happened
  */
-void cgroup_rstat_flush_hold(struct cgroup *cgrp)
+int cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+
+	/* Only do expensive flush after enough time have passed */
+	if (time_after(jiffies,
+		       cgrp->rstat_flush_last_time + FLUSH_TIME)) {
+		cgroup_rstat_flush_locked(cgrp);
+		return 1;
+	}
+	return 0;
 }
 
 /**
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c69..771261612ec1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -742,6 +742,7 @@ static void do_flush_stats(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
+	/* memcg have own ratelimit layer */
 	cgroup_rstat_flush(memcg->css.cgroup);
 }
 



