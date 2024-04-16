Return-Path: <cgroups+bounces-2537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC1E8A72A4
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 19:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EAD283E62
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DA1353FD;
	Tue, 16 Apr 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBq3Bzz0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DB12EBF0;
	Tue, 16 Apr 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289892; cv=none; b=OtaSPt8LDvZ93WWHItzvdESnO/hI+lanZ7dioE1I0b1E1MVWTAMFgZir/9pnsd4spk/Ma9KFQSiyItTzl9lYHV1oCBf07KT7+zV5atSE0gvszSJ67aSvbbGS3h2zEXFhU57rktjbtU8UsN1cdFUmnWXG+TAmtOb61Ln+hGIrRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289892; c=relaxed/simple;
	bh=6AoQjMmtCpA92ORAYahs1Yjyu49n9JrorgvUAsN4z7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjLDHhxclmdfJeMN6iduYyyCM/2ekirySsckF/boQEKjGUYOuLP4tkEuiE/pw1l7jPBbjOvkc5/sSOjz2MQy/GUgnp1l3kYLZLAYHl/4siH0BQAwn5hK4KWZ/eI7St25jJYkYPJTLh+3MAJn6jG4omPE2ofFRnn1tQPW4nXyMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBq3Bzz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D599C113CE;
	Tue, 16 Apr 2024 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713289892;
	bh=6AoQjMmtCpA92ORAYahs1Yjyu49n9JrorgvUAsN4z7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dBq3Bzz0EYHz6B9QSkhEnwznlxP5JAAVUOO63eojPw9TTIgF3RqHAWDqPv1j32x3D
	 xkmhmtazuEqtuuOT8YiBeCcHSwk6K+gA3L+Wi6kjmC3GH0i16vmnvB5Xt/xCHpwMmu
	 z+MAOQsXce/0Af8YKLkJfedtDulk2hgU9LdLgXJr0xLiUIlHKUa9KM3i1HIPw64p1g
	 6Su3c4lVRrtAcw1srlnua2Y/o5gACkabKTgADjyYhaDuaavJ4iLOtWk257IydQkkjb
	 DKymWfbCHI5jEW2guzlRNnok/PlUl+gV+QUhfqBCTIX47xul1EKw3nClMy4KFOd3vc
	 6im5vJq/eah5Q==
Subject: [PATCH v1 1/3] cgroup/rstat: add cgroup_rstat_lock helpers and
 tracepoints
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Date: Tue, 16 Apr 2024 19:51:26 +0200
Message-ID: <171328988660.3930751.17537768209042139758.stgit@firesoul>
In-Reply-To: <171328983017.3930751.9484082608778623495.stgit@firesoul>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This commit enhances the ability to troubleshoot the global
cgroup_rstat_lock by introducing wrapper helper functions for the lock
along with associated tracepoints.

Although global, the cgroup_rstat_lock helper APIs and tracepoints take
arguments such as cgroup pointer and cpu_in_loop variable. This
adjustment is made because flushing occurs per cgroup despite the lock
being global. Hence, when troubleshooting, it's important to identify the
relevant cgroup. The cpu_in_loop variable is necessary because the global
lock may be released within the main flushing loop that traverses CPUs.
In the tracepoints, the cpu_in_loop value is set to -1 when acquiring the
main lock; otherwise, it denotes the CPU number processed last.

The new feature in this patchset is detecting when lock is contended. The
tracepoints are implemented with production in mind. For minimum overhead
attach to cgroup:cgroup_rstat_lock_contended, which only gets activated
when trylock detects lock is contended. A quick production check for
issues could be done via this perf commands:

 perf record -g -e cgroup:cgroup_rstat_lock_contended

Next natural question would be asking how long time do lock contenders
wait for obtaining the lock. This can be answered by measuring the time
between cgroup:cgroup_rstat_lock_contended and cgroup:cgroup_rstat_locked
when args->contended is set.  Like this bpftrace script:

 bpftrace -e '
   tracepoint:cgroup:cgroup_rstat_lock_contended {@start[tid]=nsecs}
   tracepoint:cgroup:cgroup_rstat_locked {
     if (args->contended) {
       @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}}
   interval:s:1 {time("%H:%M:%S "); print(@wait_ns); }'

Extending with time spend holding the lock will be more expensive as this
also looks at all the non-contended cases.
Like this bpftrace script:

 bpftrace -e '
   tracepoint:cgroup:cgroup_rstat_lock_contended {@start[tid]=nsecs}
   tracepoint:cgroup:cgroup_rstat_locked { @locked[tid]=nsecs;
     if (args->contended) {
       @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}}
   tracepoint:cgroup:cgroup_rstat_unlock {
       @locked_ns=hist(nsecs-@locked[tid]); delete(@locked[tid]);}
   interval:s:1 {time("%H:%M:%S ");  print(@wait_ns);print(@locked_ns); }'

