Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78996FCE0F
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjEISyr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjEISyq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 14:54:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B103C26
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 11:54:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559f142fce7so113570347b3.3
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683658474; x=1686250474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CVFyFNV090cR7eiRXOtg8EIDs/ck5oOA57qLIIP4F4=;
        b=KCxuFPwhPo/zizI/tEtPEL+YSWDuLAQObzGue4e9IyiJJTfHF9OGHB8I3N+yOF6J/x
         mIUdiagy7n+M5pIvbnF6C2iH/aqEEr4yHsDLZ1nBatzqkOlT0v4WYcYs8t/WorpRWhop
         TG6vnm6gUhqm5zRF5qjDn57vNcKF7ikTHl9VjNpFC4hMwEjW56GQ58pReybZdmJ9sGzZ
         bNkXGq/2Phuulf4mVmtKl43PYGm5blOX4kyxOxeJtdX6NA5XV45cGg+jtD20XTArXMgo
         YjAW6le6vsK7sZ9ggGVn1CrIBMTbY4xJXNzCkIlkLu2gi9LouuZzCdn5Kvnv0TFeeMIK
         TUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683658474; x=1686250474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CVFyFNV090cR7eiRXOtg8EIDs/ck5oOA57qLIIP4F4=;
        b=aAwLuMf1AMyb/HzYesMgZoCVAmhmF2iRf2Xh5aYbZZjvVuWx8CBAuaGfZss9T6yUVf
         nUBwtUu7LnIkKiDjk+0k1eViZY9xb1Hsjj/Ap0hIKeWP5BPFEo4EPHmZw4PeauLwINpW
         nyahe+aIXya6mdrA0krNxQzmTm/LVIb3x9fwjDOOV6v63gxSg9A/5FRHUMZUoIMAX+I+
         rx7bksE14Tnl/dvYhDj8v6WMKHr59TM5ty8Mutvu+vIJBuP8o1TsOd8A1+uxwvg41/Id
         0aIIk7gVURx/R7pz2Rz+TEPyOB2zRgywO7SQsepR5gj2SlTdGAQsrZ1DqwtSgZSXRAMv
         4lCA==
X-Gm-Message-State: AC+VfDx3+1QPwltvgO35vRRNNy7CQoQPCIdhxF0ohW/BRI8a4druivRd
        EshPQBbtcAWAAUTfLyG7tmNqlLFxi6n8
X-Google-Smtp-Source: ACHHUZ57g25YJzdGrTobMJE74jtwnDmYOUaHI4absFdxMw7rroYxFH3AyDLkFMAz1Bc37sSPj0Grgxj96Z6F
X-Received: from yuanchu.bej.corp.google.com ([2401:fa00:44:10:d495:1070:e926:f84a])
 (user=yuanchu job=sendgmr) by 2002:a81:ae55:0:b0:55d:fd06:5a7f with SMTP id
 g21-20020a81ae55000000b0055dfd065a7fmr4707277ywk.6.1683658474526; Tue, 09 May
 2023 11:54:34 -0700 (PDT)
Date:   Wed, 10 May 2023 02:54:18 +0800
In-Reply-To: <20230509185419.1088297-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20230509185419.1088297-1-yuanchu@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509185419.1088297-2-yuanchu@google.com>
Subject: [RFC PATCH 1/2] mm: multigen-LRU: working set reporting
From:   Yuanchu Xie <yuanchu@google.com>
To:     David Hildenbrand <david@redhat.com>,
        "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com
Cc:     SeongJae Park <sj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        talumbau <talumbau@google.com>, Yuanchu Xie <yuanchu@google.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: talumbau <talumbau@google.com>

A single patch to be broken up into multiple patches.
- Add working set reporting structure.
- Add per-node and per-memcg interfaces for working set reporting.
- Implement working set backend for MGLRU.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/base/node.c        |   2 +
 include/linux/memcontrol.h |   6 +
 include/linux/mmzone.h     |  14 +-
 include/linux/wss.h        |  57 +++++
 mm/Kconfig                 |   7 +
 mm/Makefile                |   1 +
 mm/memcontrol.c            | 349 ++++++++++++++++++++++++++-
 mm/mmzone.c                |   2 +
 mm/vmscan.c                | 479 ++++++++++++++++++++++++++++++++++++-
 mm/wss.c                   |  56 +++++
 10 files changed, 970 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/wss.h
 create mode 100644 mm/wss.c

diff --git a/drivers/base/node.c b/drivers/base/node.c
index faf3597a96da..047908978088 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -616,6 +616,7 @@ static int register_node(struct node *node, int num)
 	} else {
 		hugetlb_register_node(node);
 		compaction_register_node(node);
+		wss_register_node(node);
 	}
 
 	return error;
