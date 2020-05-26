Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1C1E2FC7
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbgEZUKH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 16:10:07 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43335 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390075AbgEZUKG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 16:10:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 61EE1582186;
        Tue, 26 May 2020 16:10:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 May 2020 16:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=LHN0JqCZjAhlY7hB0/Y3fto1Fs
        QcamBNWhl7bqCCYFQ=; b=Tf85u/C9df53lBvUWR+YDqK8pTkDrlYwLiHV44qbkS
        mnHeugttyrDec7o60NcUtnABRLdccSQKc7t59jSSHpVbVIAJrtb9dFc/tI/VCFik
        ZmenzZbrOUgnS/E5bPrTAnCfY2QUl2V5PbiPLZ6nLYZR3eKjZUKpp9FCkaJb30yO
        xHPJ/DJA2342C4+6ldrjdpka0rNkcWmswGMP/nbsL8819nj+hYgfqCBTdhVTldJq
        ZE556X5zBI1eSwczYvHj0naUQeMjaUmhbdB4D/ZL+psVh7Pz15JWuFIRB//rpR0r
        2AIZr2SY0irzoSvvg65uX40vdxoYuEbvGN3spSfXJEug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LHN0JqCZjAhlY7hB0
        /Y3fto1FsQcamBNWhl7bqCCYFQ=; b=wAS94y4Q5SKaY0h7NxjaHI5iBN210i57D
        RMFJcWHfxHh4bN4m9zPx+8tecS3ekBMEiCwemkO5TjYMCd7bknJVCfTtp2A6Wr6o
        TIAbO0h/HNHYhSlcdKB/c5NuXReBNeMfDL5B+uAz/G0R/84JOwTj4keSLoe7nT4n
        0QWEJS7F/+XmhW8SAZjxGkxgHr8TUORJZsw7QuJscdG8dSLaJAv1JoutVw9numCH
        WnY8Q6xN3xtlFgw3Dia2CU7YIiCCRAcZVfh5WoLmyyg0d3nExliI4pMUPGipDn5T
        eFk9/hflNNQBnrXsfAA1IWt+S/KtY7yCCB0VMBe1DR+aLxSumqazA==
X-ME-Sender: <xms:nHfNXvzvgJWk2x4WlFsZz-UClafeoFkQkptLBMsFIKSFBqMXIcFcNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduie
    dtleeuieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:nHfNXnSyyIsZBlxSCMNbdkEG1E3tQqTXJTVONmF8030q1O0ZXj-ydQ>
    <xmx:nHfNXpWLGOd-pMCdyDaaxXz9nJRXOvhse5SyYxQrIL7nnShk2AC5Og>
    <xmx:nHfNXpi4Gpu-We6KpAe9ni5ySGUOw17NCUsTrr3NZT5M22clv9tYqg>
    <xmx:nXfNXrDBU16_PYsN6sR67J4sQ25VoMHjDPQ_poglN5Woy4lEo9dJvfYuU4YLPnSS>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FB2E3280068;
        Tue, 26 May 2020 16:10:03 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Boris Burkov <boris@bur.io>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH cgroup/for-5.8] cgroup: add cpu.stat file to root cgroup
Date:   Tue, 26 May 2020 13:08:00 -0700
Message-Id: <20200526200800.3969430-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
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
 kernel/cgroup/cgroup.c |  1 -
 kernel/cgroup/rstat.c  | 60 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 9 deletions(-)

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

