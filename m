Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6A5061FF
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiDSCMo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Apr 2022 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiDSCMn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Apr 2022 22:12:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54725EA4
        for <cgroups@vger.kernel.org>; Mon, 18 Apr 2022 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650334202; x=1681870202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nH/XrxtiTaYfm0g+ofM2ITpPrGvqHIGnxGucWn4QUeE=;
  b=kI0VVkCRSajLSMxg3jLmKadZpF3GbPhDv+0vLS6s9f0+13EdOnLF+DX6
   bIoxMJjNM5wblWvW3Moi4arbUWEEM/YGwDAHDX8Y2HaSj04w3mZwuEV+B
   D5nJdUuD9sij/5ly1SHJW4cPRoLB/5gnqy6LnTWk5TOwrCH8gQUbueiC9
   7BDfxVPgV+Z3QqIyrNR8jYRh564/rxYFOozFQgXDEJhW+Mc/4aCgUceu4
   N43b/HHPstWKiraVqsCujRptyo0KXkJ+RmesA6d7yjHnsOsVB/lS8D/9k
   hoZqD40L+EMY4GFQlxcoGGkmTEmkx4ZE4qFIozZEso2YHBNosgLTtyoz5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263828606"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263828606"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="665625976"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 19:09:59 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Dave Hansen <dave.hansen@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] cgroup/cpuset: fix a memory binding failure for cgroup v2
Date:   Tue, 19 Apr 2022 10:09:58 +0800
Message-Id: <20220419020958.40419-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We got report that setting cpuset.mems failed when the nodemask
contains a newly onlined memory node (not enumerated during boot)
for cgroup v2, while the binding succeeded for cgroup v1.

The root cause is, for cgroup v2, when a new memory node is onlined,
top_cpuset's 'mem_allowed' is not updated with the new nodemask of
memory nodes, and the following setting memory nodemask will fail,
if the nodemask contains a new node.

Fix it by updating top_cpuset.mems_allowed right after the
new memory node is onlined, just like v1.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Very likely I missed some details here, but it looks strange that
the top_cpuset.mem_allowed is not updatd even after we onlined
several memory nodes after boot.

 kernel/cgroup/cpuset.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9390bfd9f1cd..b97caaf16374 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3314,8 +3314,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	/* synchronize mems_allowed to N_MEMORY */
 	if (mems_updated) {
 		spin_lock_irq(&callback_lock);
-		if (!on_dfl)
-			top_cpuset.mems_allowed = new_mems;
+		top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
 		spin_unlock_irq(&callback_lock);
 		update_tasks_nodemask(&top_cpuset);
-- 
2.27.0

