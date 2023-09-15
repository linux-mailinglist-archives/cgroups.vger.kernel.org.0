Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547AC7A22E0
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjIOPrY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjIOPqy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 11:46:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A44BC30C7;
        Fri, 15 Sep 2023 08:46:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A11C15;
        Fri, 15 Sep 2023 08:46:47 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.93.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F7573F738;
        Fri, 15 Sep 2023 08:46:08 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, aaron.lu@intel.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 1/1] cgroup/cpuset: Rebuild sched domains if isolated partition changed
Date:   Fri, 15 Sep 2023 17:45:04 +0200
Message-Id: <20230915154505.363754-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915154505.363754-1-pierre.gondois@arm.com>
References: <20230915154505.363754-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When an isolated parition is created, the sched domains (sds) are
rebuilt and the sds of the isolated CPUs are detached. This only
happens at the creation of the isolated parition. Updating
the cpuset of the partition doesn't rebuild the sds:

To reproduce:
  # ls /sys/kernel/debug/sched/domains/cpu0/
  domain0
  # ls /sys/kernel/debug/sched/domains/cpu1/
  domain0
  #
  # mkdir cgroup
  # mount -t cgroup2 none cgroup/
  # mkdir cgroup/A1/
  # echo "+cpuset" > cgroup/cgroup.subtree_control
  # echo 0-3 > cgroup/A1/cpuset.cpus
  # echo isolated > cgroup/A1/cpuset.cpus.partition
  #
  # ls /sys/kernel/debug/sched/domains/cpu0/
  # ls /sys/kernel/debug/sched/domains/cpu1/
  #
  # echo 0 > cgroup/A1/cpuset.cpus
  # ls /sys/kernel/debug/sched/domains/cpu0/
  # ls /sys/kernel/debug/sched/domains/cpu1/
  #

Here CPU1 should have a sched domain re-attached.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58e6f18f01c1..e3eb27ff9b68 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1680,11 +1680,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * empty cpuset is changed, we need to rebuild sched domains.
 		 * On default hierarchy, the cpuset needs to be a partition
 		 * root as well.
+		 * Also rebuild sched domains if the cpuset of an isolated
+		 * partition changed.
 		 */
-		if (!cpumask_empty(cp->cpus_allowed) &&
-		    is_sched_load_balance(cp) &&
-		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
-		    is_partition_valid(cp)))
+		if ((!cpumask_empty(cp->cpus_allowed) &&
+		     is_sched_load_balance(cp) &&
+		     (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		      is_partition_valid(cp))) ||
+		    (cp->partition_root_state == PRS_ISOLATED ||
+		     cp->partition_root_state == PRS_INVALID_ISOLATED))
 			need_rebuild_sched_domains = true;
 
 		rcu_read_lock();
-- 
2.25.1

