Return-Path: <cgroups+bounces-1260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF48418CE
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698D31F23F95
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17137147;
	Tue, 30 Jan 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ8H8rxR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AC36AF6;
	Tue, 30 Jan 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580582; cv=none; b=mjhdMN64V/Ja6ud53jSE5HvaCEcyD62kusdHhK3GS3EGbOzJyHnpGaWtufA4WP0ShsVujl6P7uaYrziBikWzCJUTd65uxhww05fubc7RE968DNS1qjH5vlMBiwtE5e37C75w2jBPocHgxF/bvr6rzqYTPI/5z8+O26KB3ae84OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580582; c=relaxed/simple;
	bh=d/9Zkh3WXT/GzBNXEY2h0MuOAEumEnml0DuJKlUHSQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGZCu/W9YdEyOlVyh4wxTU5K3KBAQucZ8KV1lM2lRsUgqwL1RtFyVmGfII6aVFgUE0YWfev4UaM3UAa5KK2YsaujCvToxCcSVMmWqZdVpZNxClRFsBit0JdatxrlhnGNbwrjkzCUh25j7xP70KMw0fHT3oHCc7G17mGChMHGpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ8H8rxR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580581; x=1738116581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/9Zkh3WXT/GzBNXEY2h0MuOAEumEnml0DuJKlUHSQ0=;
  b=QZ8H8rxR6l9+wzBPRLBz/tYEy2GHgSB/fMbjcduk6t1DGLexziCDFCgy
   PaEmjI5tIzpDDM/lQP4yInXyAsV7zeajgeRKWw02uxukgfcJDKn5ClVZI
   qWLMt+9ezqdu+ByYIpalFsVvUmSBkVxFT6U4Bvs2r6J0YUTksRZNYhKeN
   ej06/mXzhhdtK1wlAAytOLEEzBTkpKOIFZBQulP4iu5LqzAnDDhkc400v
   Gg+QG4v/7Xm1Wn7MWWbJxXJsGkOJ6JfD2cM0qtN87jtloGMN0AT1tlBHz
   6W6GgY0yq+J4aXDZqwAZpVBdR8XixZyNwWvKGntzBXK1YtgPLM4r+6CzR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16530921"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16530921"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042301"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042301"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2024 18:09:38 -0800
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
	chrisyan@microsoft.com
Subject: [PATCH v8 01/15] cgroup/misc: Add per resource callbacks for CSS events
Date: Mon, 29 Jan 2024 18:09:24 -0800
Message-Id: <20240130020938.10025-2-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130020938.10025-1-haitao.huang@linux.intel.com>
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

The misc cgroup controller (subsystem) currently does not perform
resource type specific action for Cgroups Subsystem State (CSS) events:
the 'css_alloc' event when a cgroup is created and the 'css_free' event
when a cgroup is destroyed.

Define callbacks for those events and allow resource providers to
register the callbacks per resource type as needed. This will be
utilized later by the EPC misc cgroup support implemented in the SGX
driver.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V8:
- Abstract out _misc_cg_res_free() and _misc_cg_res_alloc() (Jarkko)
V7:
- Make ops one per resource type and store them in array (Michal)
- Rename the ops struct to misc_res_ops, and enforce the constraints of required callback
functions (Jarkko)
- Moved addition of priv field to patch 4 where it was used first. (Jarkko)

V6:
- Create ops struct for per resource callbacks (Jarkko)
- Drop max_write callback (Dave, Michal)
- Style fixes (Kai)
---
 include/linux/misc_cgroup.h | 11 +++++
 kernel/cgroup/misc.c        | 84 +++++++++++++++++++++++++++++++++----
 2 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e799b1f8d05b..0806d4436208 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -27,6 +27,16 @@ struct misc_cg;
 
 #include <linux/cgroup.h>
 
