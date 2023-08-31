Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5A78F181
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbjHaQ4W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbjHaQ4W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 12:56:22 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC8185
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:19 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68a6cd7c6c0so1170545b3a.3
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500978; x=1694105778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnl+F2n1kOs4P011p6EJFvzkt9Ylx9T9gDi6gAnNyhk=;
        b=Y0oi2Z3Eialn+z2e/VxNA/wY4TjO2Jg+n7PCg7nqe2scLJlIjkDEQKaLeSUdSLbRkC
         xogZcgPCa4eZN1U3uA2KV041NQy5HRobTB/lIkg4XUqF9QEoh2oMVYTsz6hMuO+NVTdu
         1zn9rVUSES2xOhWecunHa/du1GzVi344f4kaDbI3wAxidvGhH8saP/JFEYj+MYLOVZcI
         jpNd2zpDaIRWdgWC/FRlXshqlqUKSIfwqW++/D7s78ySzSqFYwEZ39RqhQmBGbLc5C9E
         mUIiyazbpfjC+KP7kS7YWcL5Wt64UpzSUF1UGn0+Z+CfzAFRYorStCBRreMq+7VHBIkG
         wBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500978; x=1694105778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnl+F2n1kOs4P011p6EJFvzkt9Ylx9T9gDi6gAnNyhk=;
        b=KtlqJgB6WT/ZxMppF4EIhNN6Gx8G2IhHu8IFy3xGP0vhmbNUBGEgMXvGZcYs4PB4Zw
         KXtYB1WqBf9d5MLsCyXGEHE4Ucd6MRqLAuJj4+t52dLzgYudfuWHmPiZuGj7MHeH7g4E
         YuQxdjz1KHRMlmGtE7eCxwJMgl/FTQZFitQv1MBN7TBapsQI++F+EXXDy4GezqfgPKpC
         XEZuFluQgq3wL+Hi4IQZLYKS5aJxx5ZBLPAewYJbKEZGrjDJSv3UMlH6fjTW4QitdvYj
         VWDQ9Q/1MlJtcn28qCIG/Y0hoN4rVhsBdoH8yCpe0Gf1B16pm6ICadPvb57iA4qxexXJ
         3K2g==
X-Gm-Message-State: AOJu0YyX2oPWelNmMX3QOIW3kHglTBsOWfqSZnWoQqfIajMQmyJ2JqRL
        2SxclJENvRqy+sV8VWoZE771Eh8Rx0OgW1vG
X-Google-Smtp-Source: AGHT+IGQaFV/eoJPD0E5YObQdt63kn1VXtZb+DnEHQpo8u+eLis24QVhJvy1qf6oTqJysoROPjRG5kn0lET0eVSr
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2d87:b0:68b:dbbc:dd00 with
 SMTP id fb7-20020a056a002d8700b0068bdbbcdd00mr86084pfb.0.1693500978729; Thu,
 31 Aug 2023 09:56:18 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:56:09 +0000
In-Reply-To: <20230831165611.2610118-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831165611.2610118-3-yosryahmed@google.com>
Subject: [PATCH v4 2/4] mm: memcg: add a helper for non-unified stats flushing
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 2d0ec828a1c4..8c046feeaae7 100644
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
 	atomic_set(&stats_unified_flush_ongoing, 0);
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

