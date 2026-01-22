Return-Path: <cgroups+bounces-13366-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCeIM6IdcmmPdQAAu9opvQ
	(envelope-from <cgroups+bounces-13366-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 13:52:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFD66E35
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 13:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6B5E724623
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0C428497;
	Thu, 22 Jan 2026 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPBW2PiO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA293D411F
	for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082177; cv=none; b=JFqxYh1+vrjLBhiURy5LrQqF2SqVOOWDXD02hb6zRuix3yrmWo3NByplvWUeCVch7k19LTysDKofOzyl1Q4ArnPl/9PWIujbCc4HQbBK9QQH4STTNbF7Cy47GqWnEhXBESmwqkFMrX76dAOqbWVT8/Tt8yzTgIhhf2mGB1WfJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082177; c=relaxed/simple;
	bh=qygCWc+YjOcuhgl8uRwQkljDev/Ho6POeyL+Pd79wLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUTQzoJ6Y5VIhplm4tB5BCXlGMsi7vN6bQ9KTGU+Zr+cPfcFzfi3io7E9klAdHyaehxY/qWOr2UodiE4bkoZSHTsxgkgaw2aRze5KghpHL/sgr5Hd/JYtLdJLSWUjHv+uTpmx4NGjCvloZcc8PBCFsWSAWXOr1wokkzB5XvTC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPBW2PiO; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c635559e1c3so37463a12.0
        for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 03:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769082175; x=1769686975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okI60bxoR/3oEcZE7d2ieJqi+BFEqBLMAZE9UaRBOF0=;
        b=OPBW2PiOmYRQCoNy3d/J6CxEyPuqFGDCfGC35eui1Qr9wul0hJDK4bQj6n35p+c9Qa
         kY1S5CVCESLRbh8qYBYF7G44Eb3i2zGUK+nR3Zg/7/Zgd3bUOUd8yk8a8V+JwMeYTCmV
         U3nEk4Ng5hwopsBlXOHlF1kB4lY0lpbwEE4i2H9ufmll6iBy98hHzpL7Yh6pvzfWGQbN
         jfHGtC8XVXW/YJr5RfkhwBdbHdV4Lsw2ZSX+Cy2OTPuMk0ockaQu/jvp+E/qhBtinlDJ
         fWloE6N5iL6Li5yUOkIyaDRX+82D/6hNwGA53Rudtp7Ch9QDlkg7ggt++Z2xPQYsbabK
         yIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082175; x=1769686975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okI60bxoR/3oEcZE7d2ieJqi+BFEqBLMAZE9UaRBOF0=;
        b=bBgEP+1weDHlhPNCQCZMm3QJ8NEpe4X8EcsdKCLgWqTNesdlQRml7L9IkPVema9sEJ
         tujQZRn5N8tr8zJi5wwWC6D3MWGZj4+lR9lKN8KQnwP/NvnYPha21Gl/hOa6IJ7VWgrP
         DqR5Y6qQ6WwmNpvi/G5Tdyu6S6yVXwf+E9XNz8FPuO3UavfVeeTVIVkI/l7/ZCPR4VdS
         sLFiSHjcyQIcSdxEJO0hD6qc7IP3uDnu7cFcArn8JyBTYMsXsTz+U4wf2QJD92SHOl1P
         UgLKO6eLnOe9DfBB5P93ILDazkHK2VMYwHBpjkQszGHUCSjpl4tRVbLJLfXUfuJ8U7kq
         HRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUKu7BrNTwtoTik3O//s/xgIjHO4ubPvY64PhmLp/D5FBZZDcYWlF844dD0gV09wJA8peo+nwy0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/n6gVOASR2+u+wMYY5m9WRLRWMhMANOSF/6pJXtT7iOUpHu38
	CQScQnTDA+SyuKaKBYH5X/avXuMHYBz/F31AI1bhfBya/Lq9fUckmrZ+
X-Gm-Gg: AZuq6aLH48Fkf76SKZFcIQ4YU3TgXsiyn7RFYJ4nsTOhuSFL+M52VOsDXul1If+1bT6
	N9XhMYPqhkx2gCpV+Aa0QyFtZmPBo7ULbP0+r2QbyZHZRVr03eKgXatyPmKdMXWWcwnu4b3Gk0T
	gMEZVWNoR1YyLQk1VSbc2JrAVXeD9bQeHc9vhX4EUIgAhr8T83oeza1ytQbk/hOPY3u1XDP3+Np
	BGKusS0XlwiuzA91AMJJpO+04yWRPgGGMA6Dwhyd1OTcgtAiOLj2Tk5AFd34RzVfpvxk2uGefIZ
	SNWgYBKB5pN6yA/OeB8V566qeN8hOIOGdRhSLjDHr3Hb4kqOwmnqz53pMbBVDgqG3Nhkspj2EfZ
	V5Nba3K7iyclg39as7JIvYGCl0hf8hkU0Mpss9FSNm+hNs5bdvvctmAPmerAxd2g01XLf0eVLTf
	rWogXLSBRfWUUYCAgrtnBhWA+05y8=
X-Received: by 2002:a17:903:985:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2a7d2f1fcc4mr28151765ad.7.1769082174575;
        Thu, 22 Jan 2026 03:42:54 -0800 (PST)
Received: from NV-J4GCB44.nvidia.com ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a773d4e5basm74393005ad.94.2026.01.22.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:42:53 -0800 (PST)
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
	Jianyue Wu <wujianyue000@gmail.com>
Subject: [PATCH v3] mm: optimize stat output for 11% sys time reduce
Date: Thu, 22 Jan 2026 19:42:42 +0800
Message-ID: <20260122114242.72139-1-wujianyue000@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260110042249.31960-1-jianyuew@nvidia.com>
References: <20260110042249.31960-1-jianyuew@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13366-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 76DFD66E35
X-Rspamd-Action: no action

Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
printf parsing in memcg stats output.

Key changes:
- Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
- Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatting
- Update __memory_events_show(), swap_events_show(),
  memory_stat_format(), memory_numa_stat_show(), and related helpers
- Introduce local variables to improve readability and reduce line length

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

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---

Hi Shakeel,

Thanks for the review! I've addressed your comments in v3 by moving the
helper functions to memcontrol.c and adding kernel-doc documentation.

Thanks,
Jianyue

Changes in v3:
- Move memcg_seq_put_name_val() and memcg_seq_buf_put_name_val() from
  header (inline) to memcontrol.c and add kernel-doc documentation
  (Suggested by Shakeel Butt)

Changes in v2:
- Initial version with performance optimization

 mm/memcontrol-v1.c | 120 +++++++++++++++++++++------------
 mm/memcontrol-v1.h |   6 ++
 mm/memcontrol.c    | 162 ++++++++++++++++++++++++++++++++++-----------
 3 files changed, 205 insertions(+), 83 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..482475333876 100644
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
@@ -1795,25 +1795,36 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	mem_cgroup_flush_stats(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-		seq_printf(m, "%s=%lu", stat->name,
-			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-						   false));
-		for_each_node_state(nid, N_MEMORY)
-			seq_printf(m, " N%d=%lu", nid,
-				   mem_cgroup_node_nr_lru_pages(memcg, nid,
-							stat->lru_mask, false));
+		u64 nr_pages;
+
+		seq_puts(m, stat->name);
+		nr_pages = mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+						   false);
+		seq_put_decimal_ull(m, "=", nr_pages);
+		for_each_node_state(nid, N_MEMORY) {
+			nr_pages = mem_cgroup_node_nr_lru_pages(memcg, nid,
+								stat->lru_mask,
+								false);
+			seq_put_decimal_ull(m, " N", nid);
+			seq_put_decimal_ull(m, "=", nr_pages);
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
+		u64 nr_pages;
+
+		seq_puts(m, "hierarchical_");
+		seq_puts(m, stat->name);
+		nr_pages = mem_cgroup_nr_lru_pages(memcg, stat->lru_mask, true);
+		seq_put_decimal_ull(m, "=", nr_pages);
+		for_each_node_state(nid, N_MEMORY) {
+			nr_pages = mem_cgroup_node_nr_lru_pages(memcg, nid,
+								stat->lru_mask,
+								true);
+			seq_put_decimal_ull(m, " N", nid);
+			seq_put_decimal_ull(m, "=", nr_pages);
+		}
 		seq_putc(m, '\n');
 	}
 
