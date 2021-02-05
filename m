Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05650311023
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhBEQ6v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 11:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhBEQr0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 11:47:26 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC3C061223
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:28:30 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k193so7853929qke.6
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyRE6cACCpenz5S22wUDNGiEebDEXlsVuxUU66sedEg=;
        b=icEoG5fvED4gxDkodWySfEiJNdvHYTrXwyvRJR/NMlNgXGomJfFsLQ0X1Z7EzQefwS
         rfW+aNcKIIETp0qQ7BgaL+bHxz9JDwG8D0DQ7OfBTQMxsMX1PKR5GEDlskiULC37oHzk
         snxN/HmpVBXYD1Azekn8O3eQqv9R8NTKfz3zGLkjSAnFLNp0F5ChuS6QLvZs+NwzrOXa
         MTt6ZuHZmnFc/5tqEtOoAJV4yDeMqaNNC3TDVMuNTyayv8+BojubGAjU9FECgFSvq0Rv
         itLqqfmn0+w1v9I4LLhobur8A2NlT6lqld3Lz3oem56U7oDrlQVEEyGhxQWCkJGnDPAB
         gMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyRE6cACCpenz5S22wUDNGiEebDEXlsVuxUU66sedEg=;
        b=DnOYMf6mKoEb9gqTm37XjQ6GAiZI2YChkRU3/4Bk3r8uzdNidTCHzQnzZPIR5BhxAk
         UU6tewIimlu5ynHoOZ4l4DSndLwDU3oaP9jevYmKsXKYhPlkKt46zTossFd2sGhIJEh4
         Q3RfQxPVjjZQGN1bf4pKngZthq7Hwfv5W46aRAkmcpsI275u4dmvgXopvzwT+c5WT7rm
         +tKTyvIHJBXknYqMq+JI84eI6zXtXSZi6Mkmj9JOgxGjaaFmRyG4hV4jxbIKg9lpxEZZ
         E8I1WYRcLbZsqxbot7Hij+yTywjxGmOeJDzyZsPQwImLf4LSuApJWy5pUN4XzqAt/LCx
         I3+Q==
X-Gm-Message-State: AOAM530C8+RlpUom4fmMJ/FjsMaFKmfaxK+VBJx9hYd3t1Al5z8ynA25
        QFIt4A0tcxuoRBR4eqvaqNgq4w==
X-Google-Smtp-Source: ABdhPJwxx/7nrxQH2xMQl9OF2NmblRhnJXqu1V7GG+uDZJC69P0ViHX8NU//3iSmLG2aZEYjiC0NyA==
X-Received: by 2002:a05:620a:2226:: with SMTP id n6mr5435497qkh.193.1612549709755;
        Fri, 05 Feb 2021 10:28:29 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 2sm9983861qkf.97.2021.02.05.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:29 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/8] mm: memcontrol: privatize memcg_page_state query functions
Date:   Fri,  5 Feb 2021 13:28:01 -0500
Message-Id: <20210205182806.17220-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
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

