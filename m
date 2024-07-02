Return-Path: <cgroups+bounces-3493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C6923BDD
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E1728406E
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F071591EA;
	Tue,  2 Jul 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ul7GhrBV"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527D158DBF;
	Tue,  2 Jul 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917576; cv=none; b=NYgVU7pNx/59NswQpEr0Vw4s58CIOqJ2I+MBZawLsFX1SAbTFofaWzIJZDAp2Cx5gpNDli4tCkjrSifMJuStCEAbhObwLPfDP9EM5AmE/ccCsTm6Gfsqg2w/E/zQLBjuL4hOiPtkmLfKCOHnYlMwYBXlMQjbxw5tzsJgjToLuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917576; c=relaxed/simple;
	bh=MoEX03KwmShQECxbeLs4XKAd8xwjUgZ6KfkZ5EQ2PrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q782CB8fAlEpWwLYdsl/gdJoEu74+lma5Cvg5a1fNdb182cmkcGxmrbpOhlEBuor6oThzrDTebqcVANnZUp0ZL26tMIpL3l1DGoFkumK00u2+RalSXNALAlXEiVLADd/GgbzB6UuRyhrggLLZz1ko+dLpMZWglnXfhLPmAWeFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ul7GhrBV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=UeMLAVMzNHh/J/hWvGkOS57wxbangZTyphfqEF4tTho=;
	b=Ul7GhrBVfUQaH+QXc+M9xdPKtZo+9YlcGABUEgGWmlpqBq+dtDapfAeXWabrl9
	7FKKlVMtixYsApSjL0BbMYn6OXnSTXB+Q1HV5nE5uN4mEcD6PbiPk4llqAvzzraU
	mOPDcfvYUq+EfQzJ5TgLf9M4175O16HOZswHDchr/wvJ8=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wCXl8lk24NmRfcQAQ--.48696S2;
	Tue, 02 Jul 2024 18:50:12 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org
Cc: longman@redhat.com,
	mkoutny@suse.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v9 1/2] Union-Find: add a new module in kernel library
Date: Tue,  2 Jul 2024 18:50:09 +0800
Message-Id: <20240702105010.253933-2-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702105010.253933-1-xavier_qy@163.com>
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
 <20240702105010.253933-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXl8lk24NmRfcQAQ--.48696S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw48ury7GF4kKryrWr4UJwb_yoWkuF1xpF
	ZxK34fAw4DJ34UC340krW5Aw4SvayrGrWUJa1xGa10ywsayr10qF4jyw1rtr95GryIyFy8
	XF4aqw1rZw1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ur5rsUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZQQQEGXAmxhMRgABsM

This patch implements a union-find data structure in the kernel library,
which includes operations for allocating nodes, freeing nodes,
finding the root of a node, and merging two nodes.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 Documentation/core-api/union_find.rst         | 102 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  87 +++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  41 +++++++
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  48 +++++++++
 6 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

