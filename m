Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E181626163
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiKKShG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiKKSgO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2775083381;
        Fri, 11 Nov 2022 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191774; x=1699727774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wY8Ia7AhZOsSBmUDim+2xlwCX7VM8EjOrhb9ezVOttc=;
  b=CP7moDwxZdBbz+ai2ISJn8ohwUFqPbFTnZc97wcRrphBU0tPUK4mn+NE
   nyfu8SRGvGBGTFkAeEn0CC2GPcfgqadZFqgvf9K409D+kr+YJ4DrYLu8M
   n+P9994qJ5tAXS9OvBSOILxZ3HifnVKcw7tX/01ArQLXeMee4eeyd1kxk
   SW4XREmyq3/IOEZC+N/rQ+pbzFL9JBFip+CYyJQfShUWfYa+48tNcTf4k
   oM3osAoLXgCL/iXLyU/HRtkxM8V4kriPg2lYt5WiLWTdoFrMbguyMNmh8
   PcJjgbjMOBum5JAG3l3/lNKgb6BWJFdOjIcBh7hEUztb5tFaBDbME77nY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447706"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447706"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089360"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089360"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:12 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 18/26] cgroup/misc: Expose root_misc
Date:   Fri, 11 Nov 2022 10:35:23 -0800
Message-Id: <20221111183532.3676646-19-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221111183532.3676646-1-kristen@linux.intel.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The SGX driver will need to get access to the root misc_cg object
to do iterative walks and also determine if a charge will be
towards the root cgroup or not.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h | 5 +++++
 kernel/cgroup/misc.c        | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 8f1b7b6cb81d..b79c78378f17 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -59,6 +59,7 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
+struct misc_cg *root_misc(void);
 unsigned long misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
@@ -106,6 +107,10 @@ static inline void put_misc_cg(struct misc_cg *cg)
 }
 
 #else /* !CONFIG_CGROUP_MISC */
+static inline struct misc_cg *root_misc(void)
+{
+	return NULL;
+}
 
 static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
 {
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 1e93e1d20347..8aa994d9cd02 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -45,6 +45,15 @@ static unsigned long misc_res_capacity[MISC_CG_RES_TYPES];
  */
 static BLOCKING_NOTIFIER_HEAD(misc_cg_notify_list);
 
+/**
+ * root_misc() - Return the root misc cgroup.
+ */
+struct misc_cg *root_misc(void)
+{
+	return &root_cg;
+}
+EXPORT_SYMBOL_GPL(root_misc);
+
 /**
  * parent_misc() - Get the parent of the passed misc cgroup.
  * @cgroup: cgroup whose parent needs to be fetched.
-- 
2.37.3

