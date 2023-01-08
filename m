Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DF6612F9
	for <lists+cgroups@lfdr.de>; Sun,  8 Jan 2023 03:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAHCM1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Jan 2023 21:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjAHCMZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Jan 2023 21:12:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB215F02;
        Sat,  7 Jan 2023 18:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Lma7iRko69ZPpeW5xrn6KMqpGCw11zniVvr/dJegD0Q=; b=a8N02rIfT7KykuX+7Xs0Up/JV0
        P56+5z3gyWyUG/JcsolpKVzPnqT02M2l4Un+4yHhAWQf9oSVOHzJ4zOgnIe86xsg96ah1QiXT0t3S
        RTq5fxAmJjZEZc2XHB3EYI6dqHNx3tLU60wFOhPnWYZudM1SY1Uhk5Agcbrgf4FfuMgXzsPejw+ut
        liLmGDIw0EHZGQuoWZiY6LigcDB4nXvnpq+8jKuPyaZm3YTKtM9+ufcNukOGmrwBhU8XnWQFSoHSp
        Q182LUdfObJh7sJKFTOQWJs7OZLrU5HxxerxES952WwgL40ZztozDGLA7zZ7TOoEWUs4lbYoVvuxR
        vbln4wQQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pELAa-00Aq0G-D6; Sun, 08 Jan 2023 02:12:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH] cgroup/cpuset: fix a few kernel-doc warnings & coding style
Date:   Sat,  7 Jan 2023 18:12:17 -0800
Message-Id: <20230108021217.15491-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix kernel-doc notation warnings:

kernel/cgroup/cpuset.c:1309: warning: Excess function parameter 'cpuset' description in 'update_parent_subparts_cpumask'
kernel/cgroup/cpuset.c:3909: warning: expecting prototype for cpuset_mem_spread_node(). Prototype was for cpuset_spread_node() instead

Also drop a blank line before EXPORT_SYMBOL_GPL() to be consistent
with kernel coding style.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
---
 kernel/cgroup/cpuset.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff -- a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1267,7 +1267,7 @@ static int update_flag(cpuset_flagbits_t
 		       int turning_on);
 /**
  * update_parent_subparts_cpumask - update subparts_cpus mask of parent cpuset
- * @cpuset:  The cpuset that requests change in partition root state
+ * @cs:      The cpuset that requests change in partition root state
  * @cmd:     Partition root state change command
  * @newmask: Optional new cpumask for partcmd_update
  * @tmp:     Temporary addmask and delmask
@@ -3879,8 +3879,7 @@ bool __cpuset_node_allowed(int node, gfp
 }
 
 /**
- * cpuset_mem_spread_node() - On which node to begin search for a file page
- * cpuset_slab_spread_node() - On which node to begin search for a slab page
+ * cpuset_spread_node() - On which node to begin search for a page
  *
  * If a task is marked PF_SPREAD_PAGE or PF_SPREAD_SLAB (as for
  * tasks in a cpuset with is_spread_page or is_spread_slab set),
@@ -3904,12 +3903,14 @@ bool __cpuset_node_allowed(int node, gfp
  * is passed an offline node, it will fall back to the local node.
  * See kmem_cache_alloc_node().
  */
-
 static int cpuset_spread_node(int *rotor)
 {
 	return *rotor = next_node_in(*rotor, current->mems_allowed);
 }
 
+/**
+ * cpuset_mem_spread_node() - On which node to begin search for a file page
+ */
 int cpuset_mem_spread_node(void)
 {
 	if (current->cpuset_mem_spread_rotor == NUMA_NO_NODE)
@@ -3919,6 +3920,9 @@ int cpuset_mem_spread_node(void)
 	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
 }
 
+/**
+ * cpuset_slab_spread_node() - On which node to begin search for a slab page
+ */
 int cpuset_slab_spread_node(void)
 {
 	if (current->cpuset_slab_spread_rotor == NUMA_NO_NODE)
@@ -3927,7 +3931,6 @@ int cpuset_slab_spread_node(void)
 
 	return cpuset_spread_node(&current->cpuset_slab_spread_rotor);
 }
-
 EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
 
 /**
