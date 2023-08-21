Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546A783489
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHUUzY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjHUUzY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 16:55:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7012D
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 13:55:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bf0b05bbbeso57706125ad.0
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692651320; x=1693256120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWXap7NsEgOymMxjxsCXNzpaZzVX2vYEXhkkwglYb2w=;
        b=BxE45txI7COiK2llaPLekWLKmnwKvbfF2s+ErO15DE6ofDgcY41orJSnC1lxnC5xSD
         ns0NI3CFDeBKOgHffDfz8J+snMVDi/Bm1Z7XQP+gB/BJurXrc210wa7+HakGaRIeyfrR
         gkyrBvxIdVL0w6/wEiEjuj80edhWhBOarSLoMLG6xilaOxakqnBgLMne6hlBqjVYfs4v
         ENXPjTfI0g332oAIouzQJ4gw4Eqbnd43rlLTg2T4GFT3PPeE9f1Qb7UfSFQpFlOSlXs8
         BweEjiJ9C0STVkzlpyv7rd/z4Ep9F8B9BTFfyXqsH3AJsnekq8bnFOZfOryTXvrS+E+8
         DCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692651320; x=1693256120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWXap7NsEgOymMxjxsCXNzpaZzVX2vYEXhkkwglYb2w=;
        b=N1TjBfXmX/SMIbUhUz43+4CuZKO4RV7OSDV5j9ToNjZuIE0H/cDJgh/WXHpopbtSH7
         rit8sj9L70eE9XSmYgXvzPz1Tl77DuqOreE9rcIpomre2gylijEgWy0TtfcYi11zG+26
         AUglXGM3/dTrje417sHFb+EFgxRcNLfT6dx4BSnp4R52UUJ8b+UIhKCgL0apR0pQbO2Z
         epauaB+55T6wHrL8PDa2EzZB0T6QIE+5aKRs8lRFSOayMMhbWuDVa/nVflCH2hUXXRmf
         YJtBUCdoUfSP9kFNTLCnRCFmCBqM3tWsbhfqFAVvg05xN2GhOqsj0o6/uJv+YbSrFR09
         1e2Q==
X-Gm-Message-State: AOJu0YzfXu3PxaPbLBbTOyih8jdLdOD34Ka5+agj1JjwfyZpU7105Ho7
        zhnpAjaJebNKCBmBi4FjY3mn6AEDqbxaEK2I
X-Google-Smtp-Source: AGHT+IFrW4DDu5hPoWYHSg5YRuSc/PnkgVYk/IScMtefDrv62gvp7vZ2XxWBYhOW7vd5z08FD5JBCBz/m5ZQr4DG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:2806:b0:1bc:5182:1ddb with SMTP
 id kp6-20020a170903280600b001bc51821ddbmr2949941plb.3.1692651320527; Mon, 21
 Aug 2023 13:55:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:54:57 +0000
In-Reply-To: <20230821205458.1764662-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821205458.1764662-3-yosryahmed@google.com>
Subject: [PATCH 2/3] mm: memcg: add a helper for non-unified stats flushing
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Some contexts flush memcg stats outside of unified flushing, directly
using cgroup_rstat_flush(). Add a helper for non-unified flushing, a
counterpart for do_unified_stats_flush(), and use it in those contexts,
as well as in do_unified_stats_flush() itself.

This abstracts the rstat API and makes it easy to introduce
modifications to either unified or non-unified flushing functions
without changing callers.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c6150ea54d48..90f08b35fa77 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -639,6 +639,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
+/*
+ * do_stats_flush - do a flush of the memory cgroup statistics
+ * @memcg: memory cgroup to flush
+ *
+ * Only flushes the subtree of @memcg, does not skip under any conditions.
+ */
+static void do_stats_flush(struct mem_cgroup *memcg)
+{
+	cgroup_rstat_flush(memcg->css.cgroup);
+}
+
 /*
  * do_unified_stats_flush - do a unified flush of memory cgroup statistics
  *
@@ -656,7 +667,7 @@ static void do_unified_stats_flush(void)
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 
-	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	do_stats_flush(root_mem_cgroup);
 
 	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
@@ -7790,7 +7801,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		cgroup_rstat_flush(memcg->css.cgroup);
+		do_stats_flush(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -7855,8 +7866,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
-	cgroup_rstat_flush(css->cgroup);
-	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	do_stats_flush(memcg);
+	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
 }
 
 static int zswap_max_show(struct seq_file *m, void *v)
-- 
2.42.0.rc1.204.g551eb34607-goog

