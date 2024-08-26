Return-Path: <cgroups+bounces-4451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D695F301
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563BA28107A
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FB18858B;
	Mon, 26 Aug 2024 13:34:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E44187842;
	Mon, 26 Aug 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679295; cv=none; b=C+fJyTxgTTdI6my3u71sBge1cP1TBJLkvK7DDpx3RcgznDXvp92oAYxsRavgPQf0GZY+b1V0BWF032vB+Amd2TWTcgQMPG60tSrvWEJZtl3yycRfPSWAeaRuUuvHNTBfocPo4almLkNFNhdFDLmbK4svuV3TAy4+bnTZi7KeAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679295; c=relaxed/simple;
	bh=D2e17mZGQD1eLohDsr2MFIqtBVFf2bvz+SaiNDTP/fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izZpx938YP88pDKcVvfZJDG99iO1C5R/TeivYgSLssHjUWTaUCSwJVNE9CHL2xW4LtTzctS7gYChjWTFKnPN5EWfv5HP8BKJDe3wfBBz3tGmImWn9knt0PZUCzfqQbJ6pwgSOogL5yocYGKsSkMljx+VRycgTezYsEO0ylKkpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wss5c4p0nz1HHRB;
	Mon, 26 Aug 2024 21:31:32 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 546FA140120;
	Mon, 26 Aug 2024 21:34:50 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 21:34:49 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v2 -next 01/11] cgroup/cpuset: introduce cpuset-v1.c
Date: Mon, 26 Aug 2024 13:26:53 +0000
Message-ID: <20240826132703.558956-2-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826132703.558956-1-chenridong@huawei.com>
References: <20240826132703.558956-1-chenridong@huawei.com>
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
 kernel/cgroup/cpuset-internal.h | 7 +++++++
 kernel/cgroup/cpuset-v1.c       | 4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)
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
index 000000000000..6605be417e32
--- /dev/null
+++ b/kernel/cgroup/cpuset-internal.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __CPUSET_INTERNAL_H
+#define __CPUSET_INTERNAL_H
+
+#endif /* __CPUSET_INTERNAL_H */
+
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
new file mode 100644
index 000000000000..ae166eb4f75d
--- /dev/null
+++ b/kernel/cgroup/cpuset-v1.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "cpuset-internal.h"
+
-- 
2.34.1


