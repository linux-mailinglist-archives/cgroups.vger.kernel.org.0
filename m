Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513D13153F5
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhBIQej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 11:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhBIQeQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 11:34:16 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F61C06178B
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 08:33:32 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id e11so13355632qtg.6
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyRE6cACCpenz5S22wUDNGiEebDEXlsVuxUU66sedEg=;
        b=u/HDSEYp99RhO8kqQIIVwaAns/CtmccQ9gChZtsKMsP0WJwv841qFHb0cD60Q1fWDw
         4GCwEjU06NTqK4M7OtBfHWm7a7XidL/c7E5qvQynNhyS2gI/r0t0ePrvf2mHSGJAsuz7
         mLn4QMKjqClvDuKnSV7hLFm7zyh3SrC8zrxhLdphwbQdNDKUD8WVPzgHw5JEGhGBsuIo
         Bf1KKn8yNDd01l4N1+6FLn0twzj4sbVI3Cc/py4066Q0MMnghnKnqlv9xjpoxstEuYBA
         8/rM8j9Jb+ofG8V/fm0+LiysJI5wyCtSfbnO3ey11h6wn832ocT1rayRg9twROQXCoTK
         CrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyRE6cACCpenz5S22wUDNGiEebDEXlsVuxUU66sedEg=;
        b=OtHOGFo0bN+jAfQme0W5XRyRT+wKiajF4dlFam78y5n81KzXCapiu4qBLU7Oz89Zwa
         mAk26uUGZxORxW6O9SVC83Ne6GcaCI4mrT/yhQ9pYFZ0oHs4dQUBTA+6qJjkw0jem/o5
         8KzZ4ZsavGvdQJTzKHN1SpGldL+72XXKcVgBHjia3BpPXIAfIdmZsag9/TIMZDxFuX3p
         0Txs+jxZSmMDdUcnFKWlY4zNNjP3faR8B0odBpZYilzctkrAhLU85JoZ2KrycbvLrCgr
         2NpaWbz/4ygcroCSM0rg5WopEOFWjWfBia6IyzV9J409G7C0WNyLH0rlSZn7ehEhC1BM
         ncPQ==
X-Gm-Message-State: AOAM533xVm6PGnytff/86/j0iAKyXZRtTZW4mRFhofRRY/7YqUpMlEsu
        2WEn/fgInerXOELgpYj/pmx7Rw==
X-Google-Smtp-Source: ABdhPJxRXQumMAR1ctLKB+jTVaegvCZTuRwsfXwAurF9KHoCIWkzWWa88MdsYBcUeIpNop37kejzAw==
X-Received: by 2002:ac8:5714:: with SMTP id 20mr20670731qtw.197.1612888411536;
        Tue, 09 Feb 2021 08:33:31 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id o17sm18065496qtl.47.2021.02.09.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:30 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 3/8] mm: memcontrol: privatize memcg_page_state query functions
Date:   Tue,  9 Feb 2021 11:32:59 -0500
Message-Id: <20210209163304.77088-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are no users outside of the memory controller itself. The rest
of the kernel cares either about node or lruvec stats.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 44 --------------------------------------
 mm/memcontrol.c            | 32 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c7f387a6233e..20ecdfae3289 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -867,39 +867,6 @@ struct mem_cgroup *lock_page_memcg(struct page *page);
 void __unlock_page_memcg(struct mem_cgroup *memcg);
 void unlock_page_memcg(struct page *page);
 
-/*
- * idx can be of type enum memcg_stat_item or node_stat_item.
- * Keep in sync with memcg_exact_page_state().
- */
-static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
-{
-	long x = atomic_long_read(&memcg->vmstats[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
-
-/*
- * idx can be of type enum memcg_stat_item or node_stat_item.
- * Keep in sync with memcg_exact_page_state().
- */
-static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
-						   int idx)
-{
-	long x = 0;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
-
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
@@ -1337,17 +1304,6 @@ static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 {
 }
 
-static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
-{
-	return 0;
-}
-
-static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
-						   int idx)
-{
-	return 0;
-}
-
 static inline void __mod_memcg_state(struct mem_cgroup *memcg,
 				     int idx,
 				     int nr)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7e05a4ebf80f..2f97cb4cef6d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -789,6 +789,38 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
 }
 
+/*
+ * idx can be of type enum memcg_stat_item or node_stat_item.
+ * Keep in sync with memcg_exact_page_state().
+ */
+static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
+{
+	long x = atomic_long_read(&memcg->vmstats[idx]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
+/*
+ * idx can be of type enum memcg_stat_item or node_stat_item.
+ * Keep in sync with memcg_exact_page_state().
+ */
+static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
+{
+	long x = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 static struct mem_cgroup_per_node *
 parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
 {
-- 
2.30.0

