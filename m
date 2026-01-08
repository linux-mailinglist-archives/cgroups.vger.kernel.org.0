Return-Path: <cgroups+bounces-12972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FFFD02A05
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 13:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D283142FCA
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D870E2C21F0;
	Thu,  8 Jan 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBM4+8Qs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33783C1997
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864992; cv=none; b=r+0qIEv0TPRDlrZWyiUA4saddKj+h+VsaTj8hp9J7yRuu23ciTvCt910GieN/nPV0V54kjcZDYozPPUj0hkebNtG3JfWsL8kr7zNLUwh7KOKTLLp+GOKzKL3wyfQTDRXLKk7fabLTmQsIAzQahPRHoLzUAmp31pmG9d1lmUMTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864992; c=relaxed/simple;
	bh=z5vkkbGDVR6r6tL312e5eblDlnh/A3XrI22sJyNt0bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQt+yiz4GMT37Jb08U6s2SwV4TTBe4bp4KLjoAlQ234czQ1Qa+EuMJ462tfQY4e1T/gHxyL9JHDiuLAozM6pBgbigqWpIFbZhYTAnaT5zQAeFwe1RPdfgUy5degEGf7m1d14FGeRKLSWuLuZEIxRkEjNJ9U/Wd9FM1rfBQoWhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBM4+8Qs; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so2386380a91.1
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 01:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864983; x=1768469783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miqdi3JWBKoxNnDoIDRRY9WTssFbqfALy728r5SCWyA=;
        b=ZBM4+8Qs1lwBkzYtf/BgkSLN3ebPtIVWZQdIXILLD7Sr7sR40kVTC6tj0Dsy+bVi7k
         t8bUHMkaCMDg1RsOgxVdXV7voDZzYPnsEE8U/0xbvUZBg6Uu7fWaUdiPLjaIcjpKeVB6
         OssJ7ef5JC32D8jXHMwGT/nVdqVQA8quUi7q4PO0SlRfH/aSxNAT86Lf4WDupnRl9ydY
         7oI9SKjKUBNSI3tBY2Lddi7W2hpBVXCZr7DDbit8B2V4I2v23Y1sH4y0VUtemVGtmJtq
         dds64sjLqN5NTvzDDwazMpt+SUIHHSrhRhvfQtprn0fOp4uCK0ZNad9+1xgDRICv922f
         KNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864983; x=1768469783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miqdi3JWBKoxNnDoIDRRY9WTssFbqfALy728r5SCWyA=;
        b=aZEeWdU6RiqTr0ozNb+w3E2CXQ/BcuodnPrRvRUU1MeEbMnS2QWU2meVNF+YVvqe56
         hKgNj5pdNcJs/CqH4A23uiqxgksHHX/Pm8R8q4C/SRWMkAGgCJsvjmkBg0ZJKxvrXfVj
         YCxDOytjWZQNKYXQXsI+DFZ5DJdcgY9knHZeMTcuqJ7RTfWCJeqJ/P4fhB2l1XE8thUC
         VZh3qciPF4NJxPnx9GnuiLdjovF4csE/2KIioaowd7bN6SsHaNn840szmF1wRMIiI6M0
         5itn9ZFfNyu5jZY9nujHdZEYv40J4ZzKQaJI3hXoGfR7ascj5r9UU/6veiDPqyWQe2Yj
         7Alw==
X-Forwarded-Encrypted: i=1; AJvYcCVl649YTxKQJhtQYSUTXC1FH2a5qeER9FjEKh+flxnmeM7swIo4geGriYABxePh/U7fABB52hGU@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDUZm6/gNZZpQrlv+P96U83TlXlqOhQjtnrQh/YVqYD5Z2d77
	bktjvTFVON/uLsTo01Zg+ruP/NHNmWn7I3IB1t1RYmv8s3UUuU2LWl8540n+Ug==
