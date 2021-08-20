Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D63F296C
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhHTJmi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 05:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbhHTJmh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 05:42:37 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Aug 2021 02:42:00 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D92C061575;
        Fri, 20 Aug 2021 02:42:00 -0700 (PDT)
Received: from sas1-3cba3404b018.qloud-c.yandex.net (sas1-3cba3404b018.qloud-c.yandex.net [IPv6:2a02:6b8:c08:bd26:0:640:3cba:3404])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 0FD782E1644;
        Fri, 20 Aug 2021 12:40:10 +0300 (MSK)
Received: from sas1-9d43635d01d6.qloud-c.yandex.net (sas1-9d43635d01d6.qloud-c.yandex.net [2a02:6b8:c08:793:0:640:9d43:635d])
        by sas1-3cba3404b018.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id ftjSvo0MIX-e8uel98w;
        Fri, 20 Aug 2021 12:40:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com; s=default;
        t=1629452410; bh=w/ylIByVCiNZnqp+URhSORGTXCKyEFc1XQAMjDap0mg=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=iAXX6YfQPNI4U9rhJXMExqrwRSfgztq7Do/DuJoaq4h83qTZzmwfiOvbxJh2rnHXk
         4emh2YXrJObhsFMosqAgPhv8DXW7OT/UPR9U9MsIx6ZwTC3ExGY44aCWJttUDYH84r
         JRiq1qxUVmjiDelnT1jgc35M54vXY1sSrQ/0yEOs=
Authentication-Results: sas1-3cba3404b018.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.com
Received: from dynamic-red3.dhcp.yndx.net (dynamic-red3.dhcp.yndx.net [2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by sas1-9d43635d01d6.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id G4f2cCJGSV-e8244ouE;
        Fri, 20 Aug 2021 12:40:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Andrey Ryabinin <arbn@yandex-team.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bharata@linux.vnet.ibm.com, boris@bur.io,
        Andrey Ryabinin <arb@yandex-team.com>
Subject: [PATCH v2 5/5] sched/cpuacct: Make user/system times in cpuacct.stat more precise
Date:   Fri, 20 Aug 2021 12:40:05 +0300
Message-Id: <20210820094005.20596-5-arbn@yandex-team.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820094005.20596-1-arbn@yandex-team.com>
References: <20210217120004.7984-1-arbn@yandex-team.com>
 <20210820094005.20596-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Andrey Ryabinin <arb@yandex-team.com>

cpuacct.stat shows user time based on raw random precision tick
based counters. Use cputime_addjust() to scale these values against the
total runtime accounted by the scheduler, like we already do
for user/system times in /proc/<pid>/stat.

Signed-off-by: Andrey Ryabinin <arb@yandex-team.com>
---
 Changes since v1:
    - fix cputime.sum_exec_runtime calculation
---
 kernel/sched/cpuacct.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9de7dd51beb0..3d06c5e4220d 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -261,25 +261,30 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 static int cpuacct_stats_show(struct seq_file *sf, void *v)
 {
 	struct cpuacct *ca = css_ca(seq_css(sf));
-	s64 val[CPUACCT_STAT_NSTATS];
+	struct task_cputime cputime;
+	u64 val[CPUACCT_STAT_NSTATS];
 	int cpu;
 	int stat;
 
-	memset(val, 0, sizeof(val));
+	memset(&cputime, 0, sizeof(cputime));
 	for_each_possible_cpu(cpu) {
 		u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
 
-		val[CPUACCT_STAT_USER]   += cpustat[CPUTIME_USER];
-		val[CPUACCT_STAT_USER]   += cpustat[CPUTIME_NICE];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SYSTEM];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_IRQ];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SOFTIRQ];
+		cputime.utime += cpustat[CPUTIME_USER];
+		cputime.utime += cpustat[CPUTIME_NICE];
+		cputime.stime += cpustat[CPUTIME_SYSTEM];
+		cputime.stime += cpustat[CPUTIME_IRQ];
+		cputime.stime += cpustat[CPUTIME_SOFTIRQ];
+
+		cputime.sum_exec_runtime += *per_cpu_ptr(ca->cpuusage, cpu);
 	}
 
+	cputime_adjust(&cputime, &seq_css(sf)->cgroup->prev_cputime,
+		&val[CPUACCT_STAT_USER], &val[CPUACCT_STAT_SYSTEM]);
+
 	for (stat = 0; stat < CPUACCT_STAT_NSTATS; stat++) {
-		seq_printf(sf, "%s %lld\n",
-			   cpuacct_stat_desc[stat],
-			   (long long)nsec_to_clock_t(val[stat]));
+		seq_printf(sf, "%s %llu\n", cpuacct_stat_desc[stat],
+			nsec_to_clock_t(val[stat]));
 	}
 
 	return 0;
-- 
2.31.1

