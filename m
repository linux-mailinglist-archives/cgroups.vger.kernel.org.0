Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B231364D299
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 23:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLNWvu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 17:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLNWvt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 17:51:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1530F79
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 14:51:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so1502279ybf.13
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 14:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUc+v5HwD46tRHbZWt0mN+PX65Kt87vRY2PWRTrdra8=;
        b=D1ZGqVZqRfjR4k+QCHfaRDc8HXpG/JxiKLnotRDm7Q0jKKMK98yfDAMjKF0CLGdkeO
         BVF5VEcuWQxJx6HnJzNbK6mWrwXtEdlrjzqRS0tZNCszk9P+OwNxJmLtbk++RNZ3MJ2G
         CZO/woce3dSyn1ylx7eIxBwwxjPYWeaDpc35wLuMTka2EBsXgXps1k6sEw7ixcsNXF9p
         XS/ySLs5INBD64ztnBLJmjS2xKhcPb2uQ8HO5xHRDe3Z59Zo8PPRKLq8X555tFBm+KIb
         asLhS5yiHmEdXlSIpeEqhJHQ5RCV8f1SRahCwzobKiTodVo1k1IFYKNhqPiusXTCOodl
         f8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUc+v5HwD46tRHbZWt0mN+PX65Kt87vRY2PWRTrdra8=;
        b=r+ukuqSxIoOEkUCgm1FNR4qXJq8n0mvSxUzLh+64CZ/6cOFkMR0pQ99qGGLCCIf7yw
         Lm1XtC0Gl36qIlZGlqv3C8oEHiKz2oG/8gcj4CNDHoY/L7+1dGZTJLTxm5j/H6O7xq2b
         JyElAuFTdnAT3QOSDw1nLiSvUpUsTxMcmpnG58ZgBQ8gd1hdkd8yAEAKKhrlfTrTR5SH
         1ei7iVKPFBzgWn2hN0tGji6pDW1xqqJTgLicc5/qevbnRvDaOi6OVsMRvByqfEGJrSQT
         ugeY06LDFXO8DOX3lowAkoKfcPZyl9AhzZE9ZlQTXdcgZh7SU5vnz5GMKFoCbLJbmGJ5
         lqvg==
X-Gm-Message-State: ANoB5pmdX5vdo7h9HwlIjJW/zciWuhTGjOhYNiZB2PJeQKC3fx09MbgZ
        GoX8DuMwsgdr69HFG0g8Q/e/kLmbIl7W
X-Google-Smtp-Source: AA0mqf7DGDIJUfC4VIyKgAVtfwcgyC3fcmhOUgkP+R5oeIkqE2QVIN7CL/qi6/psX2VJUox0PiyWM7a9fBN1
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:1311:60bc:9e2a:ab1])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:583:b0:3bd:4b7a:c0b1 with SMTP id
 bo3-20020a05690c058300b003bd4b7ac0b1mr1390108ywb.220.1671058307326; Wed, 14
 Dec 2022 14:51:47 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:51:22 -0800
In-Reply-To: <20221214225123.2770216-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20221214225123.2770216-1-yuanchu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221214225123.2770216-2-yuanchu@google.com>
Subject: [RFC PATCH 1/2] mm: multi-gen LRU: periodic aging
From:   Yuanchu Xie <yuanchu@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Periodically age MGLRU-enabled lruvecs to turn MGLRU generations into
time-based working set information. This includes an interface to set
the periodic aging interval and a new kthread to perform aging.

memory.periodic_aging: a new root-level only file in cgroupfs
Writing to memory.periodic aging sets the aging interval and opts into
periodic aging.
kold: a new kthread that ages memcgs based on the set aging interval.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/kold.h   |  44 ++++++++++++
 include/linux/mmzone.h |   4 +-
 mm/Makefile            |   3 +
 mm/kold.c              | 150 +++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c        |  52 ++++++++++++++
 mm/vmscan.c            |  35 +++++++++-
 6 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/kold.h
 create mode 100644 mm/kold.c

