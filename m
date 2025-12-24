Return-Path: <cgroups+bounces-12655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD2CDC62B
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C54F3075451
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2482C0281;
	Wed, 24 Dec 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7mMb30Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4431E885A;
	Wed, 24 Dec 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766583949; cv=none; b=fSOzPwhpIHj3irTyOEnqtDklpCaihMYETsMFk6bYc7+aAyaZQVSIjD6S/zEQMGBP6HDl8/bqcUgalUA2tKJ83byGyr3mLg3ghleN7Bzq8zptuNOWaOIfgO4z5Cp+nAujzEs0P1apEZx0rKTrTHV9JkGwbakdj3XAoh7BaMFgTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766583949; c=relaxed/simple;
	bh=11kVg/bDOXpa/yvnQMWYkjqm5C/SPwrAAGSvfZEuxSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLwOwQoD4HekASB4JfrfZbXmjMwntvvhQwqMh7GwucCcksaE6Lzv0I9KKTnUpIK8PWMolv4N/ymTAlVqgYT8n+fztGpQGOT+ln798Daa21XBfKNsexVOObbDIn9hAJtzylkLS09zVCNrB/1Qm7tey+kuvu8qCyXN4z5i4ti9MJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7mMb30Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC57C4CEFB;
	Wed, 24 Dec 2025 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766583949;
	bh=11kVg/bDOXpa/yvnQMWYkjqm5C/SPwrAAGSvfZEuxSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7mMb30Qrj92/uviIhc1fyEu+nlpB/xOX1eLU8tjIzv3vuprkqSRobPPuypYr4P86
	 KKG/T/ugcEL7chZ7jENBr+nDTaB3fIQi73GMI/yU4M9CSLpe5XHRfs2aG3MH798ZKl
	 4W/s54uzqvvTq1KFo01rD6iLvt2JZgIB7Zox3EjCQFHqsDBeakRVEyKAdhPX9plzTc
	 aF7Nqm7+o5LRlE4Mh0g/fVhpHlIWeUJo9F24g6Tw54kHme7x7rVQ5M2lw44yP9OcQP
	 8I1gtwsfIgFGPD3ffd6khrIbcSTp71xzfbRWYvyWJ0QW3FHw2OXLZOVvnkrZ4PQwN7
	 u8QBR2FBdMU/w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 02/33] cpu: Revert "cpu/hotplug: Prevent self deadlock on CPU hot-unplug"
Date: Wed, 24 Dec 2025 14:44:49 +0100
Message-ID: <20251224134520.33231-3-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251224134520.33231-1-frederic@kernel.org>
References: <20251224134520.33231-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1) The commit:

	2b8272ff4a70 ("cpu/hotplug: Prevent self deadlock on CPU hot-unplug")

was added to fix an issue where the hotplug control task (BP) was
throttled between CPUHP_AP_IDLE_DEAD and CPUHP_HRTIMERS_PREPARE waiting
in the hrtimer blindspot for the bandwidth callback queued in the dead
CPU.

2) Later on, the commit:

	38685e2a0476 ("cpu/hotplug: Don't offline the last non-isolated CPU")

plugged on the target selection for the workqueue offloaded CPU down
process to prevent from destroying the last CPU domain.

3) Finally:

	5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")

removed entirely the conditions for the race exposed and partially fixed
in 1). The offloading of the CPU down process to a workqueue on another
CPU then becomes unnecessary. But the last CPU belonging to scheduler
domains must still remain online.

Therefore revert the now obsolete commit
2b8272ff4a70b866106ae13c36be7ecbef5d5da2 and move the housekeeping check
under the cpu_hotplug_lock write held. Since HK_TYPE_DOMAIN will include
both isolcpus and cpuset isolated partition, the hotplug lock will
synchronize against concurrent cpuset partition updates.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8df2d773fe3b..40b8496f47c5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1410,6 +1410,16 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
 	cpus_write_lock();
 
+	/*
+	 * Keep at least one housekeeping cpu onlined to avoid generating
+	 * an empty sched_domain span.
+	 */
+	if (cpumask_any_and(cpu_online_mask,
+			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	cpuhp_tasks_frozen = tasks_frozen;
 
 	prev_state = cpuhp_set_state(cpu, st, target);
@@ -1456,22 +1466,8 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	return ret;
 }
 
-struct cpu_down_work {
-	unsigned int		cpu;
-	enum cpuhp_state	target;
-};
-
-static long __cpu_down_maps_locked(void *arg)
-{
-	struct cpu_down_work *work = arg;
-
-	return _cpu_down(work->cpu, 0, work->target);
-}
-
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
-	struct cpu_down_work work = { .cpu = cpu, .target = target, };
-
 	/*
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
@@ -1480,18 +1476,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-
-	/*
-	 * Ensure that the control task does not run on the to be offlined
-	 * CPU to prevent a deadlock against cfs_b->period_timer.
-	 * Also keep at least one housekeeping cpu onlined to avoid generating
-	 * an empty sched_domain span.
-	 */
-	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN)) {
-		if (cpu != work.cpu)
-			return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
-	}
-	return -EBUSY;
+	return _cpu_down(cpu, 0, target);
 }
 
 static int cpu_down(unsigned int cpu, enum cpuhp_state target)
-- 
2.51.1


