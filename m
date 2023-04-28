Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2106F1952
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjD1NYU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbjD1NYP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 09:24:15 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDBD211E
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:24:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51b4a13a49fso5910676a12.1
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682688254; x=1685280254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCrHQjiS2fwiby7dz0V9ThMkUe63uEws1Bin2T2dpU8=;
        b=jcuVTOAp1c8K+ch7YCMLi+8POwhTwb1WrUalORmat2684E/X82MLP/H/sTNZiGTSzw
         ILJbHonyleAOPNozrhCp7XJpKzpTbzSV2WanXyhxQyxv5lSFZW8pMKziOeeK25UM/lM3
         JtO2LiFUAPtV+zJkr/lmiV+hDnMAOdwrsD7W9rNnMigwvNIYtIDxnNjAK3lyudpZp5yI
         5vpaP0vtG6m4sW2kgSy3vvkx/O8FeePG6gnTT8455Z1wkWEJFKZg0VnC7g7BQBECbTSk
         07ULhu3kIczPuOMcJkwFO/y0wcnsFUVJfVg87WLuR8H+9rMQZ0u8212WdRLWh+a/t1bT
         beJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688254; x=1685280254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCrHQjiS2fwiby7dz0V9ThMkUe63uEws1Bin2T2dpU8=;
        b=JAHAOtKpGKwhs7vfeb4tgCChtLuM9zoBt3hAsysvavU4ZAgkiGQm938kmSDGDSS7L3
         5AdE6mIdJPPJKC+dvWwQfkqyhveKA7lbo46hGec0iwl7mUIa7+tBPYMz1PB5iM6c0IMY
         P4El+CSxD1qOE6a0RMMizoI8blY9MgcOfN5+wMpQ1Ad9pL5YP1gotdGmuJsvH+7/1pim
         RFKcyx9qgKI5o66ylrXHH+wIpbedzCxAAGKrtT+QH5f+0eqi1ZjzXdDwvcrjVBS7jbak
         ztduoXneb5R+Dx3e4kqRPS0ir4XxrH9zlozXXXS0ziRv0/1FPfTyVLSt3mByLM4R1ifs
         g7gQ==
X-Gm-Message-State: AC+VfDxiCSmTYvwyPjGZP7W8WanA4furQWOIo4g5pGlST3UTci276s6R
        GT3z2YD9SN0aCkhyhEoX6lehTWHzo6Q1REk6
X-Google-Smtp-Source: ACHHUZ6Q1iaeTMc7znbuRU46RBkgJ3r/GzmuoUGlNK1hEg/1kqgAXN7zKR88/FXgEDBYkLlt9aTGSyL2pZdAjcsz
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:b289:b0:19f:1d62:4393 with SMTP
 id u9-20020a170902b28900b0019f1d624393mr1511380plr.7.1682688253988; Fri, 28
 Apr 2023 06:24:13 -0700 (PDT)
Date:   Fri, 28 Apr 2023 13:24:06 +0000
In-Reply-To: <20230428132406.2540811-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230428132406.2540811-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428132406.2540811-3-yosryahmed@google.com>
Subject: [PATCH v2 2/2] memcg: dump memory.stat during cgroup OOM for v1
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
OOM") made sure we dump all the stats in memory.stat during a cgroup
OOM, but it also introduced a slight behavioral change. The code used to
print the non-hierarchical v1 cgroup stats for the entire cgroup
subtree, now it only prints the v2 cgroup stats for the cgroup under
OOM.

For cgroup v1 users, this introduces a few problems:
(a) The non-hierarchical stats of the memcg under OOM are no longer
shown.
(b) A couple of v1-only stats (e.g. pgpgin, pgpgout) are no longer
shown.
(c) We show the list of cgroup v2 stats, even in cgroup v1. This list of
stats is not tracked with v1 in mind. While most of the stats seem to be
working on v1, there may be some stats that are not fully or correctly
tracked.

Although OOM log is not set in stone, we should not change it for no
reason. When upgrading the kernel version to a version including
commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
OOM"), these behavioral changes are noticed in cgroup v1.

