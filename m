Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C3626162
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiKKShE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiKKSg1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A6178A6;
        Fri, 11 Nov 2022 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191779; x=1699727779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDw1+KlOA5sa/9TNbGFSCosxMRaFIDw8SgzYI5H+AWg=;
  b=isfnaWRjwuVMTz7qupQcJpeA5mJyp0cM8SxoRmcmL8y1s2UNL6r95fdQ
   2vtLWDWTi8nJZhMEJJkOl3t1zhh1FyJU2rMQOhybxVAG0HMmtt36yHERl
   hjtWKXfOTe6yl7q2pTrgKY6uzYVjwqGkW4Ml/iP9BXkbgPrdxIEWTcq0M
   gNhrNL2ZnopOBHXZKsL5YTIZ8dnqoiXHzawEapwzfm0zpyD1y+f9BhQjb
   lTWktPfsblzcPsiyYZfELSXzH0Ai6vAtouYXNgYesjaPWx687yJCoVkYm
   nQXIcfNcxUpwkI4ls4W/SdAZjgyIKafaT6E0wS9Vo+2dPbRcEFljd+knK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447727"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089422"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089422"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:18 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 22/26] cgroup/misc: Add private per cgroup data to struct misc_cg
Date:   Fri, 11 Nov 2022 10:35:27 -0800
Message-Id: <20221111183532.3676646-23-kristen@linux.intel.com>
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

The SGX driver needs to be able to store additional per cgroup data
specific to SGX along with the misc_cg struct. Add the ability to get
and set this data in struct misc_cg.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h | 12 ++++++++++++
 kernel/cgroup/misc.c        | 39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c00deae4d2df..7fbf3efb0f62 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -43,6 +43,7 @@ struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
 	atomic_long_t events;
+	void *priv;
 };
 
 /**
@@ -63,6 +64,8 @@ struct misc_cg *root_misc(void);
 struct misc_cg *parent_misc(struct misc_cg *cg);
 unsigned long misc_cg_read(enum misc_res_type type, struct misc_cg *cg);
 unsigned long misc_cg_max(enum misc_res_type type, struct misc_cg *cg);
+void *misc_cg_get_priv(enum misc_res_type type, struct misc_cg *cg);
+void misc_cg_set_priv(enum misc_res_type type, struct misc_cg *cg, void *priv);
 unsigned long misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
@@ -130,6 +133,15 @@ static inline unsigned long misc_cg_max(enum misc_res_type type, struct misc_cg
 	return 0;
 }
 
+static void *misc_cg_get_priv(enum misc_res_type type, struct misc_cg *cg)
+{
+	return NULL;
+}
+
+static void misc_cg_set_priv(enum misc_res_type type, struct misc_cg *cg, void *priv)
+{
+}
+
 static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
 {
 	return 0;
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 18d0bec7d609..642879ad136f 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -251,6 +251,45 @@ unsigned long misc_cg_max(enum misc_res_type type, struct misc_cg *cg)
 }
 EXPORT_SYMBOL_GPL(misc_cg_max);
 
+/**
+ * misc_cg_get_priv() - Return the priv value of the misc cgroup res.
+ * @type: Type of the misc res.
+ * @cg: Misc cgroup whose priv will be read
+ *
+ * Context: Any context.
+ * Return:
+ * 	The value of the priv field for the specified misc cgroup.
+ * 	If an invalid misc_res_type is given, NULL will be returned.
+ */
+void *misc_cg_get_priv(enum misc_res_type type, struct misc_cg *cg)
+{
+	if (!(valid_type(type) && cg))
+		return NULL;
+
+	return cg->res[type].priv;
+}
+EXPORT_SYMBOL_GPL(misc_cg_get_priv);
+
+/**
+ * misc_cg_set_priv() - Set the priv value of the misc cgroup res.
+ * @type: Type of the misc res.
+ * @cg: Misc cgroup whose priv will be written
+ * @priv: Value to store in the priv field of the struct misc_cg
+ *
+ * If an invalid misc_res_type is given, the priv data will not be
+ * stored.
+ *
+ * Context: Any context.
+ */
+void misc_cg_set_priv(enum misc_res_type type, struct misc_cg *cg, void *priv)
+{
+	if (!(valid_type(type) && cg))
+		return;
+
+	cg->res[type].priv = priv;
+}
+EXPORT_SYMBOL_GPL(misc_cg_set_priv);
+
 /**
  * misc_cg_max_show() - Show the misc cgroup max limit.
  * @sf: Interface file
-- 
2.37.3

