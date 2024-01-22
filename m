Return-Path: <cgroups+bounces-1185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9F836E63
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03B11F2981D
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617D4F5E1;
	Mon, 22 Jan 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9JsFyFa"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EF3F8D3;
	Mon, 22 Jan 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944051; cv=none; b=dcs2Ft6LWIXzvn1qlVobhjyJdWySQW9Kc/ZhYwgtuEPormaJIDDL7TOVKck2t19mkzPPKp7MaJLCQo8cPgwRpg0p9omp+dtWBjU9xYNZUjdUst95J7DIHc1Fi4Y/3hlILS3flXCmV4g+40p2x1CcErdTQkjZVqgag9MtYgKsmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944051; c=relaxed/simple;
	bh=82OWhuoYS1GjdlkPieFq7gaYKjlu2VU9BJ2KlGOFoCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAAPL/Fq2fVeCLVi4x55gtCFHDi0OQ8wNgOCV4qhPyjb3oE+KeOCFy/TD228w6Fqq9A4fB2czBpr6Yvgfcg+bKaEBIlSevMuBb2HFGATZ70eFTMYM2eSM1u0L1XVa5YT4yVOYLE1OUprAOZGqPj6pR3lRF8YHd+PsQ3/WAK6JRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9JsFyFa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944050; x=1737480050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82OWhuoYS1GjdlkPieFq7gaYKjlu2VU9BJ2KlGOFoCQ=;
  b=P9JsFyFaSDZo2DaSlWd+hIHvv2Ru3lAhthhkJtNffMLxkrAJvB+XGxI6
   iALGNXiT6Ep9T+NhbqM6ZwX5Y8022h9wrBZh2uOgu/aGTYaCwq4eYCQng
   oFtIKjZA8iVJxA9RqxfEhye1iFmCU8aiY7/qEYdqVVBsGItSEPDcpmnxP
   Au9GNXDek8AsKZ4atZM5SK4dyrM02pcVXGTjzX5JkX7hY+WmXmUvdtaPz
   QRJYIZp7TPowbXszXGRKRd3QzNtgmWI8lTUc151XJPoT+R3lUKyG5DPva
   Fosle9Fq2EVc9U5vMPF5W6YKstEvQgNikhgNqHuDIVk1cj9487wzWCnR1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150099"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150099"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1262857"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa005.jf.intel.com with ESMTP; 22 Jan 2024 09:20:48 -0800
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
	yangjie@microsoft.com
Subject: [PATCH v7 01/15] cgroup/misc: Add per resource callbacks for CSS events
Date: Mon, 22 Jan 2024 09:20:34 -0800
Message-Id: <20240122172048.11953-2-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122172048.11953-1-haitao.huang@linux.intel.com>
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
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
 include/linux/misc_cgroup.h | 11 +++++++
 kernel/cgroup/misc.c        | 60 +++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

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
index 79a3717a5803..b8c32791334c 100644
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
@@ -383,23 +416,37 @@ static struct cftype misc_cg_files[] = {
 static struct cgroup_subsys_state *
 misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 {
+	struct misc_cg *parent_cg, *cg;
 	enum misc_res_type i;
-	struct misc_cg *cg;
+	int ret;
 
 	if (!parent_css) {
-		cg = &root_cg;
+		parent_cg = cg = &root_cg;
 	} else {
 		cg = kzalloc(sizeof(*cg), GFP_KERNEL);
 		if (!cg)
 			return ERR_PTR(-ENOMEM);
+		parent_cg = css_misc(parent_css);
 	}
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
 		atomic64_set(&cg->res[i].usage, 0);
+		if (misc_res_ops[i]) {
+			ret = misc_res_ops[i]->alloc(cg);
+			if (ret)
+				goto alloc_err;
+		}
 	}
 
 	return &cg->css;
+
+alloc_err:
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (misc_res_ops[i])
+			misc_res_ops[i]->free(cg);
+	kfree(cg);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -410,7 +457,14 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
  */
 static void misc_cg_free(struct cgroup_subsys_state *css)
 {
-	kfree(css_misc(css));
+	struct misc_cg *cg = css_misc(css);
+	enum misc_res_type i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (misc_res_ops[i])
+			misc_res_ops[i]->free(cg);
+
+	kfree(cg);
 }
 
 /* Cgroup controller callbacks */
-- 
2.25.1