X-Gm-Gg: AY/fxX5BXt+imwu2pleYthipcCz7B+E6ybNKVLmebXAjxrdtqrfjnctL3pOQXqVs/xp
	3ngJUNVkovMCIuXOwkCZpodA3HVofRewAdp5v/qNeObhdAKqSqlk07dM7McVYsQYM84owCrYRaO
	/Ee/AJVKIdXfPsPYTVh+CRZR3fZLrhpQGBoA9p3tUH42OWo2OAs9aKY1ulW3sanlrnncWHR93mO
	SOouNnnWC6Igkwl/EsvX6xPJiy2ry3DXmcGuwPb2kFqmfm6mamo2QJzAatJSEnwS9FZa1HNhKVD
	zrvlhMYLRZU1SilbrHdrwcZJ7yhlcseZ4cddY8X8H8XJ/p6YTfLBqf4UroyT4w3uFg8WFOFKYqV
	Ll/HnRR/grlB1d6Ra73vZzFFu6uM5ZNp63klBjiZ1bOb/7rXoNHAxdqdPjE54R6pLg2O6lBb1ma
	VNk+cZZ78y1c6++9umNcuZ+k8=
X-Google-Smtp-Source: AGHT+IHSReaBoY0payJlLNXxYuXOcysW/4kuuotsiPj+TOOyIlWaCgj/F8BpW7CjLFi/EpDUUEbMPg==
X-Received: by 2002:a17:903:1b4c:b0:2a1:3cd9:a734 with SMTP id d9443c01a7336-2a3ee49cfc7mr47710045ad.43.1767864982383;
        Thu, 08 Jan 2026 01:36:22 -0800 (PST)
Received: from NV-J4GCB44.nvidia.com ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3f3115682sm37460985ad.55.2026.01.08.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:36:21 -0800 (PST)
From: Jianyue Wu <wujianyue000@gmail.com>
X-Google-Original-From: Jianyue Wu <jianyuew@nvidia.com>
To: jianyuew@nvidia.com,
	hannes@cmpxchg.org
Cc: Jianyue Wu <wujianyue000@gmail.com>,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: optimize stat output for 11% sys time reduce
Date: Thu,  8 Jan 2026 17:36:02 +0800
Message-ID: <20260108093610.212023-1-jianyuew@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyue Wu <wujianyue000@gmail.com>

Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
printf parsing in memcg stats output.

Key changes:
- Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
- Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatting
- Update __memory_events_show(), swap_events_show(),
  memory_stat_format(), memory_numa_stat_show(), and related helpers

Performance:
- 1M reads of memory.stat+memory.numa_stat
- Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
- After:  real 0m9.051s, user 0m4.775s, sys 0m4.275s (~11.4% sys drop)

Tests:
- Script:
  for ((i=1; i<=1000000; i++)); do
      : > /dev/null < /sys/fs/cgroup/memory.stat
      : > /dev/null < /sys/fs/cgroup/memory.numa_stat
  done

Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
Signed-off-by: Jianyue Wu <jianyuew@nvidia.com>
---
 mm/memcontrol-v1.c | 97 ++++++++++++++++++++++++++--------------------
 mm/memcontrol-v1.h | 34 ++++++++++++++++
 mm/memcontrol.c    | 87 ++++++++++++++++++++++-------------------
 3 files changed, 137 insertions(+), 81 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..400feb798aec 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -10,7 +10,7 @@
 #include <linux/poll.h>
 #include <linux/sort.h>
 #include <linux/file.h>
