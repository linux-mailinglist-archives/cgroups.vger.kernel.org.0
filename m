Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2B30CA7D
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhBBSun (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 13:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbhBBSsk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 13:48:40 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED5C061351
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 10:48:00 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a1so10366020qvd.13
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIYQWYhqyLwEqsbVc7mdSrEASRoPZLsNukqo0gJhBmg=;
        b=UA+NDRaUgwhmDiqE9A/0CZWTqaviooGCnPGyA+jZ2rmm9s/ZWHmRACKLLov+V3gnkf
         f+WbulaPJMozM9OO9Nm70fO1X+fZ96IGtJLLv8iQasxbYpNhytoZLiw2GErGyqDmG7U/
         kQiBBHmf7csgJc/wcdVAf77uLQqTFN/SY4go1+zwoWOteoN4cDkF1qgflZikBVisGnJ6
         huximZuV8y3uI3nAgaySyrwW9iKWbTA3DLjStpuUBXO88S7Qfy5H/ityRic6Swg8CM9v
         3qeCFwAgZ+ZNOyO7e06J3eVQmDaJCPOAb4z07v0tBl3Ehtq9UApNk9+k9a+1wmuxnVBS
         2zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIYQWYhqyLwEqsbVc7mdSrEASRoPZLsNukqo0gJhBmg=;
        b=IYIRnwtCpOIOmRRMpjF0u3JLDFRaT4KvLtQkZRCJg+nISD9Y2KwofTSzYeDlMHbb55
         LyAwnqduVubnTsBmEDolquyVkA+XOMi0Hkx0AreOWz2HnPX5JvTad9Vr9ynD7Wf8M7MR
         Otwm6EWROC7SU13kwTgf+eBNczMFmfU8XA/m2DUAOcoFsJvQZvqo7/I5eGbvcJQO1gDG
         3vNiJOtqdB8b80sLeHQClb7XGSeLw+fipfe7tJb6QdZJ16niJMWnNOMkTzN3M1Um3lc+
         vqViRtmZ0uUkbPaUTZxMid1jjBGOiz9Ls1Ae6UygAO3e6vg1QkGA6LQgbQjNKtEo4/EL
         d1vg==
X-Gm-Message-State: AOAM531bZnsnqSubBqiTLQ3pCx1A5aoZ/flljUdsD28BAysB+PRccQXC
        0UIiP6F/mWfZdL5Hpd8hlLUElr9a7xLwNw==
X-Google-Smtp-Source: ABdhPJwKzK8oTl/nXwYBkFb8pFZhqxFNYPm1ZDqXwBOlixoBPuZguX4hE2gQpL4i5jlg/B7/MsaObw==
X-Received: by 2002:ad4:4c84:: with SMTP id bs4mr21871414qvb.0.1612291679723;
        Tue, 02 Feb 2021 10:47:59 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id j66sm18116876qkf.78.2021.02.02.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:47:59 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/7] cgroup: rstat: punt root-level optimization to individual controllers
Date:   Tue,  2 Feb 2021 13:47:44 -0500
Message-Id: <20210202184746.119084-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202184746.119084-1-hannes@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current users of the rstat code can source root-level statistics from
the native counters of their respective subsystem, allowing them to
forego aggregation at the root level. This optimization is currently
implemented inside the generic rstat code, which doesn't track the
root cgroup and doesn't invoke the subsystem flush callbacks on it.

However, the memory controller cannot do this optimization, because
cgroup1 breaks out memory specifically for the local level, including
at the root level. In preparation for the memory controller switching
to rstat, move the optimization from rstat core to the controllers.

Afterwards, rstat will always track the root cgroup for changes and
invoke the subsystem callbacks on it; and it's up to the subsystem to
special-case and skip aggregation of the root cgroup if it can source
this information through other, cheaper means.

The extra cost of tracking the root cgroup is negligible: on stat
changes, we actually remove a branch that checks for the root. The
queueing for a flush touches only per-cpu data, and only the first
stat change since a flush requires a (per-cpu) lock.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/blk-cgroup.c    | 14 +++++++---
 kernel/cgroup/rstat.c | 60 +++++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 02ce2058c14b..76725e1cad7f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -766,6 +766,10 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct blkcg_gq *blkg;
 
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (!cgroup_parent(css->cgroup))
+		return;
+
 	rcu_read_lock();
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -789,6 +793,7 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		u64_stats_update_end(&blkg->iostat.sync);
 
 		/* propagate global delta to parent */
