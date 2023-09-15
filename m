Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911007A22DE
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjIOPqw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbjIOPqt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 11:46:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 412402D7D;
        Fri, 15 Sep 2023 08:46:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B861FB;
        Fri, 15 Sep 2023 08:46:45 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.93.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBFD63F738;
        Fri, 15 Sep 2023 08:46:05 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, aaron.lu@intel.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 0/1] cgroup/cpuset: Rebuild sched domains if isolated partition changed
Date:   Fri, 15 Sep 2023 17:45:03 +0200
Message-Id: <20230915154505.363754-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

The patch aims to rebuild the sched domains if the cpus of an isolated
partition are updated. Another issue might have been found, but it
seemed to involve more complex modifications. To reproduce this issue:

# mkdir cgroup
# mount -t cgroup2 none cgroup/
# mkdir cgroup/A1 cgroup/B1
# echo "+cpuset" > cgroup/cgroup.subtree_control 
# echo 0-3 > cgroup/A1/cpuset.cpus
# echo isolated > cgroup/A1/cpuset.cpus.partition 
# echo 4-6 > cgroup/B1/cpuset.cpus
# cat cgroup/A1/cpuset.cpus.partition 
isolated

// Make the isolated partition invalid as not having
// an exclusive cpuset
# echo 0-4 > A1/cpuset.cpus
# cat cgroup/A1/cpuset.cpus.partition 
isolated invalid (Cpu list in cpuset.cpus not exclusive)
// Expected result, internal state of the cgroup:
//  - prs_err: PERR_NOTEXCL
//  - flags: CS_CPU_EXCLUSIVE | CS_MEMORY_MIGRATE | CS_SCHED_LOAD_BALANCE

// Make the isolated partition valid:
# echo 0-3 > A1/cpuset.cpus
# cat cgroup/A1/cpuset.cpus.partition 
isolated invalid (Cpu list in cpuset.cpus not exclusive)
// Unexpected result, internal state of the cgroup:
//  - prs_err: PERR_NOTEXCL
//  - flags: CS_CPU_EXCLUSIVE | CS_MEMORY_MIGRATE | CS_SCHED_LOAD_BALANCE

The issue seems to be that in update_cpumask(), the cgroup tree is
only traversed if there is a need to invalidate the partitions.
Cf. the case above, I think it should also be traversed if there
is an invalid state that might be re-validated.

Regards,
Pierre

Pierre Gondois (1):
  cgroup/cpuset: Rebuild sched domains if isolated partition changed

 kernel/cgroup/cpuset.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.25.1