diff --git a/Documentation/core-api/union_find.rst b/Documentation/core-api/union_find.rst
new file mode 100644
index 0000000000..be9f68fd6d
--- /dev/null
+++ b/Documentation/core-api/union_find.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Union-Find in Linux
+====================
+
+
+:Date: June 21, 2024
+:Author: Xavier <xavier_qy@163.com>
+
+What is Union-Find, and what is it used for?
+------------------------------------------------
+
+Union-Find is a data structure used to handle the merging and querying
+of disjoint sets. The primary operations supported by Union-Find are:
+
+	Initialization: Resetting each element as an individual set, with
+		each set's initial parent node pointing to itself.
+	Find: Determine which set a particular element belongs to, usually by
+		returning a “representative element” of that set. This operation
+		is used to check if two elements are in the same set.
+	Union: Merge two sets into one.
+
+As a data structure used to maintain sets (groups), Union-Find is commonly
+utilized to solve problems related to offline queries, dynamic connectivity,
+and graph theory. It is also a key component in Kruskal's algorithm for
+computing the minimum spanning tree, which is crucial in scenarios like
+network routing. Consequently, Union-Find is widely referenced. Additionally,
+Union-Find has applications in symbolic computation, register allocation,
+and more.
+
+Space Complexity: O(n), where n is the number of nodes.
+
+Time Complexity: Using path compression can reduce the time complexity of
+the find operation, and using union by rank can reduce the time complexity
+of the union operation. These optimizations reduce the average time
+complexity of each find and union operation to O(α(n)), where α(n) is the
+inverse Ackermann function. This can be roughly considered a constant time
+complexity for practical purposes.
+
+This document covers use of the Linux union-find implementation.  For more
+information on the nature and implementation of Union-Find,  see:
+
+  Wikipedia entry on union-find
+    https://en.wikipedia.org/wiki/Disjoint-set_data_structure
+
+Linux implementation of union-find
+-----------------------------------
+
+Linux's union-find implementation resides in the file "lib/union_find.c".
+To use it, "#include <linux/union_find.h>".
+
+The Union-Find data structure is defined as follows::
+
+	struct uf_node {
+		struct uf_node *parent;
+		unsigned int rank;
+	};
+
+In this structure, parent points to the parent node of the current node.
+The rank field represents the height of the current tree. During a union
+operation, the tree with the smaller rank is attached under the tree with the
+larger rank to maintain balance.
+
+Initializing Union-Find
+--------------------
+
+You can complete the initialization using either static or initialization
+interface. Initialize the parent pointer to point to itself and set the rank
+to 0.
+Example::
+
+	struct uf_node my_node = UF_INIT_NODE(my_node);
+or
+	uf_node_init(&my_node);
+
+Find the Root Node of Union-Find
+--------------------------------
+
+This operation is mainly used to determine whether two nodes belong to the same
+set in the Union-Find. If they have the same root, they are in the same set.
+During the find operation, path compression is performed to improve the
+efficiency of subsequent find operations.
+Example::
+
+	int connected;
+	struct uf_node *root1 = uf_find(&node_1);
+	struct uf_node *root2 = uf_find(&node_2);
+	if (root1 == root2)
+		connected = 1;
+	else
+		connected = 0;
+
+Union Two Sets in Union-Find
+----------------------------
+
+To union two sets in the Union-Find, you first find their respective root nodes
+and then link the smaller node to the larger node based on the rank of the root
+nodes.
+Example::
+
+	uf_union(&node_1, &node_2);
diff --git a/Documentation/translations/zh_CN/core-api/union_find.rst b/Documentation/translations/zh_CN/core-api/union_find.rst
new file mode 100644
index 0000000000..a56de57147
--- /dev/null
+++ b/Documentation/translations/zh_CN/core-api/union_find.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/core-api/union_find.rst
+
+===========================
+Linux中的并查集（Union-Find）
+===========================
+
+
+:日期: 2024年6月21日
+:作者: Xavier <xavier_qy@163.com>
+
+何为并查集，它有什么用？
+---------------------
+
+并查集是一种数据结构，用于处理一些不交集的合并及查询问题。并查集支持的主要操作：
+	初始化：将每个元素初始化为单独的集合，每个集合的初始父节点指向自身
+	查询：查询某个元素属于哪个集合，通常是返回集合中的一个“代表元素”。这个操作是为
+		了判断两个元素是否在同一个集合之中。
+	合并：将两个集合合并为一个。
+
+并查集作为一种用于维护集合（组）的数据结构，它通常用于解决一些离线查询、动态连通性和
+图论等相关问题，同时也是用于计算最小生成树的克鲁斯克尔算法中的关键，由于最小生成树在
+网络路由等场景下十分重要，并查集也得到了广泛的引用。此外，并查集在符号计算，寄存器分
+配等方面也有应用。
+
+空间复杂度: O(n)，n为节点数。
+
+时间复杂度：使用路径压缩可以减少查找操作的时间复杂度，使用按秩合并可以减少合并操作的
+时间复杂度，使得并查集每个查询和合并操作的平均时间复杂度仅为O(α(n))，其中α(n)是反阿
+克曼函数，可以粗略地认为并查集的操作有常数的时间复杂度。
+
+本文档涵盖了对Linux并查集实现的使用方法。更多关于并查集的性质和实现的信息，参见：
+
+  维基百科并查集词条
+    https://en.wikipedia.org/wiki/Disjoint-set_data_structure
+
+并查集的Linux实现
+----------------
+
+Linux的并查集实现在文件“lib/union_find.c”中。要使用它，需要
+“#include <linux/union_find.h>”。
+
+并查集的数据结构定义如下::
+
+	struct uf_node {
+		struct uf_node *parent;
+		unsigned int rank;
+	};
+其中parent为当前节点的父节点，rank为当前树的高度，在合并时将rank小的节点接到rank大
+的节点下面以增加平衡性。
+
+初始化并查集
+---------
+
+可以采用静态或初始化接口完成初始化操作。初始化时，parent 指针指向自身，rank 设置
+为 0。
+示例::
+
+	struct uf_node my_node = UF_INIT_NODE(my_node);
+或
+	uf_node_init(&my_node);
+
+查找并查集的根节点
+----------------
+
+主要用于判断两个并查集是否属于一个集合，如果根相同，那么他们就是一个集合。在查找过程中
+会对路径进行压缩，提高后续查找效率。
+示例::
+
+	int connected;
+	struct uf_node *root1 = uf_find(&node_1);
+	struct uf_node *root2 = uf_find(&node_2);
+	if (root1 == root2)
+		connected = 1;
+	else
+		connected = 0;
+
+合并两个并查集
+-------------
+
+对于两个相交的并查集进行合并，会首先查找它们各自的根节点，然后根据根节点秩大小，将小的
+节点连接到大的节点下面。
+示例::
+
+	uf_union(&node_1, &node_2);
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe..16171dbca3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23051,6 +23051,15 @@ F:	drivers/cdrom/cdrom.c
 F:	include/linux/cdrom.h
 F:	include/uapi/linux/cdrom.h
 