+		/* XXX: could skip this if parent is root */
 		if (parent) {
 			u64_stats_update_begin(&parent->iostat.sync);
 			blkg_iostat_set(&delta, &blkg->iostat.cur);
@@ -803,10 +808,11 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 }
 
 /*
- * The rstat algorithms intentionally don't handle the root cgroup to avoid
- * incurring overhead when no cgroups are defined. For that reason,
- * cgroup_rstat_flush in blkcg_print_stat does not actually fill out the
- * iostat in the root cgroup's blkcg_gq.
+ * We source root cgroup stats from the system-wide stats to avoid
+ * tracking the same information twice and incurring overhead when no
+ * cgroups are defined. For that reason, cgroup_rstat_flush in
+ * blkcg_print_stat does not actually fill out the iostat in the root
+ * cgroup's blkcg_gq.
  *
  * However, we would like to re-use the printing code between the root and
  * non-root cgroups to the extent possible. For that reason, we simulate
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index faa767a870ba..6f50c199bf2a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -25,13 +25,8 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup *parent;
 	unsigned long flags;
 
-	/* nothing to do for root */
-	if (!cgroup_parent(cgrp))
-		return;
-
 	/*
 	 * Speculative already-on-list test. This may race leading to
 	 * temporary inaccuracies, which is fine.
@@ -46,10 +41,10 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	raw_spin_lock_irqsave(cpu_lock, flags);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
-	for (parent = cgroup_parent(cgrp); parent;
-	     cgrp = parent, parent = cgroup_parent(cgrp)) {
+	while (true) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
+		struct cgroup *parent = cgroup_parent(cgrp);
+		struct cgroup_rstat_cpu *prstatc;
 
 		/*
 		 * Both additions and removals are bottom-up.  If a cgroup
@@ -58,8 +53,16 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 		if (rstatc->updated_next)
 			break;
 
+		if (!parent) {
+			rstatc->updated_next = cgrp;
+			break;
+		}
+
+		prstatc = cgroup_rstat_cpu(parent, cpu);
 		rstatc->updated_next = prstatc->updated_children;
 		prstatc->updated_children = cgrp;
+
+		cgrp = parent;
 	}
 
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
@@ -113,23 +116,26 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	 */
 	if (rstatc->updated_next) {
 		struct cgroup *parent = cgroup_parent(pos);
-		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
-		struct cgroup_rstat_cpu *nrstatc;
-		struct cgroup **nextp;
-
-		nextp = &prstatc->updated_children;
-		while (true) {
-			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
-			if (*nextp == pos)
-				break;
-
-			WARN_ON_ONCE(*nextp == parent);
-			nextp = &nrstatc->updated_next;
+
+		if (parent) {
+			struct cgroup_rstat_cpu *prstatc;
+			struct cgroup **nextp;
+
+			prstatc = cgroup_rstat_cpu(parent, cpu);
+			nextp = &prstatc->updated_children;
+			while (true) {
+				struct cgroup_rstat_cpu *nrstatc;
+
+				nrstatc = cgroup_rstat_cpu(*nextp, cpu);
+				if (*nextp == pos)
+					break;
+				WARN_ON_ONCE(*nextp == parent);
+				nextp = &nrstatc->updated_next;
+			}
+			*nextp = rstatc->updated_next;
 		}
 
-		*nextp = rstatc->updated_next;
 		rstatc->updated_next = NULL;
-
 		return pos;
 	}
 
@@ -309,11 +315,15 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_base_stat cur, delta;
 	unsigned seq;
 
+	/* Root-level stats are sourced from system-wide CPU stats */
+	if (!parent)
+		return;
+
 	/* fetch the current per-cpu values */
 	do {
 		seq = __u64_stats_fetch_begin(&rstatc->bsync);
@@ -326,8 +336,8 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
 	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
 
-	/* propagate global delta to parent */
-	if (parent) {
+	/* propagate global delta to parent (unless that's root) */
+	if (cgroup_parent(parent)) {
 		delta = cgrp->bstat;
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
 		cgroup_base_stat_add(&parent->bstat, &delta);
-- 
2.30.0

