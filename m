Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4C1C50A3
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgEEImR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgEEImQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 04:42:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D3BC061A0F;
        Tue,  5 May 2020 01:42:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so527651plk.10;
        Tue, 05 May 2020 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uNXSdEUBpc3xWP7djY2ze56IO2uIUgfCKO2NyW30Dck=;
        b=D97jDPF7pJRvvGaVoCW6UlzjpMr7H5DOZlC/aGmGyv/FNHecOYKhA3muG5v4zgdTVT
         Fehu8BpMixpRo7d6C31z2/Qwp/NH5uZr6nB5S70I9Gzf9VlFfydxdf4A/a8x+olV/Caq
         rcFRCjUqU/Y0wfAGf5si8tR6BNje9J9ZHiMqizH4wjXJ6Rx3JZ2N6Kkm5iDV5M8rX23u
         wP+c6naS2GRNThO0ONgdc0rkfCdFU+gVJY0Hyry0BuluwqYUaoPA3nnWgmqA1TUXq4dK
         3rOjbQNvP+NRgdfz6J5LXZA4TMN2WRIxNdmeTKmay3secfl5lVnthmCJcUmo7d8mFlp3
         +Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uNXSdEUBpc3xWP7djY2ze56IO2uIUgfCKO2NyW30Dck=;
        b=exuvVxjh0wPSzJOsezYq4DCpox10B8BBiNOaALMAC98UAs45AXMQsgYBXbd7t58/Yg
         rFrQk9oMR5uMWdde5AvbR/rQZ7+Myg6WmnscO518G6ucyFQg1JCX/9PYDp6E2IyQ2Pue
         S6o/H9watnTc/7N1mqWbQioPowWBgMi3ALDA28+r5lyyLuT1ZVQwyxSnnR6gMdmQSu/A
         WqTNFJQ5H4ZHnSZ+kd/DEVWlI/Sdvmezeilm7/kjxnlWp7XeUeI2pdDCqMNuT1aj6g3Y
         2oeMIq0LksFQtsAmgmOwjlElblI9x95NMGwexY5mFptx4PrkvoA7SK2WExvTjMxyTpsa
         Lpzw==
X-Gm-Message-State: AGi0PubI0BQ1qJKLyFWoBBmw1sdle/b6Wn7Esafy5nX1lpPUbark6Vd2
        g29GXyaSsJLJWx23DB+fbSg=
X-Google-Smtp-Source: APiQypKkl2yBbJWZ+3+d391ViVXNqxbwJdeakoqTLvcOVr7z8+Tmv4ZWBy7VlPgL2n0NiX/wCcsUgA==
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr2006175pls.69.1588668136028;
        Tue, 05 May 2020 01:42:16 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p190sm1443802pfp.207.2020.05.05.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:42:15 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 1/2] mm, memcg: Avoid stale protection values when cgroup is above protection
Date:   Tue,  5 May 2020 04:41:26 -0400
Message-Id: <20200505084127.12923-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200505084127.12923-1-laoar.shao@gmail.com>
References: <20200505084127.12923-1-laoar.shao@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A cgroup can have both memory protection and a memory limit to isolate
it from its siblings in both directions - for example, to prevent it
from being shrunk below 2G under high pressure from outside, but also
from growing beyond 4G under low pressure.

Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
implemented proportional scan pressure so that multiple siblings in
excess of their protection settings don't get reclaimed equally but
instead in accordance to their unprotected portion.

During limit reclaim, this proportionality shouldn't apply of course:
there is no competition, all pressure is from within the cgroup and
should be applied as such. Reclaim should operate at full efficiency.

However, mem_cgroup_protected() never expected anybody to look at the
effective protection values when it indicated that the cgroup is above
its protection. As a result, a query during limit reclaim may return
stale protection values that were calculated by a previous reclaim cycle
in which the cgroup did have siblings.

When this happens, reclaim is unnecessarily hesitant and potentially
slow to meet the desired limit. In theory this could lead to premature
OOM kills, although it's not obvious this has occurred in practice.

