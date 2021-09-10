Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481DE406824
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhIJIIS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 04:08:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:61054 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhIJIFg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 10 Sep 2021 04:05:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220695806"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="220695806"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 01:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="540339100"
Received: from kailun-nuc9i9qnx.sh.intel.com ([10.239.160.139])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2021 01:04:21 -0700
From:   Kailun Qin <kailun.qin@intel.com>
To:     tj@kernel.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, changhuaixin@linux.alibaba.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, Kailun Qin <kailun.qin@intel.com>
Subject: [PATCH] sched/core: Fix wrong burst unit in cgroup2 cpu.max write
Date:   Fri, 10 Sep 2021 12:06:03 -0400
Message-Id: <20210910160603.606711-1-kailun.qin@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In cpu_max_write(), as the eventual tg_set_cfs_bandwidth() operates on
the burst in nsec which is input from tg_get_cfs_burst() in usec, it
should be converted into nsec accordingly.

If not, this may cause a write into cgroup2 cpu.max to unexpectedly
change an already set cpu.max.burst.

This patch addresses the above issue.

Signed-off-by: Kailun Qin <kailun.qin@intel.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4462c454ab9..fc9fcc56149f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10711,7 +10711,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg_get_cfs_burst(tg);
+	u64 burst = (u64)tg_get_cfs_burst(tg) * NSEC_PER_USEC;
 	u64 quota;
 	int ret;
 
-- 
2.25.1

