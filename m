Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9B33F0C8A
	for <lists+cgroups@lfdr.de>; Wed, 18 Aug 2021 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhHRUSv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Aug 2021 16:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhHRUSu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Aug 2021 16:18:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3460C0613CF
        for <cgroups@vger.kernel.org>; Wed, 18 Aug 2021 13:18:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so4128848wms.1
        for <cgroups@vger.kernel.org>; Wed, 18 Aug 2021 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHfCCbHIXfL8S0LAJ+5b/okpSRYN0l8zL9APPGHUHjM=;
        b=JNxUjQJfF8Rfgw0pIVdmau+KQ+tvGbR5jwxsNL+C4ZDxsjgE+iui13LWXrzEM2oi4e
         JExJW4m3jOmYpeYqh5Jm5a8nfWjtKnJpIJqhmxMEVzERO+5UnEh+APgQwU6jjDW2aU50
         dWaLO+Kt1o238ME+il7oVvZb/cGa/r219D06M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHfCCbHIXfL8S0LAJ+5b/okpSRYN0l8zL9APPGHUHjM=;
        b=Lv1exXDh9JBW6UUL7z4nMN/sdGHVTeNNlmuhHmVemn5uzt00EHx1IyRThahv4SulA6
         7ZiFPjdzHvDB3Gg4LIBxEUqWVw5fLqcpvkyQnjl7gYL9d4ORSODx8M36BEdu5nI2l1P8
         276NVx79NSG6wbIeYYh5ehLrsi9rbD/XKCHX+UdmO6jl2WqpAv8QwHHKwjRX7Ox8Ehn3
         CGNusiAbAn5kguBJUvE08A5lIczbDdv5RFePjF07ok4JgrhQR09JuXJbpD7gverDURvv
         43d7Md9HlhAmEe//rSSR2QvOnXGv0jepKIkriYoJJENAMzc7Kk+Ux62o+DX65fUOr2Cr
         STrg==
X-Gm-Message-State: AOAM532A2uqFdlC4JCXDosKH7xmDx947ryCSDO+a/U/It/K7O0XcyLb4
        /O4J8S+GsoksoQohI/tJy0XJag==
X-Google-Smtp-Source: ABdhPJzYHZ/Yv7qcLsqA2BQ79yMvS71B29G7UVMNEpzfrAnk3wq8PLoDzLhcnwZ7fYeUBBem9GqVjA==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr10314299wmk.187.1629317893281;
        Wed, 18 Aug 2021 13:18:13 -0700 (PDT)
Received: from localhost (82-69-42-66.dsl.in-addr.zen.co.uk. [82.69.42.66])
        by smtp.gmail.com with ESMTPSA id a18sm5639913wmg.43.2021.08.18.13.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 13:18:12 -0700 (PDT)
