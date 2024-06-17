Return-Path: <cgroups+bounces-3194-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459A590AE40
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEC6281857
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875A197A91;
	Mon, 17 Jun 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNah/8EA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D61F19755F;
	Mon, 17 Jun 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628822; cv=none; b=NBlWY2j98jVASzGCyCmcKLxudb/6hN5TxFSxepq0YdHi7GeX8wyQtnYmwnvMpW5aSGgzriT26cPqC4XVC+J8JE34nkK8PaSMs7qHBe3PH8loJZgF7lfxyiLDDn+cs9yz/wUydXxJnD9HG4o94Y3LtyWq8H/BpVLRaXPnvBStd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628822; c=relaxed/simple;
	bh=oR+tYZ/GsFpEGJISo8R+qsvqhNO4Ax18tRJakz4LRA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo+H32nkZQGcCJ66CyB4xSuWrcA2xfMhsnDRVa3htdt05TcALEssKT7Sfz1WnKl4c+23Tc1xX2OwNmd8yxPXGIwIfyXM12JChewjjtnbI4fCosARe0RzMYg2HfUl35Lw1Wv8sAQo1cyEF8NyCEyvwvfNpEwxGhCT8L+Jb7mRMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNah/8EA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628821; x=1750164821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oR+tYZ/GsFpEGJISo8R+qsvqhNO4Ax18tRJakz4LRA0=;
  b=kNah/8EAePpQRKCCi/k/o49+Eli0lCwBO5ai0olhyyxMoaDQ3+DxNcOZ
   An5W1c8Aa1TZOIxAKFKcUlSXND0c8r+iZH7H/lW/zk0ljlxioJrgINsjQ
   vCgCoW3yJQD+J/l8lzpba8ATce5VdFdDvf/8ixaOmJZSyoMIByvCVo+Jq
   G2ovceDZIbHpSlVmci8aEKb/ihHBaiXuNZS8amaodTstvRlM8YK5hioZF
   Re7XqysLRg4FU4IVEdl8MxcuboGo5Bl/2k0qeaTuJkTFQzpNDXxcSSFgf
   tYfs/XZoiTWSiC5ThSR7TowGx95KzHWJ7n8XDAI3k+fVfD9ZLu0HwVZIq
   g==;
X-CSE-ConnectionGUID: v/KCk5HLRo67akaxyhJc8Q==
X-CSE-MsgGUID: ssZWt2xVQ0avZAfCp/7KtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570844"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570844"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:39 -0700
X-CSE-ConnectionGUID: 1F3UnhBgS3ewYH+bMrJuUw==
X-CSE-MsgGUID: Z6M3T2LvQcOR8+HLJJlUHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387491"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:38 -0700
From: "Huang, Haitao" <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v15 02/14] cgroup/misc: Add per resource callbacks for CSS events
Date: Mon, 17 Jun 2024 05:53:09 -0700
Message-ID: <20240617125321.36658-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617125321.36658-1-haitao.huang@linux.intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
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

This design passes a struct misc_cg into the callbacks. An alternative
to pass only a struct misc_res was considered for encapsulating how
misc_cg stores its misc_res array. However, the SGX driver would still
need to access the misc_res array in the statically defined misc root_cg
during initialization to set resource specific fields. Therefore, some
extra getter/setter APIs to abstract such access to the misc_res array
within the misc_cg struct would be needed. That seems an overkill at the
moment and is deferred to later improvement when there are more users of
these callbacks.

Link: https://lore.kernel.org/lkml/op.2kdw36otwjvjmi@hhuan26-mobl.amr.corp.intel.com/

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V15:
- Style fixes (Jarkko, Kai)
- _misc_cg_res_free() takes the last index. Only call ->free() for those res types with ->alloc() successfully called. (Ridong)

V12:
- Add comments in commit to clarify reason to pass in misc_cg, not
misc_res. (Kai)
- Remove unlikely (Kai)

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
 kernel/cgroup/misc.c        | 82 ++++++++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 6 deletions(-)

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
index 79a3717a5803..1edc005e9476 100644
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
@@ -371,6 +404,35 @@ static struct cftype misc_cg_files[] = {
 	{}
 };
 
+static inline void _misc_cg_res_free(struct misc_cg *cg, enum misc_res_type last)
+{
+	enum misc_res_type i;
+
+	for (i = 0; i <= last; i++)
+		if (misc_res_ops[i])
+			misc_res_ops[i]->free(cg);
+}
+
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
+			if (ret) {
+				_misc_cg_res_free(cg, i);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /**
  * misc_cg_alloc() - Allocate misc cgroup.
  * @parent_css: Parent cgroup.
@@ -383,20 +445,25 @@ static struct cftype misc_cg_files[] = {
 static struct cgroup_subsys_state *
 misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 {
-	enum misc_res_type i;
-	struct misc_cg *cg;
+	struct misc_cg *parent_cg, *cg;
+	int ret;
 
 	if (!parent_css) {
+		parent_cg = &root_cg;
 		cg = &root_cg;
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
+		if (likely(parent_css))
+			kfree(cg);
+
+		return ERR_PTR(ret);
 	}
 
 	return &cg->css;
@@ -410,7 +477,10 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
  */
 static void misc_cg_free(struct cgroup_subsys_state *css)
 {
-	kfree(css_misc(css));
+	struct misc_cg *cg = css_misc(css);
+
+	_misc_cg_res_free(cg, MISC_CG_RES_TYPES - 1);
+	kfree(cg);
 }
 
 /* Cgroup controller callbacks */
-- 
2.43.0


