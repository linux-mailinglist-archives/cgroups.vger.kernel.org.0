Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5383450A01
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 17:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhKOQu3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 11:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhKOQuB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 11:50:01 -0500
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D216C061714;
        Mon, 15 Nov 2021 08:47:01 -0800 (PST)
Received: from iva8-d2cd82b7433e.qloud-c.yandex.net (iva8-d2cd82b7433e.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:a88e:0:640:d2cd:82b7])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5F4A22E125B;
        Mon, 15 Nov 2021 19:44:45 +0300 (MSK)
Received: from myt6-10e59078d438.qloud-c.yandex.net (myt6-10e59078d438.qloud-c.yandex.net [2a02:6b8:c12:5209:0:640:10e5:9078])
        by iva8-d2cd82b7433e.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 71BLk75fZ0-iisOMCwG;
        Mon, 15 Nov 2021 19:44:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com; s=default;
        t=1636994685; bh=3fDLTLlIcmJsu5OEDawaWPJKtf8DsF1HzRZKQpuRSpU=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=Bq7Ab0pYQmIc3qQFAdOqvEZ7MpKKu/jlcdf5dTSxxpve9DliKmw1g/PML8yJeWbji
         rPsqF+4rUqkSejfFeWIA7tQLL0iCvr4ek3ET5vl/qQ7d0XhSJcIaKlmXH6h1rJeCfa
         zJt7bS+ADbejpJnRsTDsv6tb97ZRkM6E/4I4R9rw=
Authentication-Results: iva8-d2cd82b7433e.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.com
Received: from dellarbn.yandex.net (dynamic-red3.dhcp.yndx.net [2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by myt6-10e59078d438.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPS id 7goUWCU60O-iiwSAZs2;
        Mon, 15 Nov 2021 19:44:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Andrey Ryabinin <arbn@yandex-team.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrey Ryabinin <arbn@yandex-team.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH v3 4/4] sched/cpuacct: Make user/system times in cpuacct.stat more precise
Date:   Mon, 15 Nov 2021 19:46:07 +0300
Message-Id: <20211115164607.23784-4-arbn@yandex-team.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115164607.23784-1-arbn@yandex-team.com>
References: <20211115164607.23784-1-arbn@yandex-team.com>
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
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
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
2.32.0

