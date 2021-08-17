Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817433EF13F
	for <lists+cgroups@lfdr.de>; Tue, 17 Aug 2021 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHQSEF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Aug 2021 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhHQSED (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Aug 2021 14:04:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D20C061764
        for <cgroups@vger.kernel.org>; Tue, 17 Aug 2021 11:03:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 22so14691175qkg.2
        for <cgroups@vger.kernel.org>; Tue, 17 Aug 2021 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aakl6RvUiI6sZ5cXxvbF6/Vj9nfatl8x2B4LqmSBf8=;
        b=Yy18VUql+67ALRRkEeGggrIgzSo/8IWYyUDWIBre9LBWAOpTIeSVVbVWkqH5zdsrJt
         aSw/WwSAzFYB5fQ7IzfX9ZOk9jgKrtHxidiFX+lfXpeEJQHtxlDevqmkUVaD/9S59KpC
         ghTugOpHHb3M42P1LlhMKFh/GB2IR9Kldp5JWpYQ4AkiZXdyElHsxUL0dVJsOPizxvw0
         ac4O7+s9nW27pURc+BNWbkPwkYXrbwpC90mp97FVzPbmbTo0/jQKb/+V20/+TACMUtq5
         2dH8TqL3qpuGFjvEpM714HtxTjk6RvJTa5BwGPThji6O8b9oVv5VFtMK5bt5yX6XhVGv
         uJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aakl6RvUiI6sZ5cXxvbF6/Vj9nfatl8x2B4LqmSBf8=;
        b=WniIvRqOeFpc05ocjaa6fBPDXSt8xYpEgtuiBOUkiFPpMv9eitHo8YPrdTzoi6WqI6
         0MLQd7xu262Hhh7nStF29tt4NpVvdJEVtdD926Wpr8PdKiasALt5nCGfJjUbtMrzfSxt
         k5HxJZDDf22GzYgFtLei0cHVIDpc7ZMBdomf+jy9PrLke4Wd2UcIDDakOUdL/OxLWAJ2
         uBUl1locIIUlQ4LuYCORAt9Iylpi1xMsLCJO283Dgug8SKmyKV4pKvYF/fJWXXSntb4K
         orb1O/MSBf6xfwJSKmFWn/MLcXLd6bOvHGBjyyvRtQ6bLiqVzOAqUTPrt6I5a0VzRdKY
         StAw==
X-Gm-Message-State: AOAM531ISLEl0Ac91CDJsM5mH4AYnYrPyWM6vekn58NU/f/kqWSevQui
        e8PtxHeWqMbboFkdQGmSigUHNQ==
X-Google-Smtp-Source: ABdhPJxs2nN6GGCeCiuqVCrH+b7SWZp+zbBW872BObBp2/8KhN7Ks9ctZFuhhqdXxzBiud0bye4g1g==
X-Received: by 2002:a37:944:: with SMTP id 65mr5134121qkj.412.1629223409442;
        Tue, 17 Aug 2021 11:03:29 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bl40sm1816554qkb.64.2021.08.17.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:03:28 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional memory.low reclaim
Date:   Tue, 17 Aug 2021 14:05:06 -0400
Message-Id: <20210817180506.220056-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We've noticed occasional OOM killing when memory.low settings are in
effect for cgroups. This is unexpected and undesirable as memory.low
is supposed to express non-OOMing memory priorities between cgroups.

The reason for this is proportional memory.low reclaim. When cgroups
are below their memory.low threshold, reclaim passes them over in the
first round, and then retries if it couldn't find pages anywhere else.
But when cgroups are slighly above their memory.low setting, page scan
force is scaled down and diminished in proportion to the overage, to
the point where it can cause reclaim to fail as well - only in that
case we currently don't retry, and instead trigger OOM.

To fix this, hook proportional reclaim into the same retry logic we
have in place for when cgroups are skipped entirely. This way if
reclaim fails and some cgroups were scanned with dimished pressure,
we'll try another full-force cycle before giving up and OOMing.

Reported-by: Leon Yang <lnyng@fb.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 29 +++++++++++++++--------------
 mm/vmscan.c                | 27 +++++++++++++++++++--------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..24797929d8a1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -612,12 +612,15 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
-						  struct mem_cgroup *memcg,
-						  bool in_low_reclaim)
+static inline void mem_cgroup_protection(struct mem_cgroup *root,
+					 struct mem_cgroup *memcg,
+					 unsigned long *min,
+					 unsigned long *low)
 {
+	*min = *low = 0;
+
 	if (mem_cgroup_disabled())
-		return 0;
+		return;
 
 	/*
 	 * There is no reclaim protection applied to a targeted reclaim.
@@ -653,13 +656,10 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
 	 *
 	 */
 	if (root == memcg)
-		return 0;
-
-	if (in_low_reclaim)
-		return READ_ONCE(memcg->memory.emin);
+		return;
 
-	return max(READ_ONCE(memcg->memory.emin),
-		   READ_ONCE(memcg->memory.elow));
+	*min = READ_ONCE(memcg->memory.emin);
+	*low = READ_ONCE(memcg->memory.elow);
 }
 
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
@@ -1147,11 +1147,12 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 {
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
-						  struct mem_cgroup *memcg,
-						  bool in_low_reclaim)
+static inline void mem_cgroup_protection(struct mem_cgroup *root,
+					 struct mem_cgroup *memcg,
+					 unsigned long *min,
+					 unsigned long *low)
 {
-	return 0;
+	*min = *low = 0;
 }
 
 static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..701106e1829c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -100,9 +100,12 @@ struct scan_control {
 	unsigned int may_swap:1;
 
 	/*
-	 * Cgroups are not reclaimed below their configured memory.low,
-	 * unless we threaten to OOM. If any cgroups are skipped due to
-	 * memory.low and nothing was reclaimed, go back for memory.low.
+	 * Cgroup memory below memory.low is protected as long as we
+	 * don't threaten to OOM. If any cgroup is reclaimed at
+	 * reduced force or passed over entirely due to its memory.low
+	 * setting (memcg_low_skipped), and nothing is reclaimed as a
+	 * result, then go back back for one more cycle that reclaims
+	 * the protected memory (memcg_low_reclaim) to avert OOM.
 	 */
 	unsigned int memcg_low_reclaim:1;
 	unsigned int memcg_low_skipped:1;
@@ -2537,15 +2540,14 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	for_each_evictable_lru(lru) {
 		int file = is_file_lru(lru);
 		unsigned long lruvec_size;
+		unsigned long low, min;
 		unsigned long scan;
-		unsigned long protection;
 
 		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
-		protection = mem_cgroup_protection(sc->target_mem_cgroup,
-						   memcg,
-						   sc->memcg_low_reclaim);
+		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
+				      &min, &low);
 
-		if (protection) {
+		if (min || low) {
 			/*
 			 * Scale a cgroup's reclaim pressure by proportioning
 			 * its current usage to its memory.low or memory.min
@@ -2576,6 +2578,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			 * hard protection.
 			 */
 			unsigned long cgroup_size = mem_cgroup_size(memcg);
+			unsigned long protection;
+
+			/* memory.low scaling, make sure we retry before OOM */
+			if (!sc->memcg_low_reclaim && low > min) {
+				protection = low;
+				sc->memcg_low_skipped = 1;
+			} else {
+				protection = min;
+			}
 
 			/* Avoid TOCTOU with earlier protection check */
 			cgroup_size = max(cgroup_size, protection);
-- 
2.32.0

