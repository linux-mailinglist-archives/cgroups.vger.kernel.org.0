Return-Path: <cgroups+bounces-2538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5778A72A7
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCCBB227F9
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BA1369B2;
	Tue, 16 Apr 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/GAY3Fl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246712EBF0;
	Tue, 16 Apr 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289899; cv=none; b=crPWeUMzt7AkiwPRvXNNTXecJ8IZZCMs2bAKB1WE9fhbiCQjHgPjfMSPBknZ8fWJRMdc94ueiNoGXXY6IZ6aBT5T+L7o0jlsLllc0/cg2wQdkJ0GTJFIxkE3QGv/io3cLukHQ2AQ75OYkwYyy/AbnAhbyYw9sypZ262n7kYwiDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289899; c=relaxed/simple;
	bh=5yq8vAYf6xC8gXi+nuWR4s1aX8FwORkuEEx5b9YmRYs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWagTtaNXNMLI0Lq4xVYy38LyAkJJOLwxb160J8Qlxs8YHbLTApPe4+aAH1Bep3CFv0fvujPIi2vPgiVSCaiKOw7KFECIrRapBNvyTI76+WyBCmJha5LN8UmoJwLciw8usUFt+X9tUyN7PStN1GBt2c6K5sXxn6IMe0Y4NvubnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/GAY3Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB99C2BD11;
	Tue, 16 Apr 2024 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713289898;
	bh=5yq8vAYf6xC8gXi+nuWR4s1aX8FwORkuEEx5b9YmRYs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I/GAY3FlPH6B1QRPQ2dqGR9a/rlcVnfGdvRVTQLO45RzGqp+LU4MWf4UwES2dc8+a
	 0BKM1Hre4ug7oBUZv1rJzeMn16gFlal2lBFm4UKtNvuhqrygHncYibMZMgGCxfxXeI
	 ymw2t80RgVLeCyqPphCGqemiZ6vti6QTZxAtrPY9iUorEpW90I2Ko8DQ7xkOq7uA+t
	 f0RH0cGf0dGovxwsZX5/eNt3Mk9J46hRV5nKs1Yz+PrESejCcpZoER+HybDBcH588p
	 FutiTe1lgqsteYKqc599Y8n2e/uPvzK1sA8VHal2CeKFIT5/QKqFRby+WL5Sn53u6q
	 JDZTow0vfEVEA==
Subject: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Date: Tue, 16 Apr 2024 19:51:33 +0200
Message-ID: <171328989335.3930751.3091577850420501533.stgit@firesoul>
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

Since kernel v4.18, cgroup_rstat_lock has been an IRQ-disabling spinlock,
as introduced by commit 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex
with a spinlock").

Despite efforts in cgroup_rstat_flush_locked() to yield the lock when
necessary during the collection of per-CPU stats, this approach has led
to several scaling issues observed in production environments. Holding
this IRQ lock has caused starvation of other critical kernel functions,
such as softirq (e.g., timers and netstack). Although kernel v6.8
introduced optimizations in this area, we continue to observe instances
where the spin_lock is held for 64-128 ms in production.

This patch converts cgroup_rstat_lock back to being a mutex lock. This
change is made possible thanks to the significant effort by Yosry Ahmed
to eliminate all atomic context use-cases through multiple commits,
ending in 0a2dc6ac3329 ("cgroup: removecgroup_rstat_flush_atomic()"),
included in kernel v6.5.

After this patch lock contention will be less obvious, as converting this
to a mutex avoids multiple CPUs spinning while waiting for the lock, but
it doesn't remove the lock contention. It is recommended to use the
tracepoints to diagnose this.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/cgroup/rstat.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ff68c904e647..a90d68a7c27f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,7 +9,7 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(cgroup_rstat_lock);
+static DEFINE_MUTEX(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
@@ -238,10 +238,10 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
 {
 	bool contended;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
+	contended = !mutex_trylock(&cgroup_rstat_lock);
 	if (contended) {
 		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
-		spin_lock_irq(&cgroup_rstat_lock);
+		mutex_lock(&cgroup_rstat_lock);
 	}
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
@@ -250,7 +250,7 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	__releases(&cgroup_rstat_lock)
 {
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	mutex_unlock(&cgroup_rstat_lock);
 }
 
 /* see cgroup_rstat_flush() */
@@ -278,7 +278,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 		}
 
 		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
+		if (need_resched()) {
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();



