Return-Path: <cgroups+bounces-3266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80A9127E3
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD301C263F4
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B122031D;
	Fri, 21 Jun 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw7RZSee"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D884436;
	Fri, 21 Jun 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980376; cv=none; b=XSW+Bi+TKPav+ZAX8DvilZ0oUl+dJt3OkQcAk2giY4wKEwfPARryNbQRA9HxHbwoBrRt9V70cCp9zYu5HX4i8BfTznEtl1Uf7aHGWoOBe1yoH9XoHnuvhJTaLfkvaoh4BgFpdHKU5eNVCDUA/G4TkivKxzF4pX4Tcwm52ll0NrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980376; c=relaxed/simple;
	bh=ez03aVKBlqGthUjZy/ZRNjr5TOr2Y00yZXdbgrk//tQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=QiZciIcY8SYWvyPig7JlTWvHz+lx81PbIPg05p9wovC1DGUh0th/HhfTRDak/DBEH3T+92vkYhiRkpNoSgh5j9GleW+qFGnkYaqfH8hZmrU9FFcJoM/F24TOigzgDkxZN7hxWtZh93MpJb4X/qsABbsAiMv/u6mAsJO/ds+qKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw7RZSee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44796C4AF08;
	Fri, 21 Jun 2024 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718980375;
	bh=ez03aVKBlqGthUjZy/ZRNjr5TOr2Y00yZXdbgrk//tQ=;
	h=Subject:From:To:Cc:Date:From;
	b=Lw7RZSeeaO9duH9TTQvuqZ1NRkCsIavqwGDeNGjGj1lPcgKSG1tMmPb86gwmYTBEp
	 QBBUS9aGRHw3hTTB+q+2eYwpmJDQMr5koen1v0X0zEO0El95ER1+Qw41KR+GLGpYLH
	 sYIm37RwkhMnY/w6GkRTYLy0ksOaHWIpS5eQePfEAFOs8S+5j5p4O2T/aUz8iegk9L
	 GlIpFuIJahJkUbE3fXuQNmH2OCuAkCBhIveOnA9kPe+fAVwnAHo1cNUPV3oRjJx2Kq
	 rn6/SfVxO8alI3p8CrTDRMxmrpJU2Lu286EXChTP3D3SoLcv/g0HpR1mk35X1FeK2b
	 OOhC//SFZB/xQ==
Subject: [PATCH v1] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 21 Jun 2024 16:32:50 +0200
Message-ID: <171898037079.1222367.13467317484793748519.stgit@firesoul>
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

To resolve the kswapd issue, we generalized the "stats_flush_ongoing"
concept to apply to all users of cgroup rstat, not just memcg. This
concept was originally reverted in commit 7d7ef0a4686a ("mm: memcg:
restore subtree stats flushing"). If there is an ongoing rstat flush,
limited to the root cgroup, the flush is skipped. This is effective as
kswapd operates on the root tree, sufficiently mitigating the thundering
herd problem.

This lowers contention on the global rstat lock, although limited to the
root cgroup. Flushing cgroup subtree's can still lead to lock contention.

Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/linux/cgroup.h |    5 +++++
 kernel/cgroup/rstat.c  |   28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..ad41cca5c3b6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -499,6 +499,11 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 	return NULL;
 }
 
+static inline bool cgroup_is_root(struct cgroup *cgrp)
+{
+	return cgroup_parent(cgrp) == NULL;
+}
+
 /**
  * cgroup_is_descendant - test ancestry
  * @cgrp: the cgroup to be tested
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..5aba95e92d31 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,7 @@
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static atomic_t root_rstat_flush_ongoing = ATOMIC_INIT(0);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -350,8 +351,25 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
 
+	/*
+	 * This avoids thundering herd problem on global rstat lock. When an
+	 * ongoing flush of the entire tree is in progress, then skip flush.
+	 */
+	if (atomic_read(&root_rstat_flush_ongoing))
+		return;
+
+	/* Grab right to be ongoing flusher, return if loosing race */
+	if (cgroup_is_root(cgrp) &&
+	    atomic_xchg(&root_rstat_flush_ongoing, 1))
+		return;
+
 	__cgroup_rstat_lock(cgrp, -1);
+
 	cgroup_rstat_flush_locked(cgrp);
+
+	if (cgroup_is_root(cgrp))
+		atomic_set(&root_rstat_flush_ongoing, 0);
+
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
@@ -362,13 +380,20 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
  * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
  * paired with cgroup_rstat_flush_release().
  *
+ * Current invariant, not called with root cgrp.
+ *
  * This function may block.
  */
 void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
+
 	__cgroup_rstat_lock(cgrp, -1);
+
+	if (atomic_read(&root_rstat_flush_ongoing))
+		return;
+
 	cgroup_rstat_flush_locked(cgrp);
 }
 
@@ -379,6 +404,9 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
+	if (cgroup_is_root(cgrp))
+		atomic_set(&root_rstat_flush_ongoing, 0);
+
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 



