Return-Path: <cgroups+bounces-15252-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCAyBKSe3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15252-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:43:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956203E863F
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C81413004F1B
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F0397686;
	Mon, 13 Apr 2026 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQZF7gAD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4042393DDB
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066208; cv=none; b=WtJwePhUvsmARZpIX9Idh9qL2e9sigzDtnzEDnalkVWXVDLstn/oTUkWnown/5IXFT+0Bke1RmnDQs7y2bs2LC03WdzCC2xgXGe9zDkYsVDhAgNqTnJ8bm/PLpXybkb7q7ynB+5lomtKIJzE+zjnhSHlbFcb8XCo0gR5Fu0waRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066208; c=relaxed/simple;
	bh=M5UhHgIw8MLkGuym5witH6XqQ7eGPHPU7XznpRaYlqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pZD54XUNvqJsFjZWvRLM9RLtYTKoMuAv4ZOPiZxUOjktstESbuaVJz2Y1hBNlx47IyisdhO2KIvTMHdaRowxhJ7Y3YserBUTaQEV29V5Ykrfj2xyxzm1Lno32OSSnwYPzk8Pp1DXUVf23ZMJyDaqdD6YLTs52EkHUdh6haEYdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQZF7gAD; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so11457322c88.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066204; x=1776671004; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnm3rAs1EW1zXW14+7Lf/lvhAiqaue6tqPNOeQwzzLE=;
        b=GQZF7gADbgn9/hvhy+AYZdiCmjHHF4EqLsAsDYNAHa2y+Z7mnqEm/vZWEnOEtJ1CcQ
         yNhLr+JH2PhsNVuoOiRdxOFK1WYkrFx501v55adf0cfiSp9/WmwqP3jV8FhBpYt/7VLl
         o9EpEy1giuDsusMwzN1d/LfMxPOjvftL+Co/DjkLlt01aLVJlKgHxWh1Ve63x059L2ZI
         VDSMDr6F23TdDDf04pnNfQ0NZX5X8SHB2G5h/SPXQB7APtyJX2200Yc5h3BoXz5/1mZL
         OWv4XpecevyFDFekMsfyZLZCT8RQIfBN8wOU7St4RMGDDZango3VJoXWGsRb5ma0E5+N
         rlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066204; x=1776671004;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnm3rAs1EW1zXW14+7Lf/lvhAiqaue6tqPNOeQwzzLE=;
        b=b20dX0GWdfOCIrTU9U1zclJcBr1g5DOnaYndjnIQIRI+aiG8dnTUBNHCZDeeoOhUm5
         N6lJIPNpifX314dIFFSpFkhC9tQYJkq6h/OL7OF6oimnNz2VJUuSF4vUIS08hpk4sKMw
         AiOiuZ/Tmzmw69ycblMFFpk60PiUX3jWkCB0LpbF0AJ/fFl1tOsJhXEiPzg2l5wmI8Ex
         YesNflMr6ieaVG5HGY9AJSJJEAVDwzhZxsgn1QVQ1aRUTsCvdgjolWEVfHYRFi7cNJlH
         M1OzbpP5IJ/7BhkiFcY+L5TXf3LnkYxi7GatGf+y4EKqcv313dMUAdAPhLYnEFM5TBt/
         13nw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZE18HkoouTLRzL8qL52wX90TmAZj5iUa3Z5O4SVQkWeR54+271MfwzT8oM22jsqriEiOXGvK3@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLlqtBR2L5WTkrIw4/qbXovl5IUDv82eib28iB2cCDCn8B0f+
	NcEcWTUM0NqEAEuV2d8b8EUJXM+rVnMFYTBesIKuo5DdjO3JdgonfEm5
X-Gm-Gg: AeBDieuOfrNDGiTdp4uWc+Jkaeg5cF1H8HlvKGQwYkRS2wahD8No3kcxh6/K4MqbrQW
	N5caGxlLfZEgpeMhLXHG9uFuvYYxoSJNynYsG3T4hNU8YY9jE9jJ8cj36rANE8EFd+tje2In0IW
	DSBVj/g3oA1vDVaqYE9UdWfNQj6CRm5XPgyAZCeN6HTksBLuzdp3EXQ/iorI+YHVmLeX/yVovaY
	ADUNduQYMoz+mwrxmxgQ+JoPOai7TOBb37ZB76B8gBFZM1vM8BZyWnks6YqCPuZfUWabtGec90S
	C3jDXJyaoppsJ7PkN2QzTJArbdcm7SnnFkvRnjGoJr6XI09hggefxOzMUD6qV4Rwp7nk6tUkAT3
	Hu7dMYug++HyoiG1M/KLjMr7kBh5PYEmGxLjUWkq7t2aSVop+/k8KR3msMmtRXP4PkOnjQMWhFf
	7moec01LxS6nPEfXpm
