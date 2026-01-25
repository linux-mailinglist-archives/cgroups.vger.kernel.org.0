Return-Path: <cgroups+bounces-13407-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPnqFjaddmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13407-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:46:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B328382BEE
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC38300822A
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687203016E2;
	Sun, 25 Jan 2026 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqJjGl8d"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28612823DD;
	Sun, 25 Jan 2026 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381153; cv=none; b=p2SDTJeLrCFaxIU31zAaSqV96t1TcZqXroiZkTGLaQv9UZoL5kY7W2pU+akPHFkRcnY6pJkK3hAtLfmS4wi73WMPeb8xNFbot9cQ12nexYv10P8C8FSIoBVg/oVa9Ij/jJNvAw0JefxjRQ1UtR8ZncMAZTJPB9ebLDfdslcQWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381153; c=relaxed/simple;
	bh=S9vFWXhyg0MkV+tLx10WmLW7gf6qdVccxzNBP8JiVGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MB8M7o8wab1N68PSXQddCxqO0LnueRDwE18qO62CgmMuYYanvvpVXs9HC59AEcpte8myxg+PxdK3aeK4h9o/NgK+qpSHztzZHi7EmgzG68uXQvR0W7aEu8WiZYU4cFeRKZWmecmblC6I5pcKK1KIVCS9eJPD2N5+Fa/teoQcQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqJjGl8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E9CC4CEF1;
	Sun, 25 Jan 2026 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381152;
	bh=S9vFWXhyg0MkV+tLx10WmLW7gf6qdVccxzNBP8JiVGU=;
	h=From:To:Cc:Subject:Date:From;
	b=bqJjGl8d8RkkxkNvm/b5FIs/lRTASegJ/2eEoGWhYNy0srWYwoejNbrqxkPu2klYU
	 YVq84UWjZ3KVHkLb3wiIOu7FCgNo9VHkTwG0W5/o3u0kyD0fL7JbFhVEcrQng2LmLu
	 GVLMOXatTuZeWFep6DqNIoVnejZ4E/K2VMt5H8ZAnwsZqEtHinrP8j40M6aXuquMs/
	 N9lYLDQOFUPXs0x7iEoCWmgFUKARoa0cHptC3IKwrxOrHarVuA9cjNpuHWpvl5jM3u
	 NSMHi06NAeCcQIlPkr7hsC+VTZfuiOtGbaerDSPBNtMwoBS2MYvO7k1/vIxRHuoYi2
	 Y3KSPEiKGXnXA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	cgroups@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Will Deacon <will@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chen Ridong <chenridong@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-arm-kernel@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Phil Auld <pauld@redhat.com>,
	linux-block@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org
Subject: [PATCH 00/33 v7] cpuset/isolation: Honour kthreads preferred affinity
Date: Sun, 25 Jan 2026 23:45:07 +0100
Message-ID: <20260125224541.50226-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,linuxfoundation.org,redhat.com,suse.com,vger.kernel.org,linux.dev,arm.com,gmail.com,linux-foundation.org,kvack.org,cmpxchg.org,huawei.com,linutronix.de,suse.cz,lists.infradead.org,kernel.dk,google.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13407-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B328382BEE
X-Rspamd-Action: no action

Hi,

Here is just a few changes sinces v6:

- More tags

- Fix raw access to __rcu pointer (Simon Horman, Waiman)

- Fix cpu_hotplug_lock deadlock and use correct static branch API
  (Chen Ridong)

- Fix a few changelogs that got the set rules between HK_TYPE_DOMAIN
  HL_TYPE_KERNEL_NOISE wrong.

- Simplify arm64 mismatched 32 bits support (Will Deacon)

If all goes well, my plan is to make the pull request myself for the
upcoming merge window.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	kthread/core-v7

HEAD: dcbe41f43e2cb32fbdbaf73b7745739e018b35dc

Thanks,
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

 Documentation/arch/arm64/asymmetric-32bit.rst |  12 +-
 Documentation/core-api/housekeeping.rst       | 111 ++++++++++++++++++
 Documentation/core-api/index.rst              |   1 +
 arch/arm64/kernel/cpufeature.c                |   6 +-
 block/blk-mq.c                                |   6 +-
 drivers/base/cpu.c                            |   2 +-
 drivers/pci/pci-driver.c                      |  71 +++++++++---
 include/linux/cpuhplock.h                     |   1 +
 include/linux/cpuset.h                        |   8 +-
 include/linux/kthread.h                       |   1 +
 include/linux/memcontrol.h                    |   4 +
 include/linux/mmu_context.h                   |   2 +-
 include/linux/pci.h                           |   3 +
 include/linux/percpu-rwsem.h                  |   1 +
 include/linux/sched/isolation.h               |  16 ++-
 include/linux/vmstat.h                        |   2 +
 include/linux/workqueue.h                     |   2 +-
 init/Kconfig                                  |   1 +
 kernel/cgroup/cpuset.c                        |  53 +++------
 kernel/cpu.c                                  |  42 +++----
 kernel/kthread.c                              | 160 +++++++++++++++++---------
 kernel/sched/isolation.c                      | 145 ++++++++++++++++++-----
 kernel/sched/sched.h                          |   4 +
 kernel/time/timer_migration.c                 |  25 ++--
 kernel/workqueue.c                            |  17 +--
 mm/memcontrol.c                               |  31 ++++-
 mm/vmstat.c                                   |  15 ++-
 net/core/net-sysfs.c                          |   2 +-
 28 files changed, 538 insertions(+), 206 deletions(-)

