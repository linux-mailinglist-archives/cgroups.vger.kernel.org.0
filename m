Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4757C330
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiGUEGP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiGUEFj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F325C4A
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d7-20020a17090a564700b001f209736b89so4055168pji.0
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=chxgxgcpZm63zsd7qnwFUE6j0UUhwVxho98X19IjMdE=;
        b=MEqNBgP7agly9aS2Azra3w7VOxdjKrzITB65iYsv3NXbBBWm7HIegWxDU49K4BpbH1
         upu756UW+/g2v32lOG9VTubX3HCXZh4vdPmCLXyUcqTpp7LbUW3NBWRJB6sZ1dEz+9ax
         jLNPgIjfXX6x9qBkQEK+58do+zhoAlNUgAX7FEaaWcVrKLvW/1xA/CB4mwIZAR9wDsMm
         afAYO+RCU73xoMk/QP/DkmQSf3RstJQzsQzDCn07vnpAKmP8Y9Jyd9PXnblNfbBeLgiE
         ZFyMRwUN+WkXIe4M195SuIyrHTNTA04IEImzh2fl5Myw1YCVj/LGvPfEEQsF2ARkZEwa
         hbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chxgxgcpZm63zsd7qnwFUE6j0UUhwVxho98X19IjMdE=;
        b=Ait8OJ1U6RK3VYBPgOTP70jikJTaJS9QQiVdxwUgo5Opz6T/+hKoTHBypEkYpj+dV1
         kv6lvD1jvq1u8tDou+NEmDjSpQTZsyIiyBT0rj1DdbzhNYYesGHHb8yoTgFdvpDGRTBE
         RBDqXyUkq2fh4Ufl5mcd0NKJScc1qc6Mq7/aODrZ4GsTucEhMtk5CJu5alm2Tv+VR0x3
         O+d10kQm6jcEKUUibpl5OsVz/WVkXl42FiRpkkh5LLlIaMCDM2Gs5w3AuCUiJVsyqK2O
         S6f1YGdvVy8bZJzPpiqsYeZr+c1YC3awzo2g4iPkBhTX9/9rttvv9xJNT/XlmAmPCbQh
         pGag==
X-Gm-Message-State: AJIora9b86tRcEo7s7viCrB31DYzDwc6bMBB6CLQm5An7Z0PPio8cYyS
        M1Tf+8iU7UXl476C8oZuNEQroQ==
X-Google-Smtp-Source: AGRyM1vUIz6lPEf3HOHUkuvCGIIMxbk0t9sGoJJTfg14bbj82E++1uIgwhKvaCZx0C4rl6QULiYhTg==
X-Received: by 2002:a17:902:d552:b0:16d:33d2:955b with SMTP id z18-20020a170902d55200b0016d33d2955bmr177647plf.29.1658376335154;
        Wed, 20 Jul 2022 21:05:35 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:34 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 8/9] sched/psi: add kernel cmdline parameter psi_inner_cgroup
Date:   Thu, 21 Jul 2022 12:04:38 +0800
Message-Id: <20220721040439.2651-9-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

PSI accounts stalls for each cgroup separately and aggregates it
at each level of the hierarchy. This may case non-negligible overhead
for some workloads when under deep level of the hierarchy.

commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
make PSI to skip per-cgroup stall accounting, only account system-wide
to avoid this each level overhead.

For our use case, we also want leaf cgroup PSI accounted for userspace
adjustment on that cgroup, apart from only system-wide management.

So this patch add kernel cmdline parameter "psi_inner_cgroup" to control
whether or not to account for inner cgroups, which is default to true
for compatibility.

Performance test on Intel Xeon Platinum with 3 levels of cgroup:

1. default (psi_inner_cgroup=true)

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.032 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 7.758 [sec]

       7.758354 usecs/op
         128893 ops/sec

2. psi_inner_cgroup=false

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.032 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 7.309 [sec]

       7.309436 usecs/op
         136809 ops/sec

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 kernel/sched/psi.c                              | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..6beef5b8bc36 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4419,6 +4419,12 @@
 			tracking.
 			Format: <bool>
 
+	psi_inner_cgroup=
+			[KNL] Enable or disable pressure stall information
+			tracking for the inner cgroups.
+			Format: <bool>
+			default: enabled
+
 	psmouse.proto=	[HW,MOUSE] Highest PS2 mouse protocol extension to
 			probe for; one of (bare|imps|exps|lifebook|any).
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 2228cbf3bdd3..8d76920f47b3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -147,12 +147,21 @@ static bool psi_enable;
 #else
 static bool psi_enable = true;
 #endif
+
+static bool psi_inner_cgroup __read_mostly = true;
+
 static int __init setup_psi(char *str)
 {
 	return kstrtobool(str, &psi_enable) == 0;
 }
 __setup("psi=", setup_psi);
 
+static int __init setup_psi_inner_cgroup(char *str)
+{
+	return kstrtobool(str, &psi_inner_cgroup) == 0;
+}
+__setup("psi_inner_cgroup=", setup_psi_inner_cgroup);
+
 /* Running averages - we need to be higher-res than loadavg */
 #define PSI_FREQ	(2*HZ+1)	/* 2 sec intervals */
 #define EXP_10s		1677		/* 1/exp(2s/10s) as fixed-point */
@@ -958,7 +967,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	group_init(&cgroup->psi);
 
 	parent = cgroup_parent(cgroup);
-	if (parent && cgroup_parent(parent))
+	if (parent && cgroup_parent(parent) && psi_inner_cgroup)
 		cgroup->psi.parent = cgroup_psi(parent);
 	else
 		cgroup->psi.parent = &psi_system;
-- 
2.36.1

