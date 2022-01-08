Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1AF487FF6
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 01:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiAHAib (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 19:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiAHAia (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 19:38:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0DC061574;
        Fri,  7 Jan 2022 16:38:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w16so28165879edc.11;
        Fri, 07 Jan 2022 16:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0tl3tl0Rjc2H0O+Ee2YyH8tQI/ckCB3TAtw6D3Jv5pM=;
        b=adrk8Xw7lRyfAdM25xuBROnlbcbIFuOH92rt485pDgwwZdlOz2u5Yz1u2I8lc6MJQl
         HDg2dxVdKKlLxzHauMj8/yUrURVEd7WRrZ3cqjaNIdwAn+ehUVzwpb0kg7CTLL/WlGin
         lSNEJ/JsbcPp4ml4ICZs1p0pzbVLfRRe/6KTSpr5Gvo9Jgo0roCK4h23XAfRePsqnolr
         LHVKibo5T+STaa19Id/Um9Gj1qNrSnBnJ2QCYkewrZPUJc2UYf0y7Zn+MGV4AoxYW/4q
         arvSMjdA1/ihdOJyKUsw3H98k79N5gW2afa62fQSAMmSmCzjjhE19NiktT0izGYxf4Yc
         2agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0tl3tl0Rjc2H0O+Ee2YyH8tQI/ckCB3TAtw6D3Jv5pM=;
        b=xN0o6bFD9cjkDJMha2R8Rx0E07NptErt0ThAequvY9N1KDhrNqT4Ti+vDkQON5u2Ds
         QB+zWI9U5x6TwR9mjiw7VcDDC88lupVcY45NwHnheD1tX6SVLq6iVMEiUJDairy42sLW
         IPhqCaA9iExp2yZcfZv4OrlUx9VSmufdNILmppJK79H3iXlNbsT4UTMur1VaUVf3lnCe
         22ZoDRFKfQ2rr+4XRXNy/fmBrD2U2+xvB7QUf321hlhtAio9Ukb542dWm3ILDl4Cwz3T
         EFnqDj0p7vtxvRNhxfkGctUqysf6QnFykgfDNMC5l26oq/y4H7MM6GYdLe+KZYEx5bT9
         cZmg==
X-Gm-Message-State: AOAM530f7Kwv4kNkT/NWueeYK5STImrbmQcXYQ3kGj+DIU5MtxeQiSaR
        2uYPQ0A1lABehYnP3IcFUMUEdF+ubw4=
X-Google-Smtp-Source: ABdhPJyg3pvFHTC+0G1Tb2kJjlfdwUQUr6iJtSIHeRpF9F2FApwLxyz3dQ1eN28PlX3LdLntjN+nGA==
X-Received: by 2002:a17:907:7202:: with SMTP id dr2mr51490145ejc.442.1641602308578;
        Fri, 07 Jan 2022 16:38:28 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c9sm50507ejf.170.2022.01.07.16.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jan 2022 16:38:28 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] cgroup: rstat: retrieve current bstat to delta directly
Date:   Sat,  8 Jan 2022 00:38:17 +0000
Message-Id: <20220108003817.6619-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220108003817.6619-1-richard.weiyang@gmail.com>
References: <20220108003817.6619-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of retrieve current bstat to cur and copy it to delta, let's use
delta directly.

This saves one copy operation and has the same code convention as
propagating delta to parent.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/rstat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c626d5a526c4..f66944c53613 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -314,7 +314,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_base_stat cur, delta;
+	struct cgroup_base_stat delta;
 	unsigned seq;
 
 	/* Root-level stats are sourced from system-wide CPU stats */
@@ -324,11 +324,10 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	/* fetch the current per-cpu values */
 	do {
 		seq = __u64_stats_fetch_begin(&rstatc->bsync);
-		cur = rstatc->bstat;
+		delta = rstatc->bstat;
 	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
 
 	/* propagate percpu delta to global */
-	delta = cur;
 	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
 	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
-- 
2.33.1

