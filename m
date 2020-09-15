Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3D26AA58
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgIORSe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIORSS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 13:18:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA9C061356
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 10:18:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa1so140353pjb.0
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebq9sJqx9UJfmyOfsvRZlBUi0Qw5FSlq2i9Oj0M7RmI=;
        b=JFmmJqAVabMeTcUBUWN6RX+HbyA9sYDZ9qn8tZT6RcHuObbQlE6QO9G3cMBvIkWhJX
         AlEGQMF7askN6OXy3BA/YK4qC6WsPdBYvMdgE+FMqy8KmZT99k6DaiboSw/YVWkNfEIH
         0FBUz3PRQj+gW/3hexhkEskZO1crML8glUQObahiAwGIaUzoroy2EheK0Iip4b+3bsMH
         OXDsTYshIE86YKl8SM1erM6EedDtTH7KRimm+rq7bhOpUHoA0IF/tjSmw6zrtlOiss0W
         YhW2/M7telw1H8Zu+H91wgKSdkH5Az4C1Lu7ictO2MyHYSm8JorAuoOG0jViRUNNWgC3
         dRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebq9sJqx9UJfmyOfsvRZlBUi0Qw5FSlq2i9Oj0M7RmI=;
        b=riwiecm4CavgB1IRS/UyxDb0L9yX2Ae6gNSNQizUK3val8mPrOwC+gLF8fvWMph5G0
         0woj9jSQgngFIAZhQARURSoB0j+6Vl1xXD6yDQPV1rInnsD7GOAO9CxRKK/ic89mZzAy
         eJL5ZCOPPI30rRSOz7ODTtjwSnZ2pMfMp8KSj6WJcFFAKxgZMsv0XAJf3tUmP25wnZWZ
         xkgkuGwadtlt7haCoD+drYCyHGxsgj86VVCqpEgFHFG9PSKNNl0btI01fqCuaiu1VkXX
         vMJRqbb7IetbSS2MncPzLNwAAUuXqcVn8h2RCFiWONc19piU6JkSYE1jOUrfhLV94O58
         hfcg==
X-Gm-Message-State: AOAM530qCVBJcsOkpmYQPUwXec41kwEU/EFsgJ9uKSRzuPQgytd/TzmQ
        Md1si2CEJZCugJbmSUw3ew9fVg==
X-Google-Smtp-Source: ABdhPJwHQ5urJIBe7RR9E3kUyb++A2iLD/ExYs4YJBipu9rFJkl9lnCLKBxHHnefI0F9dXcyO2x2DQ==
X-Received: by 2002:a17:90b:50e:: with SMTP id r14mr344616pjz.230.1600190297236;
        Tue, 15 Sep 2020 10:18:17 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id x4sm14288294pfm.86.2020.09.15.10.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:18:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        rdunlap@infradead.org
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5] mm: memcontrol: Add the missing numa_stat interface for cgroup v2
Date:   Wed, 16 Sep 2020 01:18:01 +0800
Message-Id: <20200915171801.39761-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the cgroup v1, we have a numa_stat interface. This is useful for
providing visibility into the numa locality information within an
memcg since the pages are allowed to be allocated from any physical
node. One of the use cases is evaluating application performance by
combining this information with the application's CPU allocation.
But the cgroup v2 does not. So this patch adds the missing information.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 changelog in v5:
 1. Fix small nits pointed out by Shakeel Butt

 changelog in v4:
 1. Fix some document problems pointed out by Randy Dunlap.
 2. Remove memory_numa_stat_format() suggested by Shakeel Butt.

 changelog in v3:
 1. Fix compiler error on powerpc architecture reported by kernel test robot.
 2. Fix a typo from "anno" to "anon".

 changelog in v2:
 1. Add memory.numa_stat interface in cgroup v2.

 Documentation/admin-guide/cgroup-v2.rst | 72 +++++++++++++++++++++
 mm/memcontrol.c                         | 86 +++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6be43781ec7f..48bb12fc7622 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1368,6 +1368,78 @@ PAGE_SIZE multiple when read back.
 		collapsing an existing range of pages. This counter is not
 		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
 
