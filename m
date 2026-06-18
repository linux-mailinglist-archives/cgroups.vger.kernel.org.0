Return-Path: <cgroups+bounces-17055-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZNV5JeFhM2rd/wUAu9opvQ
	(envelope-from <cgroups+bounces-17055-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:11:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8C69D380
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:11:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XTRDT8rP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17055-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17055-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B823E3030107
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487E326939;
	Thu, 18 Jun 2026 03:11:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1336331EB3
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752283; cv=none; b=oSRHmjNGWQD0s15xRq849YfywAtPiTthU6JdcQCz2TV2uJZTXArSVw1bER6SsHdSs6ztleQrYrs+jamZJnTLLITO718sQf45ISd7dHaxvz4+ZbEm3ag3G50nYfvvozLVPxMf6Ilok/HrXzaz/NIszu9NU9uwPtmgaYewFiiQZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752283; c=relaxed/simple;
	bh=Xa5StEN2UH086bDikWsQrqqqrc9uy1URBleR3Pv/RuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mXUGgwDgAqEgWHacNNMHaZruGHeahDdnTCo6LKWCHi5D7RVLlDmzWTDWb5jrOKputdU7j+Fk+tAd5ThJuku1bqGwPTBJA839Z5ZSHnF68cadAtky7HSFRm7PtE1ShPvhF+pZIpMetm970k+d+RqeAWmTMLUljDAj1Zxv6OtUsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTRDT8rP; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6dadfbaafso5149655ad.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752281; x=1782357081; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJIpWsHRh9AKKYRu7jgv8q277vRNDwM5z3jTZiQx1lI=;
        b=XTRDT8rPpb1rok5YcsfdkCFn5xepyXLOhNXa+rIw5uMymVh8ILY3E0XxNialBahegb
         aFJ6yi8FTOuNfMUutWSQQWW5hoE5EPNk/e4ZK6wTqK6IUpVYbQTtLNmyQDD8wMe5R1GZ
         hspO2RY2IRxhav77+cE64G6ECphZd8032RI2pb97QhTISlKhzv6gdy65x5xx5ejn5M/y
         PGWwhknRZIrieY02awERilsrb9WarsQuJvQN5lnjhZIijnFkO0u7UO6vqYIIQRjZvgYm
         Z0jAcNrrVZWywlspd4uto83Tl2Di+O6Me5cOdAVCH1KPwd8ilNVeVkDrvc7Ayz0H0h9f
         H2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752281; x=1782357081;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJIpWsHRh9AKKYRu7jgv8q277vRNDwM5z3jTZiQx1lI=;
        b=bnzFPdWNzYlewx8LNLp3iVGiB7RY2a4afMDrsIrH8KC7BgWg2SfKJQKpZu3tSqW0bU
         34Jg2yxODbZZLkcEs5XpMXA6kig+RKIZtukpuE6UQqDRtNRgNlN+reXT6XIIsSvMirDJ
         jEnI4aLSoCkDexjWicvPTM1W3F4VvLEhVPvoJ8+s5AgOG2TBLkcz9oW6ImCYVoVTLQGv
         GcooD7lLZ3AYVUd78YpSI0H/5QHc/y5++JxW9AMUbekDhAih2oMMl300fDxMEzpWNiqc
         Q7VKHB9abTTLTAdiPRjvbIFCyP46UJegNVLoQAAaR0Z/FRDurdLk/n7J8GfdyRWYUUJt
         AZAA==
X-Forwarded-Encrypted: i=1; AFNElJ+KSTGfVJsYMEMPC+++JvcAXqqymCAOQOGryoGAKtkjJdrZ8VR3MmcFadHCrJTaCQG/03qspOig@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKyYUwJzsidal+vP/E3YUx9hA+prNQZx2mds85pZmV2JdHA/F
	H5HrTijYxnxEQdwPNlmGfYajL5IQNHXERQ7rSnJS+BQLKsmEwc3Gb6bo
X-Gm-Gg: AfdE7cl+KRnBlO5uaxCLTA8l1wERrxYOb1D08YZ4GAf+mvqwwKprGRixnVoXv9v6VWH
	+L1jWB5J0g0TONz7G1lVT2Tsryn1QZqsn7bnvzxRpRf3vU/AzLbXWIUt91kei/lVawenPoRCBGe
	IsuoqLc1DX8rbtDE0j+kmIjFwFbqhsatVC128Pkv7cdqvWWSEShJ5qTHWpOT2rDP6fmFCrRGxjE
	4jbpNLUitbeg60H89WeSS6c1X8yzPjNrUecmIcGU/zmHWYgix8Hfy8PiuLOQkb7sq+fMNe8bJ0V
	qrXtfjb0gy0ZYhQsnsZMjVA8XMR/q0hVotrAGAxE970FYnjvFlhDotDToH7ddnZd8x6g0PiU8ZW
	SE2+2dbzmtqXS7hR80iv5Z9ICZB8JQvtklR+bfQWpwG11Qg3xqRpYE5ISkZC69H1W0OLgdptcrB
	eNLgd6YiTb/yU=
X-Received: by 2002:a17:903:1d2:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c6e2464d52mr16755565ad.0.1781752281045;
        Wed, 17 Jun 2026 20:11:21 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:11:20 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Subject: [PATCH v3 00/13] Dynamic Housekeeping Management (DHM) via CPUSets
Date: Thu, 18 Jun 2026 11:11:11 +0800
Message-Id: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM9hM2oC/13O0YrCMBCF4VeRXG+WZFJr69W+xyISJ5N2ljaVx
 MYV6btvKoKydzkD/0fuIlFkSmK/uYtImRNPoQzzsRHY29CRZFe2AAW1qlQjr/MPh066fpSNrwy
 Bq1p0jSjBOZLn3wf2fSi753SZ4u1hZ1ivT0abdyaDVFLVzoNGe7Jb99WNlodPnEaxMlm/UgPb0
 hDLrEF6DnYor5K3ukW0YNA6/y+PHl89qFp6spc5knS3YEfGI6dpwPOcjk94/Y2yO63ppHBXvXP
 LsvwB3W6kfjIBAAA=
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17055-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17C8C69D380

This series introduces Dynamic Housekeeping Management (DHM) to the Linux
kernel, enabling runtime reconfiguration of kernel-noise housekeeping
(nohz_full tick suppression, RCU NOCB offloading, and managed IRQ
migration) through the existing cgroup v2 cpuset isolated partition
mechanism — no new kernel ABI required.

When a cpuset partition is set to isolated mode, the CPUs in that
partition are removed from the kernel's global housekeeping masks.  The
housekeeping subsystems (tick/nohz, RCU NOCB, genirq) react via explicit
registered callbacks, applying the new masks at runtime.  Destroying the
partition restores the CPUs to all housekeeping masks.

The architecture uses a per-type callback table (struct housekeeping_cbs)
with pre_validate/apply hooks, replacing the previous notifier chain.
Housekeeping cpumask pointers are RCU-protected to allow lock-free readers
during updates.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
V2 -> V3:
- Replace notifier chain with explicit per-type callback interface
  (struct housekeeping_cbs with .name, .pre_validate, .apply fields).
- RCU-protect all housekeeping cpumask pointers; callers must hold
  rcu_read_lock() or use housekeeping_cpumask_rcu() in apply() callbacks.
- Drop 5 patches from v2: HK_TYPE enum separation (upstream aliases are
  already correct), no-op timer/hrtimer patches, kthread dead code, and
  workqueue double-update.
- Fix deadlock in rcu_hk_workfn(): remove cpus_read_lock() wrapper around
  remove_cpu()/add_cpu() which take cpu_hotplug_lock write side.
- Fix UAF in rcu_hk_apply(): snapshot the housekeeping cpumask inside the
  work function under rcu_read_lock(), not at apply() time where the old
  pointer may be freed by synchronize_rcu() before the work runs.
- Fix tick apply(): snapshot housekeeping_cpumask_rcu() under
  rcu_read_lock() as required by lockdep for runtime-mutable types.
- Activate context_tracking dynamically via ct_cpu_track_user() /
  ct_cpu_untrack_user() in tick apply(), eliminating the dependency on
  CONFIG_CONTEXT_TRACKING_USER_FORCE flagged by tglx.
- Fix genirq apply(): snapshot HK_TYPE_MANAGED_IRQ mask under
  rcu_read_lock() before the IRQ iteration loop.
- Simplify cpuset noise_types to BIT(HK_TYPE_KERNEL_NOISE) |
  BIT(HK_TYPE_MANAGED_IRQ), replacing the redundant per-alias bitmask.
- housekeeping_update_types(): always use cpu_possible_mask as base
  for HK_TYPE_KERNEL_NOISE, so de-isolation restores the mask to all
  possible CPUs rather than leaving it at its last non-trivial value.
- Initialize watchdog_cpumask from HK_TYPE_KERNEL_NOISE (not
  HK_TYPE_TIMER) at boot; keep it in sync at runtime via a new
  housekeeping_cbs callback.
- Add kernel-noise selftest to test_cpuset_prs.sh, including
  cpu_in_cpulist() for correct cpulist range membership detection and
  nohz_full sysfs verification when CONFIG_NO_HZ_FULL is active.
- Add RCU caller fixes: sched/core (HK_TYPE_KERNEL_NOISE) and
  drivers/hv (HK_TYPE_MANAGED_IRQ) are required because those types
  are updated at runtime; hrtimer (HK_TYPE_TIMER) and arm64/topology
  (HK_TYPE_TICK) are defensive fixes.
- Reorder patches so all subsystem callbacks are registered before the
  cpuset patch that triggers housekeeping_update_types().

V1 -> V2:
- Rebrand series from DHEI to DHM (Dynamic Housekeeping Management).
- Drop custom sysfs interface entirely.
- Integrate housekeeping control into cgroup v2 cpuset isolated partition
  mechanism.
- Add SMT-aware isolation constraints to prevent splitting SMT siblings.
- Add comprehensive documentation and cgroup functional selftests.
- Refactor mask transition logic to use RCU-safe handover.

v2: https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
v1: https://lore.kernel.org/all/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com

---
Jing Wu (13):
      sched/isolation: Replace notifier chain with explicit callback interface
      sched/isolation: Add housekeeping_update_types() for kernel-noise masks
      sched/isolation: RCU-protect all housekeeping cpumask readers
      sched/isolation: Fix RCU protection for runtime-mutable cpumask callers
      cpu/hotplug: Reserve CPUHP states for nohz_full and managed IRQ down-paths
      tick/nohz, context_tracking: Prepare for runtime nohz_full updates
      rcu/nocb: Add explicit housekeeping callback for runtime NOCB toggling
      genirq: Add explicit housekeeping callback for managed IRQ migration
      watchdog/lockup_detector: Register housekeeping callback for kernel-noise
      sched: Guard sched_tick_start/stop against uninitialized tick_work_cpu
      cgroup/cpuset: Extend isolated partition to trigger kernel-noise isolation
      docs: cgroup-v2: Document kernel-noise isolation via isolated partitions
      selftests/cgroup: Add kernel-noise isolation test to cpuset selftest

 Documentation/admin-guide/cgroup-v2.rst           |   8 +
 arch/arm64/kernel/topology.c                      |   9 +-
 drivers/hv/channel_mgmt.c                         |  50 +++--
 include/linux/context_tracking.h                  |   1 +
 include/linux/cpuhotplug.h                        |   2 +
 include/linux/sched/isolation.h                   |  41 ++++
 kernel/cgroup/cpuset.c                            |  23 +-
 kernel/context_tracking.c                         |  23 +-
 kernel/irq/manage.c                               |  86 ++++++++
 kernel/rcu/tree.c                                 | 104 +++++++++
 kernel/sched/core.c                               |   7 +-
 kernel/sched/isolation.c                          | 256 ++++++++++++++++++++--
 kernel/time/hrtimer.c                             |   5 +-
 kernel/time/tick-sched.c                          | 157 ++++++++++++-
 kernel/watchdog.c                                 |  56 ++++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 204 ++++++++++++++++-
 16 files changed, 968 insertions(+), 64 deletions(-)
---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260408-wujing-dhm-8f43e2d49cd8

Best regards,
-- 
Jing Wu <realwujing@gmail.com>


