Return-Path: <cgroups+bounces-7147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938EA6859B
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 08:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0AB3BCB68
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296EC24EA9C;
	Wed, 19 Mar 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1qntm1v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC8155A25
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368416; cv=none; b=i2MTPZwn7Y1z1SaTHuYBMf22XARzbS7eshzHPwX8a4jXrnsqAIrRjLxKl9CWjBItHXznYzkFobcPQCiY2NWNbLm6CmYCMUX8BfW3JcJerKDPPpzUgDXMw8fVJMlYx7BnB/xl/QPq74gifA2dVo4tMBRFvhKlmksOOX6VCPoqz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368416; c=relaxed/simple;
	bh=Zh2p4VIFAOgujazhN06qKV5LCKI0HK3koNKkhjzsmYs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KbaxaGtUf0NCVBYY+VRKJP05bS3jWnfaqczxDYEY+9PNONJPbgLY7p5U/MVe6dakn8z3EVUGQ8j1g8mUcTpSwj0n6qjxUycsHi/SD96IfvVESKxx7xhXYJCeF7A1ErFKbcGNkoVRGv7rs7e8ehOL+jPbs1bI+H50fm3FEczQ6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1qntm1v; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso11299703a91.2
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742368415; x=1742973215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ry+Wdi81ySpLoTAkL3O3HsSaQaPoEmK4St7E09u3tvQ=;
        b=z1qntm1vTr8yyxN8/SLX51PU7GulyEtS7/9Wxd5eU4q39k4APcFYHFadeuF7Vo+4uH
         79loZzB7Hne01XVOiJFfVoFDi5rw9z+Pd/XGvOOd2eZ/04K8uKx5/CVanjqZdsqBDVwI
         F7xDL7OkKZ1EM3/HtRycpSDdV7t72YmEP5+GqQ96g4Z90vch9mKbidoXCxNiCPCnzGh2
         UYkxQgIL/YikuHH6pqguOjI4mo2N5ITixiR+5dv3kzzfBfbqjUURr8a7b2/biGKHPk7+
         uB4EFnAHPkUDqd9y9ZkrjyJ8UNAFCBdKjtKcLdx2Z9oj2vgV2U0f8Nnkz6KPyADIw+G0
         Sk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742368415; x=1742973215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry+Wdi81ySpLoTAkL3O3HsSaQaPoEmK4St7E09u3tvQ=;
        b=qVaDIDDwGd9UBksIL1tYip8dMZi5t76U4zEUbW9CsxBtiXyFDDZO/VdDieweovDzJf
         SYqTaC2iEq4Y7P3N4URNfci72bYr+xtw6Bwlz5p5RaUhkV9MCKW76QLsMinCOK6jSpg2
         Bo878KP1/tQJ18P8O+3cOQJR7tW9rhKAj6XNiTbIceWatJ3Sc/nxg/G5r7RvKejFQPkj
         OaelpIxfiFiQXsNLshQxKZDWDSRMX0Pa17h+3zSwr/5gOXBF+sJ+P4t5oVzZXHhnQsFA
         Pdx00Z9QD/oUVMS4amfRhHcvZpCKOJw/JQU43i1BM2gSUVPMBkyxBB7Z7eJUxYUC3sQ/
         Z/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDz6XpQsViqE8mFkLwkWxkv/nOCPfXr2fA0CDhd77wjnZuCqf9hB5cTxVmyHr88CCqMX3W5Mi@vger.kernel.org
X-Gm-Message-State: AOJu0YwPX2ged3ADnTaQminibWW7FL0mIu/GEfd/7UIUI6sGf3wx7HbU
	7LhAzowItTQ/eQsTEgzGaugiVyex/fNxm9UvfgvEJDGpi561qm6whqr2BDO+z0No2CfrwMQqA8M
	N8YNSSg==
X-Google-Smtp-Source: AGHT+IG+6ccyuzARIRGsMxmojnHgsRhFP0NvfPaHKu1MISqqgQ23au5PxFD94AfzmzH2q0n7Nkl99t0RM8mi
X-Received: from pgmh3.prod.google.com ([2002:a63:5743:0:b0:af2:54b0:c8d5])
 (user=gthelen job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2451:b0:1f5:8cc8:9cc5
 with SMTP id adf61e73a8af0-1fbeca50a36mr3218739637.34.1742368414712; Wed, 19
 Mar 2025 00:13:34 -0700 (PDT)
Date: Wed, 19 Mar 2025 00:13:30 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319071330.898763-1-gthelen@google.com>
Subject: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
From: Greg Thelen <gthelen@google.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Eric Dumazet <edumazet@google.com>

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
---
 kernel/cgroup/rstat.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index aac91466279f..976c24b3671a 100644
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
2.49.0.rc1.451.g8f38331e32-goog


