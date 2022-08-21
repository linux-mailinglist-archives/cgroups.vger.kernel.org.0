Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001159B298
	for <lists+cgroups@lfdr.de>; Sun, 21 Aug 2022 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiHUHeQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 Aug 2022 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiHUHeP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 Aug 2022 03:34:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8522BE6
        for <cgroups@vger.kernel.org>; Sun, 21 Aug 2022 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661067254; x=1692603254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O6fFd+1PtGhiYQl5WIAchCwfjiLwvujhPK8p2OjYqOA=;
  b=JcBA/w0JJFA9GNjqoSoSSPhfuwEOuK+3rv+/R3SK62TD2Q2b222EBSKx
   I27sBSgL0jExB/TdosDM5ZytELE//XMOozdTs9ni6/keqyh7JBywojTCq
   amPsa1c5MBHdZBjcehb3kV0DsSogzHkCrbUaC5DfnuwP6n5qtwePTVrK0
   3AGA3GJMdhqbt2VuKzUSBLxx2LVQLFtJ2Yb696MH+zIiMh5TE6uLhrII7
   +qdZWResLRxVUkZh5x5IxLifOLbJ7Yt6ZbN9Xng2tBLGO3o+lmQbBvRU/
   iYxqnLUEx1yjlv90XiY0Jgg1bD9DMWVQ1JMZCUbR4aEOFUm57dc63ecib
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="290789915"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="290789915"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 00:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="750941440"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2022 00:34:12 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH] cgroup: cleanup the format of /proc/cgroups
Date:   Sun, 21 Aug 2022 15:34:46 +0800
Message-Id: <20220821073446.92669-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currrent /proc/cgroup output is like:

  #subsys_name	hierarchy	num_cgroups	enabled
  cpuset	6	1	1
  cpu	4	7	1
  cpuacct	4	7	1
  blkio	8	7	1
  memory	9	7	1
  ...

Add some indentation to make it more readable without any functional
change:

  #subsys_name         hierarchy        num_cgroups      enabled
  cpuset               8                1                1
  cpu                  4                7                1
  cpuacct              4                7                1
  blkio                2                7                1
  memory               5                7                1
  ...

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 kernel/cgroup/cgroup-v1.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 2ade21b54dc4..e370ce3afdad 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -670,14 +670,20 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	struct cgroup_subsys *ss;
 	int i;
 
-	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
+	seq_printf(m, "%-20s %-16s %-16s %-16s\n",
+			"#subsys_name",
+			"hierarchy",
+			"num_cgroups",
+			"enabled"
+			);
+
 	/*
 	 * Grab the subsystems state racily. No need to add avenue to
 	 * cgroup_mutex contention.
 	 */
 
 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
+		seq_printf(m, "%-20s %-16d %-16d %-16d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
-- 
2.27.0

