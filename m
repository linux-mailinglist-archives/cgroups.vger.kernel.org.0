Return-Path: <cgroups+bounces-9068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE6B1FFF7
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 09:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82B03AA42B
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26942D877D;
	Mon, 11 Aug 2025 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QljUd+Wl"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7E182D2;
	Mon, 11 Aug 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896266; cv=none; b=iHtoy3dbTupzAvmIJ1F6UtGbVvHqJaFvxkG6ycj/PrwxesAYfDCWj+9bkCOai1hqdLP6e3jGBHMl4W2GlQmM4odh8xTW66c3naNq94IvAi7D6d8LUEkMI4VweB+X+aW6osuGyIqYj4Qjxp4QumeWmJ6Y5+zPiycX9CKjdmWrNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896266; c=relaxed/simple;
	bh=jirk8xt3Z/prjTMw2qP//FZM8keS0ria1KQpm0hUeiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpZThblM5O8SDjbFx7jgrQwGtGL7RKHgjLe8w5gefUTnorVlFRr4QhPo8KLJkMhyRiuNJdnO8xFju5utwogQgAtq4fVRLCktnsqnubWygOXIZ5u2hIhGFDIUqCptrM2iGgpqZxSgf8qWPDIs/8TabcowRDEZF9yp7znPMGuLZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QljUd+Wl; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h8
	NKGOUmxqambwcqTvkEZvZQZavqHLnSLKr6JQ74zRw=; b=QljUd+WlmKDp48V4sE
	71Dtmmdj/m5r4lCXLpA4Lmxxqd2solfiGK6Vr5Rk8z+6c1LEEP0ANy30o3Yopihk
	10gexAB1Go+zIoNpnuriK+p3kVwKxmIVLwlyrtej3bscnG2qIQ0JOhy958qc3UuD
	6KWqDrmqhUQP6vCxr6x++5Ss0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnXJT3lplo9hO7Ag--.55854S2;
	Mon, 11 Aug 2025 15:08:41 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com,
	longman@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
Date: Mon, 11 Aug 2025 15:08:38 +0800
Message-Id: <20250811070838.416176-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnXJT3lplo9hO7Ag--.55854S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfAw4fZr1xCr1rKr15tF1DJrb_yoW8ur18Ao
	WS9FZ8Jw4kGr47A3yrGwn8KFyYgr4vkr45JF1Ykrs5Gr4rA34jk3sIkw48Za4fKFWIkFW3
	ZFW3Wa45ZF4Dtw1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R_iSdDUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibhGmCmiZjLv1PQAAsd

