Return-Path: <cgroups+bounces-12653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F72CDC5FB
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE6F43014D5D
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E533769C;
	Wed, 24 Dec 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVp068q6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEA1DEFE9;
	Wed, 24 Dec 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766583933; cv=none; b=koN5V9sjYLcRt4bFZYt/YxkhFiKmoNoXP9WMbzj2U+5Iy7Y1eS0dQNTxP0Xjnyd4xk6zSqYemVivQr1cMXcV2W819d0Q8YQYWZMJkUh5PB2mZ4whIlI71P94DRTkplCU4ctzHWx7rLh2QT0QHlMGOKlNSLQgwgUycu1Cwiw2/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766583933; c=relaxed/simple;
	bh=tK3Yaoy6unJ5tHzgM+8i6RExHWgxXGyyr5alAshg1RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCIGD17QhNf0aDgIwRX5Dqa6oG9egX6Y0+RZy8Rg6/H03UoowUgfbh/ll/6VxpAuJx6YxW7Qno15K2SrifrXSxeLlGX9v85B1R3gkkV7RyaDyDHyLZLpqdvsplm4wNU6mCCQN1qi5DQrURDDIqdwq5CoaMU9v7W3CRLPxE+ohe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVp068q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CBCC4CEFB;
	Wed, 24 Dec 2025 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766583932;
	bh=tK3Yaoy6unJ5tHzgM+8i6RExHWgxXGyyr5alAshg1RU=;
	h=From:To:Cc:Subject:Date:From;
	b=uVp068q6+NoKI3AKxIIX51WZN2Jzi9fLoN+QB2SdXLQh+BvI82O1SnOAi1wUKysT8
	 2Gx+3lcLrUemOtTJfD8eE18TmmMX6fiZpABw/ahwtYlpSgDTztcpI3oTtMB4pAiqNN
	 m9kPVJBaJKsTFZhIULeXcmgaJ3C6o961eLzaKyONSEN2pM707fPKDmk4q+psrAQ1w4
	 VZ5iQe3+kpmbe/0RT5cv6YrpbsRyyUv24PXxW7FHAa1lgeGs0QXk5XeA4+7uk5NxWG
	 sViGJtbTDgVkVGUDDjT0nXcwqYbxz/XbwOshBOTOQxUIawvq7Ufnn7f1TTgRtyVqPN
	 5Z2zHqnJrj31w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chen Ridong <chenridong@huawei.com>,
	Michal Koutny <mkoutny@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	cgroups@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 00/33 v5] cpuset/isolation: Honour kthreads preferred affinity
Date: Wed, 24 Dec 2025 14:44:47 +0100
Message-ID: <20251224134520.33231-1-frederic@kernel.org>
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

Changes since v4:

* Add more tags

* Rebase on v6.19-rc2 with latest cpuset changes

* Accomodate timers migration isolation

* Rename housekeeping_update() parameter from mask to isol_mask (Chen Ridong)

* Link housekeeping documentation to core-api

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	kthread/core-v5

HEAD: 3c0ee047f05f361f215521424f5e789dfffcafc1

Merry Christmas,
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
 kernel/sched/isolation.c                | 144 +++++++++++++++++++++++-----
 kernel/sched/sched.h                    |   4 +
 kernel/time/timer_migration.c           |  25 +++--
 kernel/workqueue.c                      |  17 ++--
 mm/memcontrol.c                         |  25 ++++-
 mm/vmstat.c                             |  15 ++-
 net/core/net-sysfs.c                    |   2 +-
 28 files changed, 554 insertions(+), 202 deletions(-)

