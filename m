Return-Path: <cgroups+bounces-5326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E349B5DF2
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3824228462B
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47C1E1312;
	Wed, 30 Oct 2024 08:33:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3451E0B67;
	Wed, 30 Oct 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277226; cv=none; b=U7XUUSUtd3RsJAn8IGTmCmMZAgVBYV3Tgzs5xFlU1fjDd0B64poHM8cplsBpD2In1e09jgx7Jvr+CmJhG61VVBKoxqzsrA1vk+TB4ulN8aW3f2rpsWPHlKvOXfdBKkplwCuvDcLktcfl5i/oVWNU63pOe6byPGbRHtCOozw2WQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277226; c=relaxed/simple;
	bh=a9JRVxGCUBas3AV4K19cNFO6TL9a3VpgMsm74fpcCgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vha3QPzmjLc4Joefss2HJnNjpa5pamu34mDw+/w4rmOVPYSoRpbiL7ctb7LKX1YbF2zgKGpC3fqIxn0sSgONd49xG+5vHSs4c18xZLZ4QDAB+0TEHZy7OFZsBc+aQl2M7LRhgprbSOZ3q0GinOpXQyxoqVSSkP7CBej01j/5DKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdgJL0NLLz6GFtv;
	Wed, 30 Oct 2024 16:28:50 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D731A140AA7;
	Wed, 30 Oct 2024 16:33:40 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 11:33:40 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stepanov.anatoly@huawei.com>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>
Subject: [RFC PATCH 1/3] mm: Add thp_flags control for cgroup
Date: Wed, 30 Oct 2024 16:33:09 +0800
Message-ID: <20241030083311.965933-2-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Exposed a new file in memory cgroup called memory.thp_enabled. This file works
in the same way and same format as thp settings in
/sys/kernel/mm/transparent_hugepage/enabled. The patch allows to read from and
write to that file, changing effectively the memory cgroup THP policy. New
cgroups will inherit the THP policies from their parents.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Reviewed-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>

---
 include/linux/huge_mm.h    |  5 +++
 include/linux/memcontrol.h | 15 +++++++
 mm/huge_memory.c           | 71 ++++++++++++++++++++-----------
 mm/memcontrol.c            | 86 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 24 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..86c0fb4c0b28 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -53,6 +53,9 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
 };
 
+#define HUGEPAGE_FLAGS_ENABLED_MASK ((1UL << TRANSPARENT_HUGEPAGE_FLAG) |\
+				(1UL << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
+
 struct kobject;
 struct kobj_attribute;
 
@@ -430,6 +433,8 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 			   pmd_t *pmdp, struct folio *folio);
 
+int thp_enabled_parse(const char *buf, unsigned long *flags);
+const char *thp_enabled_string(unsigned long flags);
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e5bf25d324f..87b5fe93e19d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -315,6 +315,12 @@ struct mem_cgroup {
 	spinlock_t event_list_lock;
 #endif /* CONFIG_MEMCG_V1 */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	unsigned long thp_flags;
+	unsigned long thp_anon_orders_always;
+	unsigned long thp_anon_orders_madvise;
+	unsigned long thp_anon_orders_inherit;
+#endif
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -1615,6 +1621,15 @@ struct sock;
 bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 			     gfp_t gfp_mask);
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+int memory_thp_enabled_show(struct seq_file *m, void *v);
+ssize_t memory_thp_enabled_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off);
+
+int mem_cgroup_thp_flags_update_all(unsigned long flags, unsigned long mask);
+unsigned long memcg_get_thp_flags_all(unsigned long mask);
+unsigned long memcg_get_thp_flags(struct vm_area_struct *vma);
+#endif
 #ifdef CONFIG_MEMCG
 extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 67c86a5d64a6..0fbdd8213443 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -46,6 +46,8 @@
 #include "internal.h"
 #include "swap.h"
 
+#include <linux/memcontrol.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
 
@@ -287,21 +289,43 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 
 static struct shrinker *huge_zero_page_shrinker;
 
-#ifdef CONFIG_SYSFS
-static ssize_t enabled_show(struct kobject *kobj,
-			    struct kobj_attribute *attr, char *buf)
+const char *thp_enabled_string(unsigned long flags)
 {
 	const char *output;
 
-	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
+	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &flags))
 		output = "[always] madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
-			  &transparent_hugepage_flags))
+	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &flags))
 		output = "always [madvise] never";
 	else
 		output = "always madvise [never]";
 
