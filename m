Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666E51E50AB
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgE0Vqr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 17:46:47 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:48525 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbgE0Vqr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 May 2020 17:46:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E0700AAA;
        Wed, 27 May 2020 17:46:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 17:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=1uMfllCwGVRSV
        eD897uL9SAlLt6bpaVgLEM5vf/6PXU=; b=n5jA1URN2O3JQQOPok0OlsSawfeLb
        qbcVZyXyIOqc6v3EddUBeX2546X93UB6qLgI/tUrxtS7V7joMKVJch25KM6pi07J
        2G4QRoB5Z5Gp6iLFfjIzZQgmBePIV+CiRnSljB8JMlMF8VryCaYpgdqvHH18HC2p
        N9SfcT/g5sMGoAoJTlompcbWSatAW3SmDwAlwEqGhrZ2rb4h+ucztpJ7m+R/Y217
        vD2l6OBFvxs3ylviaMh9x339IDg5qNBMRvKL0vW0qy8Kq/u6+YpzRcysjUnb6c23
        oLZK0HZ1VskQV+FoPvUuwi6qoH4eYr22Dmn8DKgrQtCqsGkbBit2Y0Cdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=1uMfllCwGVRSVeD897uL9SAlLt6bpaVgLEM5vf/6PXU=; b=vhoXYIJy
        /3lxQnWiTue+356RJ4otCRAQYzaNChiU+HSGfGb3JVGdhIs6J6jBuZ3DPWPe444H
        OpqQccWga+AETOEIZwyUEWEiH6sJrqkOsSvpY2DlSnbsm+RFqzvTjBgVfKKewHwV
        1XMl++ndMIQr5BGrEeBBG8qZ2zPnhgH1MbJBQ3kqtQBUpVn4cVfvahqL0wBR2zcV
        PwLWrqQ5tCe1cA5UHpI/EIfMfgxeKKg2k7P4wauR3jXRa2qdDApY0sjFusDBgn+7
        Zzk0eMXCjxFgWcVTecs325j0DHqERu/P8Qzc5J3B/igvzH9jRXjt3dIi8pmioNyu
        ZTa2649CKs8xlA==
X-ME-Sender: <xms:w9_OXihbCd_T2cI525J_EuxTj3CfThoBndGDvD07xykf1PKJ31HMCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:w9_OXjDct1_DPzWmPDM8nOmLIsZk_q8ZQDxHzUBoVlvzM8ZmPvw7WQ>
    <xmx:w9_OXqE4vIQU7lIpdphkuEZiXCEwRsUp-ya6HK3lEyxII_lhXUc7CQ>
    <xmx:w9_OXrQuVLYJb0xRS0DX18E9ve8yUVTS-Fvixgrs81FBU0Z6Q5G3Mw>
    <xmx:xd_OXmzSkHVYyo8lVCKGqV_RQ9cG495BkLBY6v8z7cupzCq6mlTciwx-djiOrpZYFkibbQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 111E23280060;
        Wed, 27 May 2020 17:46:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Boris Burkov <boris@bur.io>
Subject: [PATCH v2 cgroup/for-5.8] cgroup: add cpu.stat file to root cgroup
Date:   Wed, 27 May 2020 14:43:19 -0700
Message-Id: <20200527214316.524124-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527160821.GC42293@cmpxchg.org>
References: <20200527160821.GC42293@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, the root cgroup does not have a cpu.stat file. Add one which
is consistent with /proc/stat to capture global cpu statistics that
might not fall under cgroup accounting.

We haven't done this in the past because the data are already presented
in /proc/stat and we didn't want to add overhead from collecting root
cgroup stats when cgroups are configured, but no cgroups have been
created.

By keeping the data consistent with /proc/stat, I think we avoid the
first problem, while improving the usability of cgroups stats.
We avoid the second problem by computing the contents of cpu.stat from
existing data collected for /proc/stat anyway.