@@ -1870,6 +1881,7 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	unsigned long memory, memsw;
 	struct mem_cgroup *mi;
 	unsigned int i;
+	u64 memory_limit, memsw_limit;
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
@@ -1879,17 +1891,24 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		unsigned long nr;
 
 		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
+		memcg_seq_buf_put_name_val(s, memcg1_stat_names[i], (u64)nr);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
-			       memcg_events_local(memcg, memcg1_events[i]));
+	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++) {
+		u64 events;
 
-	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
-			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+		events = memcg_events_local(memcg, memcg1_events[i]);
+		memcg_seq_buf_put_name_val(s, vm_event_name(memcg1_events[i]),
+					   events);
+	}
+
+	for (i = 0; i < NR_LRU_LISTS; i++) {
+		u64 nr_pages;
+
+		nr_pages = memcg_page_state_local(memcg, NR_LRU_BASE + i) *
+			   PAGE_SIZE;
+		memcg_seq_buf_put_name_val(s, lru_list_name(i), nr_pages);
+	}
 
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
@@ -1897,28 +1916,38 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		memory = min(memory, READ_ONCE(mi->memory.max));
 		memsw = min(memsw, READ_ONCE(mi->memsw.max));
 	}
-	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
-		       (u64)memory * PAGE_SIZE);
-	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
-		       (u64)memsw * PAGE_SIZE);
+	memory_limit = (u64)memory * PAGE_SIZE;
+	memsw_limit = (u64)memsw * PAGE_SIZE;
+
+	memcg_seq_buf_put_name_val(s, "hierarchical_memory_limit",
+				   memory_limit);
+	memcg_seq_buf_put_name_val(s, "hierarchical_memsw_limit",
+				   memsw_limit);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
 		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
