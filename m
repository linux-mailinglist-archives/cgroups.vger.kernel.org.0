Return-Path: <cgroups+bounces-123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C747DBFAF
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBA5B20FD7
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C3F1A271;
	Mon, 30 Oct 2023 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1uvufC3"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362519BAC
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDECC9;
	Mon, 30 Oct 2023 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690031; x=1730226031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbc5z15jjbdRkyhWfBNnPpmSka2dKIEP/U6WNWcCv9k=;
  b=J1uvufC3k+kkb07KdbRtvHvWUb5KsOcRkkvEjyuvZuEk5AQlI+PsFT+l
   yz42QpYKA2ECHv2Jm3jAiV92nXdQHyW1aEkabBpjNoDBy0KJBTQtDwMxi
   1OWbzK/5TQTMjPIqLK9Y1zDaT4uO4wTLRPUgPx2JnYO/fZGt/OJEHqF/Z
   10Oflc3p8AWKJbV8XJEcN0VxAV8ODXBrevU+RW4Vs8QV2Q4LOP5yBPQve
   VifZB7S6ML9buXGosA4YSSHdQ26DzhRB+Zl8piVHauZ1jJLeWTrtIsuBd
   N1hImS3m7ozgwkT21Um1+d/Ga31MISgxRMU0gvRxrWYOTYjqO/d/hvwQL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479531"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529501"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529501"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:28 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 02/12] cgroup/misc: Export APIs for SGX driver
Date: Mon, 30 Oct 2023 11:20:03 -0700
Message-Id: <20231030182013.40086-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Export misc_cg_root() so the SGX EPC cgroup can access and do extra
setup during initialization, e.g., set callbacks and private data
previously defined.

The SGX EPC cgroup will reclaim EPC pages when a usage in a cgroup
reaches its or ancestor's limit. This requires a walk from the current
cgroup up to the root similar to misc_cg_try_charge(). Export
misc_cg_parent() to enable this walk.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V6:
- Make commit messages more concise and split the original patch into two(Kai)
---
 include/linux/misc_cgroup.h | 24 ++++++++++++++++++++++++
 kernel/cgroup/misc.c        | 21 ++++++++-------------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 5dc509c27c3d..2a3b1f8dc669 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -68,6 +68,7 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
+struct misc_cg *misc_cg_root(void);
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
@@ -87,6 +88,20 @@ static inline struct misc_cg *css_misc(struct cgroup_subsys_state *css)
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
@@ -111,6 +126,15 @@ static inline void put_misc_cg(struct misc_cg *cg)
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
index d971ede44ebf..fa464324ccf8 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -40,18 +40,13 @@ static struct misc_cg root_cg;
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
@@ -150,7 +145,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!amount)
 		return 0;
 
-	for (i = cg; i; i = parent_misc(i)) {
+	for (i = cg; i; i = misc_cg_parent(i)) {
 		res = &i->res[type];
 
 		new_usage = atomic64_add_return(amount, &res->usage);
@@ -163,12 +158,12 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
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
@@ -190,7 +185,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!(amount && valid_type(type) && cg))
 		return;
 
-	for (i = cg; i; i = parent_misc(i))
+	for (i = cg; i; i = misc_cg_parent(i))
 		misc_cg_cancel_charge(type, i, amount);
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
-- 
2.25.1


