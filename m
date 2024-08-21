Return-Path: <cgroups+bounces-4386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002EE959266
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800121F23672
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A470132105;
	Wed, 21 Aug 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FATUj1A5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A574409;
	Wed, 21 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205264; cv=none; b=VgYUluKrOsdiNReTmuGBlxrToe5HPxup5PNL0CIuBqnUJd5Vmc/FscVZ9efHbSqP/O7PCA3b1g9a/o2+IbJIhECpJCZuqIORAUkYpzgrzRDnYABICPat16TBoK+nrlwJJ+juK8joVJnnctsLhobKhBQeyzZvUNcKtsFJrWxqF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205264; c=relaxed/simple;
	bh=YAgrZDUeDA2UrpO1iL6qJvR71TlLWMqyfnQMERdb9lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8EAZVU43PzqA6+K5PIF5OlajuyODNwHqZAqBzo9T+Ceu+sKZMuT9OUh7KuN3Dj+3o5YdHsUoEgIvVghzeLerSTk88WJmpb+x1fnpbeaRxzzrxLSPay2yqIZEOIAqMxVJHVk43OgTWq7Je9fGViRt2huXIKecylXoJg9Fb3W46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FATUj1A5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205262; x=1755741262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YAgrZDUeDA2UrpO1iL6qJvR71TlLWMqyfnQMERdb9lQ=;
  b=FATUj1A5i5i2n0A/K9cLmgaNZ3nNslOJg/X1OxyDSXjuCD7hBrlymYc3
   1vo0yOOFl5DkXGeVDWqAPSdBzULWiQL6pQg3XRkzIF33L/p4uMCPPrpQz
   yeE3RUFuNKVLj5XO2qKvxYMWLKA4hAyAnSU/H9HpcHi6CcM8iNxGQLWZA
   +j8OdEm+fzrr6abKmUUghHEZpU+7Zh6Q24hOxXm2EMJlAiQLR/l8b5RIt
   eXIZ+N6ToVFO54EIAI19sgEWzEmw2odVpV+UBF7zx1tpEC+cxg8UrVleX
   lcVR3PAcb8urN+VFXTaqEoXAE2RlSMsOEC6wKZ0Hv5qDOTAh/5J6FxbpU
   A==;
X-CSE-ConnectionGUID: Z9dVpALJSeeUKKjf/PCJdw==
X-CSE-MsgGUID: 3WmFH1F4SwSVWHpy1PZM0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107848"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107848"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:17 -0700
X-CSE-ConnectionGUID: ie9LAiRcRgWzv+vE7mVRxg==
X-CSE-MsgGUID: wLHH0YWPTZui8e7CbyRcMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078585"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:16 -0700
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
Subject: [PATCH v16 03/16] cgroup/misc: Export APIs for SGX driver
Date: Tue, 20 Aug 2024 18:53:51 -0700
Message-ID: <20240821015404.6038-4-haitao.huang@linux.intel.com>
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

The SGX EPC cgroup will reclaim EPC pages when usage in a cgroup reaches
its or ancestor's limit. This requires a walk from the current cgroup up
to the root similar to misc_cg_try_charge(). Export misc_cg_parent() to
enable this walk.

The SGX driver also needs start a global level reclamation from the
root. Export misc_cg_root() for the SGX driver to access.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V6:
- Make commit messages more concise and split the original patch into two(Kai)
---
 include/linux/misc_cgroup.h | 24 ++++++++++++++++++++++++
 kernel/cgroup/misc.c        | 21 ++++++++-------------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e5159770a68e..75c711333ad4 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -70,6 +70,7 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
+struct misc_cg *misc_cg_root(void);
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops);
@@ -90,6 +91,20 @@ static inline struct misc_cg *css_misc(struct cgroup_subsys_state *css)
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
@@ -114,6 +129,15 @@ static inline void put_misc_cg(struct misc_cg *cg)
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
index f3ce896d2c21..6cf1f0899f4e 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -43,18 +43,13 @@ static u64 misc_res_capacity[MISC_CG_RES_TYPES];
 static const struct misc_res_ops *misc_res_ops[MISC_CG_RES_TYPES];
 
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
@@ -177,7 +172,7 @@ static void misc_cg_event(enum misc_res_type type, struct misc_cg *cg)
 	atomic64_inc(&cg->res[type].events_local);
 	cgroup_file_notify(&cg->events_local_file);
 
-	for (; parent_misc(cg); cg = parent_misc(cg)) {
+	for (; misc_cg_parent(cg); cg = misc_cg_parent(cg)) {
 		atomic64_inc(&cg->res[type].events);
 		cgroup_file_notify(&cg->events_file);
 	}
@@ -212,7 +207,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!amount)
 		return 0;
 
-	for (i = cg; i; i = parent_misc(i)) {
+	for (i = cg; i; i = misc_cg_parent(i)) {
 		res = &i->res[type];
 
 		new_usage = atomic64_add_return(amount, &res->usage);
@@ -228,7 +223,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 err_charge:
 	misc_cg_event(type, i);
 
-	for (j = cg; j != i; j = parent_misc(j))
+	for (j = cg; j != i; j = misc_cg_parent(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
 	return ret;
@@ -250,7 +245,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!(amount && valid_type(type) && cg))
 		return;
 
-	for (i = cg; i; i = parent_misc(i))
+	for (i = cg; i; i = misc_cg_parent(i))
 		misc_cg_cancel_charge(type, i, amount);
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
-- 
2.43.0


