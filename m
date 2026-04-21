Return-Path: <cgroups+bounces-15378-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEsvMarp5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15378-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:06:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C4435B05
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA90D3021E83
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C23624A4;
	Tue, 21 Apr 2026 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF8ZGycg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41041DE2D3
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740704; cv=none; b=gjn2pfSBwgx2DiNGVX+e/oIjfSH68744C2szSeMa6iRyE8+U95AKkt6YisySX1H/N8HdDaQ9RQCE3iseSQPZ/NgUmy5dK5yL7LmMyd7Ip4BhXiY9aAAto+V5Bf8WSUO+3g7J6QQi9TL94zUrWVWCxisMf9+EySkNQGIyEzZFAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740704; c=relaxed/simple;
	bh=f0r0hkJLwWzr6Lbbl7nS8piEjoIcwP0Du/gFOPR+3qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DcHKny+B5JQ/lKzJmJH8FclubDLJIb2EMXD43gGqNvx80XMjfMzi7h4EZmNv/L4ICb1oJgOYcKwYfEgM+uR6C1k5Ir8BWRJPPxk4/LuusF4XMdL7PA48PwAi/V6NUtSvTUBNFigw5mWvCAT71I/PzNtjNinmIuqsUz/EllD5E14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UF8ZGycg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wjmNr9JCrkwrdx2sPCA7CcPctqUBoRuM1dGKFKpqRoo=;
	b=UF8ZGycgN789KqdvNFJXl62AyZeHLgS45W9sEbcjEqQS0HVG2qD3yI+zTeqrJ94VbXZUi/
	ehjj9w8uPwSQ8NKw/xKHl5oMKq4ssG83lOK+K1aVBT6wXiaNkjQ79mnhlwlhLJu2VIp6TS
	T7WD0C/MbWjfYBLV7yyr95Rnlmi6V+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-Xlv27X_4Mf2hAD4VUDUogQ-1; Mon,
 20 Apr 2026 23:04:56 -0400
X-MC-Unique: Xlv27X_4Mf2hAD4VUDUogQ-1
X-Mimecast-MFC-AGG-ID: Xlv27X_4Mf2hAD4VUDUogQ_1776740691
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F69018005AA;
	Tue, 21 Apr 2026 03:04:50 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFB4119560AB;
	Tue, 21 Apr 2026 03:04:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Mon, 20 Apr 2026 23:03:28 -0400
Message-ID: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15378-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 725C4435B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The "isolcpus=domain" CPU list implied by the HK_TYPE_DOMAIN housekeeping
cpumask is being dynamically updated whenever the set of cpuset isolated
partitions change. This patch series extends the isolated partition code
to make dynamic changes to the "nohz_full" and "isolcpus=managed_irq"
CPU lists. These CPU lists correspoond to equivalent changes in the
HK_TYPE_KERNEL_NOISE and HK_TYPE_MANAGED_IRQ housekeeping cpumasks.

To facilitate the changing of these CPU lists, the CPU hotplug code
which is doing a lot of heavy lifting is now being used. For changing
the "nohz_full" and HK_TYPE_KERNEL_NOISE cpumasks, the affected CPUs
are torn down into offline mode first. Then the housekeeping cpumask
and the corresponding cpumasks in the RCU, tick and watchdog subsystems
are modified. After that, the affected CPUs are brought online again.

It is slightly different with the "managed_irq" HK_TYPE_MANAGED_IRQ
cpumask, the cpumask is updated first and the affected CPUs are torn
down and brought up to move the managed interrupts away from the newly
isolated CPUs.

Using CPU hotplug does have its drawback when multiple isolated
partitions are being managed in a system. The CPU offline process uses
the stop_machine mechanism to stop all the CPUs except the one being torn
down. This will cause latency spike for isolated CPUs in other isolated
partitions. It is not a problem if only one isolated partition is
needed. This is an issue we need to address in the near future.

Patches 1-7 enables runtime updates to the nohz_full/managed_irq
cpumasks in sched/isolation, tick, RCU and watchdog subsystems.

Patches 8-17 modifies various subsystems that need access to the
HK_TYPE_MANAGED_IRQ cpumask and HK_TYPE_KERNEL_NOISE cpumask and its
aliases. Like the runtime modifiable HK_TYPE_DOMAIN cpumask, RCU is used
to protect access to cpumasks to avoid potential UAF problem. Patch 17
updates the housekeeping_dereference_check() to print a WARNING when
lockdep is enabled if those housekeeping cpumasks are used without the
proper lock protection.

