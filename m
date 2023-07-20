Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59B675A751
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 09:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGTHJH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGTHIr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 03:08:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4526A6
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5cea5773e8so463180276.1
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836919; x=1692428919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhI2s0e+GIGqReCnHtRMQPrzSnIqjbw1XBQvBPYjKY0=;
        b=oBM+gyrvc4kZmfzCDqqW014mddb+6ng6aUJcvm1PGzKPmmatk8vBmxnaO+jvawg8Cc
         cf0h8c+uRGKv+PpUjZOjju465YCs/RMkGS7FOfpfBg905u8KA48PZPv9pv5l5xU64hAu
         RRIbJwf2dG4G9KtiFyA18EerxfR/ghn9NkJLcaUskUA8yTC4t3T0XaugdSZxINO7vhKx
         oM7NXvmkzb7JDGBaiO8CTn60src/z33GmAEJWb+ZSh6IMofXorSGDhYJD6lnOVdfNi/O
         3BRMWtylTLjUhnMgpCj7SaSMPCTWyEH1d0Cr6gcddMeYKbX7Wxwr5jKmhdVPpppLRUDQ
         nHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836919; x=1692428919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhI2s0e+GIGqReCnHtRMQPrzSnIqjbw1XBQvBPYjKY0=;
        b=juqy2DU/RdbqaJ62Sk/v1sPnj5EiW9zZ9x6EdYHZThNn2fDPeEZO9JYkcYkQypHmDx
         9ZeRSipDz5DuvmLHKGmmIHy0wcktUMiSW+eQvH09ZhWERbdPhBDtrrdd3kBCfidRlNNu
         66kX+jnbBnZX8gpiKc/K3UNvFk7rYCA2lw4e7ggXg7XA68jvTeEPSIe+mKhFNhIuBrmj
         VImQ+QM//Ze/JC9z/A8gqqIrGs7WwTPh9rh7gQXq2FjWukU61RXhTwPm6IxwuSqrr3T/
         m8++URWk/Ra0ghd+QNM9RO6fBBbJxRGRd6JK9wfrLTmHY6kja53ezRQLLd69eh+lcm6N
         J2Sw==
X-Gm-Message-State: ABy/qLaendsp5J17WSWLBrG1jqj3b0VHw9fSYcJMm309x2VTXKuVSv4L
        nysWW4iH1hkfMCeNUUKHw50e2AaV7nVpq4x9
X-Google-Smtp-Source: APBJJlF2n+4mQLRSUDirJE55LlRkKhJrzGh/hC5rHcN/nPwLMBMZVZTXUQayuWTk1KX2FFq+vwWoN66wVm+m0JP7
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:ab04:0:b0:bfe:ea69:91b4 with SMTP
 id u4-20020a25ab04000000b00bfeea6991b4mr36455ybi.4.1689836919167; Thu, 20 Jul
 2023 00:08:39 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:23 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-7-yosryahmed@google.com>
Subject: [RFC PATCH 6/8] memcg: add stats for offline memcgs recharging
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

Add vm events for scanning pages for recharge, successfully recharging
pages, and cancelling a recharge due to failure to charge the target
memcg.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/vm_event_item.h | 5 +++++
 mm/memcontrol.c               | 6 ++++++
 mm/vmstat.c                   | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..cd80c00c50c2 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -60,6 +60,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PAGEOUTRUN, PGROTATED,
 		DROP_PAGECACHE, DROP_SLAB,
 		OOM_KILL,
+#ifdef CONFIG_MEMCG
+		RECHARGE_PGSCANNED,
+		RECHARGE_PGMOVED,
+		RECHARGE_PGCANCELLED,
+#endif
 #ifdef CONFIG_NUMA_BALANCING
 		NUMA_PTE_UPDATES,
 		NUMA_HUGE_PTE_UPDATES,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cf9fb51ecfcc..2fe9c6f1be80 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6394,6 +6394,8 @@ static bool mem_cgroup_recharge_folio(struct folio *folio,
 				      old_memcg, new_memcg);
 	cancel_charge(err ? new_memcg : old_memcg, nr_pages);
 out:
+	count_vm_events(err ? RECHARGE_PGCANCELLED : RECHARGE_PGMOVED,
+			nr_pages);
 	return err == 0;
 }
 
@@ -6469,6 +6471,7 @@ static bool memcg_recharge_lruvec_list(struct lruvec *lruvec,
 	int isolated_idx = NR_ISOLATED_ANON + is_file_lru(lru);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long *nr_recharged = arg;
+	unsigned long nr_scanned = 0;
 	unsigned long nr_staged = 0;
 	LIST_HEAD(folios_skipped);
 	LIST_HEAD(folios_staged);
@@ -6505,6 +6508,7 @@ static bool memcg_recharge_lruvec_list(struct lruvec *lruvec,
 			continue;
 		}
 
+		nr_scanned += folio_nr_pages(folio);
 		if (unlikely(!folio_try_get(folio))) {
 			list_move(&folio->lru, &folios_skipped);
 			continue;
@@ -6543,6 +6547,7 @@ static bool memcg_recharge_lruvec_list(struct lruvec *lruvec,
 	}
 	mem_cgroup_end_move_charge(memcg);
 	mod_lruvec_state(lruvec, isolated_idx, -nr_staged);
+	count_vm_events(RECHARGE_PGSCANNED, nr_scanned);
 	return false;
 }
 
@@ -6679,6 +6684,7 @@ void folio_memcg_deferred_recharge(struct folio *folio)
 	if (unlikely(!memcg_recharge_wq))
 		return;
 
+	count_vm_events(RECHARGE_PGSCANNED, folio_nr_pages(folio));
 	if (unlikely(!folio_try_get(folio)))
 		return;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b731d57996c5..e425a1aa7890 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1303,7 +1303,11 @@ const char * const vmstat_text[] = {
 	"drop_pagecache",
 	"drop_slab",
 	"oom_kill",
-
+#ifdef CONFIG_MEMCG
+	"recharge_pgs_scanned",
+	"recharge_pgs_moved",
+	"recharge_pgs_cancelled",
+#endif
 #ifdef CONFIG_NUMA_BALANCING
 	"numa_pte_updates",
 	"numa_huge_pte_updates",
-- 
2.41.0.255.g8b1d071c50-goog