After enabling PREEMPT_RT, ordinary spinlocks can also be subject to cgroup
limits during the lock-holding period. This can lead to seemingly unrelated
threads experiencing timing dependencies due to underlying logic, such as
memory allocation, resulting in delayed wake-up behaviors that are difficult
to understand when analyzing traces captured by tools like Perfetto.
Due to the prevalence of this performance issue when using cgroup CPU
throttling with PREEMPT_RT, the CGROUP_LOCK_OPTIMIZE configuration will be
enabled by default when both PREEMPT_RT and CFS_BANDWIDTH are activated.
This configuration option temporarily increases the priority of tasks to
SCHED_RR 1 if they hold a lock (excluding raw spinlocks, RCU, and seqlock)
and are limited by cgroup, provided they are SCHED_NORMAL. Once the lock is
released, the priority will be restored.
This patch is a derivative of the priority inheritance patch. While priority
inheritance can cover scenarios involving spinlocks and mutexes, it cannot
address the timing dependency issues between two SCHED_NORMAL tasks caused
by underlying locks. Additionally, the lazy_preempt feature does not cover
scenarios where a real-time task, such as a ktimer, interrupts a lock-holding
SCHED_NORMAL task, which is then throttled by cgroup cpu.
This patch not only addresses the issue of cgroup limits affecting spinlocks
under PREEMPT_RT but also resolves issues related to holding mutex or
semaphore locks, as well as other core rt_mutex locks under PREEMPT_RT.
The following stack trace illustrates the delayed wake-up behavior caused by
two seemingly unrelated threads due to underlying logic:
    [24123][Dexceed] [skipcount:0]begin...time[2025-04-23-21_06_42.055008680]
    [24123][Dexceed] wakertgid[16492]wakerpid[16492]wakercomm[ls]
    [24123][Dexceed] wakercommandline[]
    [24123][Dexceed] wakerppid_commandline[...commandline of processA...]
    [24123][Dexceed] stack[19]:
    [24123][Dexceed]      testdiomonitor_add_sample+0x1d8/0x1e0 [...]
    [24123][Dexceed]      cb_sched_waking+0x204/0x220 [...]
    [24123][Dexceed]      try_to_wake_up+0x2d8/0x5a4
    [24123][Dexceed]      wake_up_state+0x1c/0x30
    [24123][Dexceed]      folio_batch_move_lru+0xd8/0x1bc
    [24123][Dexceed]      lru_add_drain_cpu+0xbc/0x190
    [24123][Dexceed]      lru_add_drain+0x48/0x70
    [24123][Dexceed]      exit_mmap+0x9c/0x3b0
    [24123][Dexceed]      __mmput+0x34/0x150
    [24123][Dexceed]      mmput+0x80/0x90
    [24123][Dexceed]      do_exit+0x2b4/0x9b4
    [24123][Dexceed]      do_group_exit+0x3c/0xa0
    [24123][Dexceed]      __wake_up_parent+0x0/0x40
    [24123][Dexceed]      invoke_syscall+0x50/0x120
    [24123][Dexceed]      el0_svc_common.constprop.0+0x168/0x190
    [24123][Dexceed]      do_el0_svc+0x2c/0xa0
    [24123][Dexceed]      el0_svc+0x28/0xb0
    [24123][Dexceed]      el0t_64_sync_handler+0xf4/0x120
    [24123][Dexceed]      el0t_64_sync+0x19c/0x1a0
    [24123][Dexceed] cpu[3]desc[Dexceed]dtimens[78180100]
    [24123][Dexceed] tgid[3574]pid[3626]comm[[2]...com of processB...]
    [24123][Dexceed] iniowait[0]__state[4096][NA]
    [24123][Dexceed] commandline[...commandline of processB...]
    [24123][Dexceed] ppid_commandline[/sbin/init]
    [24123][Dexceed] stack[15]:
    [24123][Dexceed]      folio_lruvec_lock_irqsave+0x64/0xc0
    [24123][Dexceed]      folio_batch_move_lru+0xa4/0x1bc
    [24123][Dexceed]      lru_add_drain_cpu+0xbc/0x190
    [24123][Dexceed]      lru_add_drain+0x48/0x70
    [24123][Dexceed]      unmap_region+0x64/0x130
    [24123][Dexceed]      do_mas_align_munmap.constprop.0+0x28c/0x4fc
    [24123][Dexceed]      do_mas_munmap+0xb4/0xe0
    [24123][Dexceed]      __vm_munmap+0xa8/0x170
    [24123][Dexceed]      __arm64_sys_munmap+0x28/0x40
    [24123][Dexceed]      invoke_syscall+0x50/0x120
    [24123][Dexceed]      el0_svc_common.constprop.0+0x168/0x190
    [24123][Dexceed]      do_el0_svc+0x2c/0xa0
    [24123][Dexceed]      el0_svc+0x28/0xb0
    [24123][Dexceed]      el0t_64_sync_handler+0xf4/0x120
    [24123][Dexceed]      el0t_64_sync+0x19c/0x1a0
