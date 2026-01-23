Return-Path: <cgroups+bounces-13404-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHHYCrKQc2l0xAAAu9opvQ
	(envelope-from <cgroups+bounces-13404-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 16:16:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886A77A1D
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5796A303A872
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B85E285072;
	Fri, 23 Jan 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5MrvUue"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90228488D
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180511; cv=none; b=KsHOG5q24tQGbADFWRbFeEglf2hkSvmhzm8m67yjuDIC6+kSELXAF/sEIsxCXOPayKrxud6kuMcUpClvflpIL1Gd+p7A2BxbsmFFO2nLmrujHFYKAB6Zd/CGMgZrnj6rQLtvHrTMBf/jORrITWGRv8cSUWFwkLWX9nQkxdTDVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180511; c=relaxed/simple;
	bh=98z08aP2SJAE58imTYc7ee2Bfn47u8ghp+7FoXEjgls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ/pL9TSgIf5pnYKNDvvjsqyWQkyZ6Zanw4C8C+2V1Rh3VAVnKXjeDWys0OaOrhIBvaTztDtrjapsyuU+rDdLhHiWFKKTQbFRq+CTu9zTOs9gxb3dyLaoJVr/8XX1Teq4o3DWUhamWdFddht45b/ZFczzn33RxqeK8yPS2C/5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5MrvUue; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a07fac8aa1so18405425ad.1
        for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769180509; x=1769785309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Set9gO/ypIAbsARkMT+qR5jxMJl3CCIAGoFSSuhdA4A=;
        b=S5MrvUueE8pha9YI+/L2za/1cXRlhMC/nPJLE1p8OZvpfO58S5/KL77jTL8/dZePBA
         AIfy/ix/Pf+wdmsW+09zPmOkk3fKCfn6ihW6f0vmIaZKgR2mQVKRlIjCwLVijxyRN2ud
         VHY4eU3I5PfesashKugjnCjT5ALhV1R2laabBdLoxa9AE7V+GeHTBfb3ZKAjlbs2q+k0
         MmkEy/D6Afh2lOsMqRws0q1Csz7CdyWXDQ07k9RyXroXjfKJ71Du7I/P1ivTA5k2gwnH
         e5U/a5iLLutD+W4fTzEFSA/3hn+O/ueDjgANs9OhmXqvr4DK5uGM+AbO1nSsUds7iKcY
         1j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180509; x=1769785309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Set9gO/ypIAbsARkMT+qR5jxMJl3CCIAGoFSSuhdA4A=;
        b=arV5GzmoCNQYRR4CG9Iesmpkl/XOMwYR3uULEEIDHsbFwGI1BICGwr30QyBW+ExgWE
         Frjfzdgh74h7O401NGyOdEkKIl9ntzce1P4gEhfuAXX2mJ+928ohW22oeDawt/UpVrvM
         8oxtXMal0qRvPxRtZVLqDdgsdo2cBbqpVNfIonU7U8v1NOMI67tP6vW8GCj8Y4xWgfX/
         WBCpLFEg4diK/5KCZRiZeuhy4jSXdI4b9fDr40CVMR9i8YLZslkmeKrTJp+h7Ls0d/4/
         LtnMn/9NdG+BD8DHA54BW50eX74NV4bJBDUGmizq3MtWBHbTMr85mz6/SFRH1v2+zbhA
         hhYw==
X-Forwarded-Encrypted: i=1; AJvYcCWokauRqtUvA2+JGneO+4GloMlNc/Zej1k6Q1AyZubTrV4+ElJ+YjnrsUr97LjwK1apz5r3ap4L@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOcVydgGHUsPbP/5dq42E3Dk+CwzTOCXD62yzpXic0WFKP6cK
	EhdZbGLRUl2I8nWFrKmeAPREoZg5h78TSP3uDbFB/XhES8VuX9PeZevE
X-Gm-Gg: AZuq6aKySK6rPan07WPr6nWu31LCu3o7S6Ie/1aChRKGggqjR//Gj61jrz0H2/0Tkqg
	PDo1I81IYBerDHmgBl2U2mPMnzaw1RknGjUDfy6i9xoC4zQIG66F3YO+hDxzWBnY3DGoRntjtgg
	9opzHp9TJO7yc9X/mAOXTNz0weNZ1W1q/2b7YYQUpjNnu9hvUFZ4mjZU8FrhAgYPZIlIP/P0PSy
	vAJOYi5bevGkjBBV525yrZkO5YHQ46+d7kpkSF5h8rRXgDEUvQr4PjHjsh7QcFLpwZtlhPLgZ1M
	Y7RbDkY2xgvoSGYLokcua30CxiEHdWJxhyv/d0iZNy7bxpdIuEMK7cNwDyi+42gK6lj71SPFLM5
	KcdZXkLyyk5RvOi1eL8eed/dCMg328jf89DQel+K3WMhzX5d/HiltIHVhU+muR19H5J2gRE3rTd
	MXHn71x779Vrc1L569rFqup0BVrFs=
X-Received: by 2002:a17:902:f647:b0:295:86a1:5008 with SMTP id d9443c01a7336-2a7fe62504dmr26429375ad.38.1769180506366;
        Fri, 23 Jan 2026 07:01:46 -0800 (PST)
Received: from NV-J4GCB44.nvidia.com ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fae9b5sm22297685ad.80.2026.01.23.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:01:45 -0800 (PST)
From: Jianyue Wu <wujianyue000@gmail.com>
To: akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	inwardvessel@gmail.com,
	Jianyue Wu <wujianyue000@gmail.com>
Subject: [PATCH v4 1/1] mm: optimize stat output for 11% sys time reduce
Date: Fri, 23 Jan 2026 23:01:08 +0800
Message-ID: <20260123150108.43443-2-wujianyue000@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123150108.43443-1-wujianyue000@gmail.com>
References: <20260122114242.72139-1-wujianyue000@gmail.com>
 <20260123150108.43443-1-wujianyue000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13404-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7886A77A1D
X-Rspamd-Action: no action

Replace seq_buf_printf() calls in memcg stat formatting with a
lightweight helper function and replace seq_printf() in numa stat
output with direct seq operations to avoid printf format parsing
overhead.

Key changes:
- Add memcg_seq_buf_print_stat() helper that embeds separator and
  newline directly in the number buffer to reduce function calls
- Replace seq_buf_printf() in memcg_stat_format() with
  memcg_seq_buf_print_stat()
- Replace seq_printf() in memory_numa_stat_show() and
  memcg_numa_stat_show() with seq_puts() and seq_put_decimal_ull()
- Update memory_stat_format() and related v1 stats formatting

Performance improvement (1M reads of memory.stat + memory.numa_stat):
- Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
- After:  real 0m8.909s, user 0m4.661s, sys 0m4.247s
- Result: ~11% sys time reduction

Test script:
  for ((i=1; i<=1000000; i++)); do
      : > /dev/null < /sys/fs/cgroup/memory.stat
      : > /dev/null < /sys/fs/cgroup/memory.numa_stat
  done

Suggested-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---
 mm/memcontrol-v1.c | 84 ++++++++++++++++++++++++-------------------
 mm/memcontrol-v1.h |  4 +++
 mm/memcontrol.c    | 88 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 123 insertions(+), 53 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..5efea38da69e 100644
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
@@ -1794,26 +1794,39 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 
 	mem_cgroup_flush_stats(memcg);
 
+	/*
+	 * Output format: "stat_name=value N0=value0 N1=value1 ...\n"
+	 * Use seq_puts and seq_put_decimal_ull to avoid printf format
+	 * parsing overhead in this hot path.
+	 */
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
+				    mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+							    false));
+		for_each_node_state(nid, N_MEMORY) {
+			seq_put_decimal_ull(m, " N", nid);
+			seq_put_decimal_ull(m, "=",
+					    mem_cgroup_node_nr_lru_pages(memcg, nid,
+									 stat->lru_mask,
+									 false));
+		}
 		seq_putc(m, '\n');
 	}
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-
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
+				    mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+							    true));
+		for_each_node_state(nid, N_MEMORY) {
+			seq_put_decimal_ull(m, " N", nid);
+			seq_put_decimal_ull(m, "=",
+					    mem_cgroup_node_nr_lru_pages(memcg, nid,
+									 stat->lru_mask,
+									 true));
+		}
 		seq_putc(m, '\n');
 	}
 
