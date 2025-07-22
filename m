Return-Path: <cgroups+bounces-8836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C0B0DA2B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840B06C2A02
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDA2E9756;
	Tue, 22 Jul 2025 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUPEnHeU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE682E9740;
	Tue, 22 Jul 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188862; cv=none; b=ZdPPWPvOhFo/G49zpCMfcG2L7o1kMy1NzQ8xdA+n3NVycQ6Awp5t8YAGZn5BdppmWd3K3f+BEw9rV41P00G9os29SdFiaM9lOdBXP7v9J3KD3PMTwMqqWDJYsaWa7p1lLeMBrh0nBqn3lZmWgardXOoQZrK7g4HsPlVto4VQlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188862; c=relaxed/simple;
	bh=0ZfWD3fGMg7venJRU+xdGNcfzv1XmoENYubvOaZ6XD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6v1mRgLwp6UVfY9Fdnm7FoNd7jIW3c0qH7/JdWOevzRn05vUucrF/neYjboQhk+gkhOB2QKeb1uQAd6w9rYWkbhJoX/y5hGYfwINtDJgb2swBDe3pl/DpX3bzL941PBnUfCgbIr9BUusV2cwg58X3VVNj3MDWFTYYOpT/ODHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUPEnHeU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753188861; x=1784724861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ZfWD3fGMg7venJRU+xdGNcfzv1XmoENYubvOaZ6XD0=;
  b=DUPEnHeUDYgi/9xjjGuE/kxVxmwImNCQ7eAEElXjNfj6/nSoWA+rJtGO
   Iwrc/0IxtYzRXbEQW8TDtDaXwqXgWi+s6jNde93HRvL+wrEAgO1o80oMl
   +7L/IgQKGN3Qz+JAOK7iFVjCJq8tuvE2XaY4AKdMoRxoXTBEqSRJLD2eK
   JFzZqBNuhh8L9+mYLbV9BxyRUPvuYracwOJ9LTJkdnVspyxVdxWKo0TQk
   TlCSRVB+ZPqMvPkFyyp8Hi/3ADPDTil8GMPAByAdO2mYVd7c0ceEJpzFx
   rEVUs5QKHCruAT6ucfHUwNSQvMOdezJkG4Mb+QPj5mRIw9agIbybH1SAY
   A==;
X-CSE-ConnectionGUID: AgRA7D+uRJmSxbN0ALKhlQ==
X-CSE-MsgGUID: /fCBP6rmR66kVGtZN5k9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="65698847"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="65698847"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:54:15 -0700
X-CSE-ConnectionGUID: Z6o+nlcaRlmnQMXVc94yAA==
X-CSE-MsgGUID: ujjhqxBrSh6hdYofHteW3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159453856"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 22 Jul 2025 05:54:10 -0700
Received: from GK6031-HR8-NF5280M7-41522.igk.intel.com (GK6031-HR8-NF5280M7-41522.igk.intel.com [10.91.175.72])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D38422FC5B;
	Tue, 22 Jul 2025 13:54:08 +0100 (IST)
From: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	inwardvessel@gmail.com,
	Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Subject: [PATCH] cgroup/rstat: move css_rstat_lock outside cpu loop
Date: Tue, 22 Jul 2025 14:43:19 +0200
Message-ID: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By moving the lock outside the CPU loop, we reduce the frequency
of costly lock acquisition.
This adjustment slightly improves performance in scenarios where
multiple CPUs concurrently attempt to acquire the lock for
the same css.

The cpu argument passed to __css_rstat_lock, which was utilized
by the event system, has been removed because it is no longer in use.
---
Results:
 
QEMU vm
+-------+---------+
| main  | patched |
+-------+---------+
| 9.17s | 2.36s   |
+-------+---------+
ext4 raw image with debian:
qemu-system-x86_64 -enable-kvm -cpu host -smp 102 -m 16G -kernel linux-cgroup/arch/x86/boot/bzImage -drive file=rootfs.ext4,if=virtio,format=raw -append "rootwait root=/dev/vda console=tty1 console=ttyS0 nokaslr cgroup_enable=memory cgroup_memory=1" -net nic,model=virtio -net user -nographic

