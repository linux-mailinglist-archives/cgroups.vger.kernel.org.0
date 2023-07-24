Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE33775F57F
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 13:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGXLyn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 07:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGXLym (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 07:54:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF8E5D;
        Mon, 24 Jul 2023 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199679; x=1721735679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dUUOtqOX17ixG0CQwxEwuagR7WN91Ssj1qeb6A0Plp0=;
  b=NfqbXbxzvsEWlqE2ntIx/yYp8GgSckaGBblCdxL4N53L1G9RFGCpk2Dt
   yOYl1ab3FxCmpfzjJeeTIHx4FzH2bgVbv6BJuHPUZq9xILObnBWzejgRX
   //3OZarSU2uc1Y9nxDRfB+h8eawNsooX1MQkzcipn0Z3ifQ1dq1oVxf2L
   eMObKmtCT2/La7xu0J4ONYAmrxn9FUudo4Pzj5K5PaA5HH9C7uqxbIYZx
   THl7xrD6Zto4QUplUlt/4vwsLSEGfRzT/9geDRw3ke+fF4RgOsOdkeuT1
   8VGPmjFCKQIa7TDmgQFsUFORh0GQzJHZb/KUSW5PwBkocpC7mjEE4tMjl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366311174"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366311174"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="899469364"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899469364"
Received: from wtsmith-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.78.5])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:54:37 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     cgroups@vger.kernel.org
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Subject: [PATCH] misc_cgroup: Fix the obsolete comment around 'struct misc_res'
Date:   Mon, 24 Jul 2023 23:54:25 +1200
Message-ID: <20230724115425.1452383-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The comment of the 'failed' member of 'struct misc_res' is obsolete
since commit b03357528fd9 ("misc_cgroup: remove error log to avoid log
flood"), which removed the 'failed' member from the structure.  Remove
the obsolete comment.

Also add the missing comment for the 'events' field, which should come
with commit f279294b3293 ("misc_cgroup: introduce misc.events to count
failures") where the 'events' member was added.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 include/linux/misc_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c238207d1615..41aa213a1125 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -31,7 +31,7 @@ struct misc_cg;
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
  * @usage: Current usage of the resource.
- * @failed: True if charged failed for the resource in a cgroup.
+ * @events: Charge failure event counter of the resource.
  */
 struct misc_res {
 	unsigned long max;

base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
-- 
2.41.0

