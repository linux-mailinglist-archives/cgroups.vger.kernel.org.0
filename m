Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9859F500
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiHXIU4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiHXIUf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 04:20:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFC88DF1
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:20:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bf22so16317164pjb.4
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6sL83Ah5J4Txh12rTADuAWsNxWsApjv5n3GbxKgC1I4=;
        b=YyTOMGVC+f89/pninVXkLZTBAdHTuaIb2YEzmTpr0YhcBAB/Fl4riv1XmMp9t7/IgX
         DZN8LVI7gNWRHy74o7YokuVqq1F2V9MeAgwS+n2bGk0A5lEZLVj/5H1yAyJLv1nZ8aHb
         cCgN54uvzD7TG8tNlDqC5/pFIp+TBxvWFiBMy39oBNOjwMY5v011r/CuvA2HDHuNeRMR
         RMjTW6HpfO2VHwkeuJ8BM5zgJ2mhEUyAvpwMZQXQ/dsOyRhz8klkfhkJCODvAkjs80Oz
         FcTC5cO5EP1KDIEJwLV+Y1QMPimq9b3+58Ho3Sp/QIX1vYUTP0i7a6U/bkzjV9Z3KsR7
         oLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6sL83Ah5J4Txh12rTADuAWsNxWsApjv5n3GbxKgC1I4=;
        b=gSrNKJDSmFZItOn2QYR290VPLRbYW1Z0g8UwTXBdc8JzzK+fIy9ptoeWPEx20gXRbU
         FlA7WF36jmE54IBRPXlPPUouA91yJOGlA4MoGBqTR3CCWkeXEkDqLR2TfSrPXAmeq5FD
         V8tZKp3IV25x2FBKnvqvz11ZbXKSvbS4AyucAYaS5rnvj5Qcr5VMrMzzS9mAodpJ7uG2
         utyWXPzKUCvyQpPLI0d5lqs5EUu7Otj6CwX2SlBPY747D+O6qGLbJ2LncYZyDugOgnw5
         CwYAsL5LDQD0Hrv7E3tQUeeX35ghdnTBOnQbDYqdh8DBiMlf54YWhxvFByFxtqqftIX1
         9+ew==
X-Gm-Message-State: ACgBeo2z3rNVOGyAP5blxWkauKAqSDPp++uPNcjkkhCVxgMmQAX0IsM/
        rOZ5sUd+oCrqUWOKVKx3MGCJFg==
X-Google-Smtp-Source: AA6agR4WRBQ7a2V97gttdVqlEdAiRRGcv0hJ0GPlAD/yUyckgX7Do4diSR5lQ71J0urZXuz/wb5sxA==
X-Received: by 2002:a17:90b:1a8d:b0:1fb:3ab0:a470 with SMTP id ng13-20020a17090b1a8d00b001fb3ab0a470mr7323838pjb.154.1661329226958;
        Wed, 24 Aug 2022 01:20:26 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id q31-20020a635c1f000000b00421841943dfsm10486587pgb.12.2022.08.24.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:20:26 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
        surenb@google.com
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 08/10] sched/psi: consolidate cgroup_psi()
Date:   Wed, 24 Aug 2022 16:18:27 +0800
Message-Id: <20220824081829.33748-9-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824081829.33748-1-zhouchengming@bytedance.com>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 8540878469e6..cc228235ce38 100644
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

