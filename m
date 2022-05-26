Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111B1534ECC
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiEZMGD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiEZMGB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 08:06:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB8D02BB;
        Thu, 26 May 2022 05:06:00 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L865D3rFMzQkQJ;
        Thu, 26 May 2022 20:02:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 20:05:55 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 20:05:54 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <surenb@google.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] psi: dont alloc memory for psi by default
Date:   Thu, 26 May 2022 20:26:56 +0800
Message-ID: <20220526122656.256274-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Memory about struct psi_group is allocated by default for
each cgroup even if psi_disabled is true, in this case, these
allocated memory is waste, so alloc memory for struct psi_group
only when psi_disabled is false.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 include/linux/cgroup-defs.h |  2 +-
 include/linux/cgroup.h      |  2 +-
 kernel/cgroup/cgroup.c      |  8 ++++----
 kernel/sched/psi.c          | 19 +++++++++++++------
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1bfcfb1af352..672de25e3ec8 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -475,7 +475,7 @@ struct cgroup {
 	struct work_struct release_agent_work;
 
 	/* used to track pressure stalls */
-	struct psi_group psi;
+	struct psi_group *psi;
 
 	/* used to store eBPF programs */
 	struct cgroup_bpf bpf;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0d1ada8968d7..ed53bfe7c46c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -674,7 +674,7 @@ static inline void pr_cont_cgroup_path(struct cgroup *cgrp)
 
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 {
-	return &cgrp->psi;
+	return cgrp->psi;
 }
 
 bool cgroup_psi_enabled(void);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..90a654cb8a1e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3609,21 +3609,21 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
 
 	return psi_show(seq, psi, PSI_IO);
 }
 static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
 
 	return psi_show(seq, psi, PSI_MEM);
 }
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
 
 	return psi_show(seq, psi, PSI_CPU);
 }
@@ -3649,7 +3649,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 		return -EBUSY;
 	}
 
-	psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
 	new = psi_trigger_create(psi, buf, nbytes, res);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..ec66b40bdd40 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -957,10 +957,16 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
-	if (!cgroup->psi.pcpu)
+	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
+	if (!cgroup->psi)
 		return -ENOMEM;
-	group_init(&cgroup->psi);
+
+	cgroup->psi->pcpu = alloc_percpu(struct psi_group_cpu);
+	if (!cgroup->psi->pcpu) {
+		kfree(cgroup->psi);
+		return -ENOMEM;
+	}
+	group_init(cgroup->psi);
 	return 0;
 }
 
@@ -969,10 +975,11 @@ void psi_cgroup_free(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
-	free_percpu(cgroup->psi.pcpu);
+	cancel_delayed_work_sync(&cgroup->psi->avgs_work);
+	free_percpu(cgroup->psi->pcpu);
 	/* All triggers must be removed by now */
-	WARN_ONCE(cgroup->psi.poll_states, "psi: trigger leak\n");
+	WARN_ONCE(cgroup->psi->poll_states, "psi: trigger leak\n");
+	kfree(cgroup->psi);
 }
 
 /**
-- 
2.25.1

