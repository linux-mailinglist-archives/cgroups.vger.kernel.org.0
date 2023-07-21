Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515CD75C672
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGUMEr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGUMEj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 08:04:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653F3A92;
        Fri, 21 Jul 2023 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689941056; x=1721477056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uv9zD1JJrwXe0E9I+ej0cnkJSwI8eyQL9t7kRDmIDo=;
  b=JrMHGcYdzpNM9PLduB1h5Sn+FLeqPXacQsvIBFPFH4chBjg+pDfZ6ksl
   GGvwSFeQ0lavCreYuva2h76uzqR6rVFmtXQpbfiwcnkevVEVJXERBKjpG
   KP9Nf/0N812B8pS90yjPIoJzqX79cMVYFwO7zKGZdvNoMCG5ZyVgVBXGM
   96Ho/79J6m0IhJndRgtx7iaoNjKAkejuoGLPdPaSkHuvQ4gyn3pMPtDEq
   yvbPmIQrDPaqDGeQvH2NNMl1jLvf5lB9F+C9uO179RPXiN4jIsw7rWIrz
   t+Gt0ZtZCul+y749XaCYxYrMveKYlVMmXTNXG7X5tGzDv5Tlg/YhUIqSR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356995884"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356995884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="675019242"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="675019242"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 05:02:31 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     tj@kernel.org
Cc:     cgroups@vger.kernel.org, dave.hansen@linux.intel.com,
        haitao.huang@linux.intel.com, hannes@cmpxchg.org,
        jarkko@kernel.org, kai.huang@intel.com, kristen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        lizefan.x@bytedance.com, reinette.chatre@intel.com,
        vipinsh@google.com, zhiquan1.li@intel.com
Subject: [PATCH] cgroup/misc: Store atomic64_t reads to u64
Date:   Fri, 21 Jul 2023 05:02:31 -0700
Message-Id: <20230721120231.13916-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZLcXmvDKheCRYOjG@slm.duckdns.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change 'new_usage' type to u64 so it can be compared with unsigned 'max'
and 'capacity' properly even if the value crosses the signed boundary.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
 kernel/cgroup/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index abbe9aa5cdd1..79a3717a5803 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -142,7 +142,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	struct misc_cg *i, *j;
 	int ret;
 	struct misc_res *res;
-	s64 new_usage;
+	u64 new_usage;
 
 	if (!(valid_type(type) && cg && READ_ONCE(misc_res_capacity[type])))
 		return -EINVAL;

base-commit: 32bf85c60ca3584a7ba3bef19da2779b73b2e7d6
-- 
2.25.1

