Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0230CA95
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 19:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhBBSyZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 13:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhBBSsh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 13:48:37 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93580C0617A7
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 10:47:57 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id a12so20827397qkh.10
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mpanv+/+JrDOLKkhynshAPXe4Ve6rW0I2YibAc13/NE=;
        b=O6ja58PYqYoZvn6p3Ba4+2qoDJfPZb1STqRFQNHtToIEjSyj1BXxH6ycynJzuxomPV
         9fl+x9JgJmfXvhv62NMyzN1ZD+/Buddm65nbmPOqK3iXg+jJ9NqA/wCMtFsY9aGRAVJi
         KTZk3QQsuUAQgka169LtM2V9I023EzNu1Kt4m8OB0Cw52000aJ3vTLT60nM1lA1DioZb
         ILdfgkvKbzGlqMLCcQWafrt71/KPfYqXBK0uxS0VzOmRtaPEq5CUAujti4DcSP8AABo1
         p/I6pOucyVi/HFirs7ugdp8cwARsiQm+CcFgrfIHN5K2WXtPHEzwkxqpZMIPDGP+ZRxj
         Yjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mpanv+/+JrDOLKkhynshAPXe4Ve6rW0I2YibAc13/NE=;
        b=nMk+sXmcL2DfXrptEcPYabJyUxRP6XWC3T11gaUQPVaY5cwR8Hcx3OrS1qy/hh4iff
         eE2xV0e6yQRgQvbAVltLKF06PvvJuP+ChIS2mC6eJUoUHEHeMHcbZR0CO799hJsyGgnd
         Pt/Uw0rq05Gq+Xvae8XU5abOBPhjEPyo2RDGPu5EHo4rxvBK4lhtCIMJLgU/wyWh705Q
         2ICzHNw3XYxDA1JzxWat3ny+Jn3P6AcqWqynxHuvXOjjwj/Eeqbs7axy2zh5yA7Nb6mw
         lcNwkzwmDQuSQTMiYCk3nWPCtqOZKpeM3FlXOZzspjGYOaPiU9dwI6v409iIMXUD3P6D
         UVNA==
X-Gm-Message-State: AOAM530ox1t0wnDNMlwGcus8rJ3y3c/B3zrdRgt5NbfUBgpw9/wanS9z
        wMcnHHsYKwm/HpYqLLYdDLdKcw==
X-Google-Smtp-Source: ABdhPJxK7OLtyLw44gKIZ9kPmlcX22umQXeXznlya2ca+opvuqTPoKzTzbj+MedVjmzxEJEkywMcRQ==
X-Received: by 2002:a05:620a:12d7:: with SMTP id e23mr22344898qkl.58.1612291676855;
        Tue, 02 Feb 2021 10:47:56 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id e5sm17299659qtp.86.2021.02.02.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:47:56 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] mm: memcontrol: privatize memcg_page_state query functions
Date:   Tue,  2 Feb 2021 13:47:42 -0500
Message-Id: <20210202184746.119084-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202184746.119084-1-hannes@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are no users outside of the memory controller itself. The rest
of the kernel cares either about node or lruvec stats.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
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