@@ -632,6 +633,7 @@ void unregister_node(struct node *node)
 {
 	hugetlb_unregister_node(node);
 	compaction_unregister_node(node);
+	wss_unregister_node(node);
 	node_remove_accesses(node);
 	node_remove_caches(node);
 	device_unregister(&node->dev);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 85dc9b88ea37..95d4a0bc89e7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -10,6 +10,7 @@
 
 #ifndef _LINUX_MEMCONTROL_H
 #define _LINUX_MEMCONTROL_H
+#include <linux/wait.h>
 #include <linux/cgroup.h>
 #include <linux/vm_event_item.h>
 #include <linux/hardirq.h>
@@ -325,6 +326,11 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+#ifdef CONFIG_WSS
+	int wss_event;
+	wait_queue_head_t wss_wait_queue;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cd28a100d9e4..506c29aaf124 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -21,6 +21,7 @@
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
 #include <linux/local_lock.h>
+#include <linux/wss.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -361,6 +362,7 @@ enum lruvec_flags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+struct node;
 struct lruvec;
 struct page_vma_mapped_walk;
 
@@ -481,7 +483,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 #ifdef CONFIG_MEMCG
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
 void lru_gen_exit_memcg(struct mem_cgroup *memcg);
-#endif
+#endif /* CONFIG_MEMCG */
 
 #else /* !CONFIG_LRU_GEN */
 
@@ -503,6 +505,14 @@ static inline void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 }
 #endif
 
+static inline void wss_register_node(struct node *node)
+{
+}
+
+static inline void wss_unregister_node(struct node *node)
+{
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 struct lruvec {
@@ -527,6 +537,8 @@ struct lruvec {
 	struct lru_gen_struct		lrugen;
 	/* to concurrently iterate lru_gen_mm_list */
 	struct lru_gen_mm_state		mm_state;
+	/* only accessed through lruvec_wss */
+	struct wss __wss;
 #endif
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
diff --git a/include/linux/wss.h b/include/linux/wss.h
new file mode 100644
index 000000000000..942efce0f9c2
--- /dev/null
+++ b/include/linux/wss.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WSS_H
+#define _LINUX_WSS_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+struct node;
+struct lruvec;
+struct mem_cgroup;
+struct pglist_data;
+struct scan_control;
+struct lru_gen_mm_walk;
+
+#define ANON_AND_FILE 2
+
+#define MIN_NR_BINS 4
+#define MAX_NR_BINS 16
+
+struct wss_bin {
+	unsigned long idle_age;
+	unsigned long nr_pages[ANON_AND_FILE];
+};
+
+struct wss {
+	/* protects bins */
+	struct mutex bins_lock;
+	/* protects reaccess_bins */
+	struct mutex reaccess_bins_lock;
+	struct kernfs_node *notifier;
+	unsigned long timestamp;
+	unsigned long report_threshold;
+	unsigned long refresh_threshold;
+	struct wss_bin bins[MAX_NR_BINS];
+	struct wss_bin reaccess_bins[MAX_NR_BINS];
+};
+
+void wss_register_node(struct node *node);
+void wss_unregister_node(struct node *node);
+
+void wss_init(struct wss *wss);
+void wss_destroy(struct wss *wss);
+struct wss *lruvec_wss(struct lruvec *lruvec);
+
+ssize_t wss_intervals_ms_parse(char *src, struct wss_bin *bins);
+
+/*
+ * wss->bins needs to be locked
+ * refreshes wss based on the refresh threshold
+ */
+void wss_refresh(struct wss *wss, struct mem_cgroup *root,
+		 struct pglist_data *pgdat);
+void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk);
+void report_wss(struct pglist_data *pgdat, struct scan_control *sc);
+
+#endif /* _LINUX_WSS_H */
+
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..b3a32c2b360f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,13 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config WSS
+	bool "Working set reporting"
+	depends on LRU_GEN
+	help
+	  This option enables working set reporting, separate backends
+	  WIP. Currently only supports MGLRU.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..409b4fc97485 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_WSS) += wss.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2eee092f8f11..08e574c86b18 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -25,6 +25,7 @@
  * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */
 
+#include <linux/wait.h>
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
@@ -65,6 +66,7 @@
 #include <linux/seq_buf.h>
 #include "internal.h"
 #include <net/sock.h>
+#include <linux/wss.h>
 #include <net/ip.h>
 #include "slab.h"
 #include "swap.h"
@@ -5233,6 +5235,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
+	wss_destroy(lruvec_wss(&pn->lruvec));
 	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn);
 }
