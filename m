Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A22B31D916
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhBQMDs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 07:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhBQMDm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Feb 2021 07:03:42 -0500
X-Greylist: delayed 172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Feb 2021 04:03:01 PST
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A9C061788;
        Wed, 17 Feb 2021 04:03:01 -0800 (PST)
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C12662E156D;
        Wed, 17 Feb 2021 14:58:59 +0300 (MSK)
Received: from iva4-f06c35e68a0a.qloud-c.yandex.net (iva4-f06c35e68a0a.qloud-c.yandex.net [2a02:6b8:c0c:152e:0:640:f06c:35e6])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 9kYzOk54fM-wwxStqNL;
        Wed, 17 Feb 2021 14:58:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com; s=default;
        t=1613563139; bh=ZihCwyg27DE0gQVcXSelAR/MAX3FaaVdJsFruU5jb10=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=sUbDlFl2v+Pg1C7RJV1S4qxbWxPyVgIO2DwwFFj249/NmO0QLiV3cEPNixdpNQI+0
         6KMZKxemlO+eP/7C8W1RoZ3YmZCMOfoBivgxduhgzJBPlvwzxOdd6jW0g2VDuDxJHF
         m+MZGHR58LpY67FzaTm8JIe/YaPACHzQirMJhWVU=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.com
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7222::1:5])
        by iva4-f06c35e68a0a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id GINHK1nK2P-wwnWnO2K;
        Wed, 17 Feb 2021 14:58:58 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Andrey Ryabinin <arbn@yandex-team.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Boris Burkov <boris@bur.io>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH 4/4] sched/cpuacct: Make user/system times in cpuacct.stat more precise
Date:   Wed, 17 Feb 2021 15:00:04 +0300
Message-Id: <20210217120004.7984-4-arbn@yandex-team.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217120004.7984-1-arbn@yandex-team.com>
References: <20210217120004.7984-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cpuacct.stat shows user time based on raw random precision tick
based counters. Use cputime_addjust() to scale these values against the
total runtime accounted by the scheduler, like we already do
for user/system times in /proc/<pid>/stat.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/sched/cpuacct.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 7eff79faab0d..36347f2810c0 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -266,25 +266,30 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
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
 
-		val[CPUACCT_STAT_USER] += cpustat[CPUTIME_USER];
-		val[CPUACCT_STAT_USER] += cpustat[CPUTIME_NICE];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SYSTEM];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_IRQ];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SOFTIRQ];
+		cputime.utime += cpustat[CPUTIME_USER];
+		cputime.utime += cpustat[CPUTIME_NICE];
+		cputime.stime += cpustat[CPUTIME_SYSTEM];
+		cputime.stime += cpustat[CPUTIME_IRQ];
+		cputime.stime += cpustat[CPUTIME_SOFTIRQ];
+
+		cputime.sum_exec_runtime += this_cpu_read(*ca->cpuusage);
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
2.26.2

