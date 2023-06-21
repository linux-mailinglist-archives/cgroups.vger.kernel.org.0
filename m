Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1321738E5B
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjFUSRO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 14:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjFUSRI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 14:17:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526A198B
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b53e1cd390so27970855ad.0
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687371425; x=1689963425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OF0x5iXR2rtborFmFX3mVbCSq6NeXvlAh2BRuHag0JE=;
        b=1LbcOPviyE1RonFFFO2iRhIHUi81/c0so2hP4+VMcspAnZIkymOf0iYBytVRabaeUj
         ycl2o8rabRTKDi0TntoygE8hzAJWWLwNNKjQ3PIqTegl/qovifqQmm17729vy1wOcJAb
         ipMUT0w+5oN7kjrvtSucwhWwkXJW4ZIukhr9qhGT9SGdyrzYe24E8iKoGwtx45fxHbFO
         N7keCLJrpODVRUe3OL50ehki7wzAWuUgb2eF/Kmp6C/b1p8AHQIs5a3J9j6vb5mp36Vn
         GXUnR3XgqklGviIoRppCczDbFXuHcyV8jUVaZLT/luwa6Rb3AGJ7BeEn95ssG1HOFz5G
         4d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371425; x=1689963425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF0x5iXR2rtborFmFX3mVbCSq6NeXvlAh2BRuHag0JE=;
        b=TeYW1IVxpAnWRR+hddppU+Joqe5WbWqJbNgHeVoC83pcVfwR7Zm85ngAdXv6kSd5WK
         P7snV8AIDTTt1jIBLaJ+37QuHgDxX/b1D3sv8arigiDvXICFCqo8356gt9dI0UGl/EAc
         qdeFCZczfDM6Kj+7usRko8XafH5XRJlj31usuzTgh3tsWb/kfZDfr0dnycCi/Z0/vzIR
         lFZQorqPNV7qDkuqweR/IEzDRIPDvtsUazS7aDlbYxz1txumpjLoISsrjsUf3FHuIvef
         5jZrkSYW6fuWU2Ybmm1QWv1JSpYXaHuSgNUjfvnxSUHBkdk+x+bcQYUVWRYVBNtyUsbp
         NcTA==
X-Gm-Message-State: AC+VfDwBfu/UZ6IM+U4kTpOGV47cqM7HYMNqdWx/gKtrJ9zSYvRu3Iir
        pWkissvt9vFqwP4EcGymm4g4GnPdUEMe
X-Google-Smtp-Source: ACHHUZ4mpKZriHV7/8M4aeA4yBiuYHt8Y1dznOFrrbtQmh4+5VwjaWA8c6SnASriyzI2egHbvgkfoxR9rjRM
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4024])
 (user=yuanchu job=sendgmr) by 2002:a17:902:c215:b0:1b5:2b7b:1233 with SMTP id
 21-20020a170902c21500b001b52b7b1233mr2122074pll.12.1687371425190; Wed, 21 Jun
 2023 11:17:05 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:04:49 +0000
In-Reply-To: <20230621180454.973862-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20230621180454.973862-1-yuanchu@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621180454.973862-2-yuanchu@google.com>
Subject: [RFC PATCH v2 1/6] mm: aggregate working set information into histograms
From:   Yuanchu Xie <yuanchu@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kairui Song <kasong@tencent.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yuanchu Xie <yuanchu@google.com>,
        "T . J . Alumbaugh" <talumbau@google.com>
Cc:     Wei Xu <weixugc@google.com>, SeongJae Park <sj@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hierarchically aggregate all memcgs' MGLRU generations and their
page counts into working set histograms.
The histograms break down the system's working set per-node,
per-anon/file.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/base/node.c    |   3 +
 include/linux/mmzone.h |   4 +
 include/linux/wsr.h    |  73 +++++++++++
 mm/Kconfig             |   7 +
 mm/Makefile            |   1 +
 mm/internal.h          |   1 +
 mm/mmzone.c            |   3 +
 mm/vmscan.c            |   3 +
 mm/wsr.c               | 288 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 383 insertions(+)
 create mode 100644 include/linux/wsr.h
 create mode 100644 mm/wsr.c

diff --git a/drivers/base/node.c b/drivers/base/node.c
index faf3597a96da9..e326debe22d8f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
+#include <linux/wsr.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -616,6 +617,7 @@ static int register_node(struct node *node, int num)
 	} else {
 		hugetlb_register_node(node);
 		compaction_register_node(node);
+		wsr_register_node(node);
 	}
 
 	return error;