@@ -5311,6 +5314,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
+#endif
+#ifdef CONFIG_WSS
+	memcg->wss_event = 0;
+	init_waitqueue_head(&memcg->wss_wait_queue);
 #endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	lru_gen_init_memcg(memcg);
@@ -5411,6 +5418,9 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	}
 	spin_unlock_irq(&memcg->event_list_lock);
 
+	wake_up_pollfree(&memcg->wss_wait_queue);
+	synchronize_rcu();
+
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
@@ -6642,6 +6652,306 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+#ifdef CONFIG_WSS
+static int memory_wss_intervals_ms_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wss *wss;
+		struct wss_bin *bin;
+
+		wss = lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+		mutex_lock(&wss->bins_lock);
+		seq_printf(m, "N%d=", nid);
+		for (bin = wss->bins; bin->idle_age != -1; bin++)
+			seq_printf(m, "%u,", jiffies_to_msecs(bin->idle_age));
+		mutex_unlock(&wss->bins_lock);
+
+		seq_printf(m, "%lld ", LLONG_MAX);
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_wss_intervals_ms_parse(struct kernfs_open_file *of,
+					     char *buf, size_t nbytes,
+					     unsigned int *nid_out,
+					     struct wss_bin *bins)
+{
+	char *node, *intervals;
+	unsigned int nid;
+	int err;
+
+	buf = strstrip(buf);
+	intervals = buf;
+	node = strsep(&intervals, "=");
+
+	if (*node != 'N')
+		return -EINVAL;
+
+	err = kstrtouint(node + 1, 0, &nid);
+	if (err)
+		return err;
+
+	if (nid >= nr_node_ids || !node_state(nid, N_MEMORY))
+		return -EINVAL;
+
+	err = wss_intervals_ms_parse(intervals, bins);
+	if (err)
+		return err;
+
+	*nid_out = nid;
+	return 0;
+}
+
+static ssize_t memory_wss_intervals_ms_write(struct kernfs_open_file *of,
+					     char *buf, size_t nbytes,
+					     loff_t off)
+{
+	unsigned int nid;
+	int err;
+	struct wss *wss;
+	struct wss_bin *bins;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	bins = kzalloc(sizeof(wss->bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	err = memory_wss_intervals_ms_parse(of, buf, nbytes, &nid, bins);
+	if (err)
+		goto failed;
+
+	wss = lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+	mutex_lock(&wss->bins_lock);
+	memcpy(wss->bins, bins, sizeof(wss->bins));
+	mutex_unlock(&wss->bins_lock);
+failed:
+	kfree(bins);
+	return err ?: nbytes;
+}
+
+static int memory_reaccess_intervals_ms_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wss *wss;
+		struct wss_bin *bin;
+
+		wss = lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+		mutex_lock(&wss->reaccess_bins_lock);
+		seq_printf(m, "N%d=", nid);
+		for (bin = wss->reaccess_bins; bin->idle_age != -1; bin++)
+			seq_printf(m, "%u,", jiffies_to_msecs(bin->idle_age));
+		mutex_unlock(&wss->reaccess_bins_lock);
+
+		seq_printf(m, "%lld ", LLONG_MAX);
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_reaccess_intervals_ms_write(struct kernfs_open_file *of,
+						  char *buf, size_t nbytes,
+						  loff_t off)
+{
+	unsigned int nid;
+	int err;
+	struct wss *wss;
+	struct wss_bin *bins;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	bins = kzalloc(sizeof(wss->reaccess_bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	err = memory_wss_intervals_ms_parse(of, buf, nbytes, &nid, bins);
+	if (err)
+		goto failed;
+
+	wss = lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+	mutex_lock(&wss->reaccess_bins_lock);
+	memcpy(wss->reaccess_bins, bins, sizeof(wss->reaccess_bins));
+	mutex_unlock(&wss->reaccess_bins_lock);
+failed:
+	kfree(bins);
+	return err ?: nbytes;
+}
+
+static int memory_wss_refresh_ms_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wss *wss =
+			lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+
+		seq_printf(m, "N%d=%u ", nid,
+			   jiffies_to_msecs(READ_ONCE(wss->refresh_threshold)));
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_wss_threshold_parse(char *buf, size_t nbytes,
+					  unsigned int *nid_out,
+					  unsigned int *msecs)
+{
+	char *node, *threshold;
+	unsigned int nid;
+	int err;
+
+	buf = strstrip(buf);
+	threshold = buf;
+	node = strsep(&threshold, "=");
+
+	if (*node != 'N')
+		return -EINVAL;
+
+	err = kstrtouint(node + 1, 0, &nid);
+	if (err)
+		return err;
+
+	if (nid >= nr_node_ids || !node_state(nid, N_MEMORY))
+		return -EINVAL;
+
+	err = kstrtouint(threshold, 0, msecs);
+	if (err)
+		return err;
+
+	*nid_out = nid;
+
+	return nbytes;
+}
+
+static ssize_t memory_wss_refresh_ms_write(struct kernfs_open_file *of,
+					   char *buf, size_t nbytes, loff_t off)
+{
+	unsigned int nid, msecs;
+	struct wss *wss;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = memory_wss_threshold_parse(buf, nbytes, &nid, &msecs);
+
+	if (ret < 0)
+		return ret;
+
+	wss = lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+	WRITE_ONCE(wss->refresh_threshold, msecs_to_jiffies(msecs));
+	return ret;
+}
+
+static int memory_wss_report_ms_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wss *wss =
+			lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+
+		seq_printf(m, "N%d=%u ", nid,
+			   jiffies_to_msecs(READ_ONCE(wss->report_threshold)));
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static ssize_t memory_wss_report_ms_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	unsigned int nid, msecs;
+	struct wss *wss;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = memory_wss_threshold_parse(buf, nbytes, &nid, &msecs);
+
+	if (ret < 0)
+		return ret;
+
+	wss = lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+	WRITE_ONCE(wss->report_threshold, msecs_to_jiffies(msecs));
+	return ret;
+}
+
+static int memory_wss_histogram_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wss *wss =
+			lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+		struct wss_bin *bin;
+
+		seq_printf(m, "N%d\n", nid);
+
+		mutex_lock(&wss->bins_lock);
+		wss_refresh(wss, memcg, NODE_DATA(nid));
+		for (bin = wss->bins; bin->idle_age != -1; bin++)
+			seq_printf(m, "%u anon=%lu file=%lu\n",
+				   jiffies_to_msecs(bin->idle_age),
+				   bin->nr_pages[0], bin->nr_pages[1]);
+
+		seq_printf(m, "%lld anon=%lu file=%lu\n", LLONG_MAX,
+			   bin->nr_pages[0], bin->nr_pages[1]);
+
+		mutex_unlock(&wss->bins_lock);
+	}
+
+	return 0;
+}
+
+__poll_t memory_wss_histogram_poll(struct kernfs_open_file *of,
+				   struct poll_table_struct *pt)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	if (memcg->css.flags & CSS_DYING)
+		return DEFAULT_POLLMASK;
+
+	poll_wait(of->file, &memcg->wss_wait_queue, pt);
+	if (cmpxchg(&memcg->wss_event, 1, 0) == 1)
+		return DEFAULT_POLLMASK | EPOLLPRI;
+	return DEFAULT_POLLMASK;
+}
+
+static int memory_reaccess_histogram_show(struct seq_file *m, void *v)
+{
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct wss *wss =
+			lruvec_wss(mem_cgroup_lruvec(memcg, NODE_DATA(nid)));
+		struct wss_bin *bin;
+
+		seq_printf(m, "N%d\n", nid);
+
+		mutex_lock(&wss->reaccess_bins_lock);
+		wss_refresh(wss, memcg, NODE_DATA(nid));
+		for (bin = wss->reaccess_bins; bin->idle_age != -1; bin++)
+			seq_printf(m, "%u anon=%lu file=%lu\n",
+				   jiffies_to_msecs(bin->idle_age),
+				   bin->nr_pages[0], bin->nr_pages[1]);
+
+		seq_printf(m, "%lld anon=%lu file=%lu\n", LLONG_MAX,
+			   bin->nr_pages[0], bin->nr_pages[1]);
+
+		mutex_unlock(&wss->reaccess_bins_lock);
+	}
+
+	return 0;
+}
+#endif
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -6710,7 +7020,44 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
-	{ }	/* terminate */
+#ifdef CONFIG_WSS
+	{
+		.name = "wss.intervals_ms",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_wss_intervals_ms_show,
+		.write = memory_wss_intervals_ms_write,
+	},
+	{
+		.name = "wss.refresh_ms",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_wss_refresh_ms_show,
+		.write = memory_wss_refresh_ms_write,
+	},
+	{
+		.name = "wss.report_ms",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_wss_report_ms_show,
+		.write = memory_wss_report_ms_write,
+	},
+	{
+		.name = "wss.histogram",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_wss_histogram_show,
+		.poll = memory_wss_histogram_poll,
+	},
+	{
+		.name = "reaccess.intervals_ms",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_reaccess_intervals_ms_show,
+		.write = memory_reaccess_intervals_ms_write,
+	},
+	{
+		.name = "reaccess.histogram",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_reaccess_histogram_show,
+	},
+#endif
+	{} /* terminate */
 };
 
 struct cgroup_subsys memory_cgrp_subsys = {
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..6e70c44897cc 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -89,6 +89,8 @@ void lruvec_init(struct lruvec *lruvec)
 	 */
 	list_del(&lruvec->lists[LRU_UNEVICTABLE]);
 
+	wss_init(&lruvec->__wss);
+
 	lru_gen_init_lruvec(lruvec);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5b7b8d4f5297..b3adf924691c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -10,6 +10,7 @@
  *  Multiqueue VM started 5.8.00, Rik van Riel.
  */
 
+#include "linux/jiffies.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/mm.h>
@@ -55,6 +56,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/khugepaged.h>
+#include <linux/wss.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -4225,6 +4227,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 		mem_cgroup_unlock_pages();
 
 		if (walk->batched) {
+			report_reaccess(lruvec, walk);
 			spin_lock_irq(&lruvec->lru_lock);
 			reset_batch_size(lruvec, walk);
 			spin_unlock_irq(&lruvec->lru_lock);
@@ -4465,6 +4468,470 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	return true;
 }
 
+/******************************************************************************
+ *                          working set monitoring
+ ******************************************************************************/
+
+static void collect_wss(struct wss *wss, const struct lruvec *lruvec,
+			bool can_swap)
+{
+	int gen, type, zone;
+	const struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	unsigned long curr_timestamp = jiffies;
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	for (type = !can_swap; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+		// TODO update bins hierarchically
+		struct wss_bin *bin = wss->bins;
+
+		lockdep_assert_held(&wss->bins_lock);
+		for (seq = max_seq; seq + 1 > min_seq[type]; seq--) {
+			unsigned long birth, gen_start = curr_timestamp, error, size = 0;
+
+			gen = lru_gen_from_seq(seq);
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++)
+				size += max(
+					READ_ONCE(lrugen->nr_pages[gen][type]
+								  [zone]),
+					0L);
+
+			birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
+			if (seq != max_seq) {
+				int next_gen = lru_gen_from_seq(seq + 1);
+
+				gen_start = READ_ONCE(
+					lruvec->lrugen.timestamps[next_gen]);
+			}
+
+			error = size;
+			/* gen exceeds the idle_age of bin */
+			while (bin->idle_age != -1 &&
+			       time_before(birth + bin->idle_age,
+					   curr_timestamp)) {
+				unsigned long proportion =
+					gen_start -
+					(curr_timestamp - bin->idle_age);
+				unsigned long gen_len = gen_start - birth;
+
+				if (!gen_len)
+					break;
+				if (proportion) {
+					unsigned long split_bin =
+						size / gen_len *
+						proportion;
+					bin->nr_pages[type] += split_bin;
+					error -= split_bin;
+				}
+				gen_start = curr_timestamp - bin->idle_age;
+				bin++;
+
+			}
+			bin->nr_pages[type] += error;
+		}
+	}
+}
+
+static void refresh_wss(struct wss *wss, struct mem_cgroup *root,
+			struct pglist_data *pgdat, struct scan_control *sc,
+			unsigned long refresh_threshold)
+{
+	struct wss_bin *bin;
+	struct mem_cgroup *memcg;
+
+	lockdep_assert_held(&wss->bins_lock);
+	VM_WARN_ON_ONCE(wss->bins->idle_age == -1);
+
+	for (bin = wss->bins; bin->idle_age != -1; bin++) {
+		bin->nr_pages[0] = 0;
+		bin->nr_pages[1] = 0;
+	}
+	// the last used bin has idle_age == -1.
+	bin->nr_pages[0] = 0;
+	bin->nr_pages[1] = 0;
+
+	memcg = mem_cgroup_iter(root, NULL, NULL);
+	do {
+		struct lruvec *lruvec =
+			mem_cgroup_lruvec(memcg, pgdat);
+		bool can_swap = get_swappiness(lruvec, sc);
+		DEFINE_MAX_SEQ(lruvec);
+		DEFINE_MIN_SEQ(lruvec);
+
+		mem_cgroup_calculate_protection(root, memcg);
+		if (!mem_cgroup_below_min(root, memcg) && refresh_threshold &&
+		    min_seq[!can_swap] + MAX_NR_GENS - 1 > max_seq) {
+			int gen = lru_gen_from_seq(max_seq);
+			unsigned long birth =
+				READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+			if (time_is_before_jiffies(birth + refresh_threshold))
+				try_to_inc_max_seq(lruvec, max_seq, sc,
+						   can_swap, false);
+		}
+
+		collect_wss(wss, lruvec, can_swap);
+
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+}
+
+void report_wss(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	static DEFINE_RATELIMIT_STATE(rate, HZ, 3);
+
+	struct mem_cgroup *memcg = sc->target_mem_cgroup;
+	struct wss *wss = lruvec_wss(mem_cgroup_lruvec(memcg, pgdat));
+	unsigned long threshold;
+
+	threshold = READ_ONCE(wss->report_threshold);
+
+	if (sc->priority == DEF_PRIORITY)
+		return;
+
+	if (READ_ONCE(wss->bins->idle_age) == -1)
+		return;
+
+	if (!threshold || time_is_after_jiffies(wss->timestamp + threshold))
+		return;
+
+	if (!__ratelimit(&rate))
+		return;
+
+	if (!mutex_trylock(&wss->bins_lock))
+		return;
+
+	refresh_wss(wss, memcg, pgdat, sc, 0);
+	WRITE_ONCE(wss->timestamp, jiffies);
+
+	mutex_unlock(&wss->bins_lock);
+
+	if (wss->notifier)
+		kernfs_notify(wss->notifier);
+	if (memcg && cmpxchg(&memcg->wss_event, 0, 1) == 0)
+		wake_up_interruptible(&memcg->wss_wait_queue);
+}
+
+static void collect_reaccess_locked(struct wss *wss,
+				    struct lru_gen_struct *lrugen,
+				    struct lru_gen_mm_walk *walk)
+{
+	int gen, type, zone;
+	unsigned long curr_timestamp = jiffies;
+	unsigned long max_seq = READ_ONCE(walk->max_seq);
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lrugen->min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lrugen->min_seq[LRU_GEN_FILE]),
+	};
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+		struct wss_bin *bin = wss->reaccess_bins;
+
+		lockdep_assert_held(&wss->reaccess_bins_lock);
+		/* Skip max_seq because a reaccess moves a page from another seq
+		 * to max_seq. We use the negative change in page count from
+		 * other seqs to track the number of reaccesses.
+		 */
+		for (seq = max_seq - 1; seq + 1 > min_seq[type]; seq--) {
+			long error;
+			int next_gen;
+			unsigned long birth, gen_start;
+			long delta = 0;
+
+			gen = lru_gen_from_seq(seq);
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
+				long nr_pages = walk->nr_pages[gen][type][zone];
+
+				if (nr_pages < 0)
+					delta += -nr_pages;
+			}
+
+			birth = READ_ONCE(lrugen->timestamps[gen]);
+			next_gen = lru_gen_from_seq(seq + 1);
+			gen_start = READ_ONCE(lrugen->timestamps[next_gen]);
+
+			/* ensure gen_start is within idle_age of bin */
+			while (bin->idle_age != -1 &&
+			       time_before(gen_start + bin->idle_age,
+					  curr_timestamp))
+				bin++;
+
+			error = delta;
+			/* gen exceeds the idle_age of bin */
+			while (bin->idle_age != -1 &&
+			       time_before(birth + bin->idle_age,
+					   curr_timestamp)) {
+				unsigned long proportion =
+					gen_start -
+					(curr_timestamp - bin->idle_age);
+				unsigned long gen_len = gen_start - birth;
+
+				if (!gen_len)
+					break;
+				if (proportion) {
+					unsigned long split_bin =
+						delta / gen_len * proportion;
+					bin->nr_pages[type] += split_bin;
+					error -= split_bin;
+				}
+				gen_start = curr_timestamp - bin->idle_age;
+				bin++;
+			}
+			bin->nr_pages[type] += error;
+		}
+	}
+}
+
+static void collect_reaccess(struct wss *wss,
+				   struct lru_gen_struct *lrugen,
+				   struct lru_gen_mm_walk *walk)
+{
+	if (READ_ONCE(wss->reaccess_bins->idle_age) == -1)
+		return;
+
+	mutex_lock(&wss->reaccess_bins_lock);
+	collect_reaccess_locked(wss, lrugen, walk);
+	mutex_unlock(&wss->reaccess_bins_lock);
+}
+
+void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
+{
+	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	while (memcg) {
+		collect_reaccess(lruvec_wss(mem_cgroup_lruvec(
+					 memcg, lruvec_pgdat(lruvec))),
+				 lrugen, walk);
+		memcg = parent_mem_cgroup(memcg);
+	}
+}
+
+static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
+{
+	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
+					    first_memory_node;
+
+	return NODE_DATA(nid);
+}
+
+static struct wss *kobj_to_wss(struct kobject *kobj)
+{
+	return lruvec_wss(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
+}
+
+static ssize_t report_ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	struct wss *wss = kobj_to_wss(kobj);
+	unsigned long threshold = READ_ONCE(wss->report_threshold);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(threshold));
+}
+
+static ssize_t report_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+			       const char *buf, size_t len)
+{
+	unsigned int msecs;
+	struct wss *wss = kobj_to_wss(kobj);
+
+	if (kstrtouint(buf, 0, &msecs))
+		return -EINVAL;
+
+	WRITE_ONCE(wss->report_threshold, msecs_to_jiffies(msecs));
+
+	return len;
+}
+
+static struct kobj_attribute report_ms_attr = __ATTR_RW(report_ms);
+
+static ssize_t refresh_ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+			       char *buf)
+{
+	struct wss *wss = kobj_to_wss(kobj);
+	unsigned long threshold = READ_ONCE(wss->refresh_threshold);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(threshold));
+}
+
+static ssize_t refresh_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t len)
+{
+	unsigned int msecs;
+	struct wss *wss = kobj_to_wss(kobj);
+
+	if (kstrtouint(buf, 0, &msecs))
+		return -EINVAL;
+
+	WRITE_ONCE(wss->refresh_threshold, msecs_to_jiffies(msecs));
+
+	return len;
+}
+
+static struct kobj_attribute refresh_ms_attr = __ATTR_RW(refresh_ms);
+
+static ssize_t intervals_ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+				 char *buf)
+{
+	struct wss_bin *bin;
+	int len = 0;
+	struct wss *wss = kobj_to_wss(kobj);
+
+	mutex_lock(&wss->bins_lock);
+
+	for (bin = wss->bins; bin->idle_age != -1; bin++)
+		len += sysfs_emit_at(buf, len, "%u,", jiffies_to_msecs(bin->idle_age));
+
+	len += sysfs_emit_at(buf, len, "%lld\n", LLONG_MAX);
+
+	mutex_unlock(&wss->bins_lock);
+
+	return len;
+}
+
+static ssize_t intervals_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+				  const char *src, size_t len)
+{
+	char *buf;
+	struct wss_bin *bins;
+	int err = 0;
+	struct wss *wss = kobj_to_wss(kobj);
+
+	bins = kzalloc(sizeof(wss->bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	buf = kstrdup(src, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = wss_intervals_ms_parse(buf, bins);
+	if (err)
+		goto failed;
+
+	mutex_lock(&wss->bins_lock);
+	memcpy(wss->bins, bins, sizeof(wss->bins));
+	mutex_unlock(&wss->bins_lock);
+failed:
+	kfree(buf);
+	kfree(bins);
+
+	return err ?: len;
+}
+
+static struct kobj_attribute intervals_ms_attr = __ATTR_RW(intervals_ms);
+
+void wss_refresh(struct wss *wss, struct mem_cgroup *root,
+		 struct pglist_data *pgdat)
+{
+	unsigned int flags;
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+
+	lockdep_assert_held(&wss->bins_lock);
+
+	if (wss->bins->idle_age != -1) {
+		unsigned long timestamp = READ_ONCE(wss->timestamp);
+		unsigned long threshold = READ_ONCE(wss->refresh_threshold);
+
+		if (time_is_before_jiffies(timestamp + threshold)) {
+			set_task_reclaim_state(current, &sc.reclaim_state);
+			flags = memalloc_noreclaim_save();
+			refresh_wss(wss, root, pgdat, &sc, threshold);
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+		}
+	}
+}
+
+static ssize_t histogram_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	struct wss_bin *bin;
+	int len = 0;
+	struct wss *wss = kobj_to_wss(kobj);
+
+	mutex_lock(&wss->bins_lock);
+
+	wss_refresh(wss, NULL, kobj_to_pgdat(kobj));
+
+	for (bin = wss->bins; bin->idle_age != -1; bin++)
+		len += sysfs_emit_at(buf, len, "%u anon=%lu file=%lu\n",
+				     jiffies_to_msecs(bin->idle_age), bin->nr_pages[0],
+				     bin->nr_pages[1]);
+
+	len += sysfs_emit_at(buf, len, "%lld anon=%lu file=%lu\n", LLONG_MAX,
+			     bin->nr_pages[0], bin->nr_pages[1]);
+
+	mutex_unlock(&wss->bins_lock);
+
+	return len;
+}
+
+static struct kobj_attribute histogram_attr = __ATTR_RO(histogram);
+
+static struct attribute *wss_attrs[] = {
+	&report_ms_attr.attr,
+	&refresh_ms_attr.attr,
+	&intervals_ms_attr.attr,
+	&histogram_attr.attr,
+	NULL
+};
+
+static const struct attribute_group wss_attr_group = {
+	.name = "wss",
+	.attrs = wss_attrs,
+};
+
+void wss_register_node(struct node *node)
+{
+	struct kobject *kobj = node ? &node->dev.kobj : mm_kobj;
+	struct wss *wss;
+
+	if (IS_ENABLED(CONFIG_NUMA) && !node)
+		return;
+
+	wss = kobj_to_wss(kobj);
+
+	/* wss should be initialized when pgdat was initialized
+	 * or when the root memcg was initialized
+	 */
+	if (sysfs_create_group(kobj, &wss_attr_group)) {
+		pr_warn("WSS failed to created group");
+		return;
+	}
+
+	wss->notifier = kernfs_walk_and_get(kobj->sd, "wss/histogram");
+}
+
+void wss_unregister_node(struct node *node)
+{
+	struct kobject *kobj = &node->dev.kobj;
+	struct wss *wss;
+
+	if (IS_ENABLED(CONFIG_NUMA) && !node)
+		return;
+
+	wss = kobj_to_wss(kobj);
+	kernfs_put(wss->notifier);
+	sysfs_remove_group(kobj, &wss_attr_group);
+	wss_destroy(wss);
+}
+
+/*******************************************************************************/
+
+
 static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsigned long *min_seq,
 			     struct scan_control *sc, bool can_swap, unsigned long *nr_to_scan)
 {
@@ -4569,6 +5036,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
+	report_wss(pgdat, sc);
+
 	sc->last_reclaimed = sc->nr_reclaimed;
 
 	/*
@@ -5076,11 +5545,14 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		sc->nr_scanned -= folio_nr_pages(folio);
 	}
 
+	walk = current->reclaim_state->mm_walk;
+	if (walk && walk->batched)
+		report_reaccess(lruvec, walk);
+
 	spin_lock_irq(&lruvec->lru_lock);
 
 	move_folios_to_lru(lruvec, &list);
 
-	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched)
 		reset_batch_size(lruvec, walk);
 
@@ -5890,6 +6362,8 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
+	wss_register_node(NULL);
+
 	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
 	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
 
@@ -6411,6 +6885,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
+		if (!sc->proactive)
+			report_wss(zone->zone_pgdat, sc);
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
diff --git a/mm/wss.c b/mm/wss.c
new file mode 100644
index 000000000000..f7cbe59db079
--- /dev/null
+++ b/mm/wss.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/wss.h>
+#include <linux/mmzone.h>
+
+/* For now just embed wss in the lruvec.
+ * Consider only allocating struct wss when it's used
+ * since sizeof(struct wss) is ~864 bytes.
+ */
+struct wss *lruvec_wss(struct lruvec *lruvec)
+{
+	return &lruvec->__wss;
+}
+
+void wss_init(struct wss *wss)
+{
+	mutex_init(&wss->bins_lock);
+	mutex_init(&wss->reaccess_bins_lock);
+	wss->bins[0].idle_age = -1;
+	wss->notifier = NULL;
+	wss->reaccess_bins[0].idle_age = -1;
+}
+
+void wss_destroy(struct wss *wss)
+{
+	mutex_destroy(&wss->bins_lock);
+	mutex_destroy(&wss->reaccess_bins_lock);
+	memset(wss, 0, sizeof(*wss));
+}
+
+ssize_t wss_intervals_ms_parse(char *src, struct wss_bin *bins)
+{
+	int err, i = 0;
+	char *cur, *next = strim(src);
+
+	while ((cur = strsep(&next, ","))) {
+		unsigned int msecs;
+
+		err = kstrtouint(cur, 0, &msecs);
+		if (err)
+			return err;
+
+		bins[i].idle_age = msecs_to_jiffies(msecs);
+		if (i > 0 && bins[i].idle_age <= bins[i - 1].idle_age)
+			return -EINVAL;
+
+		if (++i == MAX_NR_BINS)
+			return -ERANGE;
+	}
+
+	if (i && i < MIN_NR_BINS - 1)
+		return -ERANGE;
+
+	bins[i].idle_age = -1;
+	return 0;
+}
-- 
2.40.1.521.gf1e218fcd8-goog