Signes-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/linux/cgroup.h        |    2 +-
 include/trace/events/cgroup.h |   48 +++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/rstat.c         |   47 +++++++++++++++++++++++++++++++++-------
 3 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 34aaf0e87def..2150ca60394b 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -690,7 +690,7 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
-void cgroup_rstat_flush_release(void);
+void cgroup_rstat_flush_release(struct cgroup *cgrp);
 
 /*
  * Basic resource stats.
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index dd7d7c9efecd..13f375800135 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -204,6 +204,54 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
 	TP_ARGS(cgrp, path, val)
 );
 
+DECLARE_EVENT_CLASS(cgroup_rstat,
+
+	TP_PROTO(struct cgroup *cgrp, int cpu_in_loop, bool contended),
+
+	TP_ARGS(cgrp, cpu_in_loop, contended),
+
+	TP_STRUCT__entry(
+		__field(	int,		root			)
+		__field(	int,		level			)
+		__field(	u64,		id			)
+		__field(	int,		cpu_in_loop		)
+		__field(	bool,		contended		)
+	),
+
+	TP_fast_assign(
+		__entry->root = cgrp->root->hierarchy_id;
+		__entry->id = cgroup_id(cgrp);
+		__entry->level = cgrp->level;
+		__entry->cpu_in_loop = cpu_in_loop;
+		__entry->contended = contended;
+	),
+
+	TP_printk("root=%d id=%llu level=%d cpu_in_loop=%d lock contended:%d",
+		  __entry->root, __entry->id, __entry->level,
+		  __entry->cpu_in_loop, __entry->contended)
+);
+
+DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
+
+	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+
+	TP_ARGS(cgrp, cpu, contended)
+);
+
+DEFINE_EVENT(cgroup_rstat, cgroup_rstat_locked,
+
+	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+
+	TP_ARGS(cgrp, cpu, contended)
+);
+
+DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
+
+	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
+
+	TP_ARGS(cgrp, cpu, contended)
+);
+
 #endif /* _TRACE_CGROUP_H */
 
 /* This part must be outside protection */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 07e2284bb499..ff68c904e647 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -7,6 +7,8 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 
+#include <trace/events/cgroup.h>
+
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
@@ -222,6 +224,35 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 
 __bpf_hook_end();
 
+/*
+ * Helper functions for locking cgroup_rstat_lock.
+ *
+ * This makes it easier to diagnose locking issues and contention in
+ * production environments.  The parameter @cpu_in_loop indicate lock
+ * was released and re-taken when collection data from the CPUs. The
+ * value -1 is used when obtaining the main lock else this is the CPU
+ * number processed last.
+ */
+static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+	__acquires(&cgroup_rstat_lock)
+{
+	bool contended;
+
+	contended = !spin_trylock_irq(&cgroup_rstat_lock);
+	if (contended) {
+		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
+		spin_lock_irq(&cgroup_rstat_lock);
+	}
+	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
+}
+
+static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
+	__releases(&cgroup_rstat_lock)
+{
+	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
+	spin_unlock_irq(&cgroup_rstat_lock);
+}
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -248,10 +279,10 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			spin_unlock_irq(&cgroup_rstat_lock);
+			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			spin_lock_irq(&cgroup_rstat_lock);
+			__cgroup_rstat_lock(cgrp, cpu);
 		}
 	}
 }
@@ -273,9 +304,9 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
 
-	spin_lock_irq(&cgroup_rstat_lock);
+	__cgroup_rstat_lock(cgrp, -1);
 	cgroup_rstat_flush_locked(cgrp);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	__cgroup_rstat_unlock(cgrp, -1);
 }
 
 /**
@@ -291,17 +322,17 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	spin_lock_irq(&cgroup_rstat_lock);
+	__cgroup_rstat_lock(cgrp, -1);
 	cgroup_rstat_flush_locked(cgrp);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  */
-void cgroup_rstat_flush_release(void)
+void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
-	spin_unlock_irq(&cgroup_rstat_lock);
+	__cgroup_rstat_unlock(cgrp, -1);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
@@ -533,7 +564,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 #ifdef CONFIG_SCHED_CORE
 		forceidle_time = cgrp->bstat.forceidle_sum;
 #endif
-		cgroup_rstat_flush_release();
+		cgroup_rstat_flush_release(cgrp);
 	} else {
 		root_cgroup_cputime(&bstat);
 		usage = bstat.cputime.sum_exec_runtime;