@@ -632,6 +634,7 @@ void unregister_node(struct node *node)
 {
 	hugetlb_unregister_node(node);
 	compaction_unregister_node(node);
+	wsr_unregister_node(node);
 	node_remove_accesses(node);
 	node_remove_caches(node);
 	device_unregister(&node->dev);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cd28a100d9e4f..96f0d8f3584e4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -21,6 +21,7 @@
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
 #include <linux/local_lock.h>
+#include <linux/wsr.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -527,7 +528,10 @@ struct lruvec {
 	struct lru_gen_struct		lrugen;
 	/* to concurrently iterate lru_gen_mm_list */
 	struct lru_gen_mm_state		mm_state;
+#ifdef CONFIG_WSR
+	struct wsr			__wsr;
 #endif
+#endif /* CONFIG_LRU_GEN */
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
diff --git a/include/linux/wsr.h b/include/linux/wsr.h
new file mode 100644
index 0000000000000..fa46b4d61177d
--- /dev/null
+++ b/include/linux/wsr.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WSR_H
+#define _LINUX_WSR_H
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
+#ifdef CONFIG_WSR
+#define ANON_AND_FILE 2
+
+#define MIN_NR_BINS 4
+#define MAX_NR_BINS 16
+
+struct ws_bin {
+	unsigned long idle_age;
+	unsigned long nr_pages[ANON_AND_FILE];
+};
+
+struct wsr {
+	/* protects bins */
+	struct mutex bins_lock;
+	struct ws_bin bins[MAX_NR_BINS];
+};
+
+void wsr_register_node(struct node *node);
+void wsr_unregister_node(struct node *node);
+
+void wsr_init(struct lruvec *lruvec);
+void wsr_destroy(struct lruvec *lruvec);
+struct wsr *lruvec_wsr(struct lruvec *lruvec);
+
+ssize_t wsr_intervals_ms_parse(char *src, struct ws_bin *bins);
+
+/*
+ * wsr->bins needs to be locked
+ */
+void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
+		 struct pglist_data *pgdat);
+#else
+struct ws_bin;
+struct wsr;
+
+static inline void wsr_register_node(struct node *node)
+{
+}
+static inline void wsr_unregister_node(struct node *node)
+{
+}
+static inline void wsr_init(struct lruvec *lruvec)
+{
+}
+static inline void wsr_destroy(struct lruvec *lruvec)
+{
+}
+/* lruvec_wsr is intentially omitted */
+static inline ssize_t wsr_intervals_ms_parse(char *src, struct ws_bin *bins)
+{
+	return -EINVAL;
+}
+static inline void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
+		 struct pglist_data *pgdat)
+{
+}
+#endif	/* CONFIG_WSR */
+
+#endif	/* _LINUX_WSR_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec055..8a84c1402159a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,13 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config WSR
+	bool "Working set reporting"
+	depends on LRU_GEN
+	help
+	  This option enables working set reporting, separate backends
+	  WIP. Currently only supports MGLRU.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e293..12e2da5ba2d04 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
+obj-$(CONFIG_WSR) += wsr.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032de..88dba0b11f663 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -180,6 +180,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 /*
  * in mm/vmscan.c:
  */
+struct scan_control;
 int isolate_lru_page(struct page *page);
 int folio_isolate_lru(struct folio *folio);
 void putback_lru_page(struct page *page);
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12de..22a8282f67150 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -8,6 +8,7 @@
 
 #include <linux/stddef.h>
 #include <linux/mm.h>
+#include <linux/wsr.h>
 #include <linux/mmzone.h>
 
 struct pglist_data *first_online_pgdat(void)
@@ -89,6 +90,8 @@ void lruvec_init(struct lruvec *lruvec)
 	 */
 	list_del(&lruvec->lists[LRU_UNEVICTABLE]);
 
+	wsr_init(lruvec);
+
 	lru_gen_init_lruvec(lruvec);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5b7b8d4f5297f..150e3cd70c65e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -55,6 +55,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/khugepaged.h>
+#include <linux/wsr.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -5890,6 +5891,8 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
+	wsr_register_node(NULL);
+
 	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
 	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
 
