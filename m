Return-Path: <cgroups+bounces-4628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769D966719
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60A11F243DC
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306491B8EB3;
	Fri, 30 Aug 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2TYlCki"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5181B3B10;
	Fri, 30 Aug 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036095; cv=none; b=tswq8S+koFYOBMvUeq5eFAs5OkKwGM/4Nwef2Z/WQ71A64rxalrZwWC3dz3P4d9W4zHORobacZGQhc6/d4BOK41lQ67S2x89vxmjyRoutPhbo/Kg+gyd1rTOlvinL7eGv+dgK7cUz6nJxNl+XLxMjgX05xrBHxPFpN2UpRVVgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036095; c=relaxed/simple;
	bh=bHMXR4kBlHaQNWZ1sZmWtMAydRtALmz756Tvz0peBSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PENBnlUd4+8NmZCC445WGrT6KnJgpXl0pDKrdCHQGvOgWHFhFiqKKASFcWzYglS0lFjYxYyQXHUwrqRMfIvfb6tce8n23fqGVBoJ1KaCivtdTgZYkYW8itAKlW1NEkDyctyZeyYLrfDyWsBAp9mQXlPtfHfMvIgoNYhCWNvmBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2TYlCki; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036093; x=1756572093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHMXR4kBlHaQNWZ1sZmWtMAydRtALmz756Tvz0peBSA=;
  b=k2TYlCkiU2iMMHmNGyEsUc7jm8a60lkyiR+MRCdtg42TfIoFmVwGwFpO
   nc4MPO0SKe04Sm0KCaqXopIwAFmnEE24kVQ9xKzmoVfZRU3VZCAaeli6h
   iB6KwTzm1qk4jbkoGcbTQczhVq8MAQdBC+ozMlpsWd36uag8O33rgMDqe
   MGL144sRw3aPeoVfvZaGsto3fUDtJPoAwbBkmP2jrkiSjLZ0ObqlVI910
   IfMWUxRJO4YqVJTgwfW71j5jcaorY9cpSZRjZ0Lx7o7qcAIZhQeX5Hrce
   W+N/xGvXzrzyVfA4/VoXA01V4p0ST+PeP7GdMgBh85hLnfE2/BXWqiYWU
   Q==;
X-CSE-ConnectionGUID: ftDaNkHCTqy3Ex29BokULA==
X-CSE-MsgGUID: Cs9hV5WhT+C6VLu9CUKtlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34299925"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34299925"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: iOqFgDb9Th6apccG67sCEA==
X-CSE-MsgGUID: 5YqiamlnRsu+S/vmsVLAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440455"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
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
Subject: [PATCH v17 02/16] cgroup/misc: Add per resource callbacks for CSS events
Date: Fri, 30 Aug 2024 09:40:23 -0700
Message-ID: <20240830164038.39343-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830164038.39343-1-haitao.huang@linux.intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
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

The SGX callbacks will need to access the 'struct misc_cg'.  Pass
'struct misc_cg' to the callbacks but not the 'struct misc_res' because
the latter doesn't have a pointer pointing back to 'struct misc_cg'.

Link: https://lore.kernel.org/lkml/op.2kdw36otwjvjmi@hhuan26-mobl.amr.corp.intel.com/

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V17:
- remove EXPORT_SYMBOL_GPL and add READ_ONCE, WRITE_ONCE to be consistent, remove unused parent_cg. (Kai)

V16:
- Don't call the ops if capacity is zero. (Kai)
- Simplify the last paragraph of the commit message. (Kai)

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
 kernel/cgroup/misc.c        | 88 ++++++++++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 49eef10c8e59..e5159770a68e 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -28,6 +28,16 @@ struct misc_cg;
 
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
@@ -62,6 +72,7 @@ struct misc_cg {
 
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
+int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 0e26068995a6..b06343ab9651 100644
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
@@ -105,6 +108,40 @@ int misc_cg_set_capacity(enum misc_res_type type, u64 capacity)
 }
 EXPORT_SYMBOL_GPL(misc_cg_set_capacity);
 
+/**
+ * misc_cg_set_ops() - register resource specific operations.
+ * @type: Type of the misc res.
+ * @ops: Operations for the given type.
+ *
+ * The callbacks in @ops will not be invoked if the capacity of @type is 0.
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
+	if (!ops)
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
+	WRITE_ONCE(misc_res_ops[type], ops);
+	return 0;
+}
+
 /**
  * misc_cg_cancel_charge() - Cancel the charge from the misc cgroup.
  * @type: Misc res type in misc cg to cancel the charge from.
@@ -439,6 +476,41 @@ static struct cftype misc_cg_files[] = {
 	{}
 };
 
+static inline void _misc_cg_res_free(struct misc_cg *cg, enum misc_res_type last)
+{
+	const struct misc_res_ops *ops;
+	enum misc_res_type i;
+
+	for (i = 0; i <= last; i++) {
+		ops = READ_ONCE(misc_res_ops[i]);
+		if (ops && READ_ONCE(misc_res_capacity[i]))
+			ops->free(cg);
+	}
+}
+
+static inline int _misc_cg_res_alloc(struct misc_cg *cg)
+{
+	const struct misc_res_ops *ops;
+	enum misc_res_type i;
+	int ret;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		WRITE_ONCE(cg->res[i].max, MAX_NUM);
+		atomic64_set(&cg->res[i].usage, 0);
+
+		ops = READ_ONCE(misc_res_ops[i]);
+		if (ops && READ_ONCE(misc_res_capacity[i])) {
+			ret = ops->alloc(cg);
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
@@ -451,8 +523,8 @@ static struct cftype misc_cg_files[] = {
 static struct cgroup_subsys_state *
 misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 {
-	enum misc_res_type i;
 	struct misc_cg *cg;
+	int ret;
 
 	if (!parent_css) {
 		cg = &root_cg;
@@ -462,9 +534,12 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 			return ERR_PTR(-ENOMEM);
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
@@ -478,7 +553,10 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
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