Benchmark code: https://gist.github.com/bwlodarcz/c955b36b5667f0167dffcff23953d1da
musl-gcc -o benchmark -static -g3 -DNUM_THREADS=10 -DNUM_ITER=10000 -O2 -Wall benchmark.c -pthread
---
 include/trace/events/cgroup.h | 22 ++++++++++------------
 kernel/cgroup/rstat.c         | 20 +++++++++-----------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index ba9229af9a34..eb674eef8b99 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -206,15 +206,14 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
 
 DECLARE_EVENT_CLASS(cgroup_rstat,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended),
+	TP_ARGS(cgrp, contended),
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
 		__field(	int,		level			)
 		__field(	u64,		id			)
-		__field(	int,		cpu			)
 		__field(	bool,		contended		)
 	),
 
@@ -222,13 +221,12 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
 		__entry->root = cgrp->root->hierarchy_id;
 		__entry->id = cgroup_id(cgrp);
 		__entry->level = cgrp->level;
-		__entry->cpu = cpu;
 		__entry->contended = contended;
 	),
 
-	TP_printk("root=%d id=%llu level=%d cpu=%d lock contended:%d",
+	TP_printk("root=%d id=%llu level=%d lock contended:%d",
 		  __entry->root, __entry->id, __entry->level,
-		  __entry->cpu, __entry->contended)
+		  __entry->contended)
 );
 
 /*
@@ -238,23 +236,23 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
  */
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended)
+	TP_ARGS(cgrp, contended)
 );
 
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_locked,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended)
+	TP_ARGS(cgrp, contended)
 );
 
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
 
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+	TP_PROTO(struct cgroup *cgrp, bool contended),
 
-	TP_ARGS(cgrp, cpu, contended)
+	TP_ARGS(cgrp, contended)
 );
 
 #endif /* _TRACE_CGROUP_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c8a48cf83878..dd312fe1896d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -326,8 +326,7 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
-		int cpu_in_loop)
+static inline void __css_rstat_lock(struct cgroup_subsys_state *css)
 	__acquires(ss_rstat_lock(css->ss))
 {
 	struct cgroup *cgrp = css->cgroup;
@@ -337,21 +336,20 @@ static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
 	lock = ss_rstat_lock(css->ss);
 	contended = !spin_trylock_irq(lock);
 	if (contended) {
-		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
+		trace_cgroup_rstat_lock_contended(cgrp, contended);
 		spin_lock_irq(lock);
 	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
+	trace_cgroup_rstat_locked(cgrp, contended);
 }
 
-static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
-				      int cpu_in_loop)
+static inline void __css_rstat_unlock(struct cgroup_subsys_state *css)
 	__releases(ss_rstat_lock(css->ss))
 {
 	struct cgroup *cgrp = css->cgroup;
 	spinlock_t *lock;
 
 	lock = ss_rstat_lock(css->ss);
-	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
+	trace_cgroup_rstat_unlock(cgrp, false);
 	spin_unlock_irq(lock);
 }
 
@@ -381,11 +379,11 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 		return;
 
 	might_sleep();
+	__css_rstat_lock(css);
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos;
 
 		/* Reacquire for each CPU to avoid disabling IRQs too long */
-		__css_rstat_lock(css, cpu);
 		pos = css_rstat_updated_list(css, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
 			if (is_self) {
@@ -395,10 +393,10 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 			} else
 				pos->ss->css_rstat_flush(pos, cpu);
 		}
-		__css_rstat_unlock(css, cpu);
 		if (!cond_resched())
 			cpu_relax();
 	}
+	__css_rstat_unlock(css);
 }
 
 int css_rstat_init(struct cgroup_subsys_state *css)
@@ -685,11 +683,11 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 
 	if (cgroup_parent(cgrp)) {
 		css_rstat_flush(&cgrp->self);
-		__css_rstat_lock(&cgrp->self, -1);
+		__css_rstat_lock(&cgrp->self);
 		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &bstat.cputime.utime, &bstat.cputime.stime);
-		__css_rstat_unlock(&cgrp->self, -1);
+		__css_rstat_unlock(&cgrp->self);
 	} else {
 		root_cgroup_cputime(&bstat);
 	}
-- 
2.49.0


