Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3BED6AD
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 01:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfKDAj3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Nov 2019 19:39:29 -0500
Received: from foss.arm.com ([217.140.110.172]:33428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfKDAj3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 3 Nov 2019 19:39:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6663A1FB;
        Sun,  3 Nov 2019 16:39:28 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B33263F67D;
        Sun,  3 Nov 2019 16:39:26 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2] sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
Date:   Mon,  4 Nov 2019 00:39:06 +0000
Message-Id: <20191104003906.31476-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal noted that a cpuset's effective_cpus can be a non-empy mask, but
because of the masking done with housekeeping_cpumask(HK_FLAG_DOMAIN)
further down the line, we can still end up with an empty cpumask being
passed down to partition_sched_domains_locked().

Do the proper thing and don't just check the mask is non-empty - check
that its intersection with housekeeping_cpumask(HK_FLAG_DOMAIN) is
non-empty.

Fixes: cd1cb3350561 ("sched/topology: Don't try to build empty sched domains")
Reported-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/cgroup/cpuset.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c87ee6412b36..e4c10785dc7c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -798,8 +798,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
 			continue;
 
+		/*
+		 * Skip cpusets that would lead to an empty sched domain.
+		 * That could be because effective_cpus is empty, or because
+		 * it's only spanning CPUs outside the housekeeping mask.
+		 */
 		if (is_sched_load_balance(cp) &&
-		    !cpumask_empty(cp->effective_cpus))
+		    cpumask_intersects(cp->effective_cpus,
+				       housekeeping_cpumask(HK_FLAG_DOMAIN)))
 			csa[csn++] = cp;
 
 		/* skip @cp's subtree if not a partition root */
-- 
2.22.0