Process A, due to being limited by cgroup, had to wait over 81 ms before
it could wake up process B, which from a higher-level perspective seems
unrelated. This delay caused process B's logic to be delayed by 81 ms
before it could continue executing. This patch aims to temporarily boost
the priority of process A to SCHED_RR 1 after being limited by cgroup,
allowing it to exit the lock quickly and restore its priority afterward,
enabling process B to resume execution more promptly.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 include/linux/cgroup.h    |   5 ++
 include/linux/interrupt.h |  11 +++
 include/linux/sched.h     |   9 +++
 include/linux/spinlock.h  |  69 +++++++++++++++++
 init/Kconfig              |  15 ++++
 kernel/cgroup/cgroup.c    | 155 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c       |   6 ++
 kernel/sched/fair.c       |  87 ++++++++++++++++++++-
 kernel/softirq.c          |  23 ++++++
 9 files changed, 378 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb..aa46efd02 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -876,4 +876,9 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
 
 struct cgroup_of_peak *of_peak(struct kernfs_open_file *of);
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+extern void cgroup_boost_prio_pid_write(int pid);
+extern void cgroup_prio_boost_tasklet_schedule(void);
+#endif
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c0..f067eaced 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -758,6 +758,17 @@ static inline void tasklet_schedule(struct tasklet_struct *t)
 		__tasklet_schedule(t);
 }
 
