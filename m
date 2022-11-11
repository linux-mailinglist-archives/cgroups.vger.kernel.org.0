Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0F626164
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiKKShH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiKKSgP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727382937;
        Fri, 11 Nov 2022 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191775; x=1699727775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQ7ZYI4WFVi0TVSU0cIX9E3CVIqNB+6yLjwlI7zqKjc=;
  b=CsngimnXo57fCXP7N4YGZ/TcdiElF/D8Igbx28tiEIMmCWwsYAvnQZ4D
   92Fcq/tEC8GYa4IzRXjSI6KFosPa13OrKdWeeCVp5MvSyRs9ziGxhvVJu
   tSvIGGTGjLUSkvK1XpFrP/3aWI7Usgz644lmBdHslrJXAc6mpJtk7IcD2
   d0mWnxocIwUW/23M/dd/umPgzyGbbp3hmtshCL4l5o4CFU5JlUD8SYpd1
   qmVFkw2naOrAEcM8CuO/S1qKVY5tY9GFA3RPfhvHd4eqeySvc0oeSxYph
   zAOjMWHfFcJmpra4q0RLM2lOl59TEwhiOZRM5VL8NSApGqM0iskFE1OS9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447709"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447709"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089369"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089369"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:13 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 19/26] cgroup/misc: Expose parent_misc()
Date:   Fri, 11 Nov 2022 10:35:24 -0800
Message-Id: <20221111183532.3676646-20-kristen@linux.intel.com>
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

To manage the SGX EPC memory via the misc controller, the SGX
driver will need to be able to iterate over the misc cgroup
hierarchy. Make parent_misc() available for a future patch
that will utilize it.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h | 6 ++++++
 kernel/cgroup/misc.c        | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index b79c78378f17..d1aeb85f2ed6 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -60,6 +60,7 @@ struct misc_cg {
 };
 
 struct misc_cg *root_misc(void);
+struct misc_cg *parent_misc(struct misc_cg *cg);
 unsigned long misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
@@ -112,6 +113,11 @@ static inline struct misc_cg *root_misc(void)
 	return NULL;
 }
 
+static inline struct misc_cg *parent_misc(struct misc_cg *cg)
+{
+	return NULL;
+}
+
 static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
 {
 	return 0;
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 8aa994d9cd02..b22a055af9ad 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -63,10 +63,11 @@ EXPORT_SYMBOL_GPL(root_misc);
  * * struct misc_cg* - Parent of the @cgroup.
  * * %NULL - If @cgroup is null or the passed cgroup does not have a parent.
  */
-static struct misc_cg *parent_misc(struct misc_cg *cgroup)
+struct misc_cg *parent_misc(struct misc_cg *cgroup)
 {
 	return cgroup ? css_misc(cgroup->css.parent) : NULL;
 }
+EXPORT_SYMBOL_GPL(parent_misc);
 
 /**
  * valid_type() - Check if @type is valid or not.
-- 
2.37.3

