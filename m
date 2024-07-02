Return-Path: <cgroups+bounces-3478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DC291EBEA
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 02:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AFF283124
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3D6FCB;
	Tue,  2 Jul 2024 00:49:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F094393;
	Tue,  2 Jul 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881369; cv=none; b=aJwOqjw3fVxosJlOT0ZwUBj74Eu1ry88mH5DWCii8E/00lpk5HVQtB5SjuqgjK6nsKP3XVG/7bMfqfirINxC1OUcDlJv7/2IuzWoAMHeyH0ibv2OaRu+wVLApTYVzoZU1ywJj2fdHGkIFhJVrkUIqkAWls+VRQLRJO++D55b8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881369; c=relaxed/simple;
	bh=AhrsQKLzA5bGsmrWY1TVtCfHRlOKgyECq1XmRebGFd8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdRYbH1Sm7GLxEJ1ZKgHrAmopX2aB5gipELevQlftIAn7BGBrS2EvtFjIuWexivJE0lXfxqEVKgZCC7nEV6tmf+BiVZz0VC96hcWyZeJ/WE42fIyQg+zMxx+YGDZaX/7wj3TA6zw+vUAGcSn1eIv06rMBA1qtPZekV8OacrcOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCklk0m1yzdftM;
	Tue,  2 Jul 2024 08:47:46 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 9796F18006C;
	Tue,  2 Jul 2024 08:49:22 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 08:49:22 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <kamalesh.babulal@oracle.com>,
	<haitao.huang@linux.intel.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] cgroup/misc: Introduce misc.peak
Date: Tue, 2 Jul 2024 00:41:08 +0000
Message-ID: <20240702004108.2645587-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Introduce misc.peak to record the historical maximum usage of the
resource, as in some scenarios the value of misc.max could be
adjusted based on the peak usage of the resource.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

---
v2: use cmpxchg to update the watermark
---
 Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
 include/linux/misc_cgroup.h             |  2 ++
 kernel/cgroup/misc.c                    | 39 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ae0fdb6fc618..468a95379009 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2646,6 +2646,15 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
 	  res_a 3
 	  res_b 0
 
+  misc.peak
+        A read-only flat-keyed file shown in all cgroups.  It shows the
+        historical maximum usage of the resources in the cgroup and its
+        children.::
+
+	  $ cat misc.peak
+	  res_a 10
+	  res_b 8
+
   misc.max
         A read-write flat-keyed file shown in the non root cgroups. Allowed
         maximum usage of the resources in the cgroup and its children.::
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e799b1f8d05b..faf72a537596 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -30,11 +30,13 @@ struct misc_cg;
 /**
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
+ * @watermark: Historical maximum usage of the resource.
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
index 79a3717a5803..42642a96f4dc 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -121,6 +121,17 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
 		  misc_res_name[type]);
 }
 
+static void misc_cg_update_watermark(struct misc_res *res, u64 new_usage)
+{
+	u64 old;
+
+	do {
+		old = READ_ONCE(res->watermark);
+		if (cmpxchg(&res->watermark, old, new_usage) == old)
+			break;
+	} while (0);
+}
+
 /**
  * misc_cg_try_charge() - Try charging the misc cgroup.
  * @type: Misc res type to charge.
@@ -159,6 +170,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
 			ret = -EBUSY;
 			goto err_charge;
 		}
+		misc_cg_update_watermark(res, new_usage);
 	}
 	return 0;
 
@@ -307,6 +319,29 @@ static int misc_cg_current_show(struct seq_file *sf, void *v)
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
@@ -357,6 +392,10 @@ static struct cftype misc_cg_files[] = {
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


