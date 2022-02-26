Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489ED4C52AF
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 01:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbiBZAZI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 19:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiBZAZI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 19:25:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F7199D74
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 16:24:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d820d59530so42522717b3.5
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c5XxepI0RiJzH9nImzDTpadEG2SO2IU4ZT8K2Wm0fgw=;
        b=iwU9nbdapI4QDtZoaxiJdFfKk1Aeelgfe69uZJ/lOO24OOX3A5QLJPiH4qboOUz+2t
         zQ09GP9qcVBfCxpp8LeUQrCciTFqyr3ZfNXtHmQcDdshuU8oBAZQYGNMMsLvF1rrJSy0
         xgl5ybIbuKPpkxSdP4WL+dvjKkd+mHI6inkn2YcaLxC09Mz1DhKHMnY5GFhO+SCythBy
         J5KTKZYcptRIR/A8cB0AHU+KBOeaXdbwJSaeFWuzemzTsZh9FW8r2PUqyNenl0z+4moK
         scvXa+QlOZ7lJ9J3duby8Kr1w1z/3ERSbJTInf29y1U66/ojmBs2Psy+xnZMhY6dGx+E
         5nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c5XxepI0RiJzH9nImzDTpadEG2SO2IU4ZT8K2Wm0fgw=;
        b=fyk5cIH5l9lV3lUKqja1E2KLRVyIWkIFQE6+I1Rw3PwP/eZ7vpLNCAAxcmCeqv3xCW
         85PlZxmiTK19T1kWA4vkPxuK3jBiGuvHuahdWkit2ix5PTwOSRO5BJl7/b4p0S4M9n2D
         AJqCMS9JdUjk2BZ2g3r+MPD95fdgqa5pL2f63T7Yo9cUNDU9sr79m2P9SxiKlW0AH2/O
         1js5FAEboNv8XwxNWtK0F1gSdfZPTo6t1ZxVelw0B/c2LJZj6Vp94xWY3YxcW3tI1pk8
         CarecA3p+3/4v/j4d/Bnu8S6k22tMyVf5IuwgWEYCm4vwcq4902+PaxgkhHh1pslXDXD
         5zQQ==
X-Gm-Message-State: AOAM531Xl68xVWOE6hFKaB/WHnj7nOiChxkhqHN5rOyQzu8yVD6K7TD6
        Q9gvQ4BcKob+78QV92kHL4JnwwttideI3w==
X-Google-Smtp-Source: ABdhPJzqsLR7y0lfbkwTXvPkY6+2FHJWcDSoxXSS/X5D8//dIU/36RB8yXNtw/F6Ve7tENac2apQuJ7ROS38pQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:1a3e:f375:915f:ad7e])
 (user=shakeelb job=sendgmr) by 2002:a25:2b0a:0:b0:624:a898:3e2f with SMTP id
 r10-20020a252b0a000000b00624a8983e2fmr9753491ybr.643.1645835074125; Fri, 25
 Feb 2022 16:24:34 -0800 (PST)
Date:   Fri, 25 Feb 2022 16:24:12 -0800
Message-Id: <20220226002412.113819-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
From:   Shakeel Butt <shakeelb@google.com>
To:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Daniel Dao <dqminh@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Daniel Dao has reported [1] a regression on workloads that may trigger
a lot of refaults (anon and file). The underlying issue is that flushing
rstat is expensive. Although rstat flush are batched with (nr_cpus *
MEMCG_BATCH) stat updates, it seems like there are workloads which
genuinely do stat updates larger than batch value within short amount of
time. Since the rstat flush can happen in the performance critical
codepaths like page faults, such workload can suffer greatly.

The easiest fix for now is for performance critical codepaths trigger
the rstat flush asynchronously. This patch converts the refault codepath
to use async rstat flush. In addition, this patch has premptively
converted mem_cgroup_wb_stats and shrink_node to also use the async
rstat flush as they may also similar performance regressions.

Link: https://lore.kernel.org/all/CA+wXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com [1]
Fixes: 1f828223b799 ("memcg: flush lruvec stats in the refault")
Reported-by: Daniel Dao <dqminh@cloudflare.com>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 10 +++++++++-
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ef4b445392a9..bfdd48be60ff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -998,6 +998,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
+void mem_cgroup_flush_stats_async(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c695608c521c..4338e8d779b2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -690,6 +690,14 @@ void mem_cgroup_flush_stats(void)
 		__mem_cgroup_flush_stats();
 }
 
+void mem_cgroup_flush_stats_async(void)
+{
+	if (atomic_read(&stats_flush_threshold) > num_online_cpus()) {
+		atomic_set(&stats_flush_threshold, 0);
+		mod_delayed_work(system_unbound_wq, &stats_flush_dwork, 0);
+	}
+}
+
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	__mem_cgroup_flush_stats();
@@ -4522,7 +4530,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_async();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6f77e3e6d59..b6c6b165c1ef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3188,7 +3188,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_async();
 
 	memset(&sc->nr, 0, sizeof(sc->nr));
 
diff --git a/mm/workingset.c b/mm/workingset.c
index b717eae4e0dd..a4f2b1aa5bcc 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -355,7 +355,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_async();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.35.1.574.g5d30c73bfb-goog

