Return-Path: <cgroups+bounces-4385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C4959265
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2EA1F23606
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E812C486;
	Wed, 21 Aug 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMG9kKWb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100973446;
	Wed, 21 Aug 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205263; cv=none; b=PiYOH3ztqAZ00wgCI3PMfhp2uFM/0Z7xZoi5U+KXqo9nSVDLZfhcav9VVyh7zpEbvI2Jn/vUZ1LaDlhhSy5YLM0nuAoEDfasTaJyvcizHCR04e4sSAI1ACaAn2WYP2GK2RcxjYfSZ2OEY7mkNSesP2aqAJKjlBP2GGz/0C6tYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205263; c=relaxed/simple;
	bh=Gctnl1uIi0yVsQryw5O0kyrWBmCxjEZPN7g3AwSIGyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgrHuhz/MIcg3K3vwTIi3F3v4U+GGKDKivU7w9ZS5DjyssN1zDB0MsW1tFeG1uO6g50PdRrV4iYmvAyT+T/G4cPWfagalt8zUYy3ZR/SWwdiRPB0VIWWEy9NfWg1djAOQXckysy8PCz4X5X1RLd8QmkoBztLRh5DOzEXnoHh3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMG9kKWb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205262; x=1755741262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gctnl1uIi0yVsQryw5O0kyrWBmCxjEZPN7g3AwSIGyg=;
  b=nMG9kKWb/dX1Svv0J1Oe/2a6t5l1prABIpN+b8atmywaymTuPLA8IK2Q
   JFboQ0qMGlZmoxbezHDZxv2uWG4KduZYbO+jUi/haEBjOMszVm9xKMpa/
   VsZt7fIcwaOln7bAMoRqayFGc5hsUglq2enMGyO93XPB3GDOhD8sj8y5Q
   lQ725Egknn7cdSnXI3SJbPnr6uYUjY/bvTAp/Yf5ELD8afU27ORHss/y4
   DeyuXyV1zuEBvD3lOxJNUjEbjb0IqU/LsMpfzUGC+CgElqKVEFR+0bx2c
   lWS9aueEI+PGgKUnA4xrjRjVagJ1VjOJTSG8WhXw5Z1huM3DJ1QjpI5xy
   Q==;
X-CSE-ConnectionGUID: 8/J5WpfDT2mVnKAqlYk91g==
X-CSE-MsgGUID: 9aG+eeM8TRetZ54cKWkitQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107842"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107842"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:16 -0700
X-CSE-ConnectionGUID: mfNwC1JETdWMQdm0xrxvZA==
X-CSE-MsgGUID: MQCVRAAgTLiXV2OOpybvJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078581"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:15 -0700
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
Subject: [PATCH v16 02/16] cgroup/misc: Add per resource callbacks for CSS events
Date: Tue, 20 Aug 2024 18:53:50 -0700
Message-ID: <20240821015404.6038-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821015404.6038-1-haitao.huang@linux.intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
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
 2 files changed, 93 insertions(+), 6 deletions(-)

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
index 0e26068995a6..f3ce896d2c21 100644
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
@@ -105,6 +108,41 @@ int misc_cg_set_capacity(enum misc_res_type type, u64 capacity)
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
+	misc_res_ops[type] = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(misc_cg_set_ops);
+
 /**
  * misc_cg_cancel_charge() - Cancel the charge from the misc cgroup.
  * @type: Misc res type in misc cg to cancel the charge from.
@@ -439,6 +477,36 @@ static struct cftype misc_cg_files[] = {
 	{}
 };
 
+static inline void _misc_cg_res_free(struct misc_cg *cg, enum misc_res_type last)
+{
+	enum misc_res_type i;
+
+	for (i = 0; i <= last; i++)
+		if (misc_res_ops[i] && READ_ONCE(misc_res_capacity[i]))
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
+
+		if (misc_res_ops[i] && READ_ONCE(misc_res_capacity[i])) {
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
@@ -451,20 +519,25 @@ static struct cftype misc_cg_files[] = {
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
@@ -478,7 +551,10 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
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


