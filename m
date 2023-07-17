Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B39756C68
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGQSrX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGQSrW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:47:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703C9D;
        Mon, 17 Jul 2023 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689619641; x=1721155641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xn4mhx8wb+pDDvuBnsfj8E37sdsIB+VR4lYH55ZoQHk=;
  b=T+s9ij9NaN7rOESMeFL11IgEPCXS5O69U+dy7O0cf3sozFqxR8E3Oa7S
   TkUub/d9iZnwfqxvjwk6Q0oMbXUnar9RvmWG5wQay7jSWjjl0tBwFKaYg
   +HOZeFF/S5ZcNtFTiX1hM6C/p+LyylYe669vYFdBFlgmmAosGbDfpy2RO
   kjRlrtGuqTqruLt4JwMw24mRBQoFVx5R8f71k284zOAkGNeMGKX8CP5g/
   LsnQigBEHIAPxwqhA+blK/bgbAVSgBstTkJkZauvIecFAHt8SjgxkpGaZ
   JhkA61eUc+a21itcc6AH4D2mgoLWvc8nV4JcfRSvk8PCuD5HrPpUF90lw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429771528"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429771528"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 11:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1053987123"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053987123"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 11:47:19 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     vipinsh@google.com, kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: [PATCH] cgroup/misc: Fix an overflow
Date:   Mon, 17 Jul 2023 11:47:19 -0700
Message-Id: <20230717184719.85523-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The variable 'new_usage' in misc_cg_try_charge() may overflow if it
becomes above INT_MAX. This was observed when I implement the new SGX
EPC cgroup[1] as a misc cgroup and test on a platform with large SGX EPC
sizes.

Change type of new_usage to long from int and check overflow.

Fixes: a72232eabdfcf ("cgroup: Add misc cgroup controller")
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

[1] https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
---
 kernel/cgroup/misc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index fe3e8a0eb7ed..ff9f900981a3 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -143,7 +143,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	struct misc_cg *i, *j;
 	int ret;
 	struct misc_res *res;
-	int new_usage;
+	long new_usage;
 
 	if (!(valid_type(type) && cg && READ_ONCE(misc_res_capacity[type])))
 		return -EINVAL;
@@ -153,10 +153,10 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 
 	for (i = cg; i; i = parent_misc(i)) {
 		res = &i->res[type];
-
 		new_usage = atomic_long_add_return(amount, &res->usage);
 		if (new_usage > READ_ONCE(res->max) ||
-		    new_usage > READ_ONCE(misc_res_capacity[type])) {
+		    new_usage > READ_ONCE(misc_res_capacity[type]) ||
+		    new_usage < 0) {
 			ret = -EBUSY;
 			goto err_charge;
 		}
-- 
2.25.1

