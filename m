Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDC78BB88
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjH1Xdy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjH1Xd3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 19:33:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F0129
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 16:33:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d78406dee59so3946693276.0
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693265606; x=1693870406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5n9hS9q/cqFV2qh34A2AZEA4DGYELaonjfoFoCAI8g=;
        b=sSpYPt7rKW3DtUM15JcLQJplUoRrPMx95M/aXCWUkUGG4gZ450QgwVE4yFUm7CogQH
         zFv9UI4D9YSxvW6bodhDxj3Ik66YmhEKFtQN01JiGkk9R6pRwoVFGBpQEhzaG5mXyhg+
         7vKrj39/+K2fsqeCBVG9cqcEQsLe/O8dA6loSupqE+p8mxgQd1Y/Cch38q9mTgfWAdOU
         Mi/PT8DoWdqlQunEGCPiAM+0xArU4vTZKSIUUhJFt8vF/ApSZdUHhIi/YFoCfVUArao7
         1xkMsp1FV1LDKVh9Dm5/i7gS4Zp0X1DnugiYstil6izVooJ18sBWRLBaLBmogvidXImj
         ZLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265606; x=1693870406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5n9hS9q/cqFV2qh34A2AZEA4DGYELaonjfoFoCAI8g=;
        b=RF/PVYYgrmHHbHnWrt3AVOJlIHVDdREYBNnMqdKjlSUZz+tY0AXq5O0F4cHVhxJm9n
         T8dsY+EMrF/iQL8LZzTUPQqkj0KYeHdXaZAu4Ru33yoo3EXrITZOPZqbgjAkp+yYwelI
         G+Y18Bs5W/yeZgOqzR2rbXD6UMbdt89P03BHjNp7DO9N/gj26MQVYSk0A76U0hH+Vc9e
         U2W8/nhQxd1tRl3860FeiBx2r5dg01da+t9WYLwiioYp2boDCXWCs+Ks9j7i2Xma0H2U
         U3xP9GS3XaAHH8flGbLl6kJu3CD0X6THiSIwVXM9QoGMp/lAJ89sdMZ1dRFhWuPKUn2O
         fFxQ==
X-Gm-Message-State: AOJu0YxRBlo6LrZdP/fwrUsfU9pYpjwF7BNXDu9dyofjH9RUgo6jzNhP
        dzfhQCHjnvdnlFnO0pAr4ANQYXrVpFRmuCOe
X-Google-Smtp-Source: AGHT+IHgw1Dv81YEOafHari2+haF5L0KUBFcH2n6KPrSQNlL17+4o9VM2wgivkwVdbEOE7or4T1k1wZFPbeokEu2
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1788:b0:d78:3a29:214f with
 SMTP id ca8-20020a056902178800b00d783a29214fmr506633ybb.10.1693265605965;
 Mon, 28 Aug 2023 16:33:25 -0700 (PDT)
Date:   Mon, 28 Aug 2023 23:33:16 +0000
In-Reply-To: <20230828233319.340712-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230828233319.340712-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828233319.340712-3-yosryahmed@google.com>
Subject: [PATCH v2 2/4] mm: memcg: add a helper for non-unified stats flushing
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0.rc2.253.gd59a3bf2b4-goog