diff --git a/include/linux/kold.h b/include/linux/kold.h
new file mode 100644
index 000000000000..10b0dbe09a5c
--- /dev/null
+++ b/include/linux/kold.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Periodic aging for multi-gen LRU
+ *
+ * Copyright (C) 2022 Yuanchu Xie <yuanchu@google.com>
+ */
+#ifndef KOLD_H_
+#define KOLD_H_
+
+#include <linux/memcontrol.h>
+
+struct kold_stats {
+	/* late is defined as spending an entire interval aging without sleep
+	 * stat is aggregated every aging interval
+	 */
+	unsigned int late_count;
+};
+
+int kold_set_interval(unsigned int interval);
+unsigned int kold_get_interval(void);
+int kold_get_stats(struct kold_stats *stats);
+
+/* returns the creation timestamp of the youngest generation */
+unsigned long lru_gen_force_age_lruvec(struct mem_cgroup *memcg, int nid,
+				      unsigned long min_ttl);
+
+#ifndef CONFIG_MEMCG
+int kold_set_interval(unsigned int interval)
+{
+	return 0;
+}
+
+unsigned int kold_get_interval(void)
+{
+	return 0;
+}
+
+int kold_get_stats(struct kold_stats *stats)
+{
+	return -1;
+}
+#endif	/* CONFIG_MEMCG */
+
+#endif	/* KOLD_H_ */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5f74891556f3..929c777b826a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1218,7 +1218,9 @@ typedef struct pglist_data {
 
 #ifdef CONFIG_LRU_GEN
 	/* kswap mm walk data */