Workaround the problem by special casing reclaim roots in
mem_cgroup_protection. These memcgs are never participating in the
reclaim protection because the reclaim is internal.

We have to ignore effective protection values for reclaim roots because
mem_cgroup_protected might be called from racing reclaim contexts with
different roots. Calculation is relying on root -> leaf tree traversal
therefore top-down reclaim protection invariants should hold. The only
exception is the reclaim root which should have effective protection set
to 0 but that would be problematic for the following setup:
 Let's have global and A's reclaim in parallel:
  |
  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
  |\
  | C (low = 1G, usage = 2.5G)
  B (low = 1G, usage = 0.5G)

 for A reclaim we have
 B.elow = B.low
 C.elow = C.low

 For the global reclaim
 A.elow = A.low
 B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
 C.elow = min(C.usage, C.low)

 With the effective values resetting we have A reclaim
 A.elow = 0
 B.elow = B.low
 C.elow = C.low

 and global reclaim could see the above and then
 B.elow = C.elow = 0 because children_low_usage > A.elow

Which means that protected memcgs would get reclaimed.

In future we would like to make mem_cgroup_protected more robust against
racing reclaim contexts but that is likely more complex solution than
this simple workaround.

[hannes@cmpxchg.org - large part of the changelog]
[mhocko@suse.com - workaround explanation]
[chris@chrisdown.name - retitle]
Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 42 ++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c            |  8 ++++++++
 mm/vmscan.c                |  3 ++-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d275c72c4f8e..c07548ce26cb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -344,12 +344,49 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
+static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
+						  struct mem_cgroup *memcg,
 						  bool in_low_reclaim)
 {
 	if (mem_cgroup_disabled())
 		return 0;
 
+	/*
+	 * There is no reclaim protection applied to a targeted reclaim.
+	 * We are special casing this specific case here because
+	 * mem_cgroup_protected calculation is not robust enough to keep
+	 * the protection invariant for calculated effective values for
+	 * parallel reclaimers with different reclaim target. This is
+	 * especially a problem for tail memcgs (as they have pages on LRU)
+	 * which would want to have effective values 0 for targeted reclaim
+	 * but a different value for external reclaim.
+	 *
+	 * Example
+	 * Let's have global and A's reclaim in parallel:
+	 *  |
+	 *  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
+	 *  |\
+	 *  | C (low = 1G, usage = 2.5G)
+	 *  B (low = 1G, usage = 0.5G)
+	 *
+	 * For the global reclaim
+	 * A.elow = A.low
+	 * B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
+	 * C.elow = min(C.usage, C.low)
+	 *
+	 * With the effective values resetting we have A reclaim
+	 * A.elow = 0
+	 * B.elow = B.low
+	 * C.elow = C.low
+	 *
+	 * If the global reclaim races with A's reclaim then
+	 * B.elow = C.elow = 0 because children_low_usage > A.elow)
+	 * is possible and reclaiming B would be violating the protection.
+	 *
+	 */
+	if (root == memcg)
+		return 0;
+
 	if (in_low_reclaim)
 		return READ_ONCE(memcg->memory.emin);
 
@@ -835,7 +872,8 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 {
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
+static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
+						  struct mem_cgroup *memcg,
 						  bool in_low_reclaim)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5beea03dd58a..1206682edc1a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6388,6 +6388,14 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	if (!root)
 		root = root_mem_cgroup;
+
+	/*
+	 * Effective values of the reclaim targets are ignored so they
+	 * can be stale. Have a look at mem_cgroup_protection for more
+	 * details.
+	 * TODO: calculation should be more robust so that we do not need
+	 * that special casing.
+	 */
 	if (memcg == root)
 		return MEMCG_PROT_NONE;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868fc4926..4d3027ac131c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2346,7 +2346,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		unsigned long protection;
 
 		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
-		protection = mem_cgroup_protection(memcg,
+		protection = mem_cgroup_protection(sc->target_mem_cgroup,
+						   memcg,
 						   sc->memcg_low_reclaim);
 
 		if (protection) {
-- 
2.18.2

