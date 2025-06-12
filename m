Return-Path: <cgroups+bounces-8501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF9AD6E69
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 12:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F07B1887AA0
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2FB23C511;
	Thu, 12 Jun 2025 10:53:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C430239E97
	for <cgroups@vger.kernel.org>; Thu, 12 Jun 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725615; cv=none; b=bsynZ7enFYytREPa00wckitSMKZZFawUOaDL9Iq/LVKXub1TYwslcyBqnYW741ggSRTLUVPnyR4+955fjOAFj9LScSbqsCgaDuV7RuS16ChipJDHWPIqfdgI73Ytfx1r4c+pNmUFKGKlGJubm8Y0N+IjrewwivOCF24r4FP8/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725615; c=relaxed/simple;
	bh=+whqsb51WlU/JCoJ2tY2+hnQPGDZ0RxBZxYca/d7G3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCkJ8ka5VE1cZk0LIcKD2aCaZQReiary3NSkRx3WDlA8JFhX7Pbd78H7XTTn0+Te0hnjZ2VS5qDeyKxKVzA6wsxdo8mbRy/LecESEKQFhFnp8lnVe2Mp1m3M315NOrye2I7HituuKHY320lT9Tb+rzDTMGbL4o18N3wbt9zPS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 12 Jun 2025 19:38:31 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: youngjun.park@lge.com
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com,
	gunho.lee@lge.com,
	"youngjun.park" <youngjun.park@lge.com>
Subject: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for per cgroup swap priority control
Date: Thu, 12 Jun 2025 19:37:43 +0900
Message-Id: <20250612103743.3385842-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612103743.3385842-1-youngjun.park@lge.com>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "youngjun.park" <youngjun.park@lge.com>

We are working in a constrained environment where devices often
operate under limited resources. To improve overall system responsiveness,
especially under memory pressure, we aim to utilize idle devices as swap
targets over the network.

In this context, we propose a mechanism to control swap priorities on a
per-cgroup basis.
By assigning different swap priorities to each cgroup, we can ensure that
ciritical applications maintain higher responsiveness and stability,
while less important workloads experience deferred swap activity.

The following is detailed explanation of the implementation.

1. Object Description

- swap_cgroup_priority
This object manages an array of swap_cgroup_priority_pnode
that points to swap devices and their associated priorities.

- swap_cgroup_priority_pnode
This object points to a swap device and contains priority information
that can be allocated through an interface.

2. Object Lifecycle

- The swap_cgroup_priority and swap_cgroup_priority_pnode share the same
lifetime.

- Object is dealt with memory.swap.priority interface.
Each swap device is assigned a unique ID at swapon time,
which can be queried via the memory.swap.priority interface.

Example:
cat memory.swap.priority
Inactive
/dev/sdb	unique:1	 prio:10
/dev/sdc	unique:2	 prio:5

- Creation
echo  "unique id of swapdev 1: priority, unique id of swapdev 2: priority ..."
> memory.swap.priority

- Destruction
Reset through the memory.swap.priority interface.
Example: echo "" > memory.swap.priority

And also be destroyed when the mem_cgroup is removed.

3. Priority Mechanism

- Follows the original concept of swap priority.
(This includes automatic binding of swap devices to NUMA nodes.)

- Swap On/Off Propagation
When swapon is executed, the settings are propagated.
Also when swapoff is executed, the settings are removed.