+UNION-FIND
+M:	Xavier <xavier_qy@163.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/union_find.rst
+F:	Documentation/translations/zh_CN/core-api/union_find.rst
+F:	include/linux/union_find.h
+F:	lib/union_find.c
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 R:	Avri Altman <avri.altman@wdc.com>
diff --git a/include/linux/union_find.h b/include/linux/union_find.h
new file mode 100644
index 0000000000..45b7aa66a6
--- /dev/null
+++ b/include/linux/union_find.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_UNION_FIND_H
+#define __LINUX_UNION_FIND_H
+/**
+ * union_find.h - Union-Find data structure implementation
+ *
+ * This header provides functions and structures to implement the Union-Find
+ * data structure. The Union-Find data structure is used to manage disjoint
+ * sets and supports efficient union and find operations.
+ *
+ * See Documentation/core-api/union_find.rst for documentation and samples.
+ */
+
+struct uf_node {
+	struct uf_node *parent;
+	unsigned int rank;
+};
+
+/* This macro is used for static initialization of a union-find node. */
+#define UF_INIT_NODE(node)	{.parent = &node, .rank = 0}
+
+/**
+ * uf_node_init - Initialize a union-find node
+ * @node: pointer to the union-find node to be initialized
+ *
+ * This function sets the parent of the node to itself and
+ * initializes its rank to 0.
+ */
+static inline void uf_node_init(struct uf_node *node)
+{
+	node->parent = node;
+	node->rank = 0;
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
index 0000000000..bec574ad24
--- /dev/null
+++ b/lib/union_find.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/union_find.h>
+
+/**
+ * uf_find - Find the root of a node and perform path compression
+ * @node: the node to find the root of
+ *
+ * This function returns the root of the node by following the parent
+ * pointers. It also performs path compression, making the tree shallower.
+ *
+ * Returns the root node of the set containing node.
+ */
+struct uf_node *uf_find(struct uf_node *node)
+{
+	struct uf_node *parent;
+
+	while (node->parent != node) {
+		parent = node->parent;
+		node->parent = parent->parent;
+		node = parent;
+	}
+	return node;
+}
+
+/**
+ * uf_union - Merge two sets, using union by rank
+ * @node1: the first node
+ * @node2: the second node
+ *
+ * This function merges the sets containing node1 and node2, by comparing
+ * the ranks to keep the tree balanced.
+ */
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
2.45.0


