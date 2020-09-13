Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF2267E4A
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 09:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgIMHC3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgIMHBh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 03:01:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A0C061574
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 00:01:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so9124129pgd.12
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTITQjXjsPqeS3q5uQCStGzc676txDfh5hSNVhc3r6s=;
        b=EQNxbcmrx5LKBOZbdD8y3CWQOUtvm9Q9+0LXa4r0Mj0wtS+MstvPvKBH10e+vDijQV
         qtvQZ6EPHWdqk+TXzscujfYxeiG+eqJL4hXQuJvTDB1Q7noGY2y0+q/5KwhUWju9ytls
         VsLgAd9qO1HQVHzT2m6u0HrCBaGI8wG96AL7z7s8X6JU7rzM5lmOVAAcHiWKG8nVZuEZ
         u184xHmL/m/0Ptklo5uCIPA8bK5rnZKIp+LKwh0GCFkJF6u8uZsqkUaPKaFLu5ZkDzdJ
         FD3lsNrc8KwB7ScA80kn8z79unTGX1dZ4sJ2p3+lT9gqjjDaPUVQbFdTrswlwUWzbSmg
         wb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTITQjXjsPqeS3q5uQCStGzc676txDfh5hSNVhc3r6s=;
        b=F+pWEFGB+c9bbGfSZE34rEuR8ObQONhL0C9MRjcLKjBSgk6MulFsSUOyW/Rfh1cM09
         dcbY6SJFUNAaJJY/pPSeuDX744LRzoRrMhovuIOZrQBVotA8Vk3cAu5daUzONV3842pg
         kU6usK4lTGl2+YBBy2q/3SS+rD9Po7IFGHfihLYpW/oyGtxAkbDcyyP6L5OzlY3zw3Rh
         y7p0PnOvIYQvGVj5N+Uhg9t4FtpPTaVUaoGtoUourJszaUOQLhvNg08C9LLTiv8uE1hI
         nF4/iFS6gCblsPC5xyWiV5Nekriq7Ip/eEsYwsXt7/ne3LJ+JfsEMKGgkeV9fx377A4K
         Y1Yw==
X-Gm-Message-State: AOAM530aMzRs+Xvt6kUtegc7R5twqCbWhXjQKdva4+KfmmcxD2lhLVJQ
        4yfufxLAuAs2fdPQX/vME9UHBQ==
X-Google-Smtp-Source: ABdhPJwj4J678KdwNwTZPyPKY01PXjumQEW0bpphGuGp/1blnPWmE1TRf+I/un6mZ5cooWqy1Mz4VQ==
X-Received: by 2002:a63:b20d:: with SMTP id x13mr4919769pge.136.1599980495724;
        Sun, 13 Sep 2020 00:01:35 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id z84sm6877245pfc.105.2020.09.13.00.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 00:01:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mm: memcontrol: Add the missing numa_stat interface for cgroup v2
Date:   Sun, 13 Sep 2020 15:00:10 +0800
Message-Id: <20200913070010.44053-1-songmuchun@bytedance.com>
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
Reported-by: kernel test robot <lkp@intel.com>
---
 changelog in v3:
 1. Fix compiler error on powerpc architecture reported by kernel test robot.
 2. Fix a typo from "anno" to "anon".

 changelog in v2:
 1. Add memory.numa_stat interface in cgroup v2.

 Documentation/admin-guide/cgroup-v2.rst |  72 ++++++++++++++++
 mm/memcontrol.c                         | 107 ++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6be43781ec7f..92207f0012e4 100644
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
+	This is useful for providing visibility into the numa locality
+	information within an memcg since the pages are allowed to be
+	allocated from any physical node. One of the use cases is evaluating
+	application performance by combining this information with the
+	application's CPU allocation.
+
+	All memory amounts are in bytes.
+
+	The output format of memory.numa_stat is::
+
+	  type N0=<node 0 pages> N1=<node 1 pages> ...
+
+	The entries are ordered to be human readable, and new entries
+	can show up in the middle. Don't rely on items remaining in a
+	fixed position; use the keys to look up specific values!
+
+	  anon
+		Amount of memory per node used in anonymous mappings such
+		as brk(), sbrk(), and mmap(MAP_ANONYMOUS)
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
+		such as tmpfs, shm segments, shared anonymous mmap()s
+
+	  file_mapped
+		Amount of cached filesystem data per node mapped with mmap()
+
+	  file_dirty
+		Amount of cached filesystem data per node that was modified but
+		not yet written back to disk
+
+	  file_writeback
+		Amount of cached filesystem data per node that was modified and
+		is currently being written back to disk
+
+	  anon_thp
+		Amount of memory per node used in anonymous mappings backed by
+		transparent hugepages
+
+	  inactive_anon, active_anon, inactive_file, active_file, unevictable
+		Amount of memory, swap-backed and filesystem-backed,
+		per node on the internal memory management lists used
+		by the page reclaim algorithm.
+
+		As these represent internal list state (eg. shmem pages are on anon
+		memory management lists), inactive_foo + active_foo may not be equal to
+		the value for the foo counter, since the foo counter is type-based, not
+		list-based.
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
index 1b403d6f5da0..2dadb1aaedaa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6427,6 +6427,107 @@ static int memory_stat_show(struct seq_file *m, void *v)
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
+static const char *memory_numa_stat_format(struct mem_cgroup *memcg)
+{
+	int i;
+	struct seq_buf s;
+
+	/* Reserve a byte for the trailing null */
+	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
+	if (!s.buffer)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
+		int nid;
+
+		seq_buf_printf(&s, "%s", numa_stats[i].name);
+		for_each_node_state(nid, N_MEMORY) {
+			u64 size;
+
+			size = memcg_node_page_state(memcg, nid,
+						     numa_stats[i].idx);
+			size *= numa_stats[i].ratio;
+			seq_buf_printf(&s, " N%d=%llu", nid, size);
+		}
+		seq_buf_putc(&s, '\n');
+	}
+
+	/* The above should easily fit into one page */
+	if (WARN_ON_ONCE(seq_buf_putc(&s, '\0')))
+		s.buffer[PAGE_SIZE - 1] = '\0';
+
+	return s.buffer;
+}
+
+static int memory_numa_stat_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	const char *buf;
+
+	buf = memory_numa_stat_format(memcg);
+	if (!buf)
+		return -ENOMEM;
+	seq_puts(m, buf);
+	kfree(buf);
+	return 0;
+}
+#endif
+
 static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -6504,6 +6605,12 @@ static struct cftype memory_files[] = {
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

