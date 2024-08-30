Return-Path: <cgroups+bounces-4607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA638965E02
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBB51C209C6
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17017BB01;
	Fri, 30 Aug 2024 10:10:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67E16EBFC;
	Fri, 30 Aug 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012624; cv=none; b=G5QrQH8JXT5O6T9Mgz07InH06c138tG/cutPZaRd4oSpzEIr3QfyEAByi7vYdn+a/dJWCnLpB+hUV2vRr7O1iNiYgYwc4b6Ngvf2BCTKgxpkfVEtRz6Thq6fbDXF6IgvPvoZL3ofZEOyQoQTl6mWJSaCudWHTZh1ugyWQW1r08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012624; c=relaxed/simple;
	bh=/3RW9Jm8hCnuWorlqUbkb70RNWvHSm5Zd4o0IVNb+Q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4/DAFzqsKOYMITj26t1rckji22s31imYwVrtsWl4QPlP/LZigzxRc1ggORvhTHMAGaetcu6FGkeMi+oL59l3X1AgZrddAW2eBBkDsqZ9Zvc9az+VQ7K1cY1CFgK8UK8PSGIecQ14HBTzqZ/33FjsdUbN/2MVeXWuvJ1UxECqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WwDRK2Qspz1S9SN;
	Fri, 30 Aug 2024 18:10:05 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id BF3471A0188;
	Fri, 30 Aug 2024 18:10:19 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 18:10:19 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v4 -next 01/12] cgroup/cpuset: introduce cpuset-v1.c
Date: Fri, 30 Aug 2024 10:02:18 +0000
Message-ID: <20240830100229.953012-2-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
References: <20240830100229.953012-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

This patch introduces the cgroup/cpuset-v1.c source file which will be
used for all legacy (cgroup v1) cpuset cgroup code. It also introduces
cgroup/cpuset-internal.h to keep declarations shared between
cgroup/cpuset.c and cpuset/cpuset-v1.c.

As of now, let's compile it if CONFIG_CPUSET is set. Later on it can be
switched to use a separate config option, so that the legacy code won't be
compiled if not required.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 MAINTAINERS                     | 2 ++
 kernel/cgroup/Makefile          | 2 +-
 kernel/cgroup/cpuset-internal.h | 6 ++++++
 kernel/cgroup/cpuset-v1.c       | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 kernel/cgroup/cpuset-internal.h
 create mode 100644 kernel/cgroup/cpuset-v1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 82e3924816d2..3b5ec1cafd95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5698,6 +5698,8 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
 F:	include/linux/cpuset.h
+F:	kernel/cgroup/cpuset-internal.h
+F:	kernel/cgroup/cpuset-v1.c
 F:	kernel/cgroup/cpuset.c
 F:	tools/testing/selftests/cgroup/test_cpuset.c
 F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 12f8457ad1f9..005ac4c675cb 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -4,6 +4,6 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
 obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
-obj-$(CONFIG_CPUSETS) += cpuset.o
+obj-$(CONFIG_CPUSETS) += cpuset.o cpuset-v1.o
 obj-$(CONFIG_CGROUP_MISC) += misc.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
new file mode 100644
index 000000000000..034de3cbf3ad
--- /dev/null
+++ b/kernel/cgroup/cpuset-internal.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __CPUSET_INTERNAL_H
+#define __CPUSET_INTERNAL_H
+
+#endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
new file mode 100644
index 000000000000..bdec4b196986
--- /dev/null
+++ b/kernel/cgroup/cpuset-v1.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "cpuset-internal.h"
-- 
2.34.1