+  memory.numa_stat
+	A read-only flat-keyed file which exists on non-root cgroups.
+
+	This breaks down the cgroup's memory footprint into different
+	types of memory, type-specific details, and other information
+	per node on the state of the memory management system.
+
+	This is useful for providing visibility into the NUMA locality
+	information within an memcg since the pages are allowed to be
+	allocated from any physical node. One of the use case is evaluating
+	application performance by combining this information with the
+	application's CPU allocation.
+
+	All memory amounts are in bytes.
+
+	The output format of memory.numa_stat is::
+
+	  type N0=<bytes in node 0> N1=<bytes in node 1> ...
+
+	The entries are ordered to be human readable, and new entries
+	can show up in the middle. Don't rely on items remaining in a
+	fixed position; use the keys to look up specific values!
+
+	  anon
+		Amount of memory per node used in anonymous mappings such
+		as brk(), sbrk(), and mmap(MAP_ANONYMOUS).
+
+	  file
+		Amount of memory per node used to cache filesystem data,
+		including tmpfs and shared memory.
+
+	  kernel_stack
+		Amount of memory per node allocated to kernel stacks.
+
+	  shmem
+		Amount of cached filesystem data per node that is swap-backed,
+		such as tmpfs, shm segments, shared anonymous mmap()s.
+
+	  file_mapped
+		Amount of cached filesystem data per node mapped with mmap().
+
+	  file_dirty
+		Amount of cached filesystem data per node that was modified but
+		not yet written back to disk.
+
+	  file_writeback
+		Amount of cached filesystem data per node that was modified and
+		is currently being written back to disk.
+
+	  anon_thp
+		Amount of memory per node used in anonymous mappings backed by
+		transparent hugepages.
+
+	  inactive_anon, active_anon, inactive_file, active_file, unevictable
+		Amount of memory, swap-backed and filesystem-backed,
+		per node on the internal memory management lists used
+		by the page reclaim algorithm.
+
+		As these represent internal list state (e.g. shmem pages are on
+		anon memory management lists), inactive_foo + active_foo may not
+		be equal to the value for the foo counter, since the foo counter
+		is type-based, not list-based.
+
+	  slab_reclaimable
+		Amount of memory per node used for storing in-kernel data
+		structures which might be reclaimed, such as dentries and
+		inodes.
+
+	  slab_unreclaimable
+		Amount of memory per node used for storing in-kernel data
+		structures which cannot be reclaimed on memory pressure.
+
   memory.swap.current
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..ff919ef3b57b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6425,6 +6425,86 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
+struct numa_stat {
+	const char *name;
+	unsigned int ratio;
+	enum node_stat_item idx;
+};
+
+static struct numa_stat numa_stats[] = {
+	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
+	{ "file", PAGE_SIZE, NR_FILE_PAGES },
+	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "shmem", PAGE_SIZE, NR_SHMEM },
+	{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
+	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
+	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/*
+	 * The ratio will be initialized in numa_stats_init(). Because
+	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
+	 * constant(e.g. powerpc).
+	 */
+	{ "anon_thp", 0, NR_ANON_THPS },
+#endif
+	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
+	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
+	{ "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
+	{ "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
+	{ "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
+	{ "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
+	{ "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
+};
+
+static int __init numa_stats_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		if (numa_stats[i].idx == NR_ANON_THPS)
+			numa_stats[i].ratio = HPAGE_PMD_SIZE;
+#endif
+	}
+
+	return 0;
+}
+pure_initcall(numa_stats_init);
+
+static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
+					   unsigned int nid,
+					   enum node_stat_item idx)
+{
+	VM_BUG_ON(nid >= nr_node_ids);
+	return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
+}
+
+static int memory_numa_stat_show(struct seq_file *m, void *v)
+{
+	int i;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
+		int nid;
+
+		seq_printf(m, "%s", numa_stats[i].name);
+		for_each_node_state(nid, N_MEMORY) {
+			u64 size;
+
+			size = memcg_node_page_state(memcg, nid,
+						     numa_stats[i].idx);
+			VM_WARN_ON_ONCE(!numa_stats[i].ratio);
+			size *= numa_stats[i].ratio;
+			seq_printf(m, " N%d=%llu", nid, size);
+		}
+		seq_putc(m, '\n');
+	}
+
+	return 0;
+}
+#endif
+
 static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -6502,6 +6582,12 @@ static struct cftype memory_files[] = {
 		.name = "stat",
 		.seq_show = memory_stat_show,
 	},
+#ifdef CONFIG_NUMA
+	{
+		.name = "numa_stat",
+		.seq_show = memory_numa_stat_show,
+	},
+#endif
 	{
 		.name = "oom.group",
 		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
-- 
2.20.1