-			       (u64)nr);
+		seq_buf_puts(s, "total_");
+		memcg_seq_buf_put_name_val(s, memcg1_stat_names[i], (u64)nr);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++) {
+		u64 events;
+
+		events = memcg_events(memcg, memcg1_events[i]);
+		seq_buf_puts(s, "total_");
+		memcg_seq_buf_put_name_val(s, vm_event_name(memcg1_events[i]),
+					   events);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "total_%s %llu\n",
-			       vm_event_name(memcg1_events[i]),
-			       (u64)memcg_events(memcg, memcg1_events[i]));
+	for (i = 0; i < NR_LRU_LISTS; i++) {
+		u64 nr_pages;
 
-	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
-			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+		nr_pages = memcg_page_state(memcg, NR_LRU_BASE + i) * PAGE_SIZE;
+		seq_buf_puts(s, "total_");
+		memcg_seq_buf_put_name_val(s, lru_list_name(i), nr_pages);
+	}
 
 #ifdef CONFIG_DEBUG_VM
 	{
@@ -1933,8 +1962,8 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
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
@@ -1968,11 +1997,14 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
+	u64 oom_kill;
+
+	memcg_seq_put_name_val(sf, "oom_kill_disable",
+			       READ_ONCE(memcg->oom_kill_disable));
+	memcg_seq_put_name_val(sf, "under_oom", (bool)memcg->under_oom);
 
-	seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill_disable));
-	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
-	seq_printf(sf, "oom_kill %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
+	oom_kill = atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]);
+	memcg_seq_put_name_val(sf, "oom_kill", oom_kill);
 	return 0;
 }
 
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..46f198a81761 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -4,6 +4,9 @@
 #define __MM_MEMCONTROL_V1_H
 
 #include <linux/cgroup-defs.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/sprintf.h>
 
 /* Cgroup v1 and v2 common declarations */
 
@@ -33,6 +36,9 @@ int memory_stat_show(struct seq_file *m, void *v);
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
 
