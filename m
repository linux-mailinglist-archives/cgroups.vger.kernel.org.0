Return-Path: <cgroups+bounces-12849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B7CED608
	for <lists+cgroups@lfdr.de>; Thu, 01 Jan 2026 23:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139F630057C1
	for <lists+cgroups@lfdr.de>; Thu,  1 Jan 2026 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB398264612;
	Thu,  1 Jan 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+AnEX/U"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84863205E02;
	Thu,  1 Jan 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305652; cv=none; b=BJVsDaIM3uPcQA6C4pvKdwIH/ao4P0osa+yk3EIpbVXE4APixIsbfkK2p1pAa0KbCq2NBtfGUSzq7hnccHAfcNaA7c2K69PxJ5+XdN07hV2Dp5UNAAg/tQ9TaI+QB/fl+ZmfresBlElHpU604+WS+fDDTOTECGXuu28UZvllgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305652; c=relaxed/simple;
	bh=TkV0C834LNJT27mx2/Ayl0IxXi3IFIB0xDgB+kxqTGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOXKWrMCCWZsJNK5g54uUftTVh1UEQBJzObcYXccvFaKqCGuuKw98zLy5mh55ueLq4huiUO51V9dSW7rBLWAvLOFQd59votL2vvrtOZ1juY1bRohV7o+XC0WIlaVIAatrNxaKwnfm+gbF7MIptS9oB6c96uFjKBOSay9OXWt2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+AnEX/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D868C4CEF7;
	Thu,  1 Jan 2026 22:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767305652;
	bh=TkV0C834LNJT27mx2/Ayl0IxXi3IFIB0xDgB+kxqTGk=;
	h=From:To:Cc:Subject:Date:From;
	b=r+AnEX/Uh7pY3+P9PtZZEL/YIDn27sHbkqPtMSwNLRKHHMTms8Iih3doTf696xwnu
	 gEPlpuSiMxK4SXJxo4eSA8HJefbZZhMKsT1EF4NF5ytyce+tbp8wA33QjukE70v5oL
	 UeUMrHshVDmYFFB+rH5otwwzlN8jOnScbiMonmLog0e7JWiUXs7DCJJjEnsGDShFp7
	 T9eAqXR4tqZeHDiuR8a6MJx6IsPtATcbvcdT4Q6qbs9dBvxv5nSVFssetF1MBcynmq
	 OcDhyEwkROwIlr8GTTga8WovIiNHj94MbaZ+Yc4fvu65j6YAwxQYvgJLR/xHfZNysi
	 Tu6x4WAFW1OMA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Phil Auld <pauld@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michal Koutny <mkoutny@suse.com>,
	netdev@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Chen Ridong <chenridong@huawei.com>,
	cgroups@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Simon Horman <horms@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Subject: [PATCH 00/33 v6] cpuset/isolation: Honour kthreads preferred affinity
Date: Thu,  1 Jan 2026 23:13:25 +0100
Message-ID: <20260101221359.22298-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
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

Changes since v5:

* Add more tags

* Fix leaked destroy_work_on_stack() (Zhang Qiao, Waiman Long)

* Comment schedule_drain_work() synchronization requirement (Tejun)

* s/Revert of/Inverse of (Waiman Long)

* Remove housekeeping_update() needless (for now) parameter (Chen Ridong)

* Don't propagate housekeeping_update() failures beyond allocations (Waiman Long)

* Whitespace cleanup (Waiman Long)


git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	kthread/core-v6

HEAD: 811e87ca8a0a1e54eb5f23e71896cb97436cccdc

Happy new year,
	Frederic
---

Frederic Weisbecker (33):
      PCI: Prepare to protect against concurrent isolated cpuset change
      cpu: Revert "cpu/hotplug: Prevent self deadlock on CPU hot-unplug"
      memcg: Prepare to protect against concurrent isolated cpuset change
      mm: vmstat: Prepare to protect against concurrent isolated cpuset change
      sched/isolation: Save boot defined domain flags
      cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
      driver core: cpu: Convert /sys/devices/system/cpu/isolated to use HK_TYPE_DOMAIN_BOOT
      net: Keep ignoring isolated cpuset change
      block: Protect against concurrent isolated cpuset change
      timers/migration: Prevent from lockdep false positive warning
      cpu: Provide lockdep check for CPU hotplug lock write-held
      cpuset: Provide lockdep check for cpuset lock held
      sched/isolation: Convert housekeeping cpumasks to rcu pointers
      cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
      sched/isolation: Flush memcg workqueues on cpuset isolated partition change
      sched/isolation: Flush vmstat workqueues on cpuset isolated partition change
      PCI: Flush PCI probe workqueue on cpuset isolated partition change
      cpuset: Propagate cpuset isolation update to workqueue through housekeeping
      cpuset: Propagate cpuset isolation update to timers through housekeeping
      timers/migration: Remove superfluous cpuset isolation test
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

 Documentation/core-api/housekeeping.rst | 111 ++++++++++++++++++++++
 Documentation/core-api/index.rst        |   1 +
 arch/arm64/kernel/cpufeature.c          |  18 +++-
 block/blk-mq.c                          |   6 +-
 drivers/base/cpu.c                      |   2 +-
 drivers/pci/pci-driver.c                |  71 ++++++++++----
 include/linux/cpu.h                     |   4 +
 include/linux/cpuhplock.h               |   1 +
 include/linux/cpuset.h                  |   8 +-
 include/linux/kthread.h                 |   1 +
 include/linux/memcontrol.h              |   4 +
 include/linux/mmu_context.h             |   2 +-
 include/linux/pci.h                     |   3 +
 include/linux/percpu-rwsem.h            |   1 +
 include/linux/sched/isolation.h         |  16 +++-
 include/linux/vmstat.h                  |   2 +
 include/linux/workqueue.h               |   2 +-
 init/Kconfig                            |   1 +
 kernel/cgroup/cpuset.c                  |  68 +++++++-------
 kernel/cpu.c                            |  42 ++++-----
 kernel/kthread.c                        | 160 +++++++++++++++++++++-----------
 kernel/sched/isolation.c                | 141 +++++++++++++++++++++++-----
 kernel/sched/sched.h                    |   4 +
 kernel/time/timer_migration.c           |  25 +++--
 kernel/workqueue.c                      |  17 ++--
 mm/memcontrol.c                         |  31 ++++++-
 mm/vmstat.c                             |  15 ++-
 net/core/net-sysfs.c                    |   2 +-
 28 files changed, 557 insertions(+), 202 deletions(-)