diff --git a/mm/wsr.c b/mm/wsr.c
new file mode 100644
index 0000000000000..1e4c0ce69caf7
--- /dev/null
+++ b/mm/wsr.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+#include <linux/wsr.h>
+
+#include <linux/node.h>
+#include <linux/mmzone.h>
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+
+#include "internal.h"
+
+/* For now just embed wsr in the lruvec.
+ * Consider only allocating struct wsr when it's used
+ * since sizeof(struct wsr) is ~864 bytes.
+ */
+struct wsr *lruvec_wsr(struct lruvec *lruvec)
+{
+	return &lruvec->__wsr;
+}
+
+void wsr_init(struct lruvec *lruvec)
+{
+	struct wsr *wsr = lruvec_wsr(lruvec);
+
+	mutex_init(&wsr->bins_lock);
+	wsr->bins[0].idle_age = -1;
+}
+
+void wsr_destroy(struct lruvec *lruvec)
+{
+	struct wsr *wsr = lruvec_wsr(lruvec);
+
+	mutex_destroy(&wsr->bins_lock);
+	memset(wsr, 0, sizeof(*wsr));
+}
+
+ssize_t wsr_intervals_ms_parse(char *src, struct ws_bin *bins)
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
+
+static void collect_wsr(struct wsr *wsr, const struct lruvec *lruvec)
+{
+	int gen, type, zone;
+	const struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	unsigned long curr_timestamp = jiffies;
+	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lruvec->lrugen.min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lruvec->lrugen.min_seq[LRU_GEN_FILE]),
+	};
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+		// TODO update bins hierarchically
+		struct ws_bin *bin = wsr->bins;
+
+		lockdep_assert_held(&wsr->bins_lock);
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
+static void refresh_wsr(struct wsr *wsr, struct mem_cgroup *root,
+			struct pglist_data *pgdat)
+{
+	struct ws_bin *bin;
+	struct mem_cgroup *memcg;
+
+	lockdep_assert_held(&wsr->bins_lock);
+	VM_WARN_ON_ONCE(wsr->bins->idle_age == -1);
+
+	for (bin = wsr->bins; bin->idle_age != -1; bin++) {
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
+
+		collect_wsr(wsr, lruvec);
+
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+}
+static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
+{
+	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
+					    first_memory_node;
+
+	return NODE_DATA(nid);
+}
+
+static struct wsr *kobj_to_wsr(struct kobject *kobj)
+{
+	return lruvec_wsr(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
+}
+
+static ssize_t intervals_ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+				 char *buf)
+{
+	struct ws_bin *bin;
+	int len = 0;
+	struct wsr *wsr = kobj_to_wsr(kobj);
+
+	mutex_lock(&wsr->bins_lock);
+
+	for (bin = wsr->bins; bin->idle_age != -1; bin++)
+		len += sysfs_emit_at(buf, len, "%u,", jiffies_to_msecs(bin->idle_age));
+
+	len += sysfs_emit_at(buf, len, "%lld\n", LLONG_MAX);
+
+	mutex_unlock(&wsr->bins_lock);
+
+	return len;
+}
+
+static ssize_t intervals_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+				  const char *src, size_t len)
+{
+	char *buf;
+	struct ws_bin *bins;
+	int err = 0;
+	struct wsr *wsr = kobj_to_wsr(kobj);
+
+	bins = kzalloc(sizeof(wsr->bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	buf = kstrdup(src, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = wsr_intervals_ms_parse(buf, bins);
+	if (err)
+		goto failed;
+
+	mutex_lock(&wsr->bins_lock);
+	memcpy(wsr->bins, bins, sizeof(wsr->bins));
+	mutex_unlock(&wsr->bins_lock);
+failed:
+	kfree(buf);
+	kfree(bins);
+
+	return err ?: len;
+}
+
+static struct kobj_attribute intervals_ms_attr = __ATTR_RW(intervals_ms);
+
+static ssize_t histogram_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	struct ws_bin *bin;
+	int len = 0;
+	struct wsr *wsr = kobj_to_wsr(kobj);
+
+	mutex_lock(&wsr->bins_lock);
+
+	refresh_wsr(wsr, NULL, kobj_to_pgdat(kobj));
+
+	for (bin = wsr->bins; bin->idle_age != -1; bin++)
+		len += sysfs_emit_at(buf, len, "%u anon=%lu file=%lu\n",
+				     jiffies_to_msecs(bin->idle_age), bin->nr_pages[0],
+				     bin->nr_pages[1]);
+
+	len += sysfs_emit_at(buf, len, "%lld anon=%lu file=%lu\n", LLONG_MAX,
+			     bin->nr_pages[0], bin->nr_pages[1]);
+
+	mutex_unlock(&wsr->bins_lock);
+
+	return len;
+}
+
+static struct kobj_attribute histogram_attr = __ATTR_RO(histogram);
+
+static struct attribute *wsr_attrs[] = {
+	&intervals_ms_attr.attr,
+	&histogram_attr.attr,
+	NULL
+};
+
+static const struct attribute_group wsr_attr_group = {
+	.name = "wsr",
+	.attrs = wsr_attrs,
+};
+
+void wsr_register_node(struct node *node)
+{
+	struct kobject *kobj = node ? &node->dev.kobj : mm_kobj;
+	struct wsr *wsr;
+
+	if (IS_ENABLED(CONFIG_NUMA) && !node)
+		return;
+
+	wsr = kobj_to_wsr(kobj);
+
+	/* wsr should be initialized when pgdat was initialized
+	 * or when the root memcg was initialized
+	 */
+	if (sysfs_create_group(kobj, &wsr_attr_group)) {
+		pr_warn("WSR failed to created group");
+		return;
+	}
+}
+
+void wsr_unregister_node(struct node *node)
+{
+	struct kobject *kobj = &node->dev.kobj;
+	struct wsr *wsr;
+
+	if (IS_ENABLED(CONFIG_NUMA) && !node)
+		return;
+
+	wsr = kobj_to_wsr(kobj);
+	sysfs_remove_group(kobj, &wsr_attr_group);
+	wsr_destroy(mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj)));
+}
-- 
2.41.0.162.gfafddb0af9-goog

