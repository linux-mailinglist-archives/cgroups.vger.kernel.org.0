Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BC1A2A3
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfEJRuA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 13:50:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727562AbfEJRuA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 13:50:00 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AHaXSC017909
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 10:49:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Vx+fboig1rRLQHiyt4x8kMFHXQDhcpUyPZUqbGASJ+s=;
 b=ZB5habr6JwKSQxVtjXM6wum/5y6gDXvf1zm3QSA0WIyWoZO0i14+TM/b/oM7egq7bYiV
 3g4QhKmma8jg8vvjz2wUOWmy60hvB5hQzF2j+cqTAiUfHn1ekIBYt1MxDskTPe6YkOVe
 PIOagbPtqJaAf4h5/koWYEhvVUOzJAzSXGs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2sdd3e0gb4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 10:49:59 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 10 May 2019 10:49:57 -0700
Received: by devvm2807.frc2.facebook.com (Postfix, from userid 119756)
        id 938503D2646C; Fri, 10 May 2019 10:49:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Dan Schatzberg <dschatzberg@fb.com>
Smtp-Origin-Hostname: devvm2807.frc2.facebook.com
CC:     Dan Schatzberg <dschatzberg@fb.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH] psi: Expose pressure metrics on root cgroup
Date:   Fri, 10 May 2019 10:49:34 -0700
Message-ID: <20190510174938.3361741-1-dschatzberg@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Pressure metrics are already recorded and exposed in procfs for the
entire system, but any tool which monitors cgroup pressure has to
special case the root cgroup to read from procfs. This patch exposes
the already recorded pressure metrics on the root cgroup.

Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
---
 include/linux/psi.h    |  1 +
 kernel/cgroup/cgroup.c | 18 ++++++++++++------
 kernel/sched/psi.c     |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index fc08da2bcc0a..64740dc42aa2 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -10,6 +10,7 @@ struct css_set;
 #ifdef CONFIG_PSI
 
 extern bool psi_disabled;
+extern struct psi_group psi_system;
 
 void psi_init(void);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dc8adb124874..3a748c746324 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3392,15 +3392,24 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 #ifdef CONFIG_PSI
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
-	return psi_show(seq, &seq_css(seq)->cgroup->psi, PSI_CPU);
+	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+
+	return psi_show(seq, psi, PSI_CPU);
 }
 static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
-	return psi_show(seq, &seq_css(seq)->cgroup->psi, PSI_MEM);
+	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+
+	return psi_show(seq, psi, PSI_MEM);
 }
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
-	return psi_show(seq, &seq_css(seq)->cgroup->psi, PSI_IO);
+	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+
+	return psi_show(seq, psi, PSI_IO);
 }
 #endif
 
@@ -4518,17 +4527,14 @@ static struct cftype cgroup_base_files[] = {
 #ifdef CONFIG_PSI
 	{
 		.name = "cpu.pressure",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cgroup_cpu_pressure_show,
 	},
 	{
 		.name = "memory.pressure",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cgroup_memory_pressure_show,
 	},
 	{
 		.name = "io.pressure",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cgroup_io_pressure_show,
 	},
 #endif
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc3faf56b614..59e67b3c3bc4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -150,7 +150,7 @@ static u64 psi_period __read_mostly;
 
 /* System-level pressure and stall tracking */
 static DEFINE_PER_CPU(struct psi_group_cpu, system_group_pcpu);
-static struct psi_group psi_system = {
+struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
-- 
2.17.1

