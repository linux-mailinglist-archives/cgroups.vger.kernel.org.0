Return-Path: <cgroups+bounces-3465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A2991E018
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24EF1F23729
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AFE158D8F;
	Mon,  1 Jul 2024 13:01:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E68146017;
	Mon,  1 Jul 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838881; cv=none; b=WN2RYZ0MW1CqSmlHVxT4lF2gnQhJqtgrMN5+k2MkOe+dH9GLZRcEMfO9eJpl381RDN4kN1vm/TNgecaJcw5TnU94VVbnQVB3m/QKcQN6ywO3lOQUsH2mGDr5dzh8o0o/RfvRjwGu9t4IPDZxi6byrB8BFWndBmirpzT2m4leFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838881; c=relaxed/simple;
	bh=mSSBgX5YD/tN1nW23Z9JSj0R5Z2gP3h1AymETTt512Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwUoTPK0bDk8V6f5R8CP8gEb+zVGhAtw0H6n1cIzqV0cXK3FOw8Fw9jqSK3GQcwgh1E3917157zSmbBiap9WJRF9MzNFbImkdWohnyEWP/eDqizVa5k2IV9IO44UWzl9MC42LpdTeRghr3oqD1ZRiYX6aDVBEi6osIrmsr7mmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WCQzG1x4hzZh4c;
	Mon,  1 Jul 2024 20:56:42 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 413AB1403D4;
	Mon,  1 Jul 2024 21:01:13 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 21:01:13 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <kamalesh.babulal@oracle.com>,
	<haitao.huang@linux.intel.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/misc: Introduce misc.peak
Date: Mon, 1 Jul 2024 12:52:59 +0000
Message-ID: <20240701125259.2611466-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Introduce misc.peak to record the historical maximum usage of the
resource, as in some scenarios the value of misc.max could be
adjusted based on the peak usage of the resource.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 ++++++++
 include/linux/misc_cgroup.h             |  2 ++
 kernel/cgroup/misc.c                    | 29 +++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ae0fdb6fc618..48ae30f2d9ab 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2646,6 +2646,15 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
 	  res_a 3
 	  res_b 0
 
+  misc.peak
+        A read-only flat-keyed file shown in the all cgroups.  It shows
+        the historical maximum usage of the resources in the cgroup and
+        its children.::
+
+	  $ cat misc.peak
+	  res_a 10
+	  res_b 8
+
   misc.max
         A read-write flat-keyed file shown in the non root cgroups. Allowed
         maximum usage of the resources in the cgroup and its children.::
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e799b1f8d05b..8aa69818291e 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -30,11 +30,13 @@ struct misc_cg;
 /**
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
+ * $watermark: Historical maximum usage of the resource.
  * @usage: Current usage of the resource.
  * @events: Number of times, the resource limit exceeded.
  */
 struct misc_res {
 	u64 max;
+	u64 watermark;
 	atomic64_t usage;
 	atomic64_t events;
 };
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 79a3717a5803..a1b6ed76e00b 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -159,6 +159,8 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 			ret = -EBUSY;
 			goto err_charge;
 		}
+		if (new_usage > READ_ONCE(res->watermark))
+			WRITE_ONCE(res->watermark, new_usage);
 	}
 	return 0;
 
@@ -307,6 +309,29 @@ static int misc_cg_current_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+/**
+ * misc_cg_peak_show() - Show the peak usage of the misc cgroup.
+ * @sf: Interface file
+ * @v: Arguments passed
+ *
+ * Context: Any context.
+ * Return: 0 to denote successful print.
+ */
+static int misc_cg_peak_show(struct seq_file *sf, void *v)
+{
+	int i;
+	u64 watermark;
+	struct misc_cg *cg = css_misc(seq_css(sf));
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		watermark = READ_ONCE(cg->res[i].watermark);
+		if (READ_ONCE(misc_res_capacity[i]) || watermark)
+			seq_printf(sf, "%s %llu\n", misc_res_name[i], watermark);
+	}
+
+	return 0;
+}
+
 /**
  * misc_cg_capacity_show() - Show the total capacity of misc res on the host.
  * @sf: Interface file
@@ -357,6 +382,10 @@ static struct cftype misc_cg_files[] = {
 		.name = "current",
 		.seq_show = misc_cg_current_show,
 	},
+	{
+		.name = "peak",
+		.seq_show = misc_cg_peak_show,
+	},
 	{
 		.name = "capacity",
 		.seq_show = misc_cg_capacity_show,
-- 
2.34.1


