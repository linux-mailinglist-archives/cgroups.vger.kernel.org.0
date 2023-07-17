Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624A755F83
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGQJkS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGQJkA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 05:40:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268264223
        for <cgroups@vger.kernel.org>; Mon, 17 Jul 2023 02:37:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2647423b3a.3
        for <cgroups@vger.kernel.org>; Mon, 17 Jul 2023 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689586656; x=1692178656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt43AGwP78WC80RAn41rmisnWae//0xO36ekfLuw42c=;
        b=jC7fae8lFjyqrJWA2LzQPl6FbH1OzsT5Gc9737HZWMKXRD8pS+FDesVLzG0MQUqivh
         kl0w0WfhfNnUmT2cbdRlls0wJchGwg894mxP/5U0yarwfQgprEiVOnnwfmnHohS1jZSW
         j87ESoEDgVl+b4VDIsU5ca1jtHsLvptabPi+ZnzFRa3j6DfGYqKs/18Zme/MQdY6nH/O
         LbhS023WhlvCRp50+HcW6ViDqX6PaIOYyw0PGCdNGbKwtmrs29t8xq7FwNPsgOT6Z0tG
         XR6uUb3PxyTKPdpOIoiLAzWTe7TZZhXf8qC5Jq99z9ah1ypSPMuES/nvhj5TOAPtn5wl
         IZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586656; x=1692178656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt43AGwP78WC80RAn41rmisnWae//0xO36ekfLuw42c=;
        b=H4AKFuBM467fBdD4Far3uya7Nt9SzHEAE3sc2i7fcm9Jy66argas/2uiWV6ISNqh99
         P++7nOV08GXwMl4dRCWz4BUFDACxhSibllmjamT1uGzMPwydYX/wL/UI1HVjrZEaXRLw
         gwURLmPHDDt5L737o39tyZ9RvM6nDFkd/texZrd93DfnXJDLsAh83Jno9FIlG1s7PMoi
         /UCaV7GcB6tYYUKYfgCd8MeI1CaKjlFu41m6ycdgAV4xm9LdzKennIFswIaee9RY4PA+
         EBQ80O2cdq7eVgcu3E7ZaGRF4+e+cV4ibkZnMbF+FkVDvmtYolkFNuQ1+g7npWZ7C0nv
         k8kA==
X-Gm-Message-State: ABy/qLbDx67WFNgI7N2dXmECUqI8W2tkfKG7olQw2m4bOxfzOifA5N+I
        4eBJ9n+iP1Tv95l9jNsL7MPBR+WzTEQRt48UQDc=
X-Google-Smtp-Source: APBJJlEi5FKYNab5ZfbXQFHiYyO4nWkp890dCF+4uVRDSCNzu22deBhJ2q2Q6auiU9KLTtcsnHqTdw==
X-Received: by 2002:a05:6a21:8cc4:b0:134:2fd0:7362 with SMTP id ta4-20020a056a218cc400b001342fd07362mr5248697pzb.22.1689586655878;
        Mon, 17 Jul 2023 02:37:35 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id t5-20020aa79385000000b0063d2dae6247sm11541435pfe.77.2023.07.17.02.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:37:35 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] cgroup/rstat: record the cumulative per-cpu time of cgroup and its descendants
Date:   Mon, 17 Jul 2023 17:36:12 +0800
Message-Id: <20230717093612.40846-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now the member variable bstat of the structure cgroup_rstat_cpu
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

So we add the cumul_bstat variable to record the total
per-cpu time of this cgroup and its descendants, which is
similar to "cpuacct.usage*" in cgroup v1. And this is
also helpful for the migration from cgroup v1 to cgroup v2.
After adding this variable, we can obtain the per-cpu time of
cgroup and its descendants in user mode through eBPF, etc.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 include/linux/cgroup-defs.h | 3 +++
 kernel/cgroup/rstat.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c7be..25114d62089e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -341,6 +341,9 @@ struct cgroup_rstat_cpu {
 	 */
 	struct cgroup_base_stat last_bstat;
 
+	/* Record the cumulative per-cpu time of cgroup and its descendants */
+	struct cgroup_base_stat cumul_bstat;
+
 	/*
 	 * Child cgroups with stat updates on this cpu since the last read
 	 * are linked on the parent's ->updated_children through
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 2542c21b6b6d..7c0ddd2e90d7 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -361,11 +361,15 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
 	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
+	cgroup_base_stat_add(&rstatc->cumul_bstat, &delta);
 
 	/* propagate global delta to parent (unless that's root) */
 	if (cgroup_parent(parent)) {
 		delta = cgrp->bstat;
+		rstatc = cgroup_rstat_cpu(parent, cpu);
+
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
+		cgroup_base_stat_add(&rstatc->cumul_bstat, &delta);
 		cgroup_base_stat_add(&parent->bstat, &delta);
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 	}
-- 
2.37.0

