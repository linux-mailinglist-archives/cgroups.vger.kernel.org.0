Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA5751404
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjGLXCx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGLXCT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956719B;
        Wed, 12 Jul 2023 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202937; x=1720738937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zH+XX+VHFK8n349nOoRMB7hDW6982oRC8Tt5cNcQSvM=;
  b=mj4Oh7sRh93BpuCLSxSnKB11aJS3Nm9hJPt0N3mr9ETzlWpcYNw/LsrR
   ld0MPuvyCmlABUrEFMjnTLGsERthz0XlDXDkqrQMKAf2iVqYh5Vz+Mri+
   yXkN0STUMIbecOeb5T0XDRaWb+YI7sf/uZBHYjXrYYrfR558w5Hqewtu7
   2j66Q3wp5XUX1NaiPnp1px4LKNYhEWdBtZqOzbLogadmtgTwIF3hFQGYR
   VeKeMRy7laqson8As6VhRANiBVgWZ8GVvAilhoAk12BmCI8N2fmdiBDY/
   u2xJ/7Hu1eDzCicI0359pJUt5Y9tV3twRRl6TETuP3bUShUUeK3RKGuJp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774182"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338659"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338659"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:16 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        zhiquan1.li@intel.com
Subject: [PATCH v3 20/28] cgroup/misc: Add SGX EPC resource type and export APIs for SGX driver
Date:   Wed, 12 Jul 2023 16:01:54 -0700
Message-Id: <20230712230202.47929-21-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/misc_cgroup.h | 29 +++++++++++++++++++++++++++++
 kernel/cgroup/misc.c        | 25 ++++++++++++-------------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 9962b870d382..8bef9d92e36a 100644
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
 	unsigned long max;
 	atomic_long_t usage;
 	atomic_long_t events;
+	void *priv;
 
 	/* per resource callback ops */
 	int (*misc_cg_alloc)(struct misc_cg *cg);
@@ -58,6 +63,7 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
+struct misc_cg *misc_cg_root(void);
 unsigned long misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
@@ -79,6 +85,20 @@ static inline struct misc_cg *css_misc(struct cgroup_subsys_state *css)
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
@@ -103,6 +123,15 @@ static inline void put_misc_cg(struct misc_cg *cg)
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
 
 static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
 {
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 4736db3cd418..ea18eae862a4 100644
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
 static unsigned long misc_res_capacity[MISC_CG_RES_TYPES];
 
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
@@ -151,7 +150,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	if (!amount)
 		return 0;
 
-	for (i = cg; i; i = parent_misc(i)) {
+	for (i = cg; i; i = misc_cg_parent(i)) {
 		res = &i->res[type];
 		new_usage = atomic_long_add_return(amount, &res->usage);
 		if (new_usage > READ_ONCE(res->max) ||
@@ -164,12 +163,12 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	return 0;
 
 err_charge:
-	for (j = i; j; j = parent_misc(j)) {
+	for (j = i; j; j = misc_cg_parent(j)) {
 		atomic_long_inc(&j->res[type].events);
 		cgroup_file_notify(&j->events_file);
 	}
 
-	for (j = cg; j != i; j = parent_misc(j))
+	for (j = cg; j != i; j = misc_cg_parent(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
 	return ret;
@@ -192,7 +191,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg,
 	if (!(amount && valid_type(type) && cg))
 		return;
 
-	for (i = cg; i; i = parent_misc(i))
+	for (i = cg; i; i = misc_cg_parent(i))
 		misc_cg_cancel_charge(type, i, amount);
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
-- 
2.25.1

