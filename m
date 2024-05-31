Return-Path: <cgroups+bounces-3050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A307D8D6C64
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8A2853A1
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BA4823DF;
	Fri, 31 May 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+Au7tMx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255381204;
	Fri, 31 May 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194396; cv=none; b=oWFTo4wYGvGJLltar2jkyIVTqUk9E2isUCMqWSoe/Yflm0O7vJmYkF2kUIcP4B0sEk6AGWnTN8t9WGUbq3P1PzsfbsIsW46N08W7WSefgAk/duZGNLsYCf9qRT4Xv0a8Cp8xHBp7Q9rt0WiwNEKYoYqTVMvPmXzJWLIzq86PoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194396; c=relaxed/simple;
	bh=eqN2yKPP04cTarojAaLprGk14sHMHhoIfgiMAqyE0Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKbI2S6Jbj+R8oqUL6osd3R28wuPP3xCGrcf1J4lAtdilUCfx3pQjF4ghptSZsMhGVJoEMbe1xSlWbmBgw8giuXPcO6gjiv6hevf4/3ns4bxb3JAPN+rqYd4bef1vd56azVecaAZAyzzRhZAZLINacVH1biGmpn/I7JcWOyUz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+Au7tMx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194394; x=1748730394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eqN2yKPP04cTarojAaLprGk14sHMHhoIfgiMAqyE0Ac=;
  b=P+Au7tMxlkX/rMczxPEGEClwFkdU9mPUdrP/F57Uc6VlB+HEHxBp6lnq
   RKqTQfLjCiH8cs+Bf1e0BP95N3aDA7lvSJmIT2gQNCKNZ2DEfxbBX80pJ
   KxpJiuoNdW77ahgF3+P47QLgwIbOSnGbBuxQNnscJvVNwuecgePCK06Qu
   byNZh01ZgZEREWaHoHVL4zGQM4SM4D/vbT4Hj/wGghF/rAvgDBlQFgQvc
   GqNPin/0TA0xVMpMP/9dp5X9aNvDAYCg8koDGfyknVchC6/ZCRhsYgHKn
   vS+M7HYA0BKCyqrbFIec3emd1U/rqeWNND5C/GCiTwfD1wCcAGoPGjOV/
   w==;
X-CSE-ConnectionGUID: ntQbN9hvQ5OBNZgXiiO+HA==
X-CSE-MsgGUID: 6wcc7LN+RueDUTrBT4xU7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13949752"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13949752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:26:33 -0700
X-CSE-ConnectionGUID: 44jArniuRd+A6i6mX8tIew==
X-CSE-MsgGUID: jg7XUO40RaOhL9ENjCry3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40736921"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 15:26:32 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
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
Subject: [PATCH v14 03/14] cgroup/misc: Export APIs for SGX driver
Date: Fri, 31 May 2024 15:26:19 -0700
Message-Id: <20240531222630.4634-4-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531222630.4634-1-haitao.huang@linux.intel.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
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
index 4a602d68cf7d..7d852139121a 100644
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


