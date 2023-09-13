Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E679DEE8
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 06:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjIMEIx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 00:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbjIMEIw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 00:08:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D92CE4B;
        Tue, 12 Sep 2023 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578128; x=1726114128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HqRj5uRH5mZXfWy3E/kPRnOT0vE/WrAZ/bOtfduqTXE=;
  b=NBrZ6n5K5gFQKKSBgQzBXscMtI83lmxfUndRVUb5GHTBhU3OJ7IMHoUs
   uVDKjLRkmXe18FQQejgqN0GJDBd4Sn7jSf+qJq18F/bj60SjE70B1t8MV
   GPxLIRTLJYc5JBqNQOo9JXH2f5eHg9lfxN9+uI21PYJM6LLHLLP/jB96s
   a/GFICsuuKILhX3kfT/SWVqoCDCOL83tZmn7C1nGGdZ0x8c1DoC2x4jTF
   jfNZgFzelm8fCTPpS48r4OvWyot8g5DwlqpJexi1YQjSYYlSkYM6J3BQ8
   WFJHVtPgXAzPlTBzT/N7kBSsgbUrLDKIiaLSdc1PG+yhK9+e9Wx+/LduT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357990310"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357990310"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747155873"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747155873"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:06:38 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v4 02/18] cgroup/misc: Add SGX EPC resource type and export APIs for SGX driver
Date:   Tue, 12 Sep 2023 21:06:19 -0700
Message-Id: <20230913040635.28815-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913040635.28815-1-haitao.huang@linux.intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

The SGX driver will need to get access to the root misc_cg object
to do iterative walks and also determine if a charge will be
towards the root cgroup or not.

To manage the SGX EPC memory via the misc controller, the SGX
driver will also need to be able to iterate over the misc cgroup
hierarchy.

Move parent_misc() into misc_cgroup.h and make inline to make this
function available to SGX, rename it to misc_cg_parent(), and update
misc.c to use the new name.

Add per resource type private data so that SGX can store additional
per cgroup data with the misc_cg struct.

Allow SGX EPC memory to be a valid resource type for the misc
controller.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V4:
- Moved this to the second in the series.
---
 include/linux/misc_cgroup.h | 29 +++++++++++++++++++++++++++++
 kernel/cgroup/misc.c        | 25 ++++++++++++-------------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e1bcd176c2de..6f8330f435ba 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -17,6 +17,10 @@ enum misc_res_type {
 	MISC_CG_RES_SEV,
 	/* AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
+#endif
+#ifdef CONFIG_CGROUP_SGX_EPC
+	/* SGX EPC memory resource */
+	MISC_CG_RES_SGX_EPC,
 #endif
 	MISC_CG_RES_TYPES
 };
@@ -37,6 +41,7 @@ struct misc_res {
 	u64 max;
 	atomic64_t usage;
 	atomic64_t events;
+	void *priv;
 
 	/* per resource callback ops */
 	int (*misc_cg_alloc)(struct misc_cg *cg);
@@ -59,6 +64,7 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
+struct misc_cg *misc_cg_root(void);
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
@@ -78,6 +84,20 @@ static inline struct misc_cg *css_misc(struct cgroup_subsys_state *css)
 	return css ? container_of(css, struct misc_cg, css) : NULL;
 }
 
+/**
+ * misc_cg_parent() - Get the parent of the passed misc cgroup.
+ * @cgroup: cgroup whose parent needs to be fetched.
+ *
+ * Context: Any context.
+ * Return:
+ * * struct misc_cg* - Parent of the @cgroup.
+ * * %NULL - If @cgroup is null or the passed cgroup does not have a parent.
+ */
+static inline struct misc_cg *misc_cg_parent(struct misc_cg *cgroup)
+{
+	return cgroup ? css_misc(cgroup->css.parent) : NULL;
+}
+
 /*
  * get_current_misc_cg() - Find and get the misc cgroup of the current task.
  *
@@ -102,6 +122,15 @@ static inline void put_misc_cg(struct misc_cg *cg)
 }
 
 #else /* !CONFIG_CGROUP_MISC */
+static inline struct misc_cg *misc_cg_root(void)
+{
+	return NULL;
+}
+
+static inline struct misc_cg *misc_cg_parent(struct misc_cg *cg)
+{
+	return NULL;
+}
 
 static inline u64 misc_cg_res_total_usage(enum misc_res_type type)
 {
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index e0092170d0dd..dbd881be773f 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -24,6 +24,10 @@ static const char *const misc_res_name[] = {
 	/* AMD SEV-ES ASIDs resource */
 	"sev_es",
 #endif
+#ifdef CONFIG_CGROUP_SGX_EPC
+	/* Intel SGX EPC memory bytes */
+	"sgx_epc",
+#endif
 };
 
 /* Root misc cgroup */
@@ -40,18 +44,13 @@ static struct misc_cg root_cg;
 static u64 misc_res_capacity[MISC_CG_RES_TYPES];
 
 /**
- * parent_misc() - Get the parent of the passed misc cgroup.
- * @cgroup: cgroup whose parent needs to be fetched.
- *
- * Context: Any context.
- * Return:
- * * struct misc_cg* - Parent of the @cgroup.
- * * %NULL - If @cgroup is null or the passed cgroup does not have a parent.
+ * misc_cg_root() - Return the root misc cgroup.
  */
-static struct misc_cg *parent_misc(struct misc_cg *cgroup)
+struct misc_cg *misc_cg_root(void)
 {
-	return cgroup ? css_misc(cgroup->css.parent) : NULL;
+	return &root_cg;
 }
+EXPORT_SYMBOL_GPL(misc_cg_root);
 
 /**
  * valid_type() - Check if @type is valid or not.
@@ -150,7 +149,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!amount)
 		return 0;
 
-	for (i = cg; i; i = parent_misc(i)) {
+	for (i = cg; i; i = misc_cg_parent(i)) {
 		res = &i->res[type];
 
 		new_usage = atomic64_add_return(amount, &res->usage);
@@ -163,12 +162,12 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	return 0;
 
 err_charge:
-	for (j = i; j; j = parent_misc(j)) {
+	for (j = i; j; j = misc_cg_parent(j)) {
 		atomic64_inc(&j->res[type].events);
 		cgroup_file_notify(&j->events_file);
 	}
 
-	for (j = cg; j != i; j = parent_misc(j))
+	for (j = cg; j != i; j = misc_cg_parent(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
 	return ret;
@@ -190,7 +189,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!(amount && valid_type(type) && cg))
 		return;
 
-	for (i = cg; i; i = parent_misc(i))
+	for (i = cg; i; i = misc_cg_parent(i))
 		misc_cg_cancel_charge(type, i, amount);
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
-- 
2.25.1

