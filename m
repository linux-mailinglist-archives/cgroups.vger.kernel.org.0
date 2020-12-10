Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149EE2D52C6
	for <lists+cgroups@lfdr.de>; Thu, 10 Dec 2020 05:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgLJEYn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Dec 2020 23:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgLJEYl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Dec 2020 23:24:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401FC061794
        for <cgroups@vger.kernel.org>; Wed,  9 Dec 2020 20:24:01 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so3000709pga.9
        for <cgroups@vger.kernel.org>; Wed, 09 Dec 2020 20:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3R+1Kw1+pxZrJagVjtPWvZt7HKHZG/cWLsw4oRpXRM=;
        b=ed7QLo/rYT5tWL9hE0juUheenuYvMB/DsiCixtcPicRPnPdc5XSR5o8m6ehwmw9ixx
         mqoOK5hMiLYq01XPF9wfQE8kIs8GHOOEue2QNA+YeNaiJO64O7YYDLWV1814M/RsjyZu
         757nJtTf62KwIE+mCNy7RcyEp2w+a8Go8gEoZJGLXl2wgy0Yiqb6Ai2HDNPFfr/Il+Mz
         fdI/7omavvu1NoE46SQOnBHFAgSFEVhlhgnKlCcjMKT6dt8Uyk7WrIDLOmUeQzQxEv7R
         l5wZZ8MaVUhKBZOZ1vGRpKibvImYmJB5CzZIWinZyRk0oj+oIQ290DXX3lQDuP4o5Drg
         hYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3R+1Kw1+pxZrJagVjtPWvZt7HKHZG/cWLsw4oRpXRM=;
        b=BOASV59H0HQg8EnFzx3ZfouHKCdCSNMV8eja4erq1BMpgv/921ehpLXjQMpxFWECIN
         Z3E2mL9s1YMZi3LIrrO0DZa7OWpMo7y46eaFP5bUs9beRvR17dy74Akpe0uud7Hv4QaY
         kVzRVbs6B85AqoqcgrK0vDWzOdedW71uJ+8lo8Jb41Otun01Edw04mcMV58IcfpRZMhE
         1c6djwIIU5WPikpiE65PMTNZmFLXeJlWP6oyZmMz3b5+CBBmZRn9avyp17sLZtTq6mQg
         yjDeIO60/XevgEMfE49JoXVzlrjv3/Lp7ww0tCiVOk6IP2Fs9KObuCRWh82m2gM2YFq+
         b60A==
X-Gm-Message-State: AOAM531wG2dvwM5FKkL8qn2j0bfZ1oAaqLL+kbokoLrkvDX1HYczXyst
        Xz9fStejTyVUvfFj0xbnKzRizw==
X-Google-Smtp-Source: ABdhPJwkCF7fY1bFrcA6xK2/kdJzPG4YfdS6qXeU6PxZwyABhuXfLBj6ekpI6AfnvSaQU/HEQuqamA==
X-Received: by 2002:a63:7982:: with SMTP id u124mr4880721pgc.259.1607574240745;
        Wed, 09 Dec 2020 20:24:00 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.73])
        by smtp.gmail.com with ESMTPSA id q9sm4319411pgb.82.2020.12.09.20.23.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 20:24:00 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        sfr@canb.auug.org.au, chris@chrisdown.name, laoar.shao@gmail.com,
        richard.weiyang@gmail.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] mm: memcontrol: optimize per-lruvec stats counter memory usage
Date:   Thu, 10 Dec 2020 12:21:21 +0800
Message-Id: <20201210042121.39665-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), Actually the threshold
can be as big as MEMCG_CHARGE_BATCH * PAGE_SIZE. It still fits into s32.
So introducing struct batched_lruvec_stat to optimize memory usage.

The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
bytes per-memcg per-node where ncpu is the number of the possible CPU.
If there are c memory cgroup (include dying cgroup) and n NUMA node in
the system. Finally, we can save (152 * ncpu * c * n) bytes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
Changes in v2 -> v3:
 - Rename per_cpu_lruvec_stat to batched_lruvec_stat. Thanks Shakeel.
 - Update commit log. Thanks Roman.

Changes in v1 -> v2:
 - Update the commit log to point out how many bytes that we can save.

 include/linux/memcontrol.h | 14 ++++++++++++--
 mm/memcontrol.c            | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3febf64d1b80..076512e1dc9c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -92,6 +92,10 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+struct batched_lruvec_stat {
+	s32 count[NR_VM_NODE_STAT_ITEMS];
+};
+
 /*
  * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
  * which have elements charged to this memcg.
@@ -107,11 +111,17 @@ struct memcg_shrinker_map {
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
-	/* Legacy local VM stats */
+	/*
+	 * Legacy local VM stats. This should be struct lruvec_stat and
+	 * cannot be optimized to struct batched_lruvec_stat. Becasue
+	 * the threshold of the lruvec_stat_cpu can be as big as
+	 * MEMCG_CHARGE_BATCH * PAGE_SIZE. It can fit into s32. But this
+	 * filed has no upper limit.
+	 */
 	struct lruvec_stat __percpu *lruvec_stat_local;
 
 	/* Subtree VM stats (batched updates) */
-	struct lruvec_stat __percpu *lruvec_stat_cpu;
+	struct batched_lruvec_stat __percpu *lruvec_stat_cpu;
 	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eec44918d373..1b01771f2600 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5198,7 +5198,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 		return 1;
 	}
 
-	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
+	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct batched_lruvec_stat,
 					       GFP_KERNEL_ACCOUNT);
 	if (!pn->lruvec_stat_cpu) {
 		free_percpu(pn->lruvec_stat_local);
@@ -7089,6 +7089,14 @@ static int __init mem_cgroup_init(void)
 {
 	int cpu, node;
 
+	/*
+	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
+	 * used for per-memcg-per-cpu caching of per-node statistics. In order
+	 * to work fine, we should make sure that the overfill threshold can't
+	 * exceed S32_MAX / PAGE_SIZE.
+	 */
+	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S32_MAX / PAGE_SIZE);
+
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
-- 
2.11.0