+void memcg_seq_put_name_val(struct seq_file *m, const char *name, u64 val);
+void memcg_seq_buf_put_name_val(struct seq_buf *s, const char *name, u64 val);
+
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f43b7e5f71..0bc244c5a570 100644
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
@@ -1460,9 +1461,70 @@ static bool memcg_accounts_hugetlb(void)
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
+/* Max 2^64 - 1 = 18446744073709551615 (20 digits) */
+#define MEMCG_DEC_U64_MAX_LEN 20
+
+/**
+ * memcg_seq_put_name_val - Write a name-value pair to a seq_file
+ * @m: The seq_file to write to
+ * @name: The name string (not null-terminated required, uses seq_puts)
+ * @val: The u64 value to write
+ *
+ * This helper formats and writes a "name value\n" line to a seq_file,
+ * commonly used for cgroup statistics output. The value is efficiently
+ * converted to decimal using seq_put_decimal_ull.
+ *
+ * Output format: "<name> <value>\n"
+ * Example: "anon 1048576\n"
+ */
+void memcg_seq_put_name_val(struct seq_file *m, const char *name, u64 val)
+{
+	seq_puts(m, name);
+	/* need a space between name and value */
+	seq_put_decimal_ull(m, " ", val);
+	seq_putc(m, '\n');
+}
+
+/**
+ * memcg_seq_buf_put_name_val - Write a name-value pair to a seq_buf
+ * @s: The seq_buf to write to
+ * @name: The name string to write
+ * @val: The u64 value to write
+ *
+ * This helper formats and writes a "name value\n" line to a seq_buf.
+ * Unlike memcg_seq_put_name_val which uses seq_file's built-in formatting,
+ * this function manually converts the value to a string using num_to_str
+ * and writes it using seq_buf primitives for better performance when
+ * batching multiple writes to a seq_buf.
+ *
+ * The function checks for overflow at each step and returns early if
+ * any operation would cause the buffer to overflow.
+ *
+ * Output format: "<name> <value>\n"
+ * Example: "file 2097152\n"
+ */
+void memcg_seq_buf_put_name_val(struct seq_buf *s, const char *name, u64 val)
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
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
+	u64 pgscan, pgsteal;
 
 	/*
 	 * Provide statistics on the state of the memory subsystem as
@@ -1485,36 +1547,40 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
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
+	pgscan = memcg_events(memcg, PGSCAN_KSWAPD) +
+		 memcg_events(memcg, PGSCAN_DIRECT) +
+		 memcg_events(memcg, PGSCAN_PROACTIVE) +
+		 memcg_events(memcg, PGSCAN_KHUGEPAGED);
+	pgsteal = memcg_events(memcg, PGSTEAL_KSWAPD) +
+		  memcg_events(memcg, PGSTEAL_DIRECT) +
+		  memcg_events(memcg, PGSTEAL_PROACTIVE) +
+		  memcg_events(memcg, PGSTEAL_KHUGEPAGED);
+
+	memcg_seq_buf_put_name_val(s, "pgscan", pgscan);
+	memcg_seq_buf_put_name_val(s, "pgsteal", pgsteal);
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
+		u64 events;
+
 #ifdef CONFIG_MEMCG_V1
 		if (memcg_vm_event_stat[i] == PGPGIN ||
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
 #endif
-		seq_buf_printf(s, "%s %lu\n",
-			       vm_event_name(memcg_vm_event_stat[i]),
-			       memcg_events(memcg, memcg_vm_event_stat[i]));
+		events = memcg_events(memcg, memcg_vm_event_stat[i]);
+		memcg_seq_buf_put_name_val(s,
+					   vm_event_name(memcg_vm_event_stat[i]),
+					   events);
 	}
 }
 
@@ -4218,10 +4284,12 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
 
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
@@ -4247,7 +4315,8 @@ static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
 	else
 		peak = max(fd_peak, READ_ONCE(pc->local_watermark));
 
-	seq_printf(sf, "%llu\n", peak * PAGE_SIZE);
+	seq_put_decimal_ull(sf, "", peak * PAGE_SIZE);
+	seq_putc(sf, '\n');
 	return 0;
 }
 
@@ -4480,16 +4549,24 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
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
+	u64 low, high, max, oom, oom_kill;
+	u64 oom_group_kill, sock_throttled;
+
+	low = atomic_long_read(&events[MEMCG_LOW]);
+	high = atomic_long_read(&events[MEMCG_HIGH]);
+	max = atomic_long_read(&events[MEMCG_MAX]);
+	oom = atomic_long_read(&events[MEMCG_OOM]);
+	oom_kill = atomic_long_read(&events[MEMCG_OOM_KILL]);
+	oom_group_kill = atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]);
+	sock_throttled = atomic_long_read(&events[MEMCG_SOCK_THROTTLED]);
+
+	memcg_seq_put_name_val(m, "low", low);
+	memcg_seq_put_name_val(m, "high", high);
+	memcg_seq_put_name_val(m, "max", max);
+	memcg_seq_put_name_val(m, "oom", oom);
+	memcg_seq_put_name_val(m, "oom_kill", oom_kill);
+	memcg_seq_put_name_val(m, "oom_group_kill", oom_group_kill);
+	memcg_seq_put_name_val(m, "sock_throttled", sock_throttled);
 }
 
 static int memory_events_show(struct seq_file *m, void *v)
@@ -4544,7 +4621,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 		if (memory_stats[i].idx >= NR_VM_NODE_STAT_ITEMS)
 			continue;
 
-		seq_printf(m, "%s", memory_stats[i].name);
+		seq_puts(m, memory_stats[i].name);
 		for_each_node_state(nid, N_MEMORY) {
 			u64 size;
 			struct lruvec *lruvec;
@@ -4552,7 +4629,10 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
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
@@ -4565,7 +4645,8 @@ static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", READ_ONCE(memcg->oom_group));
+	seq_put_decimal_ll(m, "", READ_ONCE(memcg->oom_group));
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -5372,13 +5453,15 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 static int swap_events_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	u64 swap_high, swap_max, swap_fail;
+
+	swap_high = atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]);
+	swap_max = atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]);
+	swap_fail = atomic_long_read(&memcg->memory_events[MEMCG_SWAP_FAIL]);
 
-	seq_printf(m, "high %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]));
-	seq_printf(m, "max %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
-	seq_printf(m, "fail %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_FAIL]));
+	memcg_seq_put_name_val(m, "high", swap_high);
+	memcg_seq_put_name_val(m, "max", swap_max);
+	memcg_seq_put_name_val(m, "fail", swap_fail);
 
 	return 0;
 }
@@ -5564,7 +5647,8 @@ static int zswap_writeback_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
+	seq_put_decimal_ll(m, "", READ_ONCE(memcg->zswap_writeback));
+	seq_putc(m, '\n');
 	return 0;
 }
 
-- 
2.43.0


