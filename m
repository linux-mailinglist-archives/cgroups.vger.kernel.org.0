Return-Path: <cgroups+bounces-5327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7939B5DF5
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 09:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B5A1C214AF
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678501E1C0F;
	Wed, 30 Oct 2024 08:33:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FC1E0E0B;
	Wed, 30 Oct 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277227; cv=none; b=NRRvNmQzIDXb7iS7CMnVNKnrWX9ljWcmnnYZw3S2W9LhuqA0a+MTanIdStlncBwK8v3dK1n1792AyBgYWcniD3rPJRXodnyyuzsi+LqqjzFOGlda2V8ZAbNq1pI7MB//JVClvlU2iHadm0hH3nljcEM+9xXTPsNE94Tc3lUid3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277227; c=relaxed/simple;
	bh=P+Fy4mbrUnx5m73aSP5REkcuhFBJjsHIiadHOOPubCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5PdwVSQxajQPgsRDyiJfwaMNHt9TWqtKEUMJeMf6oO3lLA1QaUPmw5Z6Pa7DpZMWfF1R8WHuSvhrBX0n41G+2b0Sa4Cmts/ohilwSMHCXJs1dpveRxKzu+k6Tky4Sa6acARwK38u7S/pPUq+qTOxUVfoAXyF79+F5sPwDwBTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdgJL2H7Pz6GFtq;
	Wed, 30 Oct 2024 16:28:50 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FB3A140CB9;
	Wed, 30 Oct 2024 16:33:41 +0800 (CST)
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
Subject: [RFC PATCH 3/3] mm: Add thp_defrag control for cgroup
Date: Wed, 30 Oct 2024 16:33:11 +0800
Message-ID: <20241030083311.965933-4-gutierrez.asier@huawei-partners.com>
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

This patch exposes a new file in memory cgroups: memory.thp_defrag, which
follows the /sys/kernel/mm/transparent_hugepage/defrag style. Support for
different defrag THP defrag policies for memory cgroups were also added.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Reviewed-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>

---
 include/linux/huge_mm.h    |   8 +++
 include/linux/memcontrol.h |   4 +-
 mm/huge_memory.c           | 116 ++++++++++++++++++++++---------------
 mm/memcontrol.c            |  31 ++++++++++
 4 files changed, 112 insertions(+), 47 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f99ac9b7e5bc..177c7d3578ed 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -56,6 +56,12 @@ enum transparent_hugepage_flag {
 #define HUGEPAGE_FLAGS_ENABLED_MASK ((1UL << TRANSPARENT_HUGEPAGE_FLAG) |\
 				(1UL << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
 
+#define HUGEPAGE_FLAGS_DEFRAG_MASK ((1UL << TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG) |\
+				(1UL << TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG) |\
+				(1UL << TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG) |\
+				(1UL << TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG) |\
+				(1UL << TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
+
 struct kobject;
 struct kobj_attribute;
 
@@ -442,7 +448,9 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 			   pmd_t *pmdp, struct folio *folio);
 
 int thp_enabled_parse(const char *buf, unsigned long *flags);
+int thp_defrag_parse(const char *buf, unsigned long *flags);
 const char *thp_enabled_string(unsigned long flags);
+const char *thp_defrag_string(unsigned long flags);
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d78318782af8..a0edf15b3a07 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1634,9 +1634,11 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int memory_thp_enabled_show(struct seq_file *m, void *v);
+int memory_thp_defrag_show(struct seq_file *m, void *v);
 ssize_t memory_thp_enabled_write(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off);
-
+ssize_t memory_thp_defrag_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off);
 int mem_cgroup_thp_flags_update_all(unsigned long flags, unsigned long mask);
 unsigned long memcg_get_thp_flags_all(unsigned long mask);
 unsigned long memcg_get_thp_flags(struct vm_area_struct *vma);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fdffdfc8605c..6e1886b220d9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -311,6 +311,28 @@ const char *thp_enabled_string(unsigned long flags)
 	return output;
 }
 
