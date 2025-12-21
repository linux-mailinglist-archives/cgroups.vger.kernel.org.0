Return-Path: <cgroups+bounces-12558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4C2CD472C
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 00:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1790F3001E2A
	for <lists+cgroups@lfdr.de>; Sun, 21 Dec 2025 23:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B4286897;
	Sun, 21 Dec 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJaErCQG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDE283159
	for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360219; cv=none; b=nVD5wDJo8lmSZeQ/IoWBoOK266B2uJ64MjBXBb3wRhwYHgmXqpUGxZ96qVbhFv2y5kDicGKx0fWOI1jL2ULPlEhBhDDNCajEL4kU208nKCg6EtbwC5ikdoC31184s49lHUyzvrzFC0Wxb4K0zeYHZHSN7t1UYjbSfHcoVqUNDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360219; c=relaxed/simple;
	bh=TH8d2yyXKa4fMd0WI4nPJ0bzAgbIns0ypw8/ovvAOfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wu/DjzcieRlWGEK/FXDTVSQk6BMW9ECJNB3fPk5U/EfB8RPwfIzafQxZ+B6U+ZCiksZXiIC1FaVP5KNGoLQ0B12VPbVnFNokhc3tcGJjEQeUkZhaUqq0WYQ6o+K++N254u2Cydotj2jjcj18oDxCWvlIXjX2dbntI7r87wQqx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJaErCQG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99763210e5so6945447a12.3
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766360216; x=1766965016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GfhhMoWYFTh/aN/kwrLJXHldk5+UtwhObh4bR+INB4=;
        b=aJaErCQGfQUOk6wMvmLvIIMGxSp+3eaKlUbdKiv2Pe5fgHmS11NP+tGw/Wr7fY7pmJ
         UU3n3hPnXo4jL3dWwF821Fo99YmbuMQQUkcaoWD97ooXi7LIc586fWvrh5EqHyS/fH7Z
         uPqGHVjizbslTG85ZTQunVdgtFvWAZAZNBMkloGPCUULrjxHVG67XA9OetrsOJ1/XyT5
         rDJfrnADGMX0zsfJBqu9atLaSpBc/AjF5V9yuQQhom51XM9pblp33tXKhbKHxFXjLEzC
         i92D60U+2K6De7hg1KRDxVfBERgkror0Dk7XEeD6QcWF/GER1DBHm7kV+obcJr/DPo+K
         Brxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766360216; x=1766965016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GfhhMoWYFTh/aN/kwrLJXHldk5+UtwhObh4bR+INB4=;
        b=WraHP6/ZrEMOvrvkG14FCyATSeAJW/J+Gli/kk83akfCvPz6wHoxXK7JFOUJkg4K5q
         4+uUue5m4QORwV+jdaV1d/cBb82biBJ7RdFst5mHbx1lHfMWcX9SdcK6LIK7Je9sNVdK
         Ler30o+lUPvmQLsPerdp7hPrhtBS0q8D4eB+2eQpc0DSk29GHuxbKYOWlJfbSajyAIdi
         j56S1ys8wHYLaD3186jFx1PO7XfvGYv9GkfsLooYDE+iHyRsXZbS0pNnrAs7Q+70n80e
         lh8BvTSL014IuAeG/hT3NTy0TwpcdmdRyPNB2vS8r6KqE/zLvHKjTlRjbZaxuNZXtUuv
         BVkw==
X-Forwarded-Encrypted: i=1; AJvYcCV/v/qzv64EZlHlMV9k/wKF5GzyWFIW0UUV05gOUWOPxaaodFcxC75tU4E7kw3Ko2N53hVYBWfB@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKZPC7aY850FJ89Llv6KVCJNWSgp8jU+Hla1/T8HJRW8yl2WB
	kE/M8bUNbYFuXS3fSDygeQvF7Jm0Xy7HcoYpCmKj05tqSKe+i3svrkxcfw0ZGB9sQO87rhO4QAP
	od4mcHhSqhbBUdQ==
X-Google-Smtp-Source: AGHT+IEicLxazx7S6uu1698T5FhlbmHzMdzgeAbcuTNEEaAVkEM1v1fpFPWcA/uiQi7D96w3YBVKbgPaJ+Ktsg==
X-Received: from dyboo7.prod.google.com ([2002:a05:7301:1e87:b0:2ac:36d5:fc65])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d89:b0:2ac:2263:dcc0 with SMTP id 5a478bee46e88-2b05ec19181mr11168511eec.19.1766360216254;
 Sun, 21 Dec 2025 15:36:56 -0800 (PST)