@@ -1879,17 +1892,17 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		unsigned long nr;
 
 		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
+		memcg_seq_buf_print_stat(s, NULL, memcg1_stat_names[i], ' ', (u64)nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
-			       memcg_events_local(memcg, memcg1_events[i]));
+		memcg_seq_buf_print_stat(s, NULL, vm_event_name(memcg1_events[i]),
+					 ' ', memcg_events_local(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
-			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+		memcg_seq_buf_print_stat(s, NULL, lru_list_name(i), ' ',
+					 memcg_page_state_local(memcg, NR_LRU_BASE + i) *
+					 PAGE_SIZE);
 
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
@@ -1897,28 +1910,27 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		memory = min(memory, READ_ONCE(mi->memory.max));
 		memsw = min(memsw, READ_ONCE(mi->memsw.max));
 	}
-	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
-		       (u64)memory * PAGE_SIZE);
-	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
-		       (u64)memsw * PAGE_SIZE);
+	memcg_seq_buf_print_stat(s, NULL, "hierarchical_memory_limit", ' ',
+				 (u64)memory * PAGE_SIZE);
+	memcg_seq_buf_print_stat(s, NULL, "hierarchical_memsw_limit", ' ',
+				 (u64)memsw * PAGE_SIZE);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
 		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
-			       (u64)nr);
+		memcg_seq_buf_print_stat(s, "total_", memcg1_stat_names[i], ' ',
+					 (u64)nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "total_%s %llu\n",
-			       vm_event_name(memcg1_events[i]),
-			       (u64)memcg_events(memcg, memcg1_events[i]));
+		memcg_seq_buf_print_stat(s, "total_", vm_event_name(memcg1_events[i]),
+					 ' ', (u64)memcg_events(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
-			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+		memcg_seq_buf_print_stat(s, "total_", lru_list_name(i), ' ',
+					 (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
+					 PAGE_SIZE);
 
 #ifdef CONFIG_DEBUG_VM
 	{
@@ -1933,8 +1945,8 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			anon_cost += mz->lruvec.anon_cost;
 			file_cost += mz->lruvec.file_cost;
 		}
-		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
-		seq_buf_printf(s, "file_cost %lu\n", file_cost);
+		memcg_seq_buf_print_stat(s, NULL, "anon_cost", ' ', (u64)anon_cost);
+		memcg_seq_buf_print_stat(s, NULL, "file_cost", ' ', (u64)file_cost);
 	}
 #endif
 }
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..b1015cbe858f 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -4,6 +4,7 @@
 #define __MM_MEMCONTROL_V1_H
 
 #include <linux/cgroup-defs.h>
+#include <linux/seq_buf.h>
 
 /* Cgroup v1 and v2 common declarations */
 
@@ -33,6 +34,9 @@ int memory_stat_show(struct seq_file *m, void *v);
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
 
+void memcg_seq_buf_print_stat(struct seq_buf *s, const char *prefix,
+			      const char *name, char sep, u64 val);
+
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f43b7e5f71..136c08462cd1 100644
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
@@ -1460,6 +1461,53 @@ static bool memcg_accounts_hugetlb(void)
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
+/* Max 2^64 - 1 = 18446744073709551615 (20 digits) */
+#define MEMCG_DEC_U64_MAX_LEN 20
+
+/**
+ * memcg_seq_buf_print_stat - Write a name-value pair to a seq_buf with newline
+ * @s: The seq_buf to write to
+ * @prefix: Optional prefix string (can be NULL or "")
+ * @name: The name string to write
+ * @sep: Separator character between name and value (typically ' ' or '=')
+ * @val: The u64 value to write
+ *
+ * This helper efficiently formats and writes "<prefix><name><sep><value>\n"
+ * to a seq_buf. It manually converts the value to a string using num_to_str
+ * and embeds the separator and newline in the buffer to minimize function
+ * calls for better performance.
+ *
+ * The function checks for overflow at each step and returns early if any
+ * operation would cause the buffer to overflow.
+ *
+ * Example: memcg_seq_buf_print_stat(s, "total_", "cache", ' ', 1048576)
+ *          Output: "total_cache 1048576\n"
+ */
+void memcg_seq_buf_print_stat(struct seq_buf *s, const char *prefix,
+			      const char *name, char sep, u64 val)
+{
+	char num_buf[MEMCG_DEC_U64_MAX_LEN + 2];  /* +2 for separator and newline */
+	int num_len;
+
+	/* Embed separator at the beginning */
+	num_buf[0] = sep;
+
+	/* Convert number starting at offset 1 */
+	num_len = num_to_str(num_buf + 1, sizeof(num_buf) - 2, val, 0);
+	if (num_len <= 0)
+		return;
+
+	/* Embed newline at the end */
+	num_buf[num_len + 1] = '\n';
+
+	if (prefix && *prefix && seq_buf_puts(s, prefix))
+		return;
+	if (seq_buf_puts(s, name))
+		return;
+	/* Output separator, value, and newline in one call */
+	seq_buf_putmem(s, num_buf, num_len + 2);
+}
+
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
@@ -1485,26 +1533,26 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			continue;
 #endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
+		memcg_seq_buf_print_stat(s, NULL, memory_stats[i].name, ' ', size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(s, "slab %llu\n", size);
+			memcg_seq_buf_print_stat(s, NULL, "slab", ' ', size);
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
+	memcg_seq_buf_print_stat(s, NULL, "pgscan", ' ',
+				 memcg_events(memcg, PGSCAN_KSWAPD) +
+				 memcg_events(memcg, PGSCAN_DIRECT) +
+				 memcg_events(memcg, PGSCAN_PROACTIVE) +
+				 memcg_events(memcg, PGSCAN_KHUGEPAGED));
+	memcg_seq_buf_print_stat(s, NULL, "pgsteal", ' ',
+				 memcg_events(memcg, PGSTEAL_KSWAPD) +
+				 memcg_events(memcg, PGSTEAL_DIRECT) +
+				 memcg_events(memcg, PGSTEAL_PROACTIVE) +
+				 memcg_events(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
 #ifdef CONFIG_MEMCG_V1
@@ -1512,9 +1560,9 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
 #endif
-		seq_buf_printf(s, "%s %lu\n",
-			       vm_event_name(memcg_vm_event_stat[i]),
-			       memcg_events(memcg, memcg_vm_event_stat[i]));
+		memcg_seq_buf_print_stat(s, NULL,
+					 vm_event_name(memcg_vm_event_stat[i]), ' ',
+					 memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
 }
 
@@ -4544,7 +4592,12 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 		if (memory_stats[i].idx >= NR_VM_NODE_STAT_ITEMS)
 			continue;
 
-		seq_printf(m, "%s", memory_stats[i].name);
+		/*
+		 * Output format: "stat_name N0=value0 N1=value1 ...\n"
+		 * Use seq_puts and seq_put_decimal_ull to avoid printf
+		 * format parsing overhead in this hot path.
+		 */
+		seq_puts(m, memory_stats[i].name);
 		for_each_node_state(nid, N_MEMORY) {
 			u64 size;
 			struct lruvec *lruvec;
@@ -4552,7 +4605,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 			size = lruvec_page_state_output(lruvec,
 							memory_stats[i].idx);
-			seq_printf(m, " N%d=%llu", nid, size);
+			seq_put_decimal_ull(m, " N", nid);
+			seq_put_decimal_ull(m, "=", size);
 		}
 		seq_putc(m, '\n');
 	}
-- 
2.43.0


