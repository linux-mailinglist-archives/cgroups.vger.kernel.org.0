Return-Path: <cgroups+bounces-3244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B260D90FFA9
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DAB251A6
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8EE22611;
	Thu, 20 Jun 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EVQqJgvM"
X-Original-To: cgroups@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC453BB50;
	Thu, 20 Jun 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873710; cv=none; b=mfXaDD3deuzvwC7SjjXiL3hO5opBd76Bpwna4H82wY5pvuFNTRPROIjuiXC9dN5HaxGy9B5iRW3gzR+e3m6Z5wkn1aNW5G/ih8207MvgaDnMuKgtIcSoH7bqhjBzE8FEtt9W1hxQ3zUSSldc77QSl996aqo5X9BeUHpWb+O2Aw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873710; c=relaxed/simple;
	bh=jHWt+oS0pQA+C3uyXiXZ+VQ20jbeR+O/U+jRyfrwnbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3zmlRAZyfxshK8ehpQFNBgPkMPjob0PSZYiwnkpbGxxHX+FG4I7GtU6ikPEUv28/MkBMJkfjAQpaEXvJx1JwK8pDgzu81nqvRUObAFCpvNfYQD8mkpF0Dltz6nUBQXxvo06TcO1TIWwk+tDH5Ba5RFCxAS4hAbZxsKjK8yBaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EVQqJgvM; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P+H56
	2k2vggjvg30NvL8+mRhFD6CP57Wnu7B+p9noDY=; b=EVQqJgvM9XACxbAJMl/nN
	Hy/AdSnGvjwIU0FL9ioSHHjT0l1CF4GJpBWGJg+nXUk74XIT2Qi42UyMCZAJDLkN
	nsQJr+hFCj7en5ac+BlfwYrgqw+8XPO33iTqVQVv9vePqx1uijrH6d6Tm72S6YQw
	Y6iGSqAXJT52SORmoZxeeU=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnLzzU7XNmxZGiDw--.17631S2;
	Thu, 20 Jun 2024 16:52:36 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: longman@redhat.com,
	mkoutny@suse.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v4 v4 1/2] Union-Find: add a new module in kernel library
Date: Thu, 20 Jun 2024 16:52:32 +0800
Message-Id: <20240620085233.205690-2-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620085233.205690-1-xavier_qy@163.com>
References: <20240603123101.590760-1-ghostxavier@sina.com>
 <20240620085233.205690-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLzzU7XNmxZGiDw--.17631S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4UZFWDtr48Gry7tr1xGrg_yoW5KF48pF
	45GryfCrs7Jry7Cr9akFWFyw4Sva1rGrWUuFWxGw4rArn5tr10qF1qvryFyrn3Jr4xCFW7
	XF4agr13CrWUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7kucUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRYEEGXAmg963AAAsx

This patch implements a union-find data structure in the kernel library,
which includes operations for allocating nodes, freeing nodes,
finding the root of a node, and merging two nodes.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 MAINTAINERS                |  7 +++++++
 include/linux/union_find.h | 30 ++++++++++++++++++++++++++++++
 lib/Makefile               |  2 +-
 lib/union_find.c           | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7..602d8c6f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23054,6 +23054,13 @@ F:	drivers/cdrom/cdrom.c
 F:	include/linux/cdrom.h
 F:	include/uapi/linux/cdrom.h
 
+UNION-FIND
+M:	Xavier <xavier_qy@163.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	include/linux/union_find.h
+F:	lib/union_find.c
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 R:	Avri Altman <avri.altman@wdc.com>
diff --git a/include/linux/union_find.h b/include/linux/union_find.h
new file mode 100644
index 0000000000..67e9f62bb3
--- /dev/null
+++ b/include/linux/union_find.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_UNION_FIND_H
+#define __LINUX_UNION_FIND_H
+#include <linux/slab.h>
+
+/* Define a union-find node struct */
+struct uf_node {
+	struct uf_node *parent;
+	unsigned int rank;
+};
+
+/* Allocate nodes and initialize to 0 */
+static inline struct uf_node *uf_nodes_alloc(unsigned int node_num)
+{
+	return kzalloc(sizeof(struct uf_node) * node_num, GFP_KERNEL);
+}
+
+/* Free nodes*/
+static inline void uf_nodes_free(struct uf_node *nodes)
+{
+	kfree(nodes);
+}
+
+/* find the root of a node*/
+struct uf_node *uf_find(struct uf_node *node);
+
+/* Merge two intersecting nodes */
+void uf_union(struct uf_node *node1, struct uf_node *node2);
+
+#endif /*__LINUX_UNION_FIND_H*/
diff --git a/lib/Makefile b/lib/Makefile
index 3b17690456..e1769e6f03 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o
+	 buildid.o objpool.o union_find.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/union_find.c b/lib/union_find.c
new file mode 100644
index 0000000000..2f77bae1ca
--- /dev/null
+++ b/lib/union_find.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/union_find.h>
+
+struct uf_node *uf_find(struct uf_node *node)
+{
+	struct uf_node *parent;
+
+	if (!node->parent) {
+		node->parent = node;
+		return node;
+	}
+
+	/*Find the root node and perform path compression at the same time*/
+	while (node->parent != node) {
+		parent = node->parent;
+		node->parent = parent->parent;
+		node = parent;
+	}
+	return node;
+}
+
+/*Function to merge two sets, using union by rank*/
+void uf_union(struct uf_node *node1, struct uf_node *node2)
+{
+	struct uf_node *root1 = uf_find(node1);
+	struct uf_node *root2 = uf_find(node2);
+
+	if (root1 != root2) {
+		if (root1->rank < root2->rank) {
+			root1->parent = root2;
+		} else if (root1->rank > root2->rank) {
+			root2->parent = root1;
+		} else {
+			root2->parent = root1;
+			root1->rank++;
+		}
+	}
+}
-- 
2.45.2


