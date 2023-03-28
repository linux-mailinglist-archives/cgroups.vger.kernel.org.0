Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86F6CB6D1
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 08:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjC1GRY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 02:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjC1GRI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 02:17:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0B3A9B
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:51 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gj9-20020a17090b108900b0024038c818a0so2934409pjb.7
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdlOdGF0YCCYf+h2+Wx+Pr2285UVOLm52gCW9Jb/OEo=;
        b=dxPzci0vIh1xyJxlLBjWkEhAjm9YbPSdsUTO5u3B5j0mjvT8KDBeosrn5UiPm3Ksna
         ECFLKks3+i/JLwnVARkeiq9XCne6PDhOU+plEpcmqroZ0FIo5b3stpDp4azRz7RDEUXr
         fg0RX+xHWkbr/97SE9yMggMcSWIL9SDqbA2byVm27sTtHVM/RcaUTUFVwNm3hT6OyTW8
         KGm1B3oJJOu2mLGqIrSENlsxO5AJatCTwMfnNnO9IVILzvLEURQL9lNGe4Pge9n4mWvC
         01ODxHoNCu+DMqEmep2UjWrEts9KjVkOV7sWpi8aLYcEgH/6hlGK54jM+qhbvTAI+Y6D
         5qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdlOdGF0YCCYf+h2+Wx+Pr2285UVOLm52gCW9Jb/OEo=;
        b=giUoW+cr1HZuhxSCt0CY1FncNm1cl9SfX4A0zhl3b9yYh0naKO0Mi/CPRixnsjXIy6
         CGmGMuKeeRzl/t6ZsOTW0SznRIzNvdwgSgcbZY1s26YOycLu+hB917orI8wYb9YeuWFh
         YxGXuMlgUO4Ryv7vomm9ezplQtMLxWZKM4BJBf5KRXCB3sDQpG12eoA40RU0mIHfMDEy
         PJJN1dWJihZsuDfycVQ8kZEeM3JX3ByZn1roxNNt5z60OL6FDZAhSwcc2qCaLUWQ7kcW
         LAFemPDoSc1OxXRte9MMBmmuaOhL7FPsZvLvG/Xz7iKfMvH9qxlAF1rB0NInDigzwPOY
         bV/w==
X-Gm-Message-State: AAQBX9chhXXJeuiIkHgiKuwEAMzkYGQywBrjvkxGH8pLkUIlp41gc3by
        OcJq3EoixDL1KBm0rvwo5CxqO8kXdxafMQgg
X-Google-Smtp-Source: AKy350ZiMUeqTdYquDazwFQP3GVswROLJyitcbpH2br9NmUFXZZud9qfmMVPueO4yaGFykMkMD2PV8f94RgXrI2o
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:74c9:b0:23f:1105:4295 with SMTP
 id p9-20020a17090a74c900b0023f11054295mr4298168pjl.7.1679984210825; Mon, 27
 Mar 2023 23:16:50 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:34 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-6-yosryahmed@google.com>
Subject: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
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

As Johannes notes in [1], stats_flush_lock is currently used to:
(a) Protect updated to stats_flush_threshold.
(b) Protect updates to flush_next_time.
(c) Serializes calls to cgroup_rstat_flush() based on those ratelimits.

However:

1. stats_flush_threshold is already an atomic

2. flush_next_time is not atomic. The writer is locked, but the reader
   is lockless. If the reader races with a flush, you could see this:

                                        if (time_after(jiffies, flush_next_time))
        spin_trylock()
        flush_next_time = now + delay
        flush()
        spin_unlock()
                                        spin_trylock()
                                        flush_next_time = now + delay
                                        flush()
                                        spin_unlock()

   which means we already can get flushes at a higher frequency than
   FLUSH_TIME during races. But it isn't really a problem.

   The reader could also see garbled partial updates, so it needs at
   least READ_ONCE and WRITE_ONCE protection.

3. Serializing cgroup_rstat_flush() calls against the ratelimit
   factors is currently broken because of the race in 2. But the race
   is actually harmless, all we might get is the occasional earlier
   flush. If there is no delta, the flush won't do much. And if there
   is, the flush is justified.

So the lock can be removed all together. However, the lock also served
the purpose of preventing a thundering herd problem for concurrent
flushers, see [2]. Use an atomic instead to serve the purpose of
unifying concurrent flushers.

[1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/
[2]https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ff39f78f962e..64ff33e02c96 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static DEFINE_SPINLOCK(stats_flush_lock);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
+static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_next_time;
 
@@ -636,15 +636,18 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 
 static void __mem_cgroup_flush_stats(void)
 {
-	unsigned long flag;
-
-	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
+	/*
+	 * We always flush the entire tree, so concurrent flushers can just
+	 * skip. This avoids a thundering herd problem on the rstat global lock
+	 * from memcg flushers (e.g. reclaim, refault, etc).
+	 */
+	if (atomic_xchg(&stats_flush_ongoing, 1))
 		return;
 
-	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
+	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
-	spin_unlock_irqrestore(&stats_flush_lock, flag);
+	atomic_set(&stats_flush_ongoing, 0);
 }
 
 void mem_cgroup_flush_stats(void)
@@ -655,7 +658,7 @@ void mem_cgroup_flush_stats(void)
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
-	if (time_after64(jiffies_64, flush_next_time))
+	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
 		mem_cgroup_flush_stats();
 }
 
-- 
2.40.0.348.gf938b09366-goog