-	struct lru_gen_mm_walk	mm_walk;
+	struct lru_gen_mm_walk mm_walk;
+	/* kold periodic aging walk data */
+	struct lru_gen_mm_walk kold_mm_walk;
 #endif
 
 	CACHELINE_PADDING(_pad2_);
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..8bd554a6eb7d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -98,6 +98,9 @@ obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+ifdef CONFIG_LRU_GEN
+obj-$(CONFIG_MEMCG) += kold.o
+endif
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/kold.c b/mm/kold.c
new file mode 100644
index 000000000000..094574177968
--- /dev/null
+++ b/mm/kold.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Yuanchu Xie <yuanchu@google.com>
+ */
+#include <linux/stddef.h>
+#include <linux/topology.h>
+#include <linux/cpumask.h>
+#include <linux/mmzone.h>
+#include <linux/nodemask.h>
+#include <linux/sched/mm.h>
+#include <linux/swap.h>
+#include <linux/memcontrol.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/cache.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/kold.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mm_inline.h>
+
+static struct task_struct *kold_thread __read_mostly;
+/* protects kold_thread */
+static DEFINE_MUTEX(kold_mutex);
+
+static unsigned int aging_interval __read_mostly;
+static unsigned int late_count;
+
+/* try to move to a cpu on the target node */
+static void try_move_current_to_node(int nid)
+{
+	struct cpumask node_cpus;
+
+	cpumask_and(&node_cpus, cpumask_of_node(nid), cpu_online_mask);
+	if (!cpumask_empty(&node_cpus))
+		set_cpus_allowed_ptr(current, &node_cpus);
+}
+
+static int kold_run(void *none)
+{
+	int nid;
+	unsigned int flags;
+	unsigned long last_interval_start_time = jiffies;
+	bool sleep_since_last_full_scan = false;
+	struct mem_cgroup *memcg;
+	struct reclaim_state reclaim_state = {};
+
+	while (!kthread_should_stop()) {
+		unsigned long interval =
+			(unsigned long)(READ_ONCE(aging_interval)) * HZ;
+		unsigned long next_wakeup_tick = jiffies + interval;
+		long timeout_ticks;
+
+		current->reclaim_state = &reclaim_state;
+		flags = memalloc_noreclaim_save();
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+
+			try_move_current_to_node(nid);
+			reclaim_state.mm_walk = &pgdat->kold_mm_walk;
+
+			memcg = mem_cgroup_iter(NULL, NULL, NULL);
+			do {
+				unsigned long young_timestamp =
+					lru_gen_force_age_lruvec(memcg, nid,
+								 interval);
+
+				if (time_before(young_timestamp + interval,
+						next_wakeup_tick)) {
+					next_wakeup_tick = young_timestamp + interval;
+				}
+			} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+		}
+
+		memalloc_noreclaim_restore(flags);
+		current->reclaim_state = NULL;
+
+		/* late_count stats update */
+		if (time_is_before_jiffies(last_interval_start_time + interval)) {
+			last_interval_start_time += interval;
+			if (!sleep_since_last_full_scan) {
+				WRITE_ONCE(late_count,
+					   READ_ONCE(late_count) + 1);
+			}
+			sleep_since_last_full_scan = false;
+		}
+
+		/* sleep until next aging */
+		timeout_ticks = -(long)(jiffies - next_wakeup_tick);
+		if (timeout_ticks > 0 && timeout_ticks != MAX_SCHEDULE_TIMEOUT) {
+			sleep_since_last_full_scan = true;
+			schedule_timeout_idle(timeout_ticks);
+		}
+	}
+	return 0;
+}
+
+int kold_get_stats(struct kold_stats *stats)
+{
+	stats->late_count = READ_ONCE(late_count);
+	return 0;
+}
+
+unsigned int kold_get_interval(void)
+{
+	return READ_ONCE(aging_interval);
+}
+
+int kold_set_interval(unsigned int interval)
+{
+	int err = 0;
+
+	mutex_lock(&kold_mutex);
+	if (interval && !kold_thread) {
+		if (!lru_gen_enabled()) {
+			err = -EOPNOTSUPP;
+			goto cleanup;
+		}
+		kold_thread = kthread_create(kold_run, NULL, "kold");
+
+		if (IS_ERR(kold_thread)) {
+			pr_err("kold: kthread_run(kold_run) failed\n");
+			err = PTR_ERR(kold_thread);
+			kold_thread = NULL;
+			goto cleanup;
+		}
+		WRITE_ONCE(aging_interval, interval);
+		wake_up_process(kold_thread);
+	} else {
+		if (!interval && kold_thread) {
+			kthread_stop(kold_thread);
+			kold_thread = NULL;
+		}
+		WRITE_ONCE(aging_interval, interval);
+	}
+
+cleanup:
+	mutex_unlock(&kold_mutex);
+	return err;
+}
+
+static int __init kold_init(void)
+{
+	return 0;
+}
+
+module_init(kold_init);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..7d2fb3fc4580 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/kold.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -6569,6 +6570,49 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+#ifdef CONFIG_LRU_GEN
+static int memory_periodic_aging_show(struct seq_file *m, void *v)
+{
+	unsigned int interval = kold_get_interval();
+	struct kold_stats stats;
+	int err;
+
+	err = kold_get_stats(&stats);
+
+	if (err)
+		return err;
+
+	seq_printf(m, "aging_interval %u\n", interval);
+	seq_printf(m, "late_count %u\n", stats.late_count);
+	return 0;
+}
+
+static ssize_t memory_periodic_aging_write(struct kernfs_open_file *of,
+				       char *buf, size_t nbytes,
+				       loff_t off)
+{
+	unsigned int new_interval;
+	int err;
+
+	if (!lru_gen_enabled())
+		return -EOPNOTSUPP;
+
+	buf = strstrip(buf);
+	if (!buf)
+		return -EINVAL;
+
+	err = kstrtouint(buf, 0, &new_interval);
+	if (err)
+		return err;
+
+	err = kold_set_interval(new_interval);
+	if (err)
+		return err;
+
+	return nbytes;
+}
+#endif /* CONFIG_LRU_GEN */
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -6679,6 +6723,14 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+#ifdef CONFIG_LRU_GEN
+	{
+		.name = "periodic_aging",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.seq_show = memory_periodic_aging_show,
+		.write = memory_periodic_aging_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..0fea21366fc8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -54,6 +54,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
+#include <linux/kold.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -5279,8 +5280,10 @@ static void lru_gen_change_state(bool enabled)
 
 	if (enabled)
 		static_branch_enable_cpuslocked(&lru_gen_caps[LRU_GEN_CORE]);
-	else
+	else {
 		static_branch_disable_cpuslocked(&lru_gen_caps[LRU_GEN_CORE]);
+		kold_set_interval(0);
+	}
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
@@ -5760,6 +5763,36 @@ static const struct file_operations lru_gen_ro_fops = {
 	.release = seq_release,
 };
 
+/******************************************************************************
+ *                      periodic aging (kold)
+ ******************************************************************************/
+
+/* age lruvec as long as it is older than min_ttl,
+ * return the timestamp of the youngest generation
+ */
+unsigned long lru_gen_force_age_lruvec(struct mem_cgroup *memcg, int nid,
+				      unsigned long min_ttl)
+{
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+	struct lruvec *lruvec = get_lruvec(memcg, nid);
+	DEFINE_MAX_SEQ(lruvec);
+	int gen = lru_gen_from_seq(max_seq);
+	unsigned long birth_timestamp =
+		READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+	if (time_is_before_jiffies(birth_timestamp + min_ttl))
+		try_to_inc_max_seq(lruvec, max_seq, &sc, true, true);
+
+	return READ_ONCE(lruvec->lrugen.timestamps[lru_gen_from_seq(
+		READ_ONCE((lruvec)->lrugen.max_seq))]);
+}
+
 /******************************************************************************
  *                          initialization
  ******************************************************************************/
-- 
2.39.0.314.g84b9a713c41-goog