-#include <linux/seq_buf.h>
+#include <linux/string.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -1795,25 +1795,33 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	mem_cgroup_flush_stats(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-		seq_printf(m, "%s=%lu", stat->name,
-			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-						   false));
-		for_each_node_state(nid, N_MEMORY)
-			seq_printf(m, " N%d=%lu", nid,
-				   mem_cgroup_node_nr_lru_pages(memcg, nid,
-							stat->lru_mask, false));
+		seq_puts(m, stat->name);
+		seq_put_decimal_ull(m, "=",
+				    (u64)mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+								  false));
+		for_each_node_state(nid, N_MEMORY) {
+			seq_put_decimal_ull(m, " N", nid);
+		seq_put_decimal_ull(m, "=",
+				    (u64)mem_cgroup_node_nr_lru_pages(memcg, nid,
+								       stat->lru_mask, false));
+		}
 		seq_putc(m, '\n');
 	}
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 
-		seq_printf(m, "hierarchical_%s=%lu", stat->name,
-			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-						   true));
-		for_each_node_state(nid, N_MEMORY)
-			seq_printf(m, " N%d=%lu", nid,
-				   mem_cgroup_node_nr_lru_pages(memcg, nid,
-							stat->lru_mask, true));
+		seq_puts(m, "hierarchical_");
+		seq_puts(m, stat->name);
+		seq_put_decimal_ull(m, "=",
+				    (u64)mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+								 true));
+		for_each_node_state(nid, N_MEMORY) {
+			seq_put_decimal_ull(m, " N", nid);
+			seq_put_decimal_ull(m, "=",
+					    (u64)mem_cgroup_node_nr_lru_pages(memcg, nid,
+									      stat->lru_mask,
+									      true));
+		}
 		seq_putc(m, '\n');
 	}
 
@@ -1879,17 +1887,17 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		unsigned long nr;
 
 		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
+		memcg_seq_buf_put_name_val(s, memcg1_stat_names[i], (u64)nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
-			       memcg_events_local(memcg, memcg1_events[i]));
+		memcg_seq_buf_put_name_val(s, vm_event_name(memcg1_events[i]),
+					   (u64)memcg_events_local(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
-			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+		memcg_seq_buf_put_name_val(s, lru_list_name(i),
+					   memcg_page_state_local(memcg, NR_LRU_BASE + i) *
+					   PAGE_SIZE);
 
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
@@ -1897,28 +1905,33 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		memory = min(memory, READ_ONCE(mi->memory.max));
 		memsw = min(memsw, READ_ONCE(mi->memsw.max));
 	}
-	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
-		       (u64)memory * PAGE_SIZE);
-	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
-		       (u64)memsw * PAGE_SIZE);
+	memcg_seq_buf_put_name_val(s, "hierarchical_memory_limit",
+				   (u64)memory * PAGE_SIZE);
+	memcg_seq_buf_put_name_val(s, "hierarchical_memsw_limit",
+				   (u64)memsw * PAGE_SIZE);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
-		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
-			       (u64)nr);
+	nr = memcg_page_state_output(memcg, memcg1_stats[i]);
+	seq_buf_puts(s, "total_");
+	memcg_seq_buf_put_name_val(s, memcg1_stat_names[i],
+				   (u64)nr);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "total_%s %llu\n",
-			       vm_event_name(memcg1_events[i]),
-			       (u64)memcg_events(memcg, memcg1_events[i]));
+	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++) {
+		seq_buf_puts(s, "total_");
+		memcg_seq_buf_put_name_val(s,
+					   vm_event_name(memcg1_events[i]),
+					   (u64)memcg_events(memcg, memcg1_events[i]));
+	}
 
-	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
-			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+	for (i = 0; i < NR_LRU_LISTS; i++) {
+		seq_buf_puts(s, "total_");
+		memcg_seq_buf_put_name_val(s, lru_list_name(i),
+					   (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
+					   (PAGE_SIZE));
+	}
 
 #ifdef CONFIG_DEBUG_VM
 	{
@@ -1933,8 +1946,8 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			anon_cost += mz->lruvec.anon_cost;
 			file_cost += mz->lruvec.file_cost;
 		}
-		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
-		seq_buf_printf(s, "file_cost %lu\n", file_cost);
+		memcg_seq_buf_put_name_val(s, "anon_cost", (u64)anon_cost);
+		memcg_seq_buf_put_name_val(s, "file_cost", (u64)file_cost);
 	}
 #endif
 }
@@ -1969,10 +1982,10 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
 
