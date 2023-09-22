Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBF7AAC8E
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 10:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjIVIZz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjIVIZy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 04:25:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EFA92
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 01:25:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d859ac9ea15so2739539276.2
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695371147; x=1695975947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hA6UCA+pZ5efAZZsDxOX7GRWmAIwRazdHR7qd0NBsLQ=;
        b=SQERdks0zi0PSIP41M1JAfs4srPJ3OG5AhWG8eQIg4LwH0qTgWWyzkYSrJw6FcYMZm
         dEiwXXeXIE6bkqzT0wNp8LakRHRz5+LAOMF4uthWy660XAFlvaPseJjcVcv7to9siRbt
         D/eFBvzFvz5976ts/5/GUazqJkQ2rFQXkLX9aKtFEPkOVfiVhQjI5how+beoc/QursBr
         XkswxWtZ/arxPCKw7y8aB3/FwBPzuo53tRbvA9fLK4rWQDEWkGkAZ7Pv0qF9qaaBQVZp
         Tq6fhLsD+B6kRtD3xj+kCw5OWXEyurDZK4MWs8v3UcB0C9gKPlU66qXFCY6nSGKI4GkI
         Zhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371147; x=1695975947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hA6UCA+pZ5efAZZsDxOX7GRWmAIwRazdHR7qd0NBsLQ=;
        b=ogTRINJxm+q6inw+TrdbUhebrNPnmRzzAdttq2znO0R+aCr3MiHaJSue/zgRYCLDxJ
         KNp5PuVWDImAvD9BBiz8ZqRbg3DIc5qpYkF75Mld5qeBdnwaCNBT6Shin5ezGlmg5nXS
         /uGJYZsUSY1zXeN1XJHCXtrnDnvzwu8aRw9tOriewbzb2kChpA+3YB/yKc2qy4WR74DT
         iuY4Qy+1z1CAQWN/eLtSi4HbTk7DV8B8PLBjG5VSvCxXoM+KrNBMhNdqwaOi4qtWzAA6
         MCFwNTBQucjDmq9rZ4EJgN1V8R7qKLITtgh2QZbDh4m9Bkf2yH1ottnnhjzQxO5FcDBH
         fvKA==
X-Gm-Message-State: AOJu0YydQcQR1ela2/PNuXs+hxls4CICpFBLza6cG2Oiw01t00fGgu9h
        1ePP6wXGfS8kVahA453CMGB1W2rZMyMFSJVH
X-Google-Smtp-Source: AGHT+IF9J46+ga8t43y1HWJEuqBoX35B757JKcac8X/f1AVgRTwmBgQww6zAvjp7qBOb/efgYTVzWDV31G7vl9VT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:ae66:0:b0:d7e:79c3:cd0b with SMTP
 id g38-20020a25ae66000000b00d7e79c3cd0bmr98381ybe.3.1695371147538; Fri, 22
 Sep 2023 01:25:47 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:25:41 +0000
In-Reply-To: <20230922082542.466579-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230922082542.466579-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922082542.466579-2-yosryahmed@google.com>
Subject: [PATCH 1/2] mm: memcg: refactor page state unit helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

memcg_page_state_unit() is currently used to identify the unit of a
memcg state item so that all stats in memory.stat are in bytes. However,
it lies about the units of WORKINGSET_* stats. These stats actually
represent pages, but we present them to userspace as a scalar number of
events. In retrospect, maybe those stats should have been memcg "events"
rather than memcg "state".

In preparation for using memcg_page_state_unit() for other purposes that
need to know the truthful units of different stat items, break it down
into two helpers:
- memcg_page_state_unit() retuns the actual unit of the item.
- memcg_page_state_output_unit() returns the unit used for output.

Use the latter instead of the former in memcg_page_state_output() and
lruvec_page_state_output(). While we are at it, let's show cgroup v1
some love and add memcg_page_state_local_output() for consistency.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a4d3282493b6..683aa8405c22 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1533,7 +1533,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
 };
 
-/* Translate stat items to the correct unit for memory.stat output */
+/* The actual unit of the state item, not the same as the output unit */
 static int memcg_page_state_unit(int item)
 {
 	switch (item) {
@@ -1541,6 +1541,22 @@ static int memcg_page_state_unit(int item)
 	case MEMCG_ZSWAP_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
+		return 1;
+	case NR_KERNEL_STACK_KB:
+		return SZ_1K;
+	default:
+		return PAGE_SIZE;
+	}
+}
+
+/* Translate stat items to the correct unit for memory.stat output */
+static int memcg_page_state_output_unit(int item)
+{
+	/*
+	 * Workingset state is actually in pages, but we export it to userspace
+	 * as a scalar count of events, so special case it here.
+	 */
+	switch (item) {
 	case WORKINGSET_REFAULT_ANON:
 	case WORKINGSET_REFAULT_FILE:
 	case WORKINGSET_ACTIVATE_ANON:
@@ -1549,17 +1565,23 @@ static int memcg_page_state_unit(int item)
 	case WORKINGSET_RESTORE_FILE:
 	case WORKINGSET_NODERECLAIM:
 		return 1;
-	case NR_KERNEL_STACK_KB:
-		return SZ_1K;
 	default:
-		return PAGE_SIZE;
+		return memcg_page_state_unit(item);
 	}
 }
 
 static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 						    int item)
 {
-	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
+	return memcg_page_state(memcg, item) *
+		memcg_page_state_output_unit(item);
+}
+
+static inline unsigned long memcg_page_state_local_output(
+		struct mem_cgroup *memcg, int item)
+{
+	return memcg_page_state_local(memcg, item) *
+		memcg_page_state_output_unit(item);
 }
 
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
@@ -4100,9 +4122,8 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
-		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
-			   nr * memcg_page_state_unit(memcg1_stats[i]));
+		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
+		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
@@ -4131,9 +4152,9 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
-		nr = memcg_page_state(memcg, memcg1_stats[i]);
+		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
 		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
-			   (u64)nr * memcg_page_state_unit(memcg1_stats[i]));
+			       (u64)nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
@@ -6609,7 +6630,8 @@ static int memory_stat_show(struct seq_file *m, void *v)
 static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
 						     int item)
 {
-	return lruvec_page_state(lruvec, item) * memcg_page_state_unit(item);
+	return lruvec_page_state(lruvec, item) *
+		memcg_page_state_output_unit(item);
 }
 
 static int memory_numa_stat_show(struct seq_file *m, void *v)
-- 
2.42.0.515.g380fc7ccd1-goog

