Return-Path: <cgroups+bounces-3614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0292E48B
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 12:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304211F210DF
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC9158D6D;
	Thu, 11 Jul 2024 10:23:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B72209B;
	Thu, 11 Jul 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693420; cv=none; b=vBzhHDp1B3LAWnSPygtl93n4lDDVElCT6+pjJhTJzRM/+LuuP2fL33sBeqajcivSQLffRCzOxurv1LDPSNc63pe/ZZWpceUVsJE30bzqStCPBja28HZ/zSFS565f4hpxcSOsOmknO+um6SfOacZ7maLQQeiM6Ad8wUn/fCVwMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693420; c=relaxed/simple;
	bh=mRiJQf8HlUUGHS/Aw8yW+dJgWms8uN86w7mo04vnImw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NEKOBHygYjY0mjZUmRfpu0j6PZVd7suMg9bl3gH7j1/w9LXLeXXQMEKUd6M9thIyHBgLuZGJUKIUfPPCCRnu3ASJfULVNK0EuSYDeCdcrDwDJMVcCFPIoUcHOMFXbkqhhZ/aS4B8SXUJzTy+LeV6Cao4NrrJUAbKE0sBqRcPeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WKW1P1dvfzQkjL;
	Thu, 11 Jul 2024 18:19:37 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 246CF1401E0;
	Thu, 11 Jul 2024 18:23:34 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 18:23:33 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <haitao.huang@linux.intel.com>, <rdunlap@infradead.org>,
	<kamalesh.babulal@oracle.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/misc: Introduce misc.events.local
Date: Thu, 11 Jul 2024 10:14:57 +0000
Message-ID: <20240711101457.2963104-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Currently the event counting provided by misc.events is hierarchical,
it's not practical if user is only concerned with events of a
specified cgroup. Therefore, introduce misc.events.local collect events
specific to the given cgroup.

This is analogous to memory.events.local and pids.events.local.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  5 ++++
 include/linux/misc_cgroup.h             |  3 ++
 kernel/cgroup/misc.c                    | 39 +++++++++++++++++++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index adf77ed92687..6c6075ed4aa5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2692,6 +2692,11 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
 		The number of times the cgroup's resource usage was
 		about to go over the max boundary.
 
+  misc.events.local
+        Similar to misc.events but the fields in the file are local to the
+        cgroup i.e. not hierarchical. The file modified event generated on
+        this file reflects only the local events.
+
 Migration and Ownership
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 618392d41975..49eef10c8e59 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -40,6 +40,7 @@ struct misc_res {
 	atomic64_t watermark;
 	atomic64_t usage;
 	atomic64_t events;
+	atomic64_t events_local;
 };
 
 /**
@@ -53,6 +54,8 @@ struct misc_cg {
 
 	/* misc.events */
 	struct cgroup_file events_file;
+	/* misc.events.local */
+	struct cgroup_file events_local_file;
 
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index b92daf5d234d..0e26068995a6 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -134,6 +134,17 @@ static void misc_cg_update_watermark(struct misc_res *res, u64 new_usage)
 	}
 }
 
+static void misc_cg_event(enum misc_res_type type, struct misc_cg *cg)
+{
+	atomic64_inc(&cg->res[type].events_local);
+	cgroup_file_notify(&cg->events_local_file);
+
+	for (; parent_misc(cg); cg = parent_misc(cg)) {
+		atomic64_inc(&cg->res[type].events);
+		cgroup_file_notify(&cg->events_file);
+	}
+}
+
 /**
  * misc_cg_try_charge() - Try charging the misc cgroup.
  * @type: Misc res type to charge.
@@ -177,10 +188,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 	return 0;
 
 err_charge:
-	for (j = i; j; j = parent_misc(j)) {
-		atomic64_inc(&j->res[type].events);
-		cgroup_file_notify(&j->events_file);
-	}
+	misc_cg_event(type, i);
 
 	for (j = cg; j != i; j = parent_misc(j))
 		misc_cg_cancel_charge(type, j, amount);
@@ -368,20 +376,33 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static int misc_events_show(struct seq_file *sf, void *v)
+static int __misc_events_show(struct seq_file *sf, bool local)
 {
 	struct misc_cg *cg = css_misc(seq_css(sf));
 	u64 events;
 	int i;
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
-		events = atomic64_read(&cg->res[i].events);
+		if (local)
+			events = atomic64_read(&cg->res[i].events_local);
+		else
+			events = atomic64_read(&cg->res[i].events);
 		if (READ_ONCE(misc_res_capacity[i]) || events)
 			seq_printf(sf, "%s.max %llu\n", misc_res_name[i], events);
 	}
 	return 0;
 }
 
+static int misc_events_show(struct seq_file *sf, void *v)
+{
+	return __misc_events_show(sf, false);
+}
+
+static int misc_events_local_show(struct seq_file *sf, void *v)
+{
+	return __misc_events_show(sf, true);
+}
+
 /* Misc cgroup interface files */
 static struct cftype misc_cg_files[] = {
 	{
@@ -409,6 +430,12 @@ static struct cftype misc_cg_files[] = {
 		.file_offset = offsetof(struct misc_cg, events_file),
 		.seq_show = misc_events_show,
 	},
+	{
+		.name = "events.local",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct misc_cg, events_local_file),
+		.seq_show = misc_events_local_show,
+	},
 	{}
 };
 
-- 
2.34.1


