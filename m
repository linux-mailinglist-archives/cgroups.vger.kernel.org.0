Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC06D5471
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjDCWEH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjDCWDx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 18:03:53 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BC26AD
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 15:03:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n15-20020a170902f60f00b001a273a4a685so9781930plg.15
        for <cgroups@vger.kernel.org>; Mon, 03 Apr 2023 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNJBwGVVZOmg9VOOVOlV/1s5wuc6P4CJY0BTT3hY1AM=;
        b=PLSbfUpOYbUqIYWD0lVUspaLdyltho/9MJ34jFGgaIu6ps/MvfYgJtvBICL0/UsCg8
         Eo1bG+CpaO1W/JWBORyxWnVMwYforRdWFpLcNNnnTr6WckgWqX8cpRotu3SoW3jnNsSm
         PizUX3QJilPLsW/5Gft8jVYazARk9Ut3n4G+JQv0SopU/bBBAHVR6m+9um87Q19Q1oES
         JkmqUr13ZWZzVKrKo78OL0QtsqIHc61QjUXFxRzUrqMEuTOHPCZ7yp3LqOiDIHhK80Se
         /pN6/hsU4YI1MwbFb/U4Ozh2+s+tmlO9zkIjBJHts6ziq2HpcgAoxfLImivvQtFY+h9I
         09eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNJBwGVVZOmg9VOOVOlV/1s5wuc6P4CJY0BTT3hY1AM=;
        b=b2u0LJZR7oj7FnL7vQG6AqJ5KGjCou4SG4HGqfv4fgl9l4NTtdNbOSaNCt0IWB1424
         ebZMT29hEOFNO4xUW3PiYkkEqcPFVDpz3oA7IuADG8jzlkggw97zVnQN+0UC7skIwiB0
         mvEvwPRK0aiN5cGzdnh3++FkxRusHhuChjGDZWXg928T18VF/6rHOb5QwMy6RUEdjXsT
         poEx5aoi32U9d1A5N2m8rXgKLWJcJkaRuyD9u4Dee1cwBzoeKkKin9NliD2F+KF/pDrk
         dQQqTkDf9OEmOa25WFeEs/gXYctcSz5cSoszjWaIEIJCkbQ/abTl1CLPtmE66oOC2Xcf
         yVdQ==
X-Gm-Message-State: AAQBX9fGo/LubC6rlOakP5cIqjF12QCF2A2C79W0ZdipU87S/e//43Xn
        CX4LwK8jijPUJ2fqiGpjLK3q5o0/5ajdcKT9
X-Google-Smtp-Source: AKy350YqjuJx0cPEvkhGlL8e3G8Xhx/mHcAIKY7AoMYKpy6RY5t/7e2yXmvxs0CQV10HpQGcD3F9B9OJJYiZoWXv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:4cce:b0:23b:5155:309f with SMTP
 id nd14-20020a17090b4cce00b0023b5155309fmr7558849pjb.0.1680559426408; Mon, 03
 Apr 2023 15:03:46 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:36 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-5-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 4/5] memcg: remove mem_cgroup_flush_stats_atomic()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Previous patches removed all callers of mem_cgroup_flush_stats_atomic().
Remove the function and simplify the code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  5 -----
 mm/memcontrol.c            | 24 +++++-------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 222d7370134c7..00a88cf947e14 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1038,7 +1038,6 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_atomic(void);
 void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
@@ -1537,10 +1536,6 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_atomic(void)
-{
-}
-
 static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e7fe18c0c0ef2..33339106f1d9b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -638,7 +638,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(bool atomic)
+static void do_flush_stats(void)
 {
 	/*
 	 * We always flush the entire tree, so concurrent flushers can just
@@ -651,30 +651,16 @@ static void do_flush_stats(bool atomic)
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 
-	if (atomic)
-		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
-	else
-		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
 	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
-static bool should_flush_stats(void)
-{
-	return atomic_read(&stats_flush_threshold) > num_online_cpus();
-}
-
 void mem_cgroup_flush_stats(void)
 {
-	if (should_flush_stats())
-		do_flush_stats(false);
-}
-
-void mem_cgroup_flush_stats_atomic(void)
-{
-	if (should_flush_stats())
-		do_flush_stats(true);
+	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+		do_flush_stats();
 }
 
 void mem_cgroup_flush_stats_ratelimited(void)
@@ -689,7 +675,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Always flush here so that flushing in latency-sensitive paths is
 	 * as cheap as possible.
 	 */
-	do_flush_stats(false);
+	do_flush_stats();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
-- 
2.40.0.348.gf938b09366-goog

