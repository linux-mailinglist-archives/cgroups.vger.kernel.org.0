Return-Path: <cgroups+bounces-10667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE84BD6151
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E42401FC8
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844093093DE;
	Mon, 13 Oct 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBF2yNcU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133A7261D;
	Mon, 13 Oct 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387519; cv=none; b=oPwNEbfbjfaikHD4dejMOcqZKk53J7lljGJfPKmm3xvRSYbgC4i4XUM7dYNR/eIhb9oy+lp69IzDEEk9w13ZaX6v+JTMziljMAx9FPKR9J3qmPVwPWgYrBQgG5/Lae6qYu6Af35/NAPMMdFd1JDPKEIzBFyEEQyTUQt6dYvmbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387519; c=relaxed/simple;
	bh=ysWVB1PH5yXaIm1/mguGEwYLxAYgw7ocXVK3fheEVQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXHKRfzwJUixLnJa48UaiSOmKmwjiI+3yl6gpDCDZyrZdQ8wJtH0tzKs63a6dRctXoatEyYuFACylyNV24dcHQ8Xg3zjHmUPkALq2jPV638wzF79LcztloKEX8DD30yK7Iw/QUjPoY/AQl0iBTOnpkjtKx7Y+G43jGsESX8Vz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBF2yNcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EEFC4CEE7;
	Mon, 13 Oct 2025 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387518;
	bh=ysWVB1PH5yXaIm1/mguGEwYLxAYgw7ocXVK3fheEVQI=;
	h=From:To:Cc:Subject:Date:From;
	b=LBF2yNcUR6yjfrW50PCgHGc8AHAvBLQ9lrvJqA2WCQ37FrvKozfK4ptrCYuj1AVqK
	 z6xLAVCLuoIDZvrgr+0C+SCMd8qYe8A7C/Cf3X++Q67H89ylB379pqJbdfHeMTCE1N
	 KZf/I96mcxhrmHyctiuPatpj08zxohCD7+/aastyPBh1gSgRXhWXSZIaTY86mC93OK
	 KUAndnd+7NuK52jdhGUE2upP207tMgConuEtCVlypo9CFV2FAxTXtjRHDRb3FjhLQX
	 nDcM2xCjsiQV94+ABdYO/QPLEZKj8pdbSvjFzcU+/jqMNtaEDRurospUsKN1F/Xx3H
	 tw5a0zfkpfrcg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	Michal Koutny <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	linux-pci@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Will Deacon <will@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-mm@kvack.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 00/33 v3] cpuset/isolation: Honour kthreads preferred affinity
Date: Mon, 13 Oct 2025 22:31:13 +0200
Message-ID: <20251013203146.10162-1-frederic@kernel.org>
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

Changes since v2:

* Keep static key (peterz)

* Handle PCI work flush

* Comment why RCU is held until PCI work is queued (Waiman)

* Add new tags

* Add CONFIG_LOCKDEP ifdeffery (Waiman)

* Rename workqueue_unbound_exclude_cpumask() to workqueue_unbound_housekeeping_update()
  and invert the parameter (Waiman)
  
* Fix a few changelogs that used to mention that HK_TYPE_KERNEL_NOISE
  must depend on HK_TYPE_DOMAIN. It's strongly advised but not mandatory (Waiman)
  
* Cherry-pick latest version of "cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping"
  (Waiman and Gabriele)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	kthread/core-v3

HEAD: 4ba707cdced479592e9f461e1944b7fa6f75910f

Thanks,
	Frederic
---

Frederic Weisbecker (32):
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
      kthread: Add API to update preferred affinity on kthread runtime
      kthread: Document kthread_affine_preferred()
      genirq: Correctly handle preferred kthreads affinity
      doc: Add housekeeping documentation

Gabriele Monaco (1):
      cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping

 Documentation/cpu_isolation/housekeeping.rst | 111 +++++++++++++++
 arch/arm64/kernel/cpufeature.c               |  18 ++-
 block/blk-mq.c                               |   6 +-
 drivers/base/cpu.c                           |   2 +-
 drivers/pci/pci-driver.c                     |  71 +++++++---
 include/linux/cpu.h                          |   4 +
 include/linux/cpuhplock.h                    |   1 +
 include/linux/cpuset.h                       |   8 +-
 include/linux/kthread.h                      |   2 +
 include/linux/memcontrol.h                   |   4 +
 include/linux/mmu_context.h                  |   2 +-
 include/linux/pci.h                          |   3 +
 include/linux/percpu-rwsem.h                 |   1 +
 include/linux/sched/isolation.h              |   7 +-
 include/linux/vmstat.h                       |   2 +
 include/linux/workqueue.h                    |   2 +-
 init/Kconfig                                 |   1 +
 kernel/cgroup/cpuset.c                       | 134 +++++++++++++-----
 kernel/cpu.c                                 |  42 +++---
 kernel/irq/manage.c                          |  47 ++++---
 kernel/kthread.c                             | 195 +++++++++++++++++++--------
 kernel/sched/isolation.c                     | 137 +++++++++++++++----
 kernel/sched/sched.h                         |   4 +
 kernel/workqueue.c                           |  17 ++-
 mm/memcontrol.c                              |  25 +++-
 mm/vmstat.c                                  |  15 ++-
 net/core/net-sysfs.c                         |   2 +-
 27 files changed, 647 insertions(+), 216 deletions(-)