The fix is simple. Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat
during cgroup OOM") separated stats formatting from stats display for
v2, to reuse the stats formatting in the OOM logs. Do the same for v1.

Move the v2 specific formatting from memory_stat_format() to
memcg_stat_format(), add memcg1_stat_format() for v1, and make
memory_stat_format() select between them based on cgroup version.
Since memory_stat_show() now works for both v1 & v2, drop
memcg_stat_show().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 60 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5922940f92c9..2b492f8d540c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1551,7 +1551,7 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
-static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
+static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
 
@@ -1604,6 +1604,17 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }
 
+static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
+
+static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
+{
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		memcg_stat_format(memcg, s);
+	else
+		memcg1_stat_format(memcg, s);
+	WARN_ON_ONCE(seq_buf_has_overflowed(s));
+}
+
 #define K(x) ((x) << (PAGE_SHIFT-10))
 /**
  * mem_cgroup_print_oom_context: Print OOM information relevant to
@@ -4078,9 +4089,8 @@ static const unsigned int memcg1_events[] = {
 	PGMAJFAULT,
 };
 
-static int memcg_stat_show(struct seq_file *m, void *v)
+static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 	unsigned long memory, memsw;
 	struct mem_cgroup *mi;
 	unsigned int i;
@@ -4095,18 +4105,18 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-		seq_printf(m, "%s %lu\n", memcg1_stat_names[i],
+		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
 			   nr * memcg_page_state_unit(memcg1_stats[i]));
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_printf(m, "%s %lu\n", vm_event_name(memcg1_events[i]),
-			   memcg_events_local(memcg, memcg1_events[i]));
+		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
+			       memcg_events_local(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_printf(m, "%s %lu\n", lru_list_name(i),
-			   memcg_page_state_local(memcg, NR_LRU_BASE + i) *
-			   PAGE_SIZE);
+		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
+			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
+			       PAGE_SIZE);
 
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
@@ -4114,11 +4124,11 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		memory = min(memory, READ_ONCE(mi->memory.max));
 		memsw = min(memsw, READ_ONCE(mi->memsw.max));
 	}
-	seq_printf(m, "hierarchical_memory_limit %llu\n",
-		   (u64)memory * PAGE_SIZE);
+	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
+		       (u64)memory * PAGE_SIZE);
 	if (do_memsw_account())
-		seq_printf(m, "hierarchical_memsw_limit %llu\n",
-			   (u64)memsw * PAGE_SIZE);
+		seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
+			       (u64)memsw * PAGE_SIZE);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4126,19 +4136,19 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state(memcg, memcg1_stats[i]);
-		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
+		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
 			   (u64)nr * memcg_page_state_unit(memcg1_stats[i]));
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_printf(m, "total_%s %llu\n",
-			   vm_event_name(memcg1_events[i]),
-			   (u64)memcg_events(memcg, memcg1_events[i]));
+		seq_buf_printf(s, "total_%s %llu\n",
+			       vm_event_name(memcg1_events[i]),
+			       (u64)memcg_events(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_printf(m, "total_%s %llu\n", lru_list_name(i),
-			   (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
-			   PAGE_SIZE);
+		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
+			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
+			       PAGE_SIZE);
 
 #ifdef CONFIG_DEBUG_VM
 	{
@@ -4153,12 +4163,10 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 			anon_cost += mz->lruvec.anon_cost;
 			file_cost += mz->lruvec.file_cost;
 		}
-		seq_printf(m, "anon_cost %lu\n", anon_cost);
-		seq_printf(m, "file_cost %lu\n", file_cost);
+		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
+		seq_buf_printf(s, "file_cost %lu\n", file_cost);
 	}
 #endif
-
-	return 0;
 }
 
 static u64 mem_cgroup_swappiness_read(struct cgroup_subsys_state *css,
@@ -4998,6 +5006,8 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 }
 #endif
 
+static int memory_stat_show(struct seq_file *m, void *v);
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -5030,7 +5040,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
 	},
 	{
 		.name = "stat",
-		.seq_show = memcg_stat_show,
+		.seq_show = memory_stat_show,
 	},
 	{
 		.name = "force_empty",
-- 
2.40.1.495.gc816e09b53d-goog

