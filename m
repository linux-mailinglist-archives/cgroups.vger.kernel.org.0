Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59B57DC65
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiGVIby (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jul 2022 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGVIby (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jul 2022 04:31:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E99E78A;
        Fri, 22 Jul 2022 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658478713; x=1690014713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uv07SzM5PWTt1IVQuWHDCVeHL3I17tUX88W1yhEAfGk=;
  b=Lhy5jvwu90NJ7gdKMPIIfYuQ85pf9L39j38JfJ3JErfSNcOXmb5hutTT
   ZUUXR/+FXrE8uq3+o6eHJCfyl3Y4EC3FWPBZ/r+DWhvGl3yd6wHnCDNQ/
   YfzEymxIDMdCdhXWsN+FF64aBA6rSZXwYn5Ew3qRR0UdOovdXJlrCtTuZ
   23khOisxGersi0DSJGITTa8SN1kiSu4uAezyUK+VZHbMdD1Odtrbz6Lqw
   zW+kwVlNGJG5otnCVdBrbQEpIUhlfXwKtEWpPm9D8a2Tu9jomss6dQXfn
   tLerFdbPPPgilSCUj6Y/25fg5ydRW7wS0WIfP+Ci/qfLosdsMYeD8z/5b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="288022524"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="288022524"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 01:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="666603605"
Received: from linux-pnp-server-12.sh.intel.com ([10.239.176.103])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jul 2022 01:31:49 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, tim.c.chen@intel.com,
        ying.huang@intel.com, amadeuszx.slawinski@linux.intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        jiebin sun <jiebin.sun@intel.com>
Subject: [PATCH] mm: Remove the redundant updating of stats_flush_threshold
Date:   Sat, 23 Jul 2022 00:49:49 +0800
Message-Id: <20220722164949.47760-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: jiebin sun <jiebin.sun@intel.com>

Remove the redundant updating of stats_flush_threshold. If the
global var stats_flush_threshold has exceeded the trigger value
for __mem_cgroup_flush_stats, further increment is unnecessary.

Apply the patch and test the pts/hackbench-1.0.0 Count:4 (160 threads).

Score gain: 1.95x
Reduce CPU cycles in __mod_memcg_lruvec_state (44.88% -> 0.12%)

CPU: ICX 8380 x 2 sockets
Core number: 40 x 2 physical cores
Benchmark: pts/hackbench-1.0.0 Count:4 (160 threads)

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 mm/memcontrol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe6..9e8c6f24c694 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -626,7 +626,14 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
 	if (x > MEMCG_CHARGE_BATCH) {
-		atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
+		/*
+		 * If stats_flush_threshold exceeds the threshold
+		 * (>num_online_cpus()), cgroup stats update will be triggered
+		 * in __mem_cgroup_flush_stats(). Increasing this var further
+		 * is redundant and simply adds overhead in atomic update.
+		 */
+		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
+			atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
 		__this_cpu_write(stats_updates, 0);
 	}
 }
-- 
2.31.1

