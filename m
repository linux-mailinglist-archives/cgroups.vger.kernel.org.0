Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8561C21D481
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgGMLGE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jul 2020 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMLGE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jul 2020 07:06:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14ADC061755
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:06:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so16474314eje.7
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZoFkzkrQ309RFK+OEsYyChcl3CTS19ns9lFUyyEZu6I=;
        b=LFQgUlJ+p3zW2HOohTZcQq0P9OZqCn0CZRV0HGSvImtjSzSUtVppG/KQiK1YkTZHTp
         6TWBAPc17Yp4sU9vBHDYzg44bvvA9m2lQNSI6McRsXDS1EX+I76sdFvmMwKfKqB3HB2y
         wkBxcblZOEGjILE15qynikXnOrpBBMbCnWIO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZoFkzkrQ309RFK+OEsYyChcl3CTS19ns9lFUyyEZu6I=;
        b=l55H5SLTOZ2swERz0RInBXEgkFdWlGmEuzwGJEZkiElJyae4f0cP9u3snWwW54F3t2
         3rExLB/mdBtwwAz4yKGZ25jRNgz6Uv0fJei4PM11uz5mzEfdq0sRPCslADJn66enw7QE
         rVr3rov+22V+dBZJjZZsAVyeBa0dilEjjuZ3r0aQbCiOS5BbYZ6geHFZduQi/s3lAT/s
         XGpNsKXRUb39QpRxbr1hog/Cx6SCbk+06ONa7t2QWS44Ookvfh2gGAgWfBVBFMKHclxg
         XuhBpC4eYKvr8nu2W4asFvS8WRNB3hpQHSWMV/pVHKMO1dm/dzEfxkkYxIgEuyyUZEY2
         iCvQ==
X-Gm-Message-State: AOAM531o10FsVwyVV5Ifm08vSw16qRZp6IRKB9JrUvOzbBxu6fvS8H0b
        /+3SBd/LCABPv7wYOzctEGUIkQ==
X-Google-Smtp-Source: ABdhPJx8VC1E7arfSO0GtUNoH/+MOB0zhtWuPG7aUY/otYk3jFdjhA+LKvkFN4VSahhnVp2L/73NfQ==
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr68370630ejb.488.1594638362470;
        Mon, 13 Jul 2020 04:06:02 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id d16sm9318965ejo.31.2020.07.13.04.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:06:01 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:06:01 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm, memcg: Decouple e{low,min} state mutations from
 protection checks
Message-ID: <ff3f915097fcee9f6d7041c084ef92d16aaeb56a.1594638158.git.chris@chrisdown.name>
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

mem_cgroup_protected currently is both used to set effective low and min
and return a mem_cgroup_protection based on the result.  As a user, this
can be a little unexpected: it appears to be a simple predicate function,
if not for the big warning in the comment above about the order in which
it must be executed.

This change makes it so that we separate the state mutations from the
actual protection checks, which makes it more obvious where we need to be
careful mutating internal state, and where we are simply checking and
don't need to worry about that.

[mhocko@suse.com - don't check protection on root memcgs]
Signed-off-by: Chris Down <chris@chrisdown.name>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 53 ++++++++++++++++++++++++++++++--------
 mm/memcontrol.c            | 28 +++++---------------
 mm/vmscan.c                | 17 +++---------
 3 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 33d834a187e5..d7887888ce99 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -55,12 +55,6 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
-enum mem_cgroup_protection {
-	MEMCG_PROT_NONE,
-	MEMCG_PROT_LOW,
-	MEMCG_PROT_MIN,
-};
-
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	unsigned int generation;
@@ -413,8 +407,36 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
 		   READ_ONCE(memcg->memory.elow));
 }
 
-enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
-						struct mem_cgroup *memcg);
+void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg);
+
+static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
+{
+	/*
+	 * The root memcg doesn't account charges, and doesn't support
+	 * protection.
+	 */
+	return !mem_cgroup_disabled() && !mem_cgroup_is_root(memcg);
+
+}
+
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+{
+	if (!mem_cgroup_supports_protection(memcg))
+		return false;
+
+	return READ_ONCE(memcg->memory.elow) >=
+		page_counter_read(&memcg->memory);
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+{
+	if (!mem_cgroup_supports_protection(memcg))
+		return false;
+
+	return READ_ONCE(memcg->memory.emin) >=
+		page_counter_read(&memcg->memory);
+}
 
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 
@@ -943,10 +965,19 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
 	return 0;
 }
 
-static inline enum mem_cgroup_protection mem_cgroup_protected(
-	struct mem_cgroup *root, struct mem_cgroup *memcg)
+static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg)
 {
-	return MEMCG_PROT_NONE;
+}
+
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+{
+	return false;
 }
 
 static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 21b620e36aa0..1f101078b217 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6548,21 +6548,15 @@ static unsigned long effective_protection(unsigned long usage,
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
- *
- * Returns one of the following:
- *   MEMCG_PROT_NONE: cgroup memory is not protected
- *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
- *     an unprotected supply of reclaimable memory from other cgroups.
- *   MEMCG_PROT_MIN: cgroup memory is protected
  */
-enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
-						struct mem_cgroup *memcg)
+void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg)
 {
 	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
 
 	if (mem_cgroup_disabled())
-		return MEMCG_PROT_NONE;
+		return;
 
 	if (!root)
 		root = root_mem_cgroup;
@@ -6575,21 +6569,21 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	 * that special casing.
 	 */
 	if (memcg == root)
-		return MEMCG_PROT_NONE;
+		return;
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-		return MEMCG_PROT_NONE;
+		return;
 
 	parent = parent_mem_cgroup(memcg);
 	/* No parent means a non-hierarchical mode on v1 memcg */
 	if (!parent)
-		return MEMCG_PROT_NONE;
+		return;
 
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
 		memcg->memory.elow = READ_ONCE(memcg->memory.low);
-		goto out;
+		return;
 	}
 
 	parent_usage = page_counter_read(&parent->memory);
@@ -6603,14 +6597,6 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 			READ_ONCE(memcg->memory.low),
 			READ_ONCE(parent->memory.elow),
 			atomic_long_read(&parent->memory.children_low_usage)));
-
-out:
-	if (usage <= memcg->memory.emin)
-		return MEMCG_PROT_MIN;
-	else if (usage <= memcg->memory.elow)
-		return MEMCG_PROT_LOW;
-	else
-		return MEMCG_PROT_NONE;
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 89921a12acae..626bdde485b3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2615,14 +2615,15 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long reclaimed;
 		unsigned long scanned;
 
-		switch (mem_cgroup_protected(target_memcg, memcg)) {
-		case MEMCG_PROT_MIN:
+		mem_cgroup_calculate_protection(target_memcg, memcg);
+
+		if (mem_cgroup_below_min(memcg)) {
 			/*
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		case MEMCG_PROT_LOW:
+		} else if (mem_cgroup_below_low(memcg)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
@@ -2634,16 +2635,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				continue;
 			}
 			memcg_memory_event(memcg, MEMCG_LOW);
-			break;
-		case MEMCG_PROT_NONE:
-			/*
-			 * All protection thresholds breached. We may
-			 * still choose to vary the scan pressure
-			 * applied based on by how much the cgroup in
-			 * question has exceeded its protection
-			 * thresholds (see get_scan_count).
-			 */
-			break;
 		}
 
 		reclaimed = sc->nr_reclaimed;
-- 
2.27.0

