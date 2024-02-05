Return-Path: <cgroups+bounces-1354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CA84A858
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FC1C283CB
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F41420D4;
	Mon,  5 Feb 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLZ/BPPu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362B1419AD;
	Mon,  5 Feb 2024 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167205; cv=none; b=i9TKL4at3E8rwgWu0wwHGvyqg1ZUxYne8phLmO/cjF+OLPAGFHG42BH9FJwpS/0ph8SRz4Q+jYw7ZwKh2s/HsQOupp+ylXxrBpsYWBij2XwEXZw5L81WjJ809lFJW8jKmB49mrmx4xoMqSORIEo3doic7o1ZyHirTOt6UdYKAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167205; c=relaxed/simple;
	bh=cWA9gob2e8+ICpFZe+WoA05IlSRb80tvhs1ZzJItqaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQz66TE+K0xyyQQzMu/ddG2hsWdLGpq5RRsED4ULsjhuwOE/0oxfpMzsohI4rdQU5qfNF34ucc2A1B7lIGbiqZ5b5ABGw+e1iKJM1pc4HgSV1OsAJxToHJ2yUHTXtx/ucplUyOVc7UmYGpO8F8nB+VUTloMN/kb+FYSe/0qbOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLZ/BPPu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167204; x=1738703204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWA9gob2e8+ICpFZe+WoA05IlSRb80tvhs1ZzJItqaU=;
  b=aLZ/BPPumJ6jOLFTAeOf+nDhnpClW1K3fHBoqpBz9mb2zhW2CqQiF9p1
   3CFMGBdEOqAHj37vtwmrF+dY/iDkQkb19bo9+uOSGZ2b3oUWfPreChHYQ
   rB/oDkEv8IRbK0VuCCXmIGmiMuMjfRQU2+lyt2njbrsJhGeoVebUILaxW
   SiGXCebttNtnG9VozlDHrznUR/X9ZeLzuzQqQpwHM0zaeGTIwjbXCri5A
   5a6krjB++E7IfzvZtFcdhtYNXhXpHBSyhZqyrzFGb/BKTFTNHERZ4SBfB
   Ox54PMv4Zsy25kbBT3WJijlrSlNqtMkpGFTKzVNlT67GLNT1ik57SPYfw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960377"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960377"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245610"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:40 -0800
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
Subject: [PATCH v9 02/15] cgroup/misc: Export APIs for SGX driver
Date: Mon,  5 Feb 2024 13:06:25 -0800
Message-Id: <20240205210638.157741-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210638.157741-1-haitao.huang@linux.intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

The SGX EPC cgroup will reclaim EPC pages when a usage in a cgroup
reaches its or ancestor's limit. This requires a walk from the current
cgroup up to the root similar to misc_cg_try_charge(). Export
misc_cg_parent() to enable this walk.

The SGX driver may also need start a global level reclamation from the
root. Export misc_cg_root() for the SGX driver to access.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
---
V6:
- Make commit messages more concise and split the original patch into two(Kai)
---
 include/linux/misc_cgroup.h | 24 ++++++++++++++++++++++++
 kernel/cgroup/misc.c        | 21 ++++++++-------------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 0806d4436208..541a5611c597 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -64,6 +64,7 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
+struct misc_cg *misc_cg_root(void);
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops);
@@ -84,6 +85,20 @@ static inline struct misc_cg *css_misc(struct cgroup_subsys_state *css)
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
@@ -108,6 +123,15 @@ static inline void put_misc_cg(struct misc_cg *cg)
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
index 14ab13ef3bc7..1f0d8e05b36c 100644
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
@@ -183,7 +178,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!amount)
 		return 0;
 
-	for (i = cg; i; i = parent_misc(i)) {
+	for (i = cg; i; i = misc_cg_parent(i)) {
 		res = &i->res[type];
 
 		new_usage = atomic64_add_return(amount, &res->usage);
@@ -196,12 +191,12 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
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
@@ -223,7 +218,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!(amount && valid_type(type) && cg))
 		return;
 
-	for (i = cg; i; i = parent_misc(i))
+	for (i = cg; i; i = misc_cg_parent(i))
 		misc_cg_cancel_charge(type, i, amount);
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
-- 
2.25.1