-	return sysfs_emit(buf, "%s\n", output);
+	return output;
+}
+
+int thp_enabled_parse(const char *buf, unsigned long *flags)
+{
+	if (sysfs_streq(buf, "always")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flags);
+		set_bit(TRANSPARENT_HUGEPAGE_FLAG, flags);
+	} else if (sysfs_streq(buf, "madvise")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, flags);
+		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flags);
+	} else if (sysfs_streq(buf, "never")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flags);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+#ifdef CONFIG_SYSFS
+static ssize_t enabled_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	unsigned long flags = transparent_hugepage_flags;
+	return sysfs_emit(buf, "%s\n", thp_enabled_string(flags));
 }
 
 static ssize_t enabled_store(struct kobject *kobj,
@@ -309,24 +333,21 @@ static ssize_t enabled_store(struct kobject *kobj,
 			     const char *buf, size_t count)
 {
 	ssize_t ret = count;
+	int err;
 
-	if (sysfs_streq(buf, "always")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
-		set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
-	} else if (sysfs_streq(buf, "madvise")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
-		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (sysfs_streq(buf, "never")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else
-		ret = -EINVAL;
+	ret = thp_enabled_parse(buf, &transparent_hugepage_flags) ? : count;
+	if (ret <= 0)
+		goto out;
 
-	if (ret > 0) {
-		int err = start_stop_khugepaged();
-		if (err)
-			ret = err;
-	}
+	if (IS_ENABLED(CONFIG_MEMCG) && !mem_cgroup_disabled())
+		err = mem_cgroup_thp_flags_update_all(transparent_hugepage_flags,
+							HUGEPAGE_FLAGS_ENABLED_MASK);
+	else
+		err = start_stop_khugepaged();
+
+	if (err)
+		ret = err;
+out:
 	return ret;
 }
 
@@ -1036,7 +1057,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
 {
 	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
-
+#ifdef CONFIG_MEMCG
+	unsigned long transparent_hugepage_flags = memcg_get_thp_flags(vma);
+#endif
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
 		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d563fb515766..2b25c45c85c3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -970,6 +970,33 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
 	return memcg;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline bool memcg_thp_always_enabled(struct mem_cgroup *memcg)
+{
+	return test_bit(TRANSPARENT_HUGEPAGE_FLAG, &memcg->thp_flags);
+}
+
+static inline bool memcg_thp_madvise_enabled(struct mem_cgroup *memcg)
+{
+	return test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &memcg->thp_flags);
+}
+
+unsigned long memcg_get_thp_flags(struct vm_area_struct *vma)
+{
+	unsigned long flags = 0UL;
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+
+	if (!memcg)
+		goto out;
+
+	flags = READ_ONCE(memcg->thp_flags);
+out:
+	if (memcg)
+		css_put(&memcg->css);
+	return flags;
+}
+#endif
+
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -3625,6 +3652,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		WRITE_ONCE(memcg->thp_flags, READ_ONCE(parent->thp_flags));
+		WRITE_ONCE(memcg->thp_anon_orders_inherit,
+			READ_ONCE(parent->thp_anon_orders_inherit));
 #endif
 	} else {
 		init_memcg_stats();
@@ -3634,6 +3666,17 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 #ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, NULL);
 		page_counter_init(&memcg->tcpmem, NULL);
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		WRITE_ONCE(memcg->thp_flags,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS
+		(1<<TRANSPARENT_HUGEPAGE_FLAG)|
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
+		(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
+#endif
+		(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG));
+		WRITE_ONCE(memcg->thp_anon_orders_inherit, BIT(PMD_ORDER));
 #endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
@@ -4315,6 +4358,19 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+DEFINE_MUTEX(memcg_thp_flags_mutex);
+
+int memory_thp_enabled_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	unsigned long flags = READ_ONCE(memcg->thp_flags);
+
+	seq_printf(m, "%s\n", thp_enabled_string(flags));
+	return 0;
+}
+#endif
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4383,6 +4439,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	{
+		.name = "thp_enabled",
+		.seq_show = memory_thp_enabled_show,
+	},
+#endif
 	{ }	/* terminate */
 };
 
@@ -4844,6 +4906,30 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 	refill_stock(memcg, nr_pages);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+int mem_cgroup_thp_flags_update_all(unsigned long new_flags, unsigned long mask)
+{
+	int ret = 0;
+	struct mem_cgroup *iter, *memcg = root_mem_cgroup;
+	unsigned long enabled_mask =
+		(1UL << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG) |
+		(1UL << TRANSPARENT_HUGEPAGE_FLAG);
+
+	mutex_lock(&memcg_thp_flags_mutex);
+	enabled_mask &= new_flags;
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		unsigned long old_flags = iter->thp_flags;
+
+		iter->thp_flags = (old_flags & ~mask) | new_flags;
+	}
+
+	mutex_unlock(&memcg_thp_flags_mutex);
+	return ret;
+}
+
+#endif
+
 static int __init cgroup_memory(char *s)
 {
 	char *token;
-- 
2.34.1


