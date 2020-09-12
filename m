Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D34267B45
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgILPlB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Sep 2020 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILPk4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Sep 2020 11:40:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F20C061573
        for <cgroups@vger.kernel.org>; Sat, 12 Sep 2020 08:40:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so9310206pfp.11
        for <cgroups@vger.kernel.org>; Sat, 12 Sep 2020 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K45/sJTWfGLOHz8j1CJv9AIhPEXu5Ad4gLQ/bbT0UcA=;
        b=AbWVWob8pChjjUl+ZgKGLxWQ8FbtPajG0QedKbpFktVwmCp8w5ZOyoAl709BTS4W0r
         +5i7Oq2hkNf5xVABiJcrvQYrCi8ohfIbR3mGDo5ddHxDKxUlGbE9PbcVLzPY1L0bkoWH
         dK+9ISOgAu5BoWTT7pSA7C2v4usnGSBDiR3xZUIpnjgaXOxuIu6sn8KmrRC3TmTPLyx4
         gM6atRQ5QNYCrqtcy4MWk0fmYNstVnw1nt5nn/GBoWtHdXTFK2r4xSdKx80EbWFW6k6K
         63+2426KoPso6XKJjSFlIKLEMM7SpNOOKtZmd85kv8J0kLpxPyqccurt+CY8PN46dr3j
         7bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K45/sJTWfGLOHz8j1CJv9AIhPEXu5Ad4gLQ/bbT0UcA=;
        b=bnwwynNhVwZmMFtamnnATjdPqsr92U0hr6Rem22j5YiVO1fr4zfeOefmflu8xepfS8
         So6lef2ZehlVUWzhJlqA1/Ag4ABQGUhl54W+kD7YgPABTqoP00YtC02sYVQ5wfpS3GgR
         yYJy0Y4MEEVw7nkCT2CtznpE30GdvRsIAZkGNGemxi6IFzvhQMi19aQPqe2OTncFKvTt
         zFGuo+8BakmB7XfFFdQY71/pJgmIBZJmloQkQhC4e29843JU9QweQ3kuCJuJateBZPv7
         NuYZiIZ7+WeJ2sEAk5imFVIPgWu4bhRDOboNOScGudI0IgI3CfguwEKKXA99CwpIGCa3
         SB0w==
X-Gm-Message-State: AOAM533ALJ3wPH7UrkM3ir890LA50xL5kCK4d7ORQ8G69cmcsGRx0B5V
        vu1KnwBPFVdCMpTqOfltA4XwFQ==
X-Google-Smtp-Source: ABdhPJxbENed1wu39aYbUE+kjJBBVndX04LrcEzfuaHjdB8eCqNmx8fQWw8S+WlnGdmOF75u5Tg+tA==
X-Received: by 2002:aa7:86c6:: with SMTP id h6mr6973675pfo.92.1599925253881;
        Sat, 12 Sep 2020 08:40:53 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id f19sm5305713pfj.25.2020.09.12.08.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 08:40:53 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcontrol: Add the missing numa_stat interface for cgroup v2
Date:   Sat, 12 Sep 2020 23:40:18 +0800
Message-Id: <20200912154018.24910-1-songmuchun@bytedance.com>
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

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 changelog in v2:
 1. Add memory.numa_stat interface in cgroup v2.

 Documentation/admin-guide/cgroup-v2.rst | 72 +++++++++++++++++++++
 mm/memcontrol.c                         | 84 +++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

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
index 75cd1a1e66c8..f2ef9a770eeb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6425,6 +6425,84 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
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
+	struct numa_stat {
+		const char *name;
+		unsigned int ratio;
+		enum node_stat_item idx;
+	};
+
+	static const struct numa_stat stats[] = {
+		{ "anno", PAGE_SIZE, NR_ANON_MAPPED },
+		{ "file", PAGE_SIZE, NR_FILE_PAGES },
+		{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+		{ "shmem", PAGE_SIZE, NR_SHMEM },
+		{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
+		{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
+		{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		{ "anon_thp", HPAGE_PMD_SIZE, NR_ANON_THPS },
+#endif
+		{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
+		{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
+		{ "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
+		{ "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
+		{ "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
+		{ "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
+		{ "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
+	};
+
+	int i, nid;
+	struct seq_buf s;
+
+	/* Reserve a byte for the trailing null */
+	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
+	if (!s.buffer)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(stats); i++) {
+		seq_buf_printf(&s, "%s", stats[i].name);
+		for_each_node_state(nid, N_MEMORY) {
+			u64 size;
+
+			size = memcg_node_page_state(memcg, nid, stats[i].idx);
+			size *= stats[i].ratio;
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
@@ -6502,6 +6580,12 @@ static struct cftype memory_files[] = {
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

