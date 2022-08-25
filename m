Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704DB5A1726
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiHYQpm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbiHYQon (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 12:44:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBBBB029
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:43:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 202so18362210pgc.8
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3dDUh515nbOqGsG/LfVzQC677KwPKHwRqNRxhOWX6cc=;
        b=NU1aKrdzuN6/Kk7ZJlXzbBU3CIdEo1joWwClSvj5lEoxy27kjb88T8rqu2WLk1jegG
         HeYyNmvy/HkWbpCbLqEJEhQ4Ulh2IOjxVmXE0LqKAMafjP/pRuMmt7lNJYCLnJlBhnZo
         qEr/fATAqaJWQUhApGNU1zlux5L7PC5U06ZvoqHBFBo4Eof4lx4s0c1uPeLoMil3tkC8
         nn1YXFB5EvF8jGhnWuKmDqn5LQxB7YgBMHSA9CNtLiNdoIefNFxH8zCpmSEO/yDFC1S+
         hhZvMxIeFMA8vOUHQvVTeUPqL6jSMPUVhOixmiibNU0IHdeMdFeOE/AxWARGilpi0ygW
         JNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3dDUh515nbOqGsG/LfVzQC677KwPKHwRqNRxhOWX6cc=;
        b=46TUX1QToNuL/UmsxWurF+k0V4bItTpEsPULkt1AI+sH6Fv2si2v2i0MDo4TH1EQN0
         UWKOeTwA78ZsIBiZChzT/Of8zeLxMF4HjXi2ZVtdkFW282hn1VcpqvR7TN2G1UojCkqY
         XdRJUgoyzqUL+cYvjCXqQ4QCuUZVxlCEPr/yTB+nKf535u1ZgHgpnQmt8WSg3zaTELd5
         7pcUTJbsYbsRmZYUNAPzXCk+c6XTpnNvinOv5RruHAhWEF6w7MflPz3/NaRsFoAY7cua
         pEh5PfzLe3PEswW3Cd/ieGRpb3JGPdMT3I/Qy/dt5LZqUCqFBGmxVSmk9kg5Vzpmd6x2
         LCHQ==
X-Gm-Message-State: ACgBeo2SYKAOF5DIhzPlUFq/rR2DONw1Hdk9AIgzQZE3uhmVrw1Rnxug
        2qd68LYAI+94jH6xIr3/i8IIRw==
X-Google-Smtp-Source: AA6agR4ice9pBjYfS1f7cHhc89813aaWR2BqW2D7YVddtufffarUZFvJ/PND+vlX3GQzDyWHM0mDPw==
X-Received: by 2002:a65:520c:0:b0:42b:31fd:b2c6 with SMTP id o12-20020a65520c000000b0042b31fdb2c6mr3849578pgp.562.1661445797763;
        Thu, 25 Aug 2022 09:43:17 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm12779408pff.67.2022.08.25.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:43:17 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com,
        surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 08/10] sched/psi: consolidate cgroup_psi()
Date:   Fri, 26 Aug 2022 00:41:09 +0800
Message-Id: <20220825164111.29534-9-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164111.29534-1-zhouchengming@bytedance.com>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_psi() can't return psi_group for root cgroup, so we have many
open code "psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi".

This patch move cgroup_psi() definition to <linux/psi.h>, in which
we can return psi_system for root cgroup, so can handle all cgroups.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/cgroup.h |  5 -----
 include/linux/psi.h    |  6 ++++++
 kernel/cgroup/cgroup.c | 10 +++++-----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7ed1fa7a6fc8..3c48753f2949 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -682,11 +682,6 @@ static inline void pr_cont_cgroup_path(struct cgroup *cgrp)
 	pr_cont_kernfs_path(cgrp->kn);
 }
 
-static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
-{
-	return cgrp->psi;
-}
-
 bool cgroup_psi_enabled(void);
 
 static inline void cgroup_init_kthreadd(void)
diff --git a/include/linux/psi.h b/include/linux/psi.h
index fffd229fbf19..362a74ca1d3b 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include <linux/cgroup-defs.h>
+#include <linux/cgroup.h>
 
 struct seq_file;
 struct css_set;
@@ -30,6 +31,11 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 			poll_table *wait);
 
 #ifdef CONFIG_CGROUPS
+static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
+{
+	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+}
+
 int psi_cgroup_alloc(struct cgroup *cgrp);
 void psi_cgroup_free(struct cgroup *cgrp);
 void cgroup_move_task(struct task_struct *p, struct css_set *to);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 371131a8b6f8..1d392c91ef95 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3657,21 +3657,21 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	struct psi_group *psi = cgroup_psi(cgrp);
 
 	return psi_show(seq, psi, PSI_IO);
 }
 static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	struct psi_group *psi = cgroup_psi(cgrp);
 
 	return psi_show(seq, psi, PSI_MEM);
 }
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	struct psi_group *psi = cgroup_psi(cgrp);
 
 	return psi_show(seq, psi, PSI_CPU);
 }
@@ -3697,7 +3697,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 		return -EBUSY;
 	}
 
-	psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	psi = cgroup_psi(cgrp);
 	new = psi_trigger_create(psi, buf, res);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
@@ -3735,7 +3735,7 @@ static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 static int cgroup_irq_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	struct psi_group *psi = cgroup_psi(cgrp);
 
 	return psi_show(seq, psi, PSI_IRQ);
 }
-- 
2.37.2