+/**
+ * struct misc_res_ops: per resource type callback ops.
+ * @alloc: invoked for resource specific initialization when cgroup is allocated.
+ * @free: invoked for resource specific cleanup when cgroup is deallocated.
+ */
+struct misc_res_ops {
+	int (*alloc)(struct misc_cg *cg);
+	void (*free)(struct misc_cg *cg);
+};
+
 /**
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
@@ -56,6 +66,7 @@ struct misc_cg {
 
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
+int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 79a3717a5803..14ab13ef3bc7 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -39,6 +39,9 @@ static struct misc_cg root_cg;
  */
 static u64 misc_res_capacity[MISC_CG_RES_TYPES];
 
+/* Resource type specific operations */
+static const struct misc_res_ops *misc_res_ops[MISC_CG_RES_TYPES];
+
 /**
  * parent_misc() - Get the parent of the passed misc cgroup.
  * @cgroup: cgroup whose parent needs to be fetched.
@@ -105,6 +108,36 @@ int misc_cg_set_capacity(enum misc_res_type type, u64 capacity)
 }
 EXPORT_SYMBOL_GPL(misc_cg_set_capacity);
 
+/**
+ * misc_cg_set_ops() - set resource specific operations.
+ * @type: Type of the misc res.
+ * @ops: Operations for the given type.
+ *
+ * Context: Any context.
+ * Return:
+ * * %0 - Successfully registered the operations.
+ * * %-EINVAL - If @type is invalid, or the operations missing any required callbacks.
+ */
+int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops)
+{
+	if (!valid_type(type))
+		return -EINVAL;
+
+	if (!ops->alloc) {
+		pr_err("%s: alloc missing\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!ops->free) {
+		pr_err("%s: free missing\n", __func__);
+		return -EINVAL;
+	}
+
+	misc_res_ops[type] = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(misc_cg_set_ops);
+
 /**
  * misc_cg_cancel_charge() - Cancel the charge from the misc cgroup.
  * @type: Misc res type in misc cg to cancel the charge from.
@@ -371,6 +404,33 @@ static struct cftype misc_cg_files[] = {
 	{}
 };
 
+static inline int _misc_cg_res_alloc(struct misc_cg *cg)
+{
+	enum misc_res_type i;
+	int ret;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		WRITE_ONCE(cg->res[i].max, MAX_NUM);
+		atomic64_set(&cg->res[i].usage, 0);
+		if (misc_res_ops[i]) {
+			ret = misc_res_ops[i]->alloc(cg);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static inline void _misc_cg_res_free(struct misc_cg *cg)
+{
+	enum misc_res_type i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (misc_res_ops[i])
+			misc_res_ops[i]->free(cg);
+}
+
 /**
  * misc_cg_alloc() - Allocate misc cgroup.
  * @parent_css: Parent cgroup.
@@ -383,20 +443,25 @@ static struct cftype misc_cg_files[] = {
 static struct cgroup_subsys_state *
 misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 {
-	enum misc_res_type i;
-	struct misc_cg *cg;
+	struct misc_cg *parent_cg, *cg;
+	int ret;
 
-	if (!parent_css) {
-		cg = &root_cg;
+	if (unlikely(!parent_css)) {
+		parent_cg = cg = &root_cg;
 	} else {
 		cg = kzalloc(sizeof(*cg), GFP_KERNEL);
 		if (!cg)
 			return ERR_PTR(-ENOMEM);
+		parent_cg = css_misc(parent_css);
 	}
 
-	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
-		WRITE_ONCE(cg->res[i].max, MAX_NUM);
-		atomic64_set(&cg->res[i].usage, 0);
+	ret = _misc_cg_res_alloc(cg);
+	if (ret) {
+		_misc_cg_res_free(cg);
+		if (likely(parent_css))
+			kfree(cg);
+
+		return ERR_PTR(ret);
 	}
 
 	return &cg->css;
@@ -410,7 +475,10 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
  */
 static void misc_cg_free(struct cgroup_subsys_state *css)
 {
-	kfree(css_misc(css));
+	struct misc_cg *cg = css_misc(css);
+
+	_misc_cg_res_free(cg);
+	kfree(cg);
 }
 
 /* Cgroup controller callbacks */
-- 
2.25.1


