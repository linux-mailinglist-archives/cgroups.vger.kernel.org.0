Return-Path: <cgroups+bounces-8025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75175AAA90E
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 03:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C035987717
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E13355665;
	Mon,  5 May 2025 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQoF7fj1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D135466C;
	Mon,  5 May 2025 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484875; cv=none; b=F1oBoa7bzBle4OO9eZ1hp+JxeWXD7RMcNa6aSAKDLXC8qX+uWAhCK9VgP2v9GtRve+P/O8jTtXiAekPjttnWxtNeEabh1G2vvFGQ9A/psIIaFjU+8jfsCKcL5uahyunJfdyN83PyBqbV9JYz/4X9Rev7IXRS4h8wPrESuu/HjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484875; c=relaxed/simple;
	bh=Pf0UDKi0u/W85Vxs0pnhVYiOyMeMAr4YGS6GScDUHRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuRaI6NIU0Y2NNYcIsQjapFUyvrICTt0cVkEn9Mk/fgVbdHSsnGzdGKSbvg4WrzaRM9XrG+eDUZ8ezILQbEsc0SXnc0vznFZp7GwHqDMbQwrbPSYMUOLaKhimj7I8UeFzOoRBfBZtMUHOktdOjqPhj/XZ43xo2rws6S3QOEpNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQoF7fj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443FDC4CEED;
	Mon,  5 May 2025 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484875;
	bh=Pf0UDKi0u/W85Vxs0pnhVYiOyMeMAr4YGS6GScDUHRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQoF7fj19o+p1ZPPUB61PHYq5374bVr7WbVgd3luCPh7yCbvTREBWSba2GT/KqTrO
	 L2bMQ68jQrXBGAq8kKhNyeJFXJ65jYGwOB3ew5q+VFfXdqvesRJ4jtRVX6YqLTJYQL
	 7q24/hA/k3BN2ln5gP5kCPUZLNjN+AzCchzNZ5aZYcACdciTq1NIwdtOZ+c4Vocilr
	 RqagZL1P5HeDIhsv6XN9CqMVrNP8RjpUrYdzbiZyZwFj6RmQtY2MRlJyeZOaMZw1lM
	 osa0sVUy80zRm9aJVx6R/FoHacgtv+gGXUyVP4xY3lv6R1GbDddx5GMa16/59xST1f
	 H3lOzqDLf2CBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 059/486] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Date: Mon,  5 May 2025 18:32:15 -0400
Message-Id: <20250505223922.2682012-59-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0efc297a3c4974dbd609ee36fc6345720b6ca735 ]

cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
iterating all possible cpus. It only drops the lock if there is
scheduler or spin lock contention. If neither, then interrupts can be
disabled for a long time. On large machines this can disable interrupts
for a long enough time to drop network packets. On 400+ CPU machines
I've seen interrupt disabled for over 40 msec.

Prevent rstat from disabling interrupts while processing all possible
cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
approach was previously discussed in
https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
though this was in the context of an non-irq rstat spin lock.

Benchmark this change with:
1) a single stat_reader process with 400 threads, each reading a test
   memcg's memory.stat repeatedly for 10 seconds.
2) 400 memory hog processes running in the test memcg and repeatedly
   charging memory until oom killed. Then they repeat charging and oom
   killing.

v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
interrupts are disabled by rstat for 45341 usec:
  #  => started at: _raw_spin_lock_irq
  #  => ended at:   cgroup_rstat_flush
  #
  #
  #                    _------=> CPU#
  #                   / _-----=> irqs-off/BH-disabled
  #                  | / _----=> need-resched
  #                  || / _---=> hardirq/softirq
  #                  ||| / _--=> preempt-depth
  #                  |||| / _-=> migrate-disable
  #                  ||||| /     delay
  #  cmd     pid     |||||| time  |   caller
  #     \   /        ||||||  \    |    /
  stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
  stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
  stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
  stat_rea-96532    52d.... 45343us : <stack trace>
   => memcg1_stat_format
   => memory_stat_format
   => memory_stat_show
   => seq_read_iter
   => vfs_read
   => ksys_read
   => do_syscall_64
   => entry_SYSCALL_64_after_hwframe

With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
longest holder. The longest irqs-off holder has irqs disabled for
4142 usec, a huge reduction from previous 45341 usec rstat finding.

Running stat_reader memory.stat reader for 10 seconds:
- without memory hogs: 9.84M accesses => 12.7M accesses
-    with memory hogs: 9.46M accesses => 11.1M accesses
The throughput of memory.stat access improves.

The mode of memory.stat access latency after grouping by of 2 buckets:
- without memory hogs: 64 usec => 16 usec
-    with memory hogs: 64 usec =>  8 usec
The memory.stat latency improves.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Greg Thelen <gthelen@google.com>
Tested-by: Greg Thelen <gthelen@google.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/rstat.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 3e01781aeb7bd..c4ce2f5a9745f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			rcu_read_unlock();
 		}
 
-		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(cgrp, cpu);
-			if (!cond_resched())
-				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
-		}
+		/* play nice and avoid disabling interrupts for a long time */
+		__cgroup_rstat_unlock(cgrp, cpu);
+		if (!cond_resched())
+			cpu_relax();
+		__cgroup_rstat_lock(cgrp, cpu);
 	}
 }
 
-- 
2.39.5


