Return-Path: <cgroups+bounces-12094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A484CC6E326
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 12:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7139234AE26
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0A347FE8;
	Wed, 19 Nov 2025 11:14:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D634A3A2;
	Wed, 19 Nov 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550859; cv=none; b=Ld6gMoE0vnjXIUBZ/flBQ4uQDe1pZK6eTptXumWr87suWxmsUnzfKXYRHSA0eqfwsBpiZO6l0MsYPkLt6QcXqOJ+QeULNg+R6R8u/B5ZVFfSbou5u/udRzKn+8gqXbEnJJjqqHuGARzhE5Goy97h93dwTcX4U3GKggNFqmaTCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550859; c=relaxed/simple;
	bh=NjoZchIMgmxOHpL/nnZumtYE5ZVpIaDfYIyjDVRhy1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0YS5xCJZRjWDGYXvy64HdwAtPtlrbk3rVWbraKSUEgL7MQ/LrPlt2bCzjdFM1IrpZzb7Sdn8q9YKQkt0V80Hp/u878bHDC5cYBaLgiHoi6QF2JH3DAoV3SSAASMBZq0mPVzxgFOicWmqhFtzFqWGwLLxN1MpAu/i/dNxT92QDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id AB33C8B2A10; Wed, 19 Nov 2025 19:14:09 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cgroups@vger.kernel.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH v1] cgroup: drop preemption_disabled checking
Date: Wed, 19 Nov 2025 19:14:01 +0800
Message-ID: <20251119111402.153727-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs do not disable preemption, they only disable migration.
Therefore, when running the cgroup_hierarchical_stats selftest, a
warning [1] is generated.

The css_rstat_updated() function is lockless and reentrant, so checking
for disabled preemption is unnecessary (please correct me if I'm wrong).

[1]:
~/tools/testing/selftests/bpf$
test_progs -a cgroup_hierarchical_stats

...
------------[ cut here ]------------
WARNING: CPU: 0 PID: 382 at kernel/cgroup/rstat.c:84
Modules linked in:
RIP: 0010:css_rstat_updated+0x9d/0x160
...
PKRU: 55555554
Call Trace:
 <TASK>
 bpf_prog_16a1c2d081688506_counter+0x143/0x14e
 bpf_trampoline_6442524909+0x4b/0xb7
 cgroup_attach_task+0x5/0x330
 ? __cgroup_procs_write+0x1d7/0x2f0
 cgroup_procs_write+0x17/0x30
 cgroup_file_write+0xa6/0x2d0
 kernfs_fop_write_iter+0x188/0x240
 vfs_write+0x2da/0x5a0
 ksys_write+0x77/0x100
 __x64_sys_write+0x19/0x30
 x64_sys_call+0x79/0x26a0
 do_syscall_64+0x89/0x790
 ? irqentry_exit+0x77/0xb0
 ? __this_cpu_preempt_check+0x13/0x20
 ? lockdep_hardirqs_on+0xce/0x170
 ? irqentry_exit_to_user_mode+0xf2/0x290
 ? irqentry_exit+0x77/0xb0
 ? clear_bhb_loop+0x50/0xa0
 ? clear_bhb_loop+0x50/0xa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
---[ end trace 0000000000000000 ]---

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/cgroup/rstat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a198e40c799b..fe0d22280cbd 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -81,8 +81,6 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (!css_uses_rstat(css))
 		return;
 
-	lockdep_assert_preemption_disabled();
-
 	/*
 	 * For archs withnot nmi safe cmpxchg or percpu ops support, ignore
 	 * the requests from nmi context.
-- 
2.43.0


