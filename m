Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4141562615F
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiKKShD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiKKSgS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0225833B2;
        Fri, 11 Nov 2022 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191776; x=1699727776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YoGb4j/ZQ61R2iQhhmxSzGX3p7smajRdGWvm5NNdTBs=;
  b=AucB0PwBRMGpEItGXZUTWsmONUkG/FmfD9juI6gfUor9xA9+Ob2NTkFF
   L4B8WH1aia4/s3+82BeFJSj6aGiwK3REC5R9EgYxI5sA2aBq3zE0U1a85
   k6tbUxOeztfpFY2iCr5AbjT4VX4nHMrQe+xO9lXXyJWVUAfnR5ZTZlaCA
   GgGYmNqEIumkHYiGU3Q1RTsPVj8AVy/yaRFb9KYt1Z/g1jrIJ/gYcLIrg
   NXbE6p2g2ovZuV42r9PEAd4VAaM8sZzyOgLI6k1YxTsCYWvs0WmgbTgd1
   elqSIreDZevioZG43Ny0wU9B8UJi/nOwqh8t3PZtVRl6UAKBPCGGv8KOY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447711"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447711"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089385"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089385"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:15 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 20/26] cgroup/misc: allow users of misc cgroup to read specific cgroup usage
Date:   Fri, 11 Nov 2022 10:35:25 -0800
Message-Id: <20221111183532.3676646-21-kristen@linux.intel.com>
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

Add a function to return the current usage of the specified cgroup.
The SGX driver will need this information to decide whether to
reclaim EPC pages from a cgroup.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h |  6 ++++++
 kernel/cgroup/misc.c        | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index d1aeb85f2ed6..a9dd087132dc 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -61,6 +61,7 @@ struct misc_cg {
 
 struct misc_cg *root_misc(void);
 struct misc_cg *parent_misc(struct misc_cg *cg);
+unsigned long misc_cg_read(enum misc_res_type type, struct misc_cg *cg);
 unsigned long misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
@@ -118,6 +119,11 @@ static inline struct misc_cg *parent_misc(struct misc_cg *cg)
 	return NULL;
 }
 
+static inline unsigned long misc_cg_read(enum misc_res_type type, struct misc_cg *cg)
+{
+	return 0;
+}
+
 static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
 {
 	return 0;
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index b22a055af9ad..e2c99fdc1d40 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -213,6 +213,25 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg,
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
 
+/**
+ * misc_cg_read() - Return the current usage of the misc cgroup res.
+ * @type: Type of the misc res.
+ * @cg: Misc cgroup whose usage will be read
+ *
+ * Context: Any context.
+ * Return:
+ * 	The current total usage of the specified misc cgroup.
+ * 	If an invalid misc_res_type is given, zero will be returned.
+ */
+unsigned long misc_cg_read(enum misc_res_type type, struct misc_cg *cg)
+{
+	if (!(valid_type(type) && cg))
+		return 0;
+
+	return atomic_long_read(&cg->res[type].usage);
+}
+EXPORT_SYMBOL_GPL(misc_cg_read);
+
 /**
  * misc_cg_max_show() - Show the misc cgroup max limit.
  * @sf: Interface file
-- 
2.37.3

