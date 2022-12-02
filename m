Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83DF640D80
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiLBSjA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiLBSiS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:38:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00DD13E03;
        Fri,  2 Dec 2022 10:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006256; x=1701542256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+r1/QmCqDwq6NgBzwiM4c1v1mVeOdSGTv4jz3p+3jWY=;
  b=I67nmsCAVHbo9gnZ/CcXlniBuxun/jVvlhrqXEHVe1/VeXUCNPtW7Q44
   gmUKv2LhOBCljvN+v5f2AIJvoFFNErcCOHpkExCO7Xw+MpprMHIJX5xQc
   RvIemaKUzUj4IG36nWi0eje2DGQciJjPDrZhEeOEZD5RSsESJzp4MzLEQ
   Vo+tpnO9HzoCalkm0cQGsfjU9bUZMFrZ9gHOnBDWb7BSN8cSPGzqX+gsU
   G8kATd070glGgV02uoMH/bB81dkcLxAIqcucN0CekPPR1yn4guxxm+nhk
   NIcdD2dB2yxrwJzS3Lzk/5ik1DyG+Va6D70vg0j+GkZxWDxssY3wvgukZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724664"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724664"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717572"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717572"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:31 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v2 15/18] cgroup/misc: Add per resource callbacks for css events
Date:   Fri,  2 Dec 2022 10:36:51 -0800
Message-Id: <20221202183655.3767674-16-kristen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202183655.3767674-1-kristen@linux.intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
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

Consumers of the misc cgroup controller might need to perform separate actions
in the event of a cgroup alloc, free or release call. In addition,
writes to the max value may also need separate action. Add the ability
to allow downstream users to setup callbacks for these operations, and
call the per resource type callback when appropriate.

This code will be utilized by the SGX driver in a future patch.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h |  6 +++++
 kernel/cgroup/misc.c        | 51 ++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c238207d1615..83620e7c4bb1 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -37,6 +37,12 @@ struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
 	atomic_long_t events;
+
+	/* per resource callback ops */
+	int (*misc_cg_alloc)(struct misc_cg *cg);
+	void (*misc_cg_free)(struct misc_cg *cg);
+	void (*misc_cg_released)(struct misc_cg *cg);
+	void (*misc_cg_max_write)(struct misc_cg *cg);
 };
 
 /**
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index fe3e8a0eb7ed..3d17afd5b7a8 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -278,10 +278,13 @@ static ssize_t misc_cg_max_write(struct kernfs_open_file *of, char *buf,
 
 	cg = css_misc(of_css(of));
 
-	if (READ_ONCE(misc_res_capacity[type]))
+	if (READ_ONCE(misc_res_capacity[type])) {
 		WRITE_ONCE(cg->res[type].max, max);
-	else
+		if (cg->res[type].misc_cg_max_write)
+			cg->res[type].misc_cg_max_write(cg);
+	} else {
 		ret = -EINVAL;
+	}
 
 	return ret ? ret : nbytes;
 }
@@ -385,23 +388,39 @@ static struct cftype misc_cg_files[] = {
 static struct cgroup_subsys_state *
 misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 {
+	struct misc_cg *parent_cg;
 	enum misc_res_type i;
 	struct misc_cg *cg;
+	int ret;
 
 	if (!parent_css) {
 		cg = &root_cg;
+		parent_cg = &root_cg;
 	} else {
 		cg = kzalloc(sizeof(*cg), GFP_KERNEL);
 		if (!cg)
 			return ERR_PTR(-ENOMEM);
+		parent_cg = css_misc(parent_css);
 	}
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
 		atomic_long_set(&cg->res[i].usage, 0);
+		if (parent_cg->res[i].misc_cg_alloc) {
+			ret = parent_cg->res[i].misc_cg_alloc(cg);
+			if (ret)
+				goto alloc_err;
+		}
 	}
 
 	return &cg->css;
+
+alloc_err:
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (parent_cg->res[i].misc_cg_free)
+			cg->res[i].misc_cg_free(cg);
+	kfree(cg);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -412,13 +431,39 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
  */
 static void misc_cg_free(struct cgroup_subsys_state *css)
 {
-	kfree(css_misc(css));
+	struct misc_cg *cg = css_misc(css);
+	enum misc_res_type i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (cg->res[i].misc_cg_free)
+			cg->res[i].misc_cg_free(cg);
+
+	kfree(cg);
+}
+
+/**
+ * misc_cg_released() - Release the misc cgroup
+ * @css: cgroup subsys object.
+ *
+ * Call the misc_cg resource type released callbacks.
+ *
+ * Context: Any context.
+ */
+static void misc_cg_released(struct cgroup_subsys_state *css)
+{
+	struct misc_cg *cg = css_misc(css);
+	enum misc_res_type i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (cg->res[i].misc_cg_released)
+			cg->res[i].misc_cg_released(cg);
 }
 
 /* Cgroup controller callbacks */
 struct cgroup_subsys misc_cgrp_subsys = {
 	.css_alloc = misc_cg_alloc,
 	.css_free = misc_cg_free,
+	.css_released = misc_cg_released,
 	.legacy_cftypes = misc_cg_files,
 	.dfl_cftypes = misc_cg_files,
 };
-- 
2.38.1

