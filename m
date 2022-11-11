Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EEA62615D
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiKKShB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiKKSgN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A678292C;
        Fri, 11 Nov 2022 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191772; x=1699727772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dM/C9NKoWZQns8V2ubS9Pw5AwFS8wR+Q2pt2pk3v+2I=;
  b=Tcy66Lxgsa8Sb74Bg1bLbC4NvZ2VNy3fJZkpayckrIRMWN1g5baOxzZ0
   /1SkTRIHou9mLTxfnb71M4SHerUTWz6r5cmIzgkMfyh/lobt8C8C6Z8N5
   EBo5/nc8hHucOAeDYHgoC8HBTmKYLjXVrMO43rU8jA+oylNsoyECXYuis
   UO5pAhhb0k3PZkmJTNcdTIqyyfixuzY9H9LmqpA7Atep7uoc+tHPJJSU7
   qGwnREeVnL0BMikzWjYp4HgU2WkCHqxkcJc034TQ1nso+NUoFvo+8HNiv
   y7t3T+61elwgIMkNuONh25XmB3VPma/79TOwlv0LWZfPzkJ+tRx052Qat
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447702"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089347"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089347"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:11 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 17/26] cgroup/misc: Add notifier block list support for css events
Date:   Fri, 11 Nov 2022 10:35:22 -0800
Message-Id: <20221111183532.3676646-18-kristen@linux.intel.com>
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

Consumers of the misc cgroup controller might need to perform separate actions
in the event of a cgroup alloc, free or release call. In addition,
writes to the max value may also need separate action. Add the ability
to allow code to register for these notifications, and
call the notifier block chain list when appropriate.

This code will be utilized by the SGX driver in a future patch.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h | 17 ++++++++++++
 kernel/cgroup/misc.c        | 52 +++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c238207d1615..8f1b7b6cb81d 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -21,6 +21,12 @@ enum misc_res_type {
 	MISC_CG_RES_TYPES
 };
 
+enum misc_cg_events {
+	MISC_CG_ALLOC,		/* a misc_cg was allocated */
+	MISC_CG_FREE,		/* a misc_cg was freed */
+	MISC_CG_RELEASED,	/* a misc_cg is being freed */
+	MISC_CG_CHANGE,		/* the misc_cg max value was changed */
+};
 struct misc_cg;
 
 #ifdef CONFIG_CGROUP_MISC
@@ -59,6 +65,8 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 		       unsigned long amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg,
 		      unsigned long amount);
+int register_misc_cg_notifier(struct notifier_block *nb);
+int unregister_misc_cg_notifier(struct notifier_block *nb);
 
 /**
  * css_misc() - Get misc cgroup from the css.
@@ -132,5 +140,14 @@ static inline void put_misc_cg(struct misc_cg *cg)
 {
 }
 
+static inline int register_misc_cg_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int unregister_misc_cg_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
 #endif /* CONFIG_CGROUP_MISC */
 #endif /* _MISC_CGROUP_H_ */
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index fe3e8a0eb7ed..1e93e1d20347 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/atomic.h>
 #include <linux/slab.h>
+#include <linux/notifier.h>
 #include <linux/misc_cgroup.h>
 
 #define MAX_STR "max"
@@ -39,6 +40,11 @@ static struct misc_cg root_cg;
  */
 static unsigned long misc_res_capacity[MISC_CG_RES_TYPES];
 
+/*
+ * Notifier list for misc_cg cgroup callback events.
+ */
+static BLOCKING_NOTIFIER_HEAD(misc_cg_notify_list);
+
 /**
  * parent_misc() - Get the parent of the passed misc cgroup.
  * @cgroup: cgroup whose parent needs to be fetched.
@@ -278,10 +284,12 @@ static ssize_t misc_cg_max_write(struct kernfs_open_file *of, char *buf,
 
 	cg = css_misc(of_css(of));
 
-	if (READ_ONCE(misc_res_capacity[type]))
+	if (READ_ONCE(misc_res_capacity[type])) {
 		WRITE_ONCE(cg->res[type].max, max);
-	else
+		blocking_notifier_call_chain(&misc_cg_notify_list, MISC_CG_CHANGE, cg);
+	} else {
 		ret = -EINVAL;
+	}
 
 	return ret ? ret : nbytes;
 }
@@ -400,6 +408,7 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
 		atomic_long_set(&cg->res[i].usage, 0);
 	}
+	blocking_notifier_call_chain(&misc_cg_notify_list, MISC_CG_ALLOC, cg);
 
 	return &cg->css;
 }
@@ -412,13 +421,52 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
  */
 static void misc_cg_free(struct cgroup_subsys_state *css)
 {
+	blocking_notifier_call_chain(&misc_cg_notify_list, MISC_CG_FREE, css_misc(css));
 	kfree(css_misc(css));
 }
 
+/**
+ * misc_cg_released() - Release the misc cgroup
+ * @css: cgroup subsys object.
+ *
+ * Call the notifier chain to notify about the event.
+ *
+ * Context: Any context.
+ */
+static void misc_cg_released(struct cgroup_subsys_state *css)
+{
+	blocking_notifier_call_chain(&misc_cg_notify_list, MISC_CG_RELEASED, css_misc(css));
+}
+
 /* Cgroup controller callbacks */
 struct cgroup_subsys misc_cgrp_subsys = {
 	.css_alloc = misc_cg_alloc,
 	.css_free = misc_cg_free,
+	.css_released = misc_cg_released,
 	.legacy_cftypes = misc_cg_files,
 	.dfl_cftypes = misc_cg_files,
 };
+
+/**
+ * register_misc_cg_notifier() - Register for css callback events
+ * @nb: notifier_block to register
+ *
+ * Context: Any context.
+ */
+int register_misc_cg_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&misc_cg_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_misc_cg_notifier);
+
+/**
+ * unregister_misc_cg_notifier() - unregister for css callback events
+ * @nb: notifier_block to unregister
+ *
+ * Context: Any context.
+ */
+int unregister_misc_cg_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&misc_cg_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_misc_cg_notifier);
-- 
2.37.3

