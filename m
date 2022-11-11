Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37B626161
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiKKShE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKKSg2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB283691;
        Fri, 11 Nov 2022 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191781; x=1699727781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSkn/vztgv3b1H9AuqHP1f8+st1SIUnPEpjHioF/AGg=;
  b=aNX7gCXNB77Zoq0LIpI74k/wVWVCbS7k02cNdzM8lHUCMjrk3M49xxs4
   9Hy6XxA3OtiyyF4pwFMjhyeXj5D2geooZ18TZm3ALUbxGWrIfr8//X5j9
   F3+RLD9n7WUAQ1Dn3HZCjko1MdEVCUpsdwvLz25WGV2r/St+bukPRShkZ
   1Dl7NEzvT8yy/3s3FykGwa/9mIdUhLSOC+LtQ1TbQ4MxCEW9G+3wLr6Pk
   eMQIR1DbKSmsxgSEPg+vCLdXZeYT3nc9Egx7QElFfUAl8qdVNzoOsGZUo
   QAwr/154NpdKnULBX+np9F1mmJRsiEdUdbFLONgT5VaBexGUVtkQIthhB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447732"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447732"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089434"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089434"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:19 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 23/26] cgroup/misc: Add tryget functionality for misc controller
Date:   Fri, 11 Nov 2022 10:35:28 -0800
Message-Id: <20221111183532.3676646-24-kristen@linux.intel.com>
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

Allows caller to do a css_tryget() on a specific misc cgroup.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 7fbf3efb0f62..cee848205715 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -112,6 +112,16 @@ static inline void put_misc_cg(struct misc_cg *cg)
 		css_put(&cg->css);
 }
 
+/*
+ * misc_cg_tryget() - Try to increment this misc cgroup ref count.
+ * @cg - cgroup to get.
+ */
+static inline bool misc_cg_tryget(struct misc_cg *cg)
+{
+	if (cg)
+		return css_tryget(&cg->css);
+	return false;
+}
 #else /* !CONFIG_CGROUP_MISC */
 static inline struct misc_cg *root_misc(void)
 {
@@ -175,6 +185,11 @@ static inline void put_misc_cg(struct misc_cg *cg)
 {
 }
 
+static inline bool misc_cg_tryget(struct misc_cg *cg)
+{
+	return true;
+}
+
 static inline int register_misc_cg_notifier(struct notifier_block *nb)
 {
 	return 0;
-- 
2.37.3