-	seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill_disable));
-	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
-	seq_printf(sf, "oom_kill %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
+	memcg_seq_put_name_val(sf, "oom_kill_disable", READ_ONCE(memcg->oom_kill_disable));
+	memcg_seq_put_name_val(sf, "under_oom", (bool)memcg->under_oom);
+	memcg_seq_put_name_val(sf, "oom_kill",
+			       (u64)atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
 	return 0;
 }
 
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..a4ac2d869506 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -4,6 +4,9 @@
 #define __MM_MEMCONTROL_V1_H
 
 #include <linux/cgroup-defs.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/sprintf.h>
 
 /* Cgroup v1 and v2 common declarations */
 
@@ -33,6 +36,37 @@ int memory_stat_show(struct seq_file *m, void *v);
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
 
+/* Max 2^64 - 1 = 18446744073709551615 (20 digits) */
+#define MEMCG_DEC_U64_MAX_LEN 20
+
+static inline void memcg_seq_put_name_val(struct seq_file *m, const char *name,
+					  u64 val)
+{
+	seq_puts(m, name);
+	/* need a space between name and value */
+	seq_put_decimal_ull(m, " ", val);
+	seq_putc(m, '\n');
+}
+
+static inline void memcg_seq_buf_put_name_val(struct seq_buf *s,
+					      const char *name, u64 val)
+{
+	char num_buf[MEMCG_DEC_U64_MAX_LEN];
+	int num_len;
+
+	num_len = num_to_str(num_buf, sizeof(num_buf), val, 0);
+	if (num_len <= 0)
+		return;
+
+	if (seq_buf_puts(s, name))
+		return;
+	if (seq_buf_putc(s, ' '))
+		return;
+	if (seq_buf_putmem(s, num_buf, num_len))
+		return;
+	seq_buf_putc(s, '\n');
+}
+
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f43b7e5f71..62652a3c8681 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -42,6 +42,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/limits.h>
+#include <linux/sprintf.h>
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -1485,26 +1486,26 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			continue;
 #endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
+		memcg_seq_buf_put_name_val(s, memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(s, "slab %llu\n", size);
+			memcg_seq_buf_put_name_val(s, "slab", size);
 		}
 	}
 
 	/* Accumulated memory events */
