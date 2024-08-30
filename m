Return-Path: <cgroups+bounces-4630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D5396671E
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883C71C215D4
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF271BA86F;
	Fri, 30 Aug 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwzVmlIh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E021B81D2;
	Fri, 30 Aug 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036096; cv=none; b=IQwOJuFd9Yi7Vsu1zHI4uYOF4BFd5D9EucsQtaHeHAn7tVEGe0uPpOrMUtcayNxEWalnmCzC8WALGKLBfpFqc8tiniPfOMukCz12jdHdjPnXZGvGiuHBuX2cBFZ3ErptI1QNgp3uyfT7pm3ODuH/f0w0dfKfktrLj9T1y4kPSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036096; c=relaxed/simple;
	bh=qQz3KW0mRe/vY0iIKXAMbxtAf+LKEJFOzU5inEYCuzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpSIcQx74cO2vxHTNAScGN2do4aGUklcjGVfdRik0yDoC5mqMu6soK8EugRW5Yt4RzXjYqRcASX3j69pUzQh28O4Kc3au7JRm3tkY96/PT01Z8w7sh67nFaq1+4Yps5Fyvi4XVbiPN46Y/ljsSE8k20nUyc/pQSlBVjv8DhOLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwzVmlIh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036094; x=1756572094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQz3KW0mRe/vY0iIKXAMbxtAf+LKEJFOzU5inEYCuzI=;
  b=kwzVmlIh4qmlNnQB/9vyFg22MMYc5mLXfIooQCatOXO3CFmew/5B443c
   7l3u8Wbrzj6R/E0AqVjtLVjF2bFkcyEnzATTutJ5gJow9YM8JE+hWPu7N
   DS7qikTWtRdagJPir79DtEIwQwLbSxIeKcM1QA6Il7avCHhMz9foU4MwN
   XVW8HkQo3MetRfDzJJXwqR1b5ZV2cWmnCIiKf+r3sz8pwO7G6Yi3vGY/u
   srBHgZJfDqj5JyEa/XKR1WEpyidYWFlY49DuUhbNw5lD4nyOYYS55h2Br
   7Uf446KR2WGg/5oRZcrRMIsFfwVqMzLaf2yxj3YRr7/aDTZw2G5sRw/oB
   A==;
X-CSE-ConnectionGUID: n/SXqgpoRmOCEYSW5m8TRA==
X-CSE-MsgGUID: tbCOJ5U6ShSuIokcOGPU5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34299954"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34299954"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: KoRjFvu7TwWUE1r+kDBYHw==
X-CSE-MsgGUID: 27iPO1OrQ32+lOftYxFZGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440458"
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
Subject: [PATCH v17 03/16] cgroup/misc: Expose APIs for SGX driver
Date: Fri, 30 Aug 2024 09:40:24 -0700
Message-ID: <20240830164038.39343-4-haitao.huang@linux.intel.com>
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

The SGX EPC cgroup will reclaim EPC pages when usage in a cgroup reaches
its or ancestor's limit. This requires a walk from the current cgroup up
to the root similar to misc_cg_try_charge(). Expose misc_cg_parent() to
enable this walk.

The SGX driver also needs start a global level reclamation from the
root. Expose misc_cg_root() for the SGX driver to access.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V17:
- Remove EXPORT_SYMBOL_GPL as these are currently used by the builtin
  SGX driver only. (Kai)

V6:
- Make commit messages more concise and split the original patch into two(Kai)
---
 include/linux/misc_cgroup.h | 24 ++++++++++++++++++++++++
 kernel/cgroup/misc.c        | 20 +++++++-------------
 2 files changed, 31 insertions(+), 13 deletions(-)

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
index b06343ab9651..757b534bec5f 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -43,17 +43,11 @@ static u64 misc_res_capacity[MISC_CG_RES_TYPES];
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
 
 /**
@@ -176,7 +170,7 @@ static void misc_cg_event(enum misc_res_type type, struct misc_cg *cg)
 	atomic64_inc(&cg->res[type].events_local);
 	cgroup_file_notify(&cg->events_local_file);
 
-	for (; parent_misc(cg); cg = parent_misc(cg)) {
+	for (; misc_cg_parent(cg); cg = misc_cg_parent(cg)) {
 		atomic64_inc(&cg->res[type].events);
 		cgroup_file_notify(&cg->events_file);
 	}
@@ -211,7 +205,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!amount)
 		return 0;
 
-	for (i = cg; i; i = parent_misc(i)) {
+	for (i = cg; i; i = misc_cg_parent(i)) {
 		res = &i->res[type];
 
 		new_usage = atomic64_add_return(amount, &res->usage);
@@ -227,7 +221,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 err_charge:
 	misc_cg_event(type, i);
 
-	for (j = cg; j != i; j = parent_misc(j))
+	for (j = cg; j != i; j = misc_cg_parent(j))
 		misc_cg_cancel_charge(type, j, amount);
 	misc_cg_cancel_charge(type, i, amount);
 	return ret;
@@ -249,7 +243,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	if (!(amount && valid_type(type) && cg))
 		return;
 
-	for (i = cg; i; i = parent_misc(i))
+	for (i = cg; i; i = misc_cg_parent(i))
 		misc_cg_cancel_charge(type, i, amount);
 }
 EXPORT_SYMBOL_GPL(misc_cg_uncharge);
-- 
2.43.0


