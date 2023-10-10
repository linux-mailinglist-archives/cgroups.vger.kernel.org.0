Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B837BF150
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441973AbjJJDVc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 23:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441970AbjJJDV1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 23:21:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAA1A4
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 20:21:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so13175957b3.0
        for <cgroups@vger.kernel.org>; Mon, 09 Oct 2023 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696908084; x=1697512884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hC1pWunCMBCtxVf3YGG9j/q6Xl3rVbI2nQig93EJD1c=;
        b=yJL49vSJJ4IGXvINefEv9WQidpmtBVzYC6kKfAJ4r62g3i0soq5k5DBOcEv/Jfvg4b
         PpiV7IkuaHNDFyvHkDdUOhhQbcXN/OkwnsgYpQ3xuCtLxKn0ObQWP+RiCgYwQXPPWH4m
         42DZvp5VZQQpDhVbD3SQYoeHoAIknD8NcNYSyAOl31isjOMXEmozxbblWsrIFjirPfEI
         lwBoTPshl2GSB5kxC6SPLir6nUQYpjMiVD1jW5taP2CmmJL5xTUMP3kG9IlSev42XwnQ
         zONR2NHp8+QKb5+B3o4562VgWZkbU4aW54d0NKQNBYaZoJOUPjIfJnbZ3S5AhY14Jlen
         MsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908084; x=1697512884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hC1pWunCMBCtxVf3YGG9j/q6Xl3rVbI2nQig93EJD1c=;
        b=m9VgGEsiWY0ZGLyUjNx4RQfpDyxFF54ollsEsDZQMWg++gA8aQ44lphFX5rGznK2lt
         eLpcZPfVDxyXpKxRpIHKF60nK7XCvu0/NGvCFl5c+Re7sRz8nKI9tg4HENw59OPv+hDW
         N0IdQCsyW+UgY3HMhOJF2hZhUQoPP8dkUbjuPc9famWzsVjTSbKLBddFe/fhQCytq/0f
         Gz2HxaGB0KViMCqT7YRVwyTPeEvitXgIJLUV8rwCOJqf1nQeBFmorYTmX5Rpkqr2Fse0
         lzfjvGB7TbbX+GZ6jNdW6moAbFYmA7vuB+1ymp1EiuMZHarj5SI7i1fMJ8loCFGTmkqT
         OGaA==
X-Gm-Message-State: AOJu0Yx+sflLxvvi6bbLzn1S/S67zGeKiaDDCfpPGCEVzX1Avc3Bgz1f
        HVTmtHpf4aa+FF8Z7UWV4Go2J4kXiKG9j93v
X-Google-Smtp-Source: AGHT+IFIrbr9jnt8AKgjFXbiV/tkMci7vpdggI/qLBKz9UQMIl0xyavjRIGPF8xVVyjEs532DFKybC2OPjpal40i
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a5b:b50:0:b0:d80:904d:c211 with SMTP id
 b16-20020a5b0b50000000b00d80904dc211mr250724ybr.7.1696908083837; Mon, 09 Oct
 2023 20:21:23 -0700 (PDT)
Date:   Tue, 10 Oct 2023 03:21:13 +0000
In-Reply-To: <20231010032117.1577496-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010032117.1577496-3-yosryahmed@google.com>
Subject: [PATCH v2 2/5] mm: memcg: move vmstats structs definition above
 flushing code
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

The following patch will make use of those structs in the flushing code,
so move their definitions (and a few other dependencies) a little bit up
to reduce the diff noise in the following patch.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 146 ++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4a194fcc9533..a393f1399a2b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -570,6 +570,79 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGPGIN,
+	PGPGOUT,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
+#endif
+};
+
+#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
+static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+
+static void init_memcg_events(void)
+{
+	int i;
+
+	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
+		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
+}
+
+static inline int memcg_events_index(enum vm_event_item idx)
+{
+	return mem_cgroup_events_index[idx] - 1;
+}
+
+struct memcg_vmstats_percpu {
+	/* Local (CPU and cgroup) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[MEMCG_NR_STAT];
+	unsigned long		events_prev[NR_MEMCG_EVENTS];
+
+	/* Cgroup1: threshold notifications & softlimit tree updates */
+	unsigned long		nr_page_events;
+	unsigned long		targets[MEM_CGROUP_NTARGETS];
+};
+
+struct memcg_vmstats {
+	/* Aggregated (CPU and subtree) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Non-hierarchical (CPU aggregated) page state & events */
+	long			state_local[MEMCG_NR_STAT];
+	unsigned long		events_local[NR_MEMCG_EVENTS];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[MEMCG_NR_STAT];
+	unsigned long		events_pending[NR_MEMCG_EVENTS];
+};
+
 /*
  * memcg and lruvec stats flushing
  *
@@ -681,79 +754,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
-/* Subset of vm_event_item to report for memcg event stats */
-static const unsigned int memcg_vm_event_stat[] = {
-	PGPGIN,
-	PGPGOUT,
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSCAN_KHUGEPAGED,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGSTEAL_KHUGEPAGED,
-	PGFAULT,
-	PGMAJFAULT,
-	PGREFILL,
-	PGACTIVATE,
-	PGDEACTIVATE,
-	PGLAZYFREE,
-	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	ZSWPIN,
-	ZSWPOUT,
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	THP_FAULT_ALLOC,
-	THP_COLLAPSE_ALLOC,
-	THP_SWPOUT,
-	THP_SWPOUT_FALLBACK,
-#endif
-};
-
-#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
-
-static void init_memcg_events(void)
-{
-	int i;
-
-	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
-		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
-}
-
-static inline int memcg_events_index(enum vm_event_item idx)
-{
-	return mem_cgroup_events_index[idx] - 1;
-}
-
-struct memcg_vmstats_percpu {
-	/* Local (CPU and cgroup) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Delta calculation for lockless upward propagation */
-	long			state_prev[MEMCG_NR_STAT];
-	unsigned long		events_prev[NR_MEMCG_EVENTS];
-
-	/* Cgroup1: threshold notifications & softlimit tree updates */
-	unsigned long		nr_page_events;
-	unsigned long		targets[MEM_CGROUP_NTARGETS];
-};
-
-struct memcg_vmstats {
-	/* Aggregated (CPU and subtree) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_NR_STAT];
-	unsigned long		events_local[NR_MEMCG_EVENTS];
-
-	/* Pending child counts during tree propagation */
-	long			state_pending[MEMCG_NR_STAT];
-	unsigned long		events_pending[NR_MEMCG_EVENTS];
-};
-
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	long x = READ_ONCE(memcg->vmstats->state[idx]);
-- 
2.42.0.609.gbb76f46606-goog

