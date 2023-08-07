Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC247718CB
	for <lists+cgroups@lfdr.de>; Mon,  7 Aug 2023 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjHGDaa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 6 Aug 2023 23:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjHGDa3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 6 Aug 2023 23:30:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F11735
        for <cgroups@vger.kernel.org>; Sun,  6 Aug 2023 20:30:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f090310dso4109713b3a.0
        for <cgroups@vger.kernel.org>; Sun, 06 Aug 2023 20:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691379002; x=1691983802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VSleIMqg0obClaPZQhg7+Ks6xrxwU85bZ75FMLlTO7c=;
        b=EnSVSnHsPlsW89xzfLkP3wUxd8KSZca7gDZUxHD2RVP7s44GVLnjzcbWmFVtLJnCV8
         CzDZNRwl2mo+D5XvQH1+JytoDuc4qdfSgKWq3EyWXSmbTMvnOB5fyBYbl9KaltxT6h2c
         FLSDhmaOfPYzWAd7bYGacMNsodAJgWHCZOjWe5ig6QevjgkdBPvKaFQbfpDcV/HTXQuX
         JrFxQb61l1zOUWWtucIgRCWnV3ogBWY3QhZilZ30hMLXiYYn4m3jDHi5ASFDduPgb5vK
         lvZGlTKYsprzbg0kqS+VVw9LK0m6HbbH1yYT8Pv9F4h4U2QhqCNHVFyRIzJzmnkp72nl
         1zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691379002; x=1691983802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSleIMqg0obClaPZQhg7+Ks6xrxwU85bZ75FMLlTO7c=;
        b=aQE56vBb7p8YumBg2bAxtrZATc/91kTYJO6hgPli+WFx+39RQFeNggK140j86IvtMr
         KylHP70qNhitl3kBYjyxQYqf+I/eHRfXzaEONlMNvufox3/w8hgK/ek/G6hH7cdnKshE
         NHSHWzcUUW9suEnlXeDXgkTsMAn4bqBhOlf1oKtaOaWmsD5m+9SRAPpYjcLd7fsg9oqy
         u0lYHDzR2F6K0WkShfaWvdIa0lwOxNHiYhVV7zwWaYhqTgH3Prr7QPAyiWaQ0UY8Tqkf
         hiQLszKAfyybkLwT78/sMsmgxu6Av5q9dLABkCpEHLYbKEQSVEm1iNC00gFi2HT1zC2E
         FcNw==
X-Gm-Message-State: AOJu0Yxo+e1tlH9O5tFhdVhcP6476yX02PmNWBI+/Lyghp71TLdQiMVF
        XDNt7xmkYc2Q/Mj+zB2EvONFcg==
X-Google-Smtp-Source: AGHT+IG8fmXur3s2KO5buqj3TgXjLGGwgt7oY8Q8Q2f2F5vXxO37J7w8kNvkogYrMMjscctKybO3NQ==
X-Received: by 2002:a05:6a20:394a:b0:13d:b318:5c70 with SMTP id r10-20020a056a20394a00b0013db3185c70mr11552531pzg.19.1691379002059;
        Sun, 06 Aug 2023 20:30:02 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b0067acbc74977sm5145675pfo.96.2023.08.06.20.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 20:30:01 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com, songmuchun@bytedance.com, muchun.song@linux.dev,
        wuyun.abel@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2] cgroup/rstat: Record the cumulative per-cpu time of cgroup and its descendants
Date:   Mon,  7 Aug 2023 11:29:30 +0800
Message-Id: <20230807032930.87785-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The member variable bstat of the structure cgroup_rstat_cpu
records the per-cpu time of the cgroup itself, but does not
include the per-cpu time of its descendants. The per-cpu time
including descendants is very useful for calculating the
per-cpu usage of cgroups.

Although we can indirectly obtain the total per-cpu time
of the cgroup and its descendants by accumulating the per-cpu
bstat of each descendant of the cgroup. But after a child cgroup
is removed, we will lose its bstat information. This will cause
the cumulative value to be non-monotonic, thus affecting
the accuracy of cgroup per-cpu usage.

So we add the subtree_bstat variable to record the total
per-cpu time of this cgroup and its descendants, which is
similar to "cpuacct.usage*" in cgroup v1. And this is
also helpful for the migration from cgroup v1 to cgroup v2.
After adding this variable, we can obtain the per-cpu time of
cgroup and its descendants in user mode through eBPF/drgn, etc.
And we are still trying to determine how to expose it in the
cgroupfs interface.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 include/linux/cgroup-defs.h | 14 ++++++++++++++
 kernel/cgroup/rstat.c       | 12 ++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c7be..7a2862172f51 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -341,6 +341,20 @@ struct cgroup_rstat_cpu {
 	 */
 	struct cgroup_base_stat last_bstat;
 
+	/*
+	 * This field is used to record the cumulative per-cpu time of
+	 * the cgroup and its descendants. Currently it can be read via
+	 * eBPF/drgn etc, and we are still trying to determine how to
+	 * expose it in the cgroupfs interface.
+	 */
+	struct cgroup_base_stat subtree_bstat;
+
+	/*
+	 * Snapshots at the last reading. These are used to calculate the
+	 * deltas to propagate to the per-cpu subtree_bstat.
+	 */
+	struct cgroup_base_stat last_subtree_bstat;
+
 	/*
 	 * Child cgroups with stat updates on this cpu since the last read
 	 * are linked on the parent's ->updated_children through
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 2542c21b6b6d..d80d7a608141 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -344,6 +344,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
+	struct cgroup_rstat_cpu *prstatc;
 	struct cgroup_base_stat delta;
 	unsigned seq;
 
@@ -357,17 +358,24 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		delta = rstatc->bstat;
 	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
 
-	/* propagate percpu delta to global */
+	/* propagate per-cpu delta to cgroup and per-cpu global statistics */
 	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
 	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
+	cgroup_base_stat_add(&rstatc->subtree_bstat, &delta);
 
-	/* propagate global delta to parent (unless that's root) */
+	/* propagate cgroup and per-cpu global delta to parent (unless that's root) */
 	if (cgroup_parent(parent)) {
 		delta = cgrp->bstat;
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
 		cgroup_base_stat_add(&parent->bstat, &delta);
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
+
+		delta = rstatc->subtree_bstat;
+		prstatc = cgroup_rstat_cpu(parent, cpu);
+		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
+		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
+		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
 	}
 }
 
-- 
2.37.0