-	seq_buf_printf(s, "pgscan %lu\n",
-		       memcg_events(memcg, PGSCAN_KSWAPD) +
-		       memcg_events(memcg, PGSCAN_DIRECT) +
-		       memcg_events(memcg, PGSCAN_PROACTIVE) +
-		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
-	seq_buf_printf(s, "pgsteal %lu\n",
-		       memcg_events(memcg, PGSTEAL_KSWAPD) +
-		       memcg_events(memcg, PGSTEAL_DIRECT) +
-		       memcg_events(memcg, PGSTEAL_PROACTIVE) +
-		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
+	memcg_seq_buf_put_name_val(s, "pgscan",
+				   memcg_events(memcg, PGSCAN_KSWAPD) +
+				   memcg_events(memcg, PGSCAN_DIRECT) +
+				   memcg_events(memcg, PGSCAN_PROACTIVE) +
+				   memcg_events(memcg, PGSCAN_KHUGEPAGED));
+	memcg_seq_buf_put_name_val(s, "pgsteal",
+				   memcg_events(memcg, PGSTEAL_KSWAPD) +
+				   memcg_events(memcg, PGSTEAL_DIRECT) +
+				   memcg_events(memcg, PGSTEAL_PROACTIVE) +
+				   memcg_events(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
 #ifdef CONFIG_MEMCG_V1
@@ -1512,9 +1513,9 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
 #endif
-		seq_buf_printf(s, "%s %lu\n",
-			       vm_event_name(memcg_vm_event_stat[i]),
-			       memcg_events(memcg, memcg_vm_event_stat[i]));
+		memcg_seq_buf_put_name_val(s,
+					   vm_event_name(memcg_vm_event_stat[i]),
+					   memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
 }
 
@@ -4218,10 +4219,12 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
 
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
 {
-	if (value == PAGE_COUNTER_MAX)
+	if (value == PAGE_COUNTER_MAX) {
 		seq_puts(m, "max\n");
-	else
-		seq_printf(m, "%llu\n", (u64)value * PAGE_SIZE);
+	} else {
+		seq_put_decimal_ull(m, "", (u64)value * PAGE_SIZE);
+		seq_putc(m, '\n');
+	}
 
 	return 0;
 }
@@ -4247,7 +4250,8 @@ static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
 	else
 		peak = max(fd_peak, READ_ONCE(pc->local_watermark));
 
-	seq_printf(sf, "%llu\n", peak * PAGE_SIZE);
+	seq_put_decimal_ull(sf, "", peak * PAGE_SIZE);
+	seq_putc(sf, '\n');
 	return 0;
 }
 
@@ -4480,16 +4484,16 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
  */
 static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 {
-	seq_printf(m, "low %lu\n", atomic_long_read(&events[MEMCG_LOW]));
-	seq_printf(m, "high %lu\n", atomic_long_read(&events[MEMCG_HIGH]));
-	seq_printf(m, "max %lu\n", atomic_long_read(&events[MEMCG_MAX]));
-	seq_printf(m, "oom %lu\n", atomic_long_read(&events[MEMCG_OOM]));
-	seq_printf(m, "oom_kill %lu\n",
-		   atomic_long_read(&events[MEMCG_OOM_KILL]));
-	seq_printf(m, "oom_group_kill %lu\n",
-		   atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
-	seq_printf(m, "sock_throttled %lu\n",
-		   atomic_long_read(&events[MEMCG_SOCK_THROTTLED]));
+	memcg_seq_put_name_val(m, "low", atomic_long_read(&events[MEMCG_LOW]));
+	memcg_seq_put_name_val(m, "high", atomic_long_read(&events[MEMCG_HIGH]));
+	memcg_seq_put_name_val(m, "max", atomic_long_read(&events[MEMCG_MAX]));
+	memcg_seq_put_name_val(m, "oom", atomic_long_read(&events[MEMCG_OOM]));
+	memcg_seq_put_name_val(m, "oom_kill",
+			       atomic_long_read(&events[MEMCG_OOM_KILL]));
+	memcg_seq_put_name_val(m, "oom_group_kill",
+			       atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
+	memcg_seq_put_name_val(m, "sock_throttled",
+			       atomic_long_read(&events[MEMCG_SOCK_THROTTLED]));
 }
 
 static int memory_events_show(struct seq_file *m, void *v)
@@ -4544,7 +4548,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 		if (memory_stats[i].idx >= NR_VM_NODE_STAT_ITEMS)
 			continue;
 
-		seq_printf(m, "%s", memory_stats[i].name);
+		seq_puts(m, memory_stats[i].name);
 		for_each_node_state(nid, N_MEMORY) {
 			u64 size;
 			struct lruvec *lruvec;
@@ -4552,7 +4556,10 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 			size = lruvec_page_state_output(lruvec,
 							memory_stats[i].idx);
-			seq_printf(m, " N%d=%llu", nid, size);
+
+			seq_put_decimal_ull(m, " N", nid);
+			seq_putc(m, '=');
+			seq_put_decimal_ull(m, "", size);
 		}
 		seq_putc(m, '\n');
 	}
@@ -4565,7 +4572,8 @@ static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", READ_ONCE(memcg->oom_group));
+	seq_put_decimal_ll(m, "", READ_ONCE(memcg->oom_group));
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -5373,12 +5381,12 @@ static int swap_events_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "high %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]));
-	seq_printf(m, "max %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
-	seq_printf(m, "fail %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_FAIL]));
+	memcg_seq_put_name_val(m, "high",
+			       atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]));
+	memcg_seq_put_name_val(m, "max",
+			       atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
+	memcg_seq_put_name_val(m, "fail",
+			       atomic_long_read(&memcg->memory_events[MEMCG_SWAP_FAIL]));
 
 	return 0;
 }
@@ -5564,7 +5572,8 @@ static int zswap_writeback_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
+	seq_put_decimal_ll(m, "", READ_ONCE(memcg->zswap_writeback));
+	seq_putc(m, '\n');
 	return 0;
 }
 
-- 
2.43.0


