Return-Path: <cgroups+bounces-3496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9A923E64
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4CD1C21D66
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99401891DB;
	Tue,  2 Jul 2024 13:05:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C579470;
	Tue,  2 Jul 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925556; cv=none; b=bEj79amGgIeDn7KQ/VUjWrrkcmplkMI3KWO2NonbKEsYcniDkuor9DNuqtE4mwyLMYY1lI2yrhQtgELqHNPpqlbFcYby2v6R5nJGVypsnYEjzEul/mnwOoPYYVPpzSkk2p7nW7fiu9dVacZk3Xt2JgOtvosMaQbtCmQlL6db4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925556; c=relaxed/simple;
	bh=P6WvHNwJFtOe2fivIfPHj5BHweMvmgj1DWklaEwm+Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D70Rm4flXq24j1EkHRwx61CtODgzsR174HEAH4tTi4ntBSUzHwwZU0oOP5XSDVIJXlki+c2Q0DFzwFwig6LqSGjEihYbmC5NkO16fwoaobaUtJD7G+2/F8wHltiJfdNuEl1zWUnCkv4ul4tXIm5zhKl5lUJiZojK7+/Neqyjk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WD3245mcJzZh3K;
	Tue,  2 Jul 2024 21:01:16 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 2449E18007E;
	Tue,  2 Jul 2024 21:05:49 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 21:05:48 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak to v2
Date: Tue, 2 Jul 2024 12:57:28 +0000
Message-ID: <20240702125728.2743143-1-xiujianfeng@huawei.com>
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

Introduce peak and rsvd.peak to v2 to show the historical maximum
usage of resources, as in some scenarios it is necessary to configure
the value of max/rsvd.max based on the peak usage of resources.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++++++++
 mm/hugetlb_cgroup.c                     | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ae0fdb6fc618..97d19968230a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2607,6 +2607,14 @@ HugeTLB Interface Files
         hugetlb pages of <hugepagesize> in this cgroup.  Only active in
         use hugetlb pages are included.  The per-node values are in bytes.
 
+  hugetlb.<hugepagesize>.peak
+	Show historical maximum usage for "hugepagesize" hugetlb.  It exists
+        for all the cgroup except root.
+
+  hugetlb.<hugepagesize>.rsvd.peak
+	Show historical maximum usage for "hugepagesize" hugetlb reservations.
+        It exists for all the cgroup except root.
+
 Misc
 ----
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 4ff238ba1250..f443a56409a9 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -583,6 +583,13 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 		else
 			seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
+	case RES_RSVD_MAX_USAGE:
+		counter = &h_cg->rsvd_hugepage[idx];
+		fallthrough;
+	case RES_MAX_USAGE:
+		val = (u64)counter->watermark;
+		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
+		break;
 	default:
 		BUG();
 	}
@@ -739,6 +746,18 @@ static struct cftype hugetlb_dfl_tmpl[] = {
 		.seq_show = hugetlb_cgroup_read_u64_max,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "peak",
+		.private = RES_MAX_USAGE,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "rsvd.peak",
+		.private = RES_RSVD_MAX_USAGE,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "events",
 		.seq_show = hugetlb_events_show,
-- 
2.34.1


