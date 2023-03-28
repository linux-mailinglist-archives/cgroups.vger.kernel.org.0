Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ABA6CB6DE
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjC1GRm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 02:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjC1GRQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 02:17:16 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09E3AB7
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:53 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q30-20020a17090a17a100b0023d376ac2c5so2971853pja.5
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IOPAG+bqxWxKt0wdRgDKHhdCXWwpmJ9UigZO44sKyE=;
        b=ntB4QsMVT8Fqv0//N2SyNJC8TO+SF5Nd//5MMCXPuMIlVWZztrbNiDvPnYTm36PsVJ
         0K9UDAdVpl/jKPNVqGESnlXBby6gGh6KP9olFVGSWL7LZjX9hTDyTd2rcdVRYaALTq3d
         Svdw5D9xcS6f+R64pTOq4hP3DTwLDxc7s6WmPqIXIzObjUGQ7BCksYYcDbsn8CMNCe4l
         XYGLULvlYDvGRGQwaFkUUkpNiN3oSuW1tCmNSMxILm7ttbjB9+T2xkgSS2wr2ydIjDg8
         ulb0ThWq/NbS6X5lqaGmn6zu6IKbfwWSX3vLp0eLAeAr3Ue3Dif4Fen7adboVvdM5kPM
         ZMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IOPAG+bqxWxKt0wdRgDKHhdCXWwpmJ9UigZO44sKyE=;
        b=WJrBycSGZiJKdFerfvVuqwp5PIPmb2TUBaR6NAalkD2NMonVKf5MHKCcKyotYHPEAC
         DYAKqaSzvcZK6tCgHu1o8ruvh4lDmN3ENEkyUDHLdvryRtIUI0S+rBfrklGX8WPW0+Qp
         L1fj+SekkO84Sk1zO3tihNTS/oWUotQkcj5jLlpXK3dUP7wYnkTu5+ouINxo5PibvbX1
         JAZ19ggy1Ii0DrwQOkqTRgGifB5SfvKLQqAyCvRXfSF89snRh/X4OcsJvdCfW25uXKVb
         lxDHYtIWrtPg+MwxTR9HIZegf9oZelM7mT46t3NVg3QajttUydi9PElGCmIiT3K7nKIA
         KgYQ==
X-Gm-Message-State: AAQBX9cNuB7QQQCukLdAyJfHy+UAaf/DDm6J74fmh0dls44g0xW5Yybc
        pMl89lKebASdBAgAIB6kqF7kRX1FYLPNjuze
X-Google-Smtp-Source: AKy350aQyFDG3vc2bblz86MnnpZXVqNeZCl/Rb1kLJ1qs2lbXDpCUugeQMSOiQHvyL07sX6z7bmDfgTHunmuYJ4D
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:4a41:0:b0:507:46cb:f45b with SMTP
 id j1-20020a634a41000000b0050746cbf45bmr3969874pgl.1.1679984212630; Mon, 27
 Mar 2023 23:16:52 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:35 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-7-yosryahmed@google.com>
Subject: [PATCH v1 6/9] memcg: sleep during flushing stats in safe contexts
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
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

Currently, all contexts that flush memcg stats do so with sleeping not
allowed. Some of these contexts are perfectly safe to sleep in, such as
reading cgroup files from userspace or the background periodic flusher.

Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
sleepable), and provide a separate atomic version. The atomic version is
used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
other code paths are left to use the non-atomic version. This includes
callbacks for userspace reads and the periodic flusher.

Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
this function is changed to call the atomic version of
mem_cgroup_flush_stats(). Reclaim and refault code paths are modified
to do non-atomic flushing in separate later patches -- so
mem_cgroup_flush_stats_ratelimited() will eventually become non-atomic.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  5 ++++
 mm/memcontrol.c            | 58 ++++++++++++++++++++++++++++++++------
 mm/vmscan.c                |  2 +-
 3 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ac3f3b3a45e2..a4bc3910a2eb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1037,6 +1037,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
+void mem_cgroup_flush_stats_atomic(void);
 void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
@@ -1535,6 +1536,10 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
+static inline void mem_cgroup_flush_stats_atomic(void)
+{
+}
+
 static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ff33e02c96..57e8cbf701f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -634,7 +634,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void __mem_cgroup_flush_stats(void)
+static bool mem_cgroup_pre_stats_flush(void)
 {
 	/*
 	 * We always flush the entire tree, so concurrent flushers can just
@@ -642,24 +642,57 @@ static void __mem_cgroup_flush_stats(void)
 	 * from memcg flushers (e.g. reclaim, refault, etc).
 	 */
 	if (atomic_xchg(&stats_flush_ongoing, 1))
-		return;
+		return false;
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
-	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
+	return true;
+}
+
+static void mem_cgroup_post_stats_flush(void)
+{
 	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
-void mem_cgroup_flush_stats(void)
+static bool mem_cgroup_should_flush_stats(void)
 {
-	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
-		__mem_cgroup_flush_stats();
+	return atomic_read(&stats_flush_threshold) > num_online_cpus();
+}
+
+/* atomic functions, safe to call from any context */
+static void __mem_cgroup_flush_stats_atomic(void)
+{
+	if (mem_cgroup_pre_stats_flush()) {
+		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
+		mem_cgroup_post_stats_flush();
+	}
+}
+
+void mem_cgroup_flush_stats_atomic(void)
+{
+	if (mem_cgroup_should_flush_stats())
+		__mem_cgroup_flush_stats_atomic();
 }
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats_atomic();
+}
+
+/* non-atomic functions, only safe from sleepable contexts */
+static void __mem_cgroup_flush_stats(void)
+{
+	if (mem_cgroup_pre_stats_flush()) {
+		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+		mem_cgroup_post_stats_flush();
+	}
+}
+
+void mem_cgroup_flush_stats(void)
+{
+	if (mem_cgroup_should_flush_stats())
+		__mem_cgroup_flush_stats();
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -3684,9 +3717,12 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 		 * done from irq context; use stale stats in this case.
 		 * Arguably, usage threshold events are not reliable on the root
 		 * memcg anyway since its usage is ill-defined.
+		 *
+		 * Additionally, other call paths through memcg_check_events()
+		 * disable irqs, so make sure we are flushing stats atomically.
 		 */
 		if (in_task())
-			mem_cgroup_flush_stats();
+			mem_cgroup_flush_stats_atomic();
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
@@ -4609,7 +4645,11 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	/*
+	 * wb_writeback() takes a spinlock and calls
+	 * wb_over_bg_thresh()->mem_cgroup_wb_stats(). Do not sleep.
+	 */
+	mem_cgroup_flush_stats_atomic();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..a9511ccb936f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_atomic();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.40.0.348.gf938b09366-goog

