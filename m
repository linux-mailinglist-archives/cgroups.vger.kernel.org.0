Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC475713B
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 03:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGRBJF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 21:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGRBJF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 21:09:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9146D8;
        Mon, 17 Jul 2023 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689642544; x=1721178544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+HYDr0YJ1RDyX2/gcHKL0bAVncJHhQaWyxrxc5y+kQ=;
  b=IXuhTp7EdtszAEwpGuUiCPemVyaHHaYhKMbYGxKCQwae1bt0LJC/lD17
   QCYK9G0NWK+WUH4P81S9t/isYrrdfTUnmzg8nq1dqA0xMX5eOrthZvkyU
   07fUdaKA1sshaZZ7BCsi7b9ygELqW4kBwOtE5h625R1LQZb+VUp7K4XdL
   VxFUJop3SJIRbfCS+PcQE9Nm0IlOh8cAzUQOJkwbckB4JzrwPGCzqQsVZ
   sG2J2GWhynYsRcoS9tBwUR1BEaE4aoswZX6qykMi2CAteKRSifESlT6v2
   YZ/pcm8mLv9eJgCmEpQBQ06TCLjqsvR5FOX5lXSDWLJ9lCazmEBrErFR3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432255248"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432255248"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793437554"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793437554"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 18:08:46 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     tj@kernel.org, jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     vipinsh@google.com, kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: [PATCH 1/2] cgroup/misc: Fix an overflow
Date:   Mon, 17 Jul 2023 18:08:44 -0700
Message-Id: <20230718010845.35197-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
References: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

Fixes: a72232eabdfc ("cgroup: Add misc cgroup controller")
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

[1] https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
---
 kernel/cgroup/misc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index fe3e8a0eb7ed..b127607837c6 100644
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
@@ -156,7 +156,8 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 
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

