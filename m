Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4FE783480
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjHUUz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHUUzZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 16:55:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE3FA1
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 13:55:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bf58d92bd9so25510125ad.3
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692651323; x=1693256123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=II24bAIuGVg2YyiqwiCMReE2mVTE25qmDUAuXBGJ4Ok=;
        b=KmH6O0vZ9sBp7HHBae0PwJCnRa8ujSumjQ0AlsGJ1pi5KbQIxpyrvcCO0krC5ztY+u
         N8ljzGOzIX6jer2HV1GxzZPCURYnOZC6D1lrlNXbpCHNDpRJB0nITXoN0mon6iaCy4e1
         QkiLalZ25r1ZxplkbXN+NiDkoW8GDcA+Uj1Shac+wu5psshTskn8q8Lf6B5bKZffckoB
         jKrEuG2Vw03aNvOQfFER14s8IkriQqDS2U2JTgSKgCtg7TmcMJ9q3B18uyHoSMZM7lnj
         ioj21pXqwFO1fJbsQwZ0rFa+1Vc07Ob56riuci9Ea7Iw13vPBzZ96Hsd5+OoDw6zGDiR
         3h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692651323; x=1693256123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=II24bAIuGVg2YyiqwiCMReE2mVTE25qmDUAuXBGJ4Ok=;
        b=Q+LbWhzphmiVg8EsuOkMRYBIv7a9zskY51czE4V7ZEoqdEXenIGeF9yhLTWw15EFfJ
         M09C0wenkwRWR2Gs/D9bw94rE4iWAXMtnP1UjUDEAZz8BFISIu9bzx9W9hlQEIS4EOss
         YOnPxZu/FavnLXqfyPmNhFdyKiQOYgtXiR6GvUF+ZTC2sMa6s949hIR2bnDwJEhkKUWJ
         NgRYCgqwxPQNcGFBMz+K6T5ThIBUTdjw/4T1exGX5yxsutUMVP9BOaSXQPWRqUG641jc
         JL1W8RoS7qrsHPFNvgXc0gQ5jh4ClY6SgVQDG6yVlzFWwAllNREIm4k+hsqH1yZKAzdT
         Xk4w==
X-Gm-Message-State: AOJu0YzePSceOevFArSBTL6VI3QVl5y+lJdY+6owdNZq2okFo3+BT8x7
        Nsm4TU+3Fqnd1t4TjclhbgOfWWVAlInw/bJR
X-Google-Smtp-Source: AGHT+IEvQmiYC84sZKnE5YzQy6JNP4dH1ZNkD129Wrs7O1rPHJU5tveJ2ce7KEKHH/DtaNVXLSxePpzIYxXdsGad
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:eccc:b0:1b8:a555:385d with SMTP
 id a12-20020a170902eccc00b001b8a555385dmr3847926plh.9.1692651322749; Mon, 21
 Aug 2023 13:55:22 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:54:58 +0000
In-Reply-To: <20230821205458.1764662-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821205458.1764662-4-yosryahmed@google.com>
Subject: [PATCH 3/3] mm: memcg: use non-unified stats flushing for userspace reads
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Unified flushing allows for great concurrency for paths that attempt to
flush the stats, at the expense of potential staleness and a single
flusher paying the extra cost of flushing the full tree.

This tradeoff makes sense for in-kernel flushers that may observe high
concurrency (e.g. reclaim, refault). For userspace readers, stale stats
may be unexpected and problematic, especially when such stats are used
for critical paths such as userspace OOM handling. Additionally, a
userspace reader will occasionally pay the cost of flushing the entire
hierarchy, which also causes problems in some cases [1].

Opt userspace reads out of unified flushing. This makes the cost of
reading the stats more predictable (proportional to the size of the
subtree), as well as the freshness of the stats. Since userspace readers
are not expected to have similar concurrency to in-kernel flushers,
serializing them among themselves and among in-kernel flushers should be
okay.

This was tested on a machine with 256 cpus by running a synthetic test
The script that creates 50 top-level cgroups, each with 5 children (250
leaf cgroups). Each leaf cgroup has 10 processes running that allocate
memory beyond the cgroup limit, invoking reclaim (which is an in-kernel
unified flusher). Concurrently, one thread is spawned per-cgroup to read
the stats every second (including root, top-level, and leaf cgroups --
so total 251 threads). No regressions were observed in the total running
time; which means that non-unified userspace readers are not slowing
down in-kernel unified flushers:

Base (mm-unstable):

real	0m18.228s
user	0m9.463s
sys	60m15.879s

real	0m20.828s
user	0m8.535s
sys	70m12.364s

real	0m19.789s
user	0m9.177s
sys	66m10.798s

With this patch:

real	0m19.632s
user	0m8.608s
sys	64m23.483s

real	0m18.463s
user	0m7.465s
sys	60m34.089s

real	0m20.309s
user	0m7.754s
sys	68m2.392s

Additionally, the average latency for reading stats went from roughly
40ms to 5 ms, because we mostly read the stats of leaf cgroups in this
script, so we only have to flush one cgroup, instead of *sometimes*
flushing the entire tree with unified flushing.

[1]https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 90f08b35fa77..d3b13a06224c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1606,7 +1606,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_try_flush_stats();
+	do_stats_flush(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4048,7 +4048,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_try_flush_stats();
+	do_stats_flush(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4123,7 +4123,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_try_flush_stats();
+	do_stats_flush(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4625,7 +4625,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_try_flush_stats();
+	do_stats_flush(memcg);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6640,7 +6640,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_try_flush_stats();
+	do_stats_flush(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
-- 
2.42.0.rc1.204.g551eb34607-goog

