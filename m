Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43930751401
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjGLXCx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjGLXCS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2418E;
        Wed, 12 Jul 2023 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202937; x=1720738937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtPme0IuXCAV4jbp0xb73aBMQFtTiscdTlcYYwDyGg8=;
  b=LU/fwLB0h47yZrs3fFKLbojxHgRpYrQ6iIvzDpxHqSnhwm5C1Bb8lLs3
   ZZ6eclaF+n5kv3WCCBcwpdZ6Bbk/iqdD9EfLa77GTJO+z9mNYI+HXbDjw
   Y85VOTZTDQegwUXEfgzDNOdIbhgoO/gOSGk9uKinxNZv1aKMEMqUMzaWh
   hGKMsgb9vB9RX1YA2Nsepz7A34ZIoWfQXbWMU+jLkSuXjDid1mudOwH+y
   JVcIWZvhc9ffHBl1yLv1/kt7JjkPJ6DpegqdUBLCCM/KmrxWFJNudHqC9
   o+PNaBrus11gnGpxuGjD4b4J7cOq/j/q9dX6kGwTfYHJNt7hAV1lC+qxO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774166"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774166"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338649"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338649"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:15 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: [PATCH v3 18/28] cgroup/misc: Fix an overflow
Date:   Wed, 12 Jul 2023 16:01:52 -0700
Message-Id: <20230712230202.47929-19-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
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

Overflow may happen in misc_cg_try_charge if new_usage becomes above
INT_MAX, for example, on platforms with large SGX EPC sizes.

Change type of new_usage to long from int and check overflow.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
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