+const char *thp_defrag_string(unsigned long flags)
+{
+	const char *output;
+
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
+		     &flags))
+		output = "[always] defer defer+madvise madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
+			  &flags))
+		output = "always [defer] defer+madvise madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
+			  &flags))
+		output = "always defer [defer+madvise] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
+			  &flags))
+		output = "always defer defer+madvise [madvise] never";
+	else
+		output = "always defer defer+madvise madvise [never]";
+
+	return output;
+}
+
 int thp_enabled_parse(const char *buf, unsigned long *flags)
 {
 	if (sysfs_streq(buf, "always")) {
@@ -328,6 +350,39 @@ int thp_enabled_parse(const char *buf, unsigned long *flags)
 	return 0;
 }
 
+int thp_defrag_parse(const char *buf, unsigned long *flags)
+{
+	if (sysfs_streq(buf, "always")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, flags);
+	} else if (sysfs_streq(buf, "defer+madvise")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, flags);
+	} else if (sysfs_streq(buf, "defer")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, flags);
+	} else if (sysfs_streq(buf, "madvise")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, flags);
+	} else if (sysfs_streq(buf, "never")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, flags);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
@@ -394,60 +449,29 @@ ssize_t single_hugepage_flag_store(struct kobject *kobj,
 static ssize_t defrag_show(struct kobject *kobj,
 			   struct kobj_attribute *attr, char *buf)
 {
-	const char *output;
-
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
-		     &transparent_hugepage_flags))
-		output = "[always] defer defer+madvise madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
-			  &transparent_hugepage_flags))
-		output = "always [defer] defer+madvise madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
-			  &transparent_hugepage_flags))
-		output = "always defer [defer+madvise] madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
-			  &transparent_hugepage_flags))
-		output = "always defer defer+madvise [madvise] never";
-	else
-		output = "always defer defer+madvise madvise [never]";
-
-	return sysfs_emit(buf, "%s\n", output);
+	unsigned long flags = transparent_hugepage_flags;
+	return sysfs_emit(buf, "%s\n", thp_defrag_string(flags));
 }
 
 static ssize_t defrag_store(struct kobject *kobj,
 			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
-	if (sysfs_streq(buf, "always")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-	} else if (sysfs_streq(buf, "defer+madvise")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (sysfs_streq(buf, "defer")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-	} else if (sysfs_streq(buf, "madvise")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else if (sysfs_streq(buf, "never")) {
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
-	} else
-		return -EINVAL;
+	ssize_t ret = count;
+	int err;
 
-	return count;
+	ret = thp_defrag_parse(buf, &transparent_hugepage_flags) ? : count;
+	if (ret > 0 && IS_ENABLED(CONFIG_MEMCG) &&
+			!mem_cgroup_disabled()) {
+		err = mem_cgroup_thp_flags_update_all(transparent_hugepage_flags,
+							HUGEPAGE_FLAGS_DEFRAG_MASK);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
 }
+
 static struct kobj_attribute defrag_attr = __ATTR_RW(defrag);
 
 static ssize_t use_zero_page_show(struct kobject *kobj,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 938e6894c0b3..53384f0a69af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3706,6 +3706,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
 		(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
 #endif
+		(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
+		(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
 		(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG));
 		WRITE_ONCE(memcg->thp_anon_orders_inherit, BIT(PMD_ORDER));
 #endif
@@ -4490,6 +4492,30 @@ ssize_t memory_thp_enabled_write(struct kernfs_open_file *of, char *buf,
 	mutex_unlock(&memcg_thp_flags_mutex);
 	return ret;
 }
+
+int memory_thp_defrag_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	unsigned long flags = READ_ONCE(memcg->thp_flags);
+
+	seq_printf(m, "%s\n", thp_defrag_string(flags));
+	return 0;
+}
+
+ssize_t memory_thp_defrag_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	int ret = nbytes;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	buf = strstrip(buf);
+
+	mutex_lock(&memcg_thp_flags_mutex);
+	ret = thp_defrag_parse(buf, &memcg->thp_flags) ? : nbytes;
+	mutex_unlock(&memcg_thp_flags_mutex);
+
+	return ret;
+}
 #endif
 
 static struct cftype memory_files[] = {
@@ -4566,6 +4592,11 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_thp_enabled_show,
 		.write = memory_thp_enabled_write,
 	},
+	{
+		.name = "thp_defrag",
+		.seq_show = memory_thp_defrag_show,
+		.write = memory_thp_defrag_write,
+	},
 #endif
 	{ }	/* terminate */
 };
-- 
2.34.1