The implementation of swap on/off propagation and the mechanism
for iterating through the configured swap cgroup priorities
are available in the next patch.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
Suggested-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h |   3 +
 include/linux/swap.h       |   3 +
 mm/Kconfig                 |   7 ++
 mm/memcontrol.c            |  55 ++++++++++
 mm/swap.h                  |  10 ++
 mm/swap_cgroup_priority.c  | 202 +++++++++++++++++++++++++++++++++++++
 mm/swapfile.c              |   6 ++
 7 files changed, 286 insertions(+)
 create mode 100644 mm/swap_cgroup_priority.c

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a..625e59f9ecd2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -218,6 +218,9 @@ struct mem_cgroup {
 	bool zswap_writeback;
 #endif
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	struct swap_cgroup_priority *swap_priority;
+#endif
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bc0e1c275fc0..49b73911c1bd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,6 +339,9 @@ struct swap_info_struct {
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	int unique_id;
+#endif
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
 					   * entry per node.
diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..ff4b0ef867f4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -190,6 +190,13 @@ config ZSMALLOC_CHAIN_SIZE
 
 	  For more information, see zsmalloc documentation.
 
+config SWAP_CGROUP_PRIORITY
+	bool "Use swap cgroup priority"
+	default false
+	depends on SWAP && CGROUPS
+	help
+	  This option sets per cgroup swap device priority.
+
 menu "Slab allocator options"
 
 config SLUB
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 902da8a9c643..628ffb048489 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -69,6 +69,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "swap.h"
 
 #include <linux/uaccess.h>
 
@@ -3702,6 +3703,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
+	delete_swap_cgroup_priority(memcg);
 	__mem_cgroup_free(memcg);
 }
 
@@ -5403,6 +5405,51 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+static ssize_t swap_cgroup_priority_write(struct kernfs_open_file *of,
+			      char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret;
+	int unique[MAX_SWAPFILES] = {0, };
+	int prios[MAX_SWAPFILES] = {0,};
+	int idx = 0;
+	char *token;
+
+	buf = strstrip(buf);
+	if (strlen(buf) == 0) {
+		delete_swap_cgroup_priority(memcg);
+		return nbytes;
+	}
+
+	while ((token = strsep(&buf, ",")) != NULL) {
+		char *token2 = token;
+		char *token3;
+
+		token3 = strsep(&token2, ":");
+		if (!token2 || !token3)
+			return -EINVAL;
+
+		if (kstrtoint(token3, 10, &unique[idx]) ||
+			kstrtoint(token2, 10, &prios[idx]))
+			return -EINVAL;
+
+		idx++;
+	}
+
+	if ((ret = create_swap_cgroup_priority(memcg, unique, prios, idx)))
+		return ret;
+
+	return nbytes;
+}
+
+static int swap_cgroup_priority_show(struct seq_file *m, void *v)
+{
+	show_swap_device_unique_id(m);
+	return 0;
+}
+#endif
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5435,6 +5482,14 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	{
+		.name = "swap.priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_cgroup_priority_show,
+		.write = swap_cgroup_priority_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/swap.h b/mm/swap.h
index 2269eb9df0af..cd2649c632ed 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -106,6 +106,16 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 		return find_next_bit(sis->zeromap, end, start) - start;
 }
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+int create_swap_cgroup_priority(struct mem_cgroup *memcg,
+				int unique[], int prio[], int nr);
+void delete_swap_cgroup_priority(struct mem_cgroup *memcg);
+void show_swap_device_unique_id(struct seq_file *m);
+#else
+static inline void delete_swap_cgroup_priority(struct mem_cgroup *memcg) {}
+static inline void get_swap_unique_id(struct swap_info_struct *si) {}
+#endif
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
new file mode 100644
index 000000000000..b3e20b676680
--- /dev/null
+++ b/mm/swap_cgroup_priority.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* per mem_cgroup */
+struct swap_cgroup_priority {
+	struct list_head link;
+	/* XXX: to flatten memory is hard. variable array is our enemy */
+	struct swap_cgroup_priority_pnode *pnode[MAX_SWAPFILES];
+	struct plist_head plist[];
+};
+
+/* per mem_cgroup & per swap device node */
+struct swap_cgroup_priority_pnode {
+	struct swap_info_struct *swap;
+	int prio;
+	struct plist_node avail_lists[];
+};
+
+/* per swap device unique id counter */
+static atomic_t swap_unique_id_counter;
+
+/* active swap_cgroup_priority list */
+static LIST_HEAD(swap_cgroup_priority_list);
+
+/* XXX: Not want memcontrol to know swap_cgroup_priority internal. */
+void show_swap_device_unique_id(struct seq_file *m)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	spin_lock(&swap_lock);
+	/* XXX: what is beautiful visibility? */
+	seq_printf(m, "%s\n", memcg->swap_priority ? "Active" : "Inactive");
+	for (int i = 0; i < nr_swapfiles; i++) {
+		struct swap_info_struct *si = swap_info[i];
+
+		if (!(si->flags & SWP_USED))
+			continue;
+
+		seq_file_path(m, si->swap_file, "\t\n\\");
+		seq_printf(m,  "\tunique:%d\t", si->unique_id);
+
+		if (!memcg->swap_priority) {
+			seq_printf(m, " prio:%d\n", si->prio);
+			continue;
+		}
+
+		seq_printf(m,  "prio:%d\n",
+			memcg->swap_priority->pnode[i]->prio);
+	}
+	spin_unlock(&swap_lock);
+}
+
+static void get_swap_unique_id(struct swap_info_struct *si)
+{
+	si->unique_id = atomic_add_return(1, &swap_unique_id_counter);
+}
+
+int create_swap_cgroup_priority(struct mem_cgroup *memcg,
+		int unique[], int prio[], int nr)
+{
+	bool b_found = false;
+	struct swap_cgroup_priority *swap_priority, *old_swap_priority = NULL;
+	int nid;
+
+	/* Fast check */
+	if (nr != nr_swapfiles)
+		return -EINVAL;
+
+	/*
+	* XXX: always make newly object and exchange it.
+	* possible to give object reusability if it is simple and better.
+	*/
+	swap_priority = kvmalloc(struct_size(swap_priority, plist, nr_node_ids),
+			GFP_KERNEL);
+
+	if (!swap_priority)
+		return -ENOMEM;
+
+	/* XXX: use pre allocate. think swapon time allocate is better? */
+	for (int i = 0; i < MAX_SWAPFILES; i++) {
+		swap_priority->pnode[i] =
+			kvmalloc(struct_size(swap_priority->pnode[0],
+				avail_lists, nr_node_ids),
+				GFP_KERNEL);
+
+		if (!swap_priority->pnode[i]) {
+			for (int j = 0; j < i; j++)
+				kvfree(swap_priority->pnode[i]);
+
+			kvfree(swap_priority);
+			return -ENOMEM;
+		}
+	}
+
+	INIT_LIST_HEAD(&swap_priority->link);
+	for_each_node(nid)
+		plist_head_init(&swap_priority->plist[nid]);
+
+	spin_lock(&swap_lock);
+	spin_lock(&swap_avail_lock);
+
+	/* swap on/off under us. */
+	if (nr != nr_swapfiles)
+		goto error;
+
+	/* TODO: naive search. make it fast.*/
+	for (int i = 0; i < nr; i++) {
+		b_found = false;
+		for (int j = 0; j < nr_swapfiles; j++) {
+			struct swap_info_struct *si = swap_info[j];
+			struct swap_cgroup_priority_pnode *pnode
+					= swap_priority->pnode[j];
+
+			if (si->unique_id != unique[i])
+				continue;
+
+			/* swap off under us */
+			if (!(si->flags & SWP_USED))
+				goto error;
+
+			int k;
+			for_each_node(k) {
+				if (prio[i] >= 0) {
+					pnode->prio = prio[i];
+					plist_node_init(&pnode->avail_lists[k],
+						-pnode->prio);
+				} else {
+					pnode->prio = si->prio;
+					if (swap_node(si) == k)
+						plist_node_init(
+							&pnode->avail_lists[k],
+							1);
+					else
+						plist_node_init(
+							&pnode->avail_lists[k],
+							-pnode->prio);
+				}
+
+				plist_add(&pnode->avail_lists[k],
+					&swap_priority->plist[k]);
+			}
+
+			pnode->swap = si;
+			b_found = true;
+			break;
+		}
+
+		/* cannot find unique id pair */
+		if (!b_found)
+			goto error;
+	}
+
+	if (memcg->swap_priority) {
+		old_swap_priority = memcg->swap_priority;
+		list_del(&old_swap_priority->link);
+	}
+
+	list_add(&swap_priority->link, &swap_cgroup_priority_list);
+
+	memcg->swap_priority = swap_priority;
+	spin_unlock(&swap_avail_lock);
+	spin_unlock(&swap_lock);
+
+	if (old_swap_priority) {
+		for (int i = 0; i < MAX_SWAPFILES; i++)
+			kvfree(old_swap_priority->pnode[i]);
+		kvfree(old_swap_priority);
+	}
+
+	return 0;
+
+error:
+	spin_unlock(&swap_avail_lock);
+	spin_unlock(&swap_lock);
+
+	for (int i = 0; i < MAX_SWAPFILES; i++)
+		kvfree(swap_priority->pnode[i]);
+	kvfree(swap_priority);
+
+	return -EINVAL;
+}
+
+void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
+{
+	struct swap_cgroup_priority *swap_priority;
+
+	spin_lock(&swap_avail_lock);
+	swap_priority = memcg->swap_priority;
+	if (!swap_priority) {
+		spin_unlock(&swap_avail_lock);
+		return;
+	}
+	memcg->swap_priority = NULL;
+	list_del(&swap_priority->link);
+	spin_unlock(&swap_avail_lock);
+
+	/* wait show_swap_device_unique_id */
+	synchronize_rcu();
+
+	for (int i = 0; i < MAX_SWAPFILES; i++)
+		kvfree(swap_priority->pnode[i]);
+	kvfree(swap_priority);
+}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 68ce283e84be..f8e48dd2381e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -126,6 +126,10 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.offset = { SWAP_ENTRY_INVALID },
 	.lock = INIT_LOCAL_LOCK(),
 };
+/* TODO: better choice? */
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+#include "swap_cgroup_priority.c"
+#endif
 
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
@@ -3462,6 +3466,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto free_swap_zswap;
 	}
 
+	get_swap_unique_id(si);
+
 	mutex_lock(&swapon_mutex);
 	prio = -1;
 	if (swap_flags & SWAP_FLAG_PREFER)
-- 
2.34.1