Patch 18 introduces a new cpuhp_offline_cb() API that enables the
shutting down of a given list of CPUs, run a callback function and then
brought those CPUs up again while disallowing any concurrent CPU hotplug
activity.

Patches 19-23 updates the cpuset code, selftest and documentation to
allow change in isolated partition configuration to be reflected in
the housekeeping and other cpumasks dynamically.

As there is a slight overhead in enabling dynamic update to the nohz_full
cpumask, this new nohz_full and managed_irq runtime update feature
has to be explicitly opted in by adding a nohz_full kernel command
line parameter with or without a CPU list to indicate a desire to use
this feature. It is also because a number of subsystems have explicit
check of nohz_full at boot time to adjust their behavior which may not
be easy to modify after boot.

Waiman Long (23):
  sched/isolation: Add HK_TYPE_KERNEL_NOISE_BOOT &
    HK_TYPE_MANAGED_IRQ_BOOT
  sched/isolation: Enhance housekeeping_update() to support updating
    more than one HK cpumask
  tick/nohz: Make nohz_full parameter optional
  tick/nohz: Allow runtime changes in full dynticks CPUs
  tick: Pass timer tick job to an online HK CPU in tick_cpu_dying()
  rcu/nocbs: Allow runtime changes in RCU NOCBS cpumask
  watchdog: Sync up with runtime change of isolated CPUs
  arm64: topology: Use RCU to protect access to HK_TYPE_TICK cpumask
  workqueue: Use RCU to protect access of HK_TYPE_TIMER cpumask
  cpu: Use RCU to protect access of HK_TYPE_TIMER cpumask
  hrtimer: Use RCU to protect access of HK_TYPE_TIMER cpumask
  net: Use boot time housekeeping cpumask settings for now
  sched/core: Use RCU to protect access of HK_TYPE_KERNEL_NOISE cpumask
  hwmon/coretemp: Use RCU to protect access of HK_TYPE_MISC cpumask
  Drivers: hv: Use RCU to protect access of HK_TYPE_MANAGED_IRQ cpumask
  genirq/cpuhotplug: Use RCU to protect access of HK_TYPE_MANAGED_IRQ
    cpumask
  sched/isolation: Extend housekeeping_dereference_check() to cover
    changes in nohz_full or manged_irqs           cpumasks
  cpu/hotplug: Add a new cpuhp_offline_cb() API
  cgroup/cpuset: Improve check for calling housekeeping_update()
  cgroup/cpuset: Enable runtime update of
    HK_TYPE_{KERNEL_NOISE,MANAGED_IRQ} cpumasks
  cgroup/cpuset: Limit the side effect of using CPU hotplug on isolated
    partition
  cgroup/cpuset: Prevent offline_disabled CPUs from being used in
    isolated partition
  cgroup/cpuset: Documentation and kselftest updates

 Documentation/admin-guide/cgroup-v2.rst       |  35 ++-
 .../admin-guide/kernel-parameters.txt         |  15 +-
 arch/arm64/kernel/topology.c                  |  17 +-
 drivers/hv/channel_mgmt.c                     |  15 +-
 drivers/hv/vmbus_drv.c                        |   7 +-
 drivers/hwmon/coretemp.c                      |   6 +-
 include/linux/context_tracking.h              |   8 +-
 include/linux/cpuhplock.h                     |   9 +
 include/linux/nmi.h                           |   2 +
 include/linux/rcupdate.h                      |   2 +
 include/linux/sched/isolation.h               |  18 +-
 include/linux/tick.h                          |   2 +
 kernel/cgroup/cpuset-internal.h               |   1 +
 kernel/cgroup/cpuset.c                        | 292 +++++++++++++++++-
 kernel/context_tracking.c                     |  19 +-
 kernel/cpu.c                                  |  72 +++++
 kernel/irq/cpuhotplug.c                       |   1 +
 kernel/irq/manage.c                           |   1 +
 kernel/rcu/tree_nocb.h                        |  24 +-
 kernel/sched/core.c                           |   4 +-
 kernel/sched/isolation.c                      | 135 +++++---
 kernel/time/hrtimer.c                         |   4 +-
 kernel/time/tick-common.c                     |  16 +-
 kernel/time/tick-sched.c                      |  48 ++-
 kernel/watchdog.c                             |  24 ++
 kernel/workqueue.c                            |   6 +-
 net/core/net-sysfs.c                          |   2 +-
 .../selftests/cgroup/test_cpuset_prs.sh       |  70 ++++-
 28 files changed, 747 insertions(+), 108 deletions(-)

-- 
2.53.0