X-Received: by 2002:a05:7022:ec1:b0:128:ca83:5aa1 with SMTP id a92af1059eb24-12c34ea25e4mr7053217c88.16.1776066204042;
        Mon, 13 Apr 2026 00:43:24 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:43:23 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH v2 00/12] Dynamic Housekeeping Management (DHM) via CPUSets
Date: Mon, 13 Apr 2026 15:43:06 +0800
Message-Id: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIqe3GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDEwML3fLSrMy8dN2UjFxdizQT41SjFBPL5BQLJaCGgqLUtMwKsGHRsbW
 1AC3kgphcAAAA
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15252-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 956203E863F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces Dynamic Housekeeping Management (DHM) to the
Linux kernel.

Previously known as the DHEI (Dynamic Housekeeping Environment Interface)
patchset (RFC and v1), this series has been fundamentally refactored in
response to upstream feedback. The custom sysfs interface has been entirely
dropped. Instead, DHM is now natively integrated into the cgroup v2
cpuset controller.

By exposing `cpuset.housekeeping.cpus` on the root cgroup, system
administrators and workload orchestrators (like Kubernetes) can
dynamically update the kernel's global housekeeping masks at runtime,
without requiring a node reboot.

This version provides dynamic reconfiguration support for the following
subsystems:
- RCU (NOCB offloading)
- Tick/NOHZ (Full dynticks)
- Global Workqueues and Timers
- Managed Interrupts (genirq)
- Hardlockup Detectors (Watchdog)
- Scheduler Domains (Isolation)
- Memory Management (vmstat/lru_add_drain)
- Kthreads and Softirqs (Affinity)

Many thanks to the maintainers for the valuable guidance that led to this
significantly improved and upstream-aligned architecture.

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Ben Segall <bsegall@google.com>
To: Mel Gorman <mgorman@suse.de>
To: Valentin Schneider <vschneid@redhat.com>
To: Paul E. McKenney <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
To: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
To: Zqiang <qiang.zhang@linux.dev>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
To: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>
To: Michal Koutný <mkoutny@suse.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

Changes in v2:
- Rebranded series from DHEI to DHM (Dynamic Housekeeping Management).
- Entirely dropped custom sysfs interface.
- Integrated housekeeping control into cgroup v2 cpuset controller
  at the root level.
- Added SMT-aware pipeline logic (cpuset.housekeeping.smt_aware) to
  prevent splitting SMT siblings.
- Added comprehensive documentation and cgroup functional selftests for
  the DHM APIs.
- Refactored the internal mask transition logic to use RCU-safe
  handover.
- Separated patch series into 4 logical phases for review.

v1 Link: https://lore.kernel.org/all/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
Qiliang Yuan (12):
      sched/isolation: Separate housekeeping types in enum hk_type
      sched/isolation: Introduce housekeeping notifier infrastructure
      rcu: Support runtime NOCB initialization and dynamic offloading
      tick/nohz: Transition to dynamic full dynticks state management
      genirq: Support dynamic migration for managed interrupts
      watchdog: Allow runtime toggle of lockup detector affinity
      sched/core: Dynamically update scheduler domain housekeeping mask
      workqueue, mm: Support dynamic housekeeping mask updates
      cgroup/cpuset: Introduce CPUSet-driven dynamic housekeeping (DHM)
      cgroup/cpuset: Implement SMT-aware grouping and safety guards
      Documentation: cgroup-v2: Document dynamic housekeeping (DHM)
      selftests: cgroup: Add functional tests for dynamic housekeeping

 Documentation/admin-guide/cgroup-v2.rst      |  24 +++++
 include/linux/sched/isolation.h              |  51 ++++++++---
 kernel/cgroup/cpuset-internal.h              |   2 +
 kernel/cgroup/cpuset.c                       |  73 +++++++++++++++
 kernel/irq/manage.c                          |  49 ++++++++++
 kernel/rcu/rcu.h                             |   4 +
 kernel/rcu/tree.c                            |  75 ++++++++++++++++
 kernel/rcu/tree.h                            |   2 +-
 kernel/rcu/tree_nocb.h                       |  31 ++++---
 kernel/sched/core.c                          |  23 +++++
 kernel/sched/isolation.c                     |  74 ++++++++++++++-
 kernel/time/tick-sched.c                     | 130 +++++++++++++++++++++------
 kernel/watchdog.c                            |  26 ++++++
 kernel/workqueue.c                           |  42 +++++++++
 mm/compaction.c                              |  27 ++++++
 tools/testing/selftests/cgroup/test_cpuset.c |  36 ++++++++
 16 files changed, 620 insertions(+), 49 deletions(-)
---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260408-wujing-dhm-8f43e2d49cd8

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>