Date:   Wed, 18 Aug 2021 21:18:10 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YR1rAoFNegl6CrPz@chrisdown.name>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner writes:
>We've noticed occasional OOM killing when memory.low settings are in
>effect for cgroups. This is unexpected and undesirable as memory.low
>is supposed to express non-OOMing memory priorities between cgroups.
>
>The reason for this is proportional memory.low reclaim. When cgroups
>are below their memory.low threshold, reclaim passes them over in the
>first round, and then retries if it couldn't find pages anywhere else.
>But when cgroups are slighly above their memory.low setting, page scan
>force is scaled down and diminished in proportion to the overage, to
>the point where it can cause reclaim to fail as well - only in that
>case we currently don't retry, and instead trigger OOM.
>
>To fix this, hook proportional reclaim into the same retry logic we
>have in place for when cgroups are skipped entirely. This way if
>reclaim fails and some cgroups were scanned with dimished pressure,
>we'll try another full-force cycle before giving up and OOMing.
>
>Reported-by: Leon Yang <lnyng@fb.com>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for tracking this down! Agreed that this looks like a good stable 
candidate.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> include/linux/memcontrol.h | 29 +++++++++++++++--------------
> mm/vmscan.c                | 27 +++++++++++++++++++--------
> 2 files changed, 34 insertions(+), 22 deletions(-)
>
>diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>index bfe5c486f4ad..24797929d8a1 100644
>--- a/include/linux/memcontrol.h
>+++ b/include/linux/memcontrol.h
>@@ -612,12 +612,15 @@ static inline bool mem_cgroup_disabled(void)
> 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
> }
>
>-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
>-						  struct mem_cgroup *memcg,
>-						  bool in_low_reclaim)
>+static inline void mem_cgroup_protection(struct mem_cgroup *root,
>+					 struct mem_cgroup *memcg,
>+					 unsigned long *min,
>+					 unsigned long *low)
> {
>+	*min = *low = 0;
>+
> 	if (mem_cgroup_disabled())
>-		return 0;
>+		return;
>
> 	/*
> 	 * There is no reclaim protection applied to a targeted reclaim.
>@@ -653,13 +656,10 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
> 	 *
> 	 */
> 	if (root == memcg)
>-		return 0;
>-
>-	if (in_low_reclaim)
>-		return READ_ONCE(memcg->memory.emin);
>+		return;
>
>-	return max(READ_ONCE(memcg->memory.emin),
>-		   READ_ONCE(memcg->memory.elow));
>+	*min = READ_ONCE(memcg->memory.emin);
>+	*low = READ_ONCE(memcg->memory.elow);
> }
>
> void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>@@ -1147,11 +1147,12 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
> {
> }
>
>-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
>-						  struct mem_cgroup *memcg,
>-						  bool in_low_reclaim)
>+static inline void mem_cgroup_protection(struct mem_cgroup *root,
>+					 struct mem_cgroup *memcg,
>+					 unsigned long *min,
>+					 unsigned long *low)
> {
>-	return 0;
>+	*min = *low = 0;
> }
>
> static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index 4620df62f0ff..701106e1829c 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -100,9 +100,12 @@ struct scan_control {
> 	unsigned int may_swap:1;
>
> 	/*
>-	 * Cgroups are not reclaimed below their configured memory.low,
>-	 * unless we threaten to OOM. If any cgroups are skipped due to
>-	 * memory.low and nothing was reclaimed, go back for memory.low.
>+	 * Cgroup memory below memory.low is protected as long as we
>+	 * don't threaten to OOM. If any cgroup is reclaimed at
>+	 * reduced force or passed over entirely due to its memory.low
>+	 * setting (memcg_low_skipped), and nothing is reclaimed as a
>+	 * result, then go back back for one more cycle that reclaims
>+	 * the protected memory (memcg_low_reclaim) to avert OOM.
> 	 */
> 	unsigned int memcg_low_reclaim:1;
> 	unsigned int memcg_low_skipped:1;
>@@ -2537,15 +2540,14 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> 	for_each_evictable_lru(lru) {
> 		int file = is_file_lru(lru);
> 		unsigned long lruvec_size;
>+		unsigned long low, min;
> 		unsigned long scan;
>-		unsigned long protection;
>
> 		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
>-		protection = mem_cgroup_protection(sc->target_mem_cgroup,
>-						   memcg,
>-						   sc->memcg_low_reclaim);
>+		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
>+				      &min, &low);
>
>-		if (protection) {
>+		if (min || low) {
> 			/*
> 			 * Scale a cgroup's reclaim pressure by proportioning
> 			 * its current usage to its memory.low or memory.min
>@@ -2576,6 +2578,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> 			 * hard protection.
> 			 */
> 			unsigned long cgroup_size = mem_cgroup_size(memcg);
>+			unsigned long protection;
>+
>+			/* memory.low scaling, make sure we retry before OOM */
>+			if (!sc->memcg_low_reclaim && low > min) {
>+				protection = low;
>+				sc->memcg_low_skipped = 1;
>+			} else {
>+				protection = min;
>+			}
>
> 			/* Avoid TOCTOU with earlier protection check */
> 			cgroup_size = max(cgroup_size, protection);
>-- 
>2.32.0
>