+extern void __tasklet_schedule_nowakeup(struct tasklet_struct *t);
+
+/*
+ * Trigger tasklet but do not do wakeup operation which is forbidden in sched code.
+ */
+static inline void tasklet_schedule_nowakeup(struct tasklet_struct *t)
+{
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
+		__tasklet_schedule_nowakeup(t);
+}
+
 extern void __tasklet_hi_schedule(struct tasklet_struct *t);
 
 static inline void tasklet_hi_schedule(struct tasklet_struct *t)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b2723826..1f98cbb43 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -815,6 +815,11 @@ struct kmap_ctrl {
 #endif
 };
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+#define ORI_NICE_DEFAULT_INVALID	(-1024)
+#define ORI_NICE_SETONCE_INVALID	1024
+#endif
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -885,6 +890,10 @@ struct task_struct {
 	struct task_group		*sched_task_group;
 #endif
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	int				ori_nice;
+	int				nr_rtmutex_nest;
+#endif
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a0..e54b1335c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -65,6 +65,75 @@
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+
+extern void cgroup_boost_prio_restore(struct task_struct *i_p);
+
+#define RTMUTEX_NEST_ADD	\
+	do {	\
+		current->nr_rtmutex_nest ++;	\
+	} while(0)
+#define RTMUTEX_NEST_DEL_WITHOUT_CHECK	\
+	do {	\
+		current->nr_rtmutex_nest --;	\
+	} while(0)
+
+#define RTMUTEX_NEST_DEL	\
+	do {	\
+		current->nr_rtmutex_nest --;	\
+		if (current->pid != 0	\
+			&& current->nr_rtmutex_nest == 0	\
+			&& unlikely(current->ori_nice >= -20)	\
+			&& current->ori_nice <= 19) {	\
+			cgroup_boost_prio_restore(current);	\
+		}	\
+	} while(0)
+
+#define RWBASE_NEST_ADD		\
+	do {	\
+		current->nr_rtmutex_nest ++;	\
+	} while(0)
+#define RWBASE_NEST_DEL_WITHOUT_CHECK	\
+	do {	\
+		current->nr_rtmutex_nest --;	\
+	} while(0)
+
+#define RWBASE_NEST_DEL		\
+	do {	\
+		current->nr_rtmutex_nest --;	\
+		if (current->pid != 0	\
+			&& current->nr_rtmutex_nest == 0	\
+			&& unlikely(current->ori_nice >= -20)	\
+			&& current->ori_nice <= 19) {	\
+			cgroup_boost_prio_restore(current);	\
+		}	\
+	} while(0)
+
+#else
+
+#define RTMUTEX_NEST_ADD	\
+	do {	\
+	} while(0)
+#define RTMUTEX_NEST_DEL_WITHOUT_CHECK	\
+	do {	\
+	} while(0)
+
+#define RTMUTEX_NEST_DEL	\
+	do {	\
+	} while(0)
+
+#define RWBASE_NEST_ADD		\
+	do {	\
+	} while(0)
+#define RWBASE_NEST_DEL_WITHOUT_CHECK	\
+	do {	\
+	} while(0)
+
+#define RWBASE_NEST_DEL		\
+	do {	\
+	} while(0)
+
+#endif
 
 /*
  * Must define these before including other files, inline functions need them
diff --git a/init/Kconfig b/init/Kconfig
index 836320251..cbfcbe7d0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1106,6 +1106,21 @@ config CFS_BANDWIDTH
 	  restriction.
 	  See Documentation/scheduler/sched-bwc.rst for more information.
 
+config CGROUP_LOCK_OPTIMIZE
+	bool "Lock optimize for cgroup cpu throttle"
+	depends on CFS_BANDWIDTH && PREEMPT_RT
+	default CFS_BANDWIDTH
+	help
+	  This option is designed to address performance issues caused by cgroup
+	  limits during lock contention, which have become increasingly severe
+	  after enabling PREEMPT_RT. Currently, this option can only be used when
+	  PREEMPT_RT is enabled. When PREEMPT_RT is enabled and CFS_BANDWIDTH is
+	  activated, this option will be enabled by default. Once this option is
+	  activated, if a fair scheduling class task is subject to cgroup limits
+	  during lock contention, the task will be temporarily adjusted to run at
+	  a priority of RR 1 until all locks are released, after which its
+	  priority will be restored to SCHED_NORMAL.
+
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on CGROUP_SCHED
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b5..0a1d47f6a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6209,6 +6209,157 @@ int __init cgroup_init_early(void)
 	return 0;
 }
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+
+#include <uapi/linux/sched/types.h>
+
+extern const struct sched_class fair_sched_class;
+
+struct cgroup_prio_boost_work {
+	struct work_struct work;
+	int boost_pid;
+};
+
+static struct workqueue_struct *cgroup_prio_boost_wq;
+static struct tasklet_struct cgroup_prio_boost_tasklet;
+#define CGROUP_PRIO_BOOST_PIDS_MAXCOUNT		8192
+static int cgroup_prio_boost_pids[CGROUP_PRIO_BOOST_PIDS_MAXCOUNT];
+static int cgroup_prio_boost_pids_writedone[CGROUP_PRIO_BOOST_PIDS_MAXCOUNT];
+static volatile u64 cgroup_prio_boost_wp = 0;
+static volatile u64 cgroup_prio_boost_rp = 0;
+static u64 cgroup_prio_boost_skipcount = 0;
+
+static int cgroup_boost_prio_get_index(void)
+{
+	u64 windex_raw, windex_raw_old;
+	u32 windex;
+	while (1) {
+		windex_raw = cgroup_prio_boost_wp;
+		if (windex_raw - cgroup_prio_boost_rp
+			>= (u64)(CGROUP_PRIO_BOOST_PIDS_MAXCOUNT)) {
+			cgroup_prio_boost_skipcount ++;
+			if (printk_ratelimit()) {
+				printk("cgroup_prio_boost_skipcount = %llu\n",
+					cgroup_prio_boost_skipcount);
+			}
+			return -1;
+		}
+		// atomic_cmpxchg return old value
+		windex_raw_old = atomic64_cmpxchg((atomic64_t*)&cgroup_prio_boost_wp,
+			windex_raw, windex_raw + 1);
+		if (windex_raw_old == windex_raw) {
+			break;
+		}
+	}
+	windex = (u32)(windex_raw & (u64)(CGROUP_PRIO_BOOST_PIDS_MAXCOUNT - 1));
+	return windex;
+}
+
+void cgroup_boost_prio_pid_write(int pid)
+{
+	int index = cgroup_boost_prio_get_index();
+	if (index >= 0) {
+		cgroup_prio_boost_pids[index] = pid;
+		smp_store_release(&cgroup_prio_boost_pids_writedone[index], 1);
+	}
+}
+EXPORT_SYMBOL(cgroup_boost_prio_pid_write);
+
+static __always_inline void cgroup_boost_prio(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = 1 };
+	if (sched_setscheduler_nocheck(p, SCHED_RR, &sp) != 0) {
+		printk(KERN_ERR "cgroup_boost_prio pid[%d][%s] fail!\n",
+			p->pid, p->comm);
+	}
+}
+
+static void cgroup_prio_boost_work_func(struct work_struct *work)
+{
+	struct cgroup_prio_boost_work *boost_work =
+		container_of(work, struct cgroup_prio_boost_work, work);
+	int boost_pid = boost_work->boost_pid;
+	struct pid* pid_struct;
+	struct task_struct *p;
+	struct sched_param param;
+	param.sched_priority = 1;
+	pid_struct = find_get_pid(boost_pid);
+	if (pid_struct) {
+		p = get_pid_task(pid_struct, PIDTYPE_PID);
+		if (likely(p)) {
+			if (p->sched_class == &fair_sched_class
+				&& p->nr_rtmutex_nest) {
+				int ori_nice = task_nice(p);
+				if (ori_nice >= -20 && ori_nice <= 19) {
+					p->ori_nice = ori_nice;
+					cgroup_boost_prio(p);
+					// corner case when set to RR just after unlock
+					if (p->nr_rtmutex_nest == 0) {
+						sched_set_normal(p, ori_nice);
+					}
+				}
+			}
+			put_task_struct(p);
+		}
+		put_pid(pid_struct);
+	}
+	kfree(boost_work);
+}
+
+static void cgroup_prio_boost_queue_work(int boost_pid)
+{
+	struct cgroup_prio_boost_work *work;
+	work = kmalloc(sizeof(struct cgroup_prio_boost_work), GFP_ATOMIC);
+	if (!work) {
+		printk(KERN_ERR "Failed to allocate memory for work\n");
+		return;
+	}
+	work->boost_pid = boost_pid;
+	INIT_WORK(&work->work, cgroup_prio_boost_work_func);
+	queue_work(cgroup_prio_boost_wq, &work->work);
+}
+
+#ifndef UNUSED
+#define UNUSED(x) (void)(x)
+#endif
+
+static void cgroup_prio_boost_tasklet_func(unsigned long data)
+{
+	UNUSED(data);
+	u32 index;
+	int boost_pid;
+	while (cgroup_prio_boost_wp != cgroup_prio_boost_rp) {
+		index = (cgroup_prio_boost_rp & (CGROUP_PRIO_BOOST_PIDS_MAXCOUNT - 1));
+		if (smp_load_acquire(&cgroup_prio_boost_pids_writedone[index]) != 1) {
+			break;
+		}
+		boost_pid = cgroup_prio_boost_pids[index];
+		cgroup_prio_boost_queue_work(boost_pid);
+		cgroup_prio_boost_pids_writedone[index] = 0;
+		cgroup_prio_boost_rp++;
+	}
+}
+
+static int cgroup_lock_optimize_init(void)
+{
+	cgroup_prio_boost_wq = create_workqueue("cgroup_prio_boost_wq");
+	if (!cgroup_prio_boost_wq) {
+		printk(KERN_ERR "Failed to create workqueue cgroup_prio_boost_wq\n");
+		return -ENOMEM;
+	}
+	tasklet_init(&cgroup_prio_boost_tasklet,
+		cgroup_prio_boost_tasklet_func, 0);
+	return 0;
+}
+
+void cgroup_prio_boost_tasklet_schedule(void)
+{
+	tasklet_schedule_nowakeup(&cgroup_prio_boost_tasklet);
+}
+EXPORT_SYMBOL(cgroup_prio_boost_tasklet_schedule);
+
+#endif
+
 /**
  * cgroup_init - cgroup initialization
  *
@@ -6312,6 +6463,10 @@ int __init cgroup_init(void)
 	WARN_ON(register_filesystem(&cpuset_fs_type));
 #endif
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	WARN_ON(cgroup_lock_optimize_init());
+#endif
+
 	return 0;
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0..156b174fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4520,6 +4520,12 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 	init_sched_mm_cid(p);
+
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	// ORI_NICE_DEFAULT_INVALID smaller than -20 for RTMUTEX_NEST_DEL check
+	p->ori_nice = ORI_NICE_DEFAULT_INVALID;
+	p->nr_rtmutex_nest = 0;
+#endif
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a0593..26bf01a22 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5546,6 +5546,20 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	/* throttle cfs_rqs exceeding runtime */
 	check_cfs_rq_runtime(cfs_rq);
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	if (cfs_rq->throttled) {
+		struct sched_entity *se = prev;
+		if (entity_is_task(se)) {
+			struct task_struct *p;
+			p = task_of(se);
+			if (p->nr_rtmutex_nest) {
+				cgroup_boost_prio_pid_write(p->pid);
+				cgroup_prio_boost_tasklet_schedule();
+			}
+		}
+	}
+#endif
+
 	if (prev->on_rq) {
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
@@ -5781,6 +5795,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	struct rb_node *node;
+	struct task_struct *p;
+#endif
 
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
@@ -5793,6 +5811,22 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	}
 	cfs_rq->throttle_count++;
 
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	node = rb_first(&cfs_rq->tasks_timeline.rb_root);
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+		if (!entity_is_task(se))
+			goto next;
+		p = task_of(se);
+		if (p->nr_rtmutex_nest) {
+			cgroup_boost_prio_pid_write(p->pid);
+			cgroup_prio_boost_tasklet_schedule();
+		}
+next:
+		node = rb_next(node);
+	}
+#endif
+
 	return 0;
 }
 
