Return-Path: <cgroups+bounces-11610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED1BC37D41
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 275F434FC54
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43F34C989;
	Wed,  5 Nov 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtbAR/JO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5C2D8783;
	Wed,  5 Nov 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376643; cv=none; b=tqTWDSiuGyPaPP9m+9xluqaj6GajjZlG8xYeoxgafDk09D4Qoo44N9x+kGgryLz1uuY6b3Snti6GqTyD/X6wXJfJxxADMhF/jb+2/Hmn0BWDfH0NkQ97c9goTz3jLuAuf2T81KftGJoiVS8HiTmj9xv98XAVMLmbSZ1f9VHFgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376643; c=relaxed/simple;
	bh=3lbd/EU2NQ8mLBwmqz/2m2jc7qv0uF70cLO4qQ/HcLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4I3orefCSJOfTMMifWUpQgYd6rWcb4z+CAnAOfRX04Z2C3m/THvsoM7nHrg52h7tzYaQ0yOKLCagkdXqVhW3f7GumxJV1OFoMLJq121zSSLXSZRKje2ea2M4177CXd4ILfI/W0AstgS1t/oDxZgByiFnlUDcHZkU0WIK4LW95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtbAR/JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21204C4CEF5;
	Wed,  5 Nov 2025 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376642;
	bh=3lbd/EU2NQ8mLBwmqz/2m2jc7qv0uF70cLO4qQ/HcLI=;
	h=From:To:Cc:Subject:Date:From;
	b=dtbAR/JOu+tct/pxmTcYqviFrVXO6KQL6RNEt8EvVv6P33xPHb9dgHSk9ViufUw5h
	 kJ1uxg96GLeI8292NUvdAXLPsvexKzZTOvz/gqFR4B6Tf9OaddzbqXg2yQcuwzn5ku
	 NZ8Sz2aQ7UWT3Uo0jQ1QoNPnzhRVhti/SyAe56tyLNPuuhK+nf+q1QjFVpUI4PCL/l
	 xdV1u0DRnHSkyp4q84sPX72DQOu3N6R+ft0MWsYIMWFXcaMrhmv46DFunA41fPSuim
	 VgLUQjfA+k0lz49d9bWIB9ytxdlmtWzuFUN4GpAWzvETdfY0TBnWeKp8qSygESbq3Z
	 Ohs2vu0HGP3Lw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Will Deacon <will@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Phil Auld <pauld@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	cgroups@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	linux-pci@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	linux-block@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tejun Heo <tj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	netdev@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 00/31 v4] cpuset/isolation: Honour kthreads preferred affinity
Date: Wed,  5 Nov 2025 22:03:16 +0100
Message-ID: <20251105210348.35256-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The kthread code was enhanced lately to provide an infrastructure which
manages the preferred affinity of unbound kthreads (node or custom
cpumask) against housekeeping constraints and CPU hotplug events.

One crucial missing piece is cpuset: when an isolated partition is
created, deleted, or its CPUs updated, all the unbound kthreads in the
top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
their preferred affinity along the way

Solve this with performing the kthreads affinity update from cpuset to
the kthreads consolidated relevant code instead so that preferred
affinities are honoured.

The dispatch of the new cpumasks to workqueues and kthreads is performed
by housekeeping, as per the nice Tejun's suggestion.

As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
now modifyable with specific synchronization. A big step toward making
nohz_full= also mutable through cpuset in the future.

Changes since v3:

- Spelling issues all over the place (Bjorn Helgaas, Simon Horman

- Comment each HK_TYPE_* (Valentin Schneider)

- Keep static branch in housekeeping_test_cpu() (Waiman Long)

- Use rcu_dereference_all_check() to also check preemption disabled
  (Chen Ridong)

- Use cpumask_size() for allocation (Waiman Long)

- Fix inverted branch on update (Phil Auld)

- Set WQ_PERCPU to memcg workqueue (Waiman Long)

- Remove linux/cpuset.h include from include/linux/sched/isolation.h
  (Waiman Long)

- Comment why unbound kthreads aren't updated on CPU online (Waiman Long)

- Remove genirq related patches (handled in another patch after discussion
  with Thomas Gleixner)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	kthread/core-v4

HEAD: 9ba457a61e09fb17a4698879367b7e6593c256d2

Thanks,
	Frederic
---

Frederic Weisbecker (30):
      PCI: Prepare to protect against concurrent isolated cpuset change
      cpu: Revert "cpu/hotplug: Prevent self deadlock on CPU hot-unplug"
      memcg: Prepare to protect against concurrent isolated cpuset change
      mm: vmstat: Prepare to protect against concurrent isolated cpuset change
      sched/isolation: Save boot defined domain flags
      cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
      driver core: cpu: Convert /sys/devices/system/cpu/isolated to use HK_TYPE_DOMAIN_BOOT
      net: Keep ignoring isolated cpuset change
      block: Protect against concurrent isolated cpuset change
      cpu: Provide lockdep check for CPU hotplug lock write-held
      cpuset: Provide lockdep check for cpuset lock held
      sched/isolation: Convert housekeeping cpumasks to rcu pointers
      cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
      sched/isolation: Flush memcg workqueues on cpuset isolated partition change
      sched/isolation: Flush vmstat workqueues on cpuset isolated partition change
      PCI: Flush PCI probe workqueue on cpuset isolated partition change
      cpuset: Propagate cpuset isolation update to workqueue through housekeeping
      cpuset: Remove cpuset_cpu_is_isolated()
      sched/isolation: Remove HK_TYPE_TICK test from cpu_is_isolated()
      PCI: Remove superfluous HK_TYPE_WQ check
      kthread: Refine naming of affinity related fields
      kthread: Include unbound kthreads in the managed affinity list
      kthread: Include kthreadd to the managed affinity list
      kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management
      sched: Switch the fallback task allowed cpumask to HK_TYPE_DOMAIN
      sched/arm64: Move fallback task cpumask to HK_TYPE_DOMAIN
      kthread: Honour kthreads preferred affinity after cpuset changes
      kthread: Comment on the purpose and placement of kthread_affine_node() call
      kthread: Document kthread_affine_preferred()
      doc: Add housekeeping documentation

Gabriele Monaco (1):
      cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping

 Documentation/cpu_isolation/housekeeping.rst | 111 +++++++++++++++++++
 arch/arm64/kernel/cpufeature.c               |  18 ++-
 block/blk-mq.c                               |   6 +-
 drivers/base/cpu.c                           |   2 +-
 drivers/pci/pci-driver.c                     |  71 ++++++++----
 include/linux/cpu.h                          |   4 +
 include/linux/cpuhplock.h                    |   1 +
 include/linux/cpuset.h                       |   8 +-
 include/linux/kthread.h                      |   1 +
 include/linux/memcontrol.h                   |   4 +
 include/linux/mmu_context.h                  |   2 +-
 include/linux/pci.h                          |   3 +
 include/linux/percpu-rwsem.h                 |   1 +
 include/linux/sched/isolation.h              |  16 ++-
 include/linux/vmstat.h                       |   2 +
 include/linux/workqueue.h                    |   2 +-
 init/Kconfig                                 |   1 +
 kernel/cgroup/cpuset.c                       | 134 +++++++++++++++-------
 kernel/cpu.c                                 |  42 +++----
 kernel/kthread.c                             | 160 ++++++++++++++++++---------
 kernel/sched/isolation.c                     | 138 ++++++++++++++++++-----
 kernel/sched/sched.h                         |   4 +
 kernel/workqueue.c                           |  17 +--
 mm/memcontrol.c                              |  25 ++++-
 mm/vmstat.c                                  |  15 ++-
 net/core/net-sysfs.c                         |   2 +-
 26 files changed, 596 insertions(+), 194 deletions(-)

