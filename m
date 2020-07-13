Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7521D47F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgGMLF6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jul 2020 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMLF5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jul 2020 07:05:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840C6C061794
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:05:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a1so7674939edt.10
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFXMEHhkBKemwA/QoFtxiRqyIHqOIfwBr0LYDpNQG/w=;
        b=AT52M10Glz6TiDoZ4uGS3qPTmg2vqCLijtoFBQ8ribBod0g/b47E9eyS4hn+Po7CIZ
         TfzqlI8FPBvDocG12P2yQK9i58fLZPBMa/ODoiYM4PgyrcNGC48huN8RO/sJncf/9QA/
         Hz1D17cq1FNCR9cfEpnzBpuSAXsA5oUre28c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFXMEHhkBKemwA/QoFtxiRqyIHqOIfwBr0LYDpNQG/w=;
        b=RUtmljnjgpHPObrAHLbKaNplxvWwiVsTChzPwi9gLhLB630FuDNAsxk1w5rgF2WFFr
         TSNnvuzNAeJk7h/wIwqO66yQDON1j+DmNcX4tbBUnW6sDjGdDwfwD+a7MftQR5bTZa5i
         Nz4b9C7TRU7ZazKvOhTJlf6h3IxKW1L7m/YPUc0GEojWwOOSuZJqQH/w1Ld8iAm8D2Jb
         q2AeQs9AvVnyNF1Ni5dGseLvSTAdCoLKNOOPvuY/d97/p3GwDl4qGzuWNI9TJYCq6ksw
         HpA46mUGxKiPg2cjC+69AfOM+GU3NUy7nLOv607kDrXd8fVvard5MvNL8md5zLKF02z4
         Qt9A==
X-Gm-Message-State: AOAM530EeGSUMAgpl87fCQObUrDKOdjNR4l3wxe9wOK0U1kuHGrhFwBH
        /dkUO5mC6jds3FDZYPUVKjhsSQ==
X-Google-Smtp-Source: ABdhPJwB4lLUUI0SASDFJIPJn2ZlyEEUDi9MRdcYhRBhVhW9BwKCmdfSLCoSFZ4vG91w9G9uO+W6JA==
X-Received: by 2002:a50:ab52:: with SMTP id t18mr92428592edc.195.1594638356061;
        Mon, 13 Jul 2020 04:05:56 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id bq8sm9165988ejb.103.2020.07.13.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:05:55 -0700 (PDT)
From:   Yafang Shao <chris@chrisdown.name>
X-Google-Original-From: Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 13 Jul 2020 12:05:54 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <044fb8ecffd001c7905d27c0c2ad998069fdc396.1594638158.git.chris@chrisdown.name>
References: <cover.1594638158.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594638158.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

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
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 include/linux/memcontrol.h | 42 ++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c            |  8 ++++++++
 mm/vmscan.c                |  3 ++-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b8f52a3fed90..33d834a187e5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -363,12 +363,49 @@ static inline bool mem_cgroup_disabled(void)
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
 
@@ -899,7 +936,8 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 {
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
+static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
+						  struct mem_cgroup *memcg,
 						  bool in_low_reclaim)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0145a77aa074..21b620e36aa0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6566,6 +6566,14 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
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
index 5215840ee217..89921a12acae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2326,7 +2326,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		unsigned long protection;
 
 		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
-		protection = mem_cgroup_protection(memcg,
+		protection = mem_cgroup_protection(sc->target_mem_cgroup,
+						   memcg,
 						   sc->memcg_low_reclaim);
 
 		if (protection) {
-- 
2.27.0