@@ -6830,6 +6864,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	bool needcheck = false;
+#endif
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6884,8 +6921,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_throttled(cfs_rq)) {
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+			needcheck = true;
+#endif
 			goto enqueue_throttle;
+		}
 
 		flags = ENQUEUE_WAKEUP;
 	}
@@ -6910,8 +6951,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_throttled(cfs_rq)) {
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+			needcheck = true;
+#endif
 			goto enqueue_throttle;
+		}
 	}
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
@@ -6945,6 +6990,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+	if (unlikely(needcheck)) {
+		if (p->nr_rtmutex_nest) {
+			cgroup_boost_prio_pid_write(p->pid);
+			cgroup_prio_boost_tasklet_schedule();
+		}
+	}
+#endif
 }
 
 static void set_next_buddy(struct sched_entity *se);
@@ -13630,3 +13683,33 @@ __init void init_sched_fair_class(void)
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
 }
+
+#ifdef CONFIG_CGROUP_LOCK_OPTIMIZE
+
+#include <uapi/linux/sched/types.h>
+
+extern void cgroup_prio_boost_tasklet_schedule(void);
+
+static __always_inline void cgroup_boost_prio(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = 1 };
+	if (sched_setscheduler_nocheck(p, SCHED_RR, &sp) != 0) {
+		printk(KERN_ERR "cgroup_boost_prio pid[%d][%s] fail!\n",
+			p->pid, p->comm);
+	}
+}
+
+void cgroup_boost_prio_restore(struct task_struct *p)
+{
+	if (p->sched_class == &fair_sched_class) {
+		return;
+	}
+	sched_set_normal(p, p->ori_nice);
+	if (p->policy != SCHED_NORMAL) {
+		// set it again for corner case when throttle boost just change prio
+		sched_set_normal(p, p->ori_nice);
+	}
+}
+EXPORT_SYMBOL(cgroup_boost_prio_restore);
+
+#endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b19459..4e9f0c3fb 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -786,6 +786,29 @@ void __tasklet_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_schedule);
 
+static void __tasklet_schedule_common_nowakeup(struct tasklet_struct *t,
+				      struct tasklet_head __percpu *headp,
+				      unsigned int softirq_nr)
+{
+	struct tasklet_head *head;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	head = this_cpu_ptr(headp);
+	t->next = NULL;
+	*head->tail = t;
+	head->tail = &(t->next);
+	__raise_softirq_irqoff(softirq_nr);
+	local_irq_restore(flags);
+}
+
+void __tasklet_schedule_nowakeup(struct tasklet_struct *t)
+{
+	__tasklet_schedule_common_nowakeup(t, &tasklet_vec,
+				  TASKLET_SOFTIRQ);
+}
+EXPORT_SYMBOL(__tasklet_schedule_nowakeup);
+
 void __tasklet_hi_schedule(struct tasklet_struct *t)
 {
 	__tasklet_schedule_common(t, &tasklet_hi_vec,
-- 
2.34.1