Signed-off-by: Boris Burkov <boris@bur.io>
Suggested-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 +--
 kernel/cgroup/cgroup.c                  |  1 -
 kernel/cgroup/rstat.c                   | 60 +++++++++++++++++++++----
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index fed4e1d2a343..fec2f13fe065 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -714,9 +714,7 @@ Conventions
 - Settings for a single feature should be contained in a single file.
 
 - The root cgroup should be exempt from resource control and thus
-  shouldn't have resource control interface files.  Also,
-  informational files on the root cgroup which end up showing global
-  information available elsewhere shouldn't exist.
+  shouldn't have resource control interface files.
 
 - The default time unit is microseconds.  If a different unit is ever
   used, an explicit unit suffix must be present.
@@ -985,7 +983,7 @@ CPU Interface Files
 All time durations are in microseconds.
 
   cpu.stat
-	A read-only flat-keyed file which exists on non-root cgroups.
+	A read-only flat-keyed file.
 	This file exists whether the controller is enabled or not.
 
 	It always reports the following three stats:
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 557a9b9d2244..b8a75169c3e4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4881,7 +4881,6 @@ static struct cftype cgroup_base_files[] = {
 	},
 	{
 		.name = "cpu.stat",
-		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_stat_show,
 	},
 #ifdef CONFIG_PSI
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 41ca996568df..b6397a186ce9 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -389,18 +389,62 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	cgroup_base_stat_cputime_account_end(cgrp, rstatc);
 }
 
+/*
+ * compute the cputime for the root cgroup by getting the per cpu data
+ * at a global level, then categorizing the fields in a manner consistent
+ * with how it is done by __cgroup_account_cputime_field for each bit of
+ * cpu time attributed to a cgroup.
+ */
+static void root_cgroup_cputime(struct task_cputime *cputime)
+{
+	int i;
+
+	cputime->stime = 0;
+	cputime->utime = 0;
+	cputime->sum_exec_runtime = 0;
+	for_each_possible_cpu(i) {
+		struct kernel_cpustat kcpustat;
+		u64 *cpustat = kcpustat.cpustat;
+		u64 user = 0;
+		u64 sys = 0;
+
+		kcpustat_cpu_fetch(&kcpustat, i);
+
+		user += cpustat[CPUTIME_USER];
+		user += cpustat[CPUTIME_NICE];
+		cputime->utime += user;
+
+		sys += cpustat[CPUTIME_SYSTEM];
+		sys += cpustat[CPUTIME_IRQ];
+		sys += cpustat[CPUTIME_SOFTIRQ];
+		cputime->stime += sys;
+
+		cputime->sum_exec_runtime += user;
+		cputime->sum_exec_runtime += sys;
+		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
+		cputime->sum_exec_runtime += cpustat[CPUTIME_GUEST];
+		cputime->sum_exec_runtime += cpustat[CPUTIME_GUEST_NICE];
+	}
+}
+
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	u64 usage, utime, stime;
-
-	if (!cgroup_parent(cgrp))
-		return;
-
-	cgroup_rstat_flush_hold(cgrp);
-	usage = cgrp->bstat.cputime.sum_exec_runtime;
-	cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime, &utime, &stime);
-	cgroup_rstat_flush_release();
+	struct task_cputime cputime;
+
+	if (cgroup_parent(cgrp)) {
+		cgroup_rstat_flush_hold(cgrp);
+		usage = cgrp->bstat.cputime.sum_exec_runtime;
+		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
+			       &utime, &stime);
+		cgroup_rstat_flush_release();
+	} else {
+		root_cgroup_cputime(&cputime);
+		usage = cputime.sum_exec_runtime;
+		utime = cputime.utime;
+		stime = cputime.stime;
+	}
 
 	do_div(usage, NSEC_PER_USEC);
 	do_div(utime, NSEC_PER_USEC);
-- 
2.24.1