Date: Sun, 21 Dec 2025 23:36:34 +0000
In-Reply-To: <20251221233635.3761887-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251220061022.2726028-1-bingjiao@google.com> <20251221233635.3761887-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251221233635.3761887-2-bingjiao@google.com>
Subject: [PATCH v2 1/2] mm/vmscan: respect mems_effective in demote_folio_list()
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, cgroups@vger.kernel.org, Bing Jiao <bingjiao@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
introduces the cpuset.mems_effective check and applies it to
can_demote(). However, it does not apply this check in
demote_folio_list().

This omission leads to situations where pages are demoted to nodes
that are explicitly excluded from the task's cpuset.mems.
The impact is two-fold:

  1. Resource Isolation: This bug breaks resource isolation provided
     by cpuset.mems. It allows pages to be demoted to nodes that are
     dedicated to other tasks or are intended for hot-unplugging.

  2. Performance Issue: In multi-tier systems, users use cpuset.mems
     to bind tasks to different performed-far tiers (e.g., avoiding
     the slowest tiers for latency-sensitive data). This bug can
     cause unexpected latency spikes if pages are demoted to the
     farthest nodes.

To address the bug, implement a new function
mem_cgroup_filter_mems_allowed() to filter out nodes that are not
set in mems_effective, and update demote_folio_list() to utilize
this filtering logic. This ensures that demotions target respect
task's memory placement constraints.

Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 include/linux/cpuset.h     |  6 ++++++
 include/linux/memcontrol.h |  7 +++++++
 kernel/cgroup/cpuset.c     | 18 ++++++++++++++++++
 mm/memcontrol.c            |  6 ++++++
 mm/vmscan.c                | 13 ++++++++++---
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index a98d3330385c..0e94548e2d24 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -175,6 +175,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 }
 
 extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask);
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -305,6 +306,11 @@ static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 {
 	return true;
 }
+
+static inline void cpuset_node_filter_allowed(struct cgroup *cgroup,
+					      nodemask_t *mask)
+{
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fd400082313a..7cfd71c57caa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1742,6 +1742,8 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 
 bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
 
+void mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg, nodemask_t *mask);
+
 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
 
 static inline bool memcg_is_dying(struct mem_cgroup *memcg)
@@ -1816,6 +1818,11 @@ static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
 	return true;
 }
 
+static inline bool mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg,
+						  nodemask_t *mask)
+{
+}
+
 static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
 {
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6e6eb09b8db6..2925bd6bca91 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4452,6 +4452,24 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	return allowed;
 }
 
+void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
+
+	if (!cpuset_v2())
+		return;
+
+	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
+	if (!css)
+		return;
+
+	/* Follows the same assumption in cpuset_node_allowed() */
+	cs = container_of(css, struct cpuset, css);
+	nodes_and(*mask, *mask, cs->effective_mems);
+	css_put(css);
+}
+
 /**
  * cpuset_spread_node() - On which node to begin search for a page
  * @rotor: round robin rotor
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..f414653867de 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5602,6 +5602,12 @@ bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
 	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
 }
 
+void mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
+{
+	if (memcg)
+		cpuset_node_filter_allowed(memcg->css.cgroup, mask);
+}
+
 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
 {
 	if (mem_cgroup_disabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 453d654727c1..4d23c491e914 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1018,7 +1018,8 @@ static struct folio *alloc_demote_folio(struct folio *src,
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      struct mem_cgroup *memcg)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
@@ -1032,7 +1033,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
 		.nmask = &allowed_mask,
 		.reason = MR_DEMOTION,
 	};
@@ -1044,6 +1044,13 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		return 0;
 
 	node_get_allowed_targets(pgdat, &allowed_mask);
+	/* Filter the given nmask based on cpuset.mems.allowed */
+	mem_cgroup_filter_mems_allowed(memcg, &allowed_mask);
+	if (nodes_empty(allowed_mask))
+		return 0;
+	if (!node_isset(target_nid, allowed_mask))
+		target_nid = node_random(&allowed_mask);
+	mtc.nid = target_nid;
 
 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
@@ -1565,7 +1572,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */
 
 	/* Migrate folios selected for demotion */
-	nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat, memcg);
 	nr_reclaimed += nr_demoted;
 	stat->nr_demoted += nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
-- 
2.52.0.351.gbe84eed79e-goog


