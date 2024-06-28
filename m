Return-Path: <cgroups+bounces-3452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57191C396
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037482848B8
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF81C9EDA;
	Fri, 28 Jun 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WdY0Ck48"
X-Original-To: cgroups@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909D1C9ED5;
	Fri, 28 Jun 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591322; cv=none; b=rlYBAx9PRLNBJdB84io7hER8Ziymkl4whlBZ1va+AavgUeWisVsDSZdy7IUxqGM1R3/7PMGuBBrZQZ4FDsGKNybOImUmC2gtETh5t4fDyBzAukEOloQHn3e89+1j7LjBrZ2E7Lsi/x5hCx0W2uUbeBVZQl5HbpRQzowQVMvjIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591322; c=relaxed/simple;
	bh=D/snAQlDcQQ9do7vedFVD99WGAZq3G7CxJRNItcEF6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPfihEloLOXoYcB/+c4djFckgfRaxzb4YxQpjVkZ3qP4Pscf/MDOoVFQamJwqRjGAJiR4fB2IZdmYA9w/95iLoIszC7Lj/NccpoKNrXWI8q8CXyC2RAsDuUZhZfjds892lmb12hkeVImoqwzrcAD1U1cps4KCD8O+Az1ozuIvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WdY0Ck48; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=eMeYN2wilMNzDh96F/mc42pvimeH08nOZXveOIA/3YE=;
	b=WdY0Ck48zety3wJt1JoC/u68kEOmbJsC0MPzvEZN06WAyVoibpSeAGI1a38UQJ
	p+lW1Ajv0ZyU3uD83ViEyNhBteNC4qgkPcXfNkVgxy6n3mlMfIQyrjwRMMhE7HMT
	K3N0QmAXt0/NdLxhmjZclKgC9c2AimW/mV37r4uaDYs2Y=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDnz0IQ4X5mFkZgAw--.61883S2;
	Sat, 29 Jun 2024 00:13:04 +0800 (CST)
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
Subject: [PATCH-cpuset v8 1/2] Union-Find: add a new module in kernel library
Date: Sat, 29 Jun 2024 00:13:01 +0800
Message-Id: <20240628161302.240043-2-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628161302.240043-1-xavier_qy@163.com>
References: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
 <20240628161302.240043-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz0IQ4X5mFkZgAw--.61883S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw48ury7GFyUCw47Ww4Durg_yoWDKF13pF
	ZxGryfAw4DJryUury0krW5Aw4Sva4rGrWUGa1xJ3W0yrnIyr10qF4jy34rtr95Gry2yFy8
	XF4agw4rZ3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UoUDXUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYxQMEGV4JBMeeQAAsm

This patch implements a union-find data structure in the kernel library,
which includes operations for allocating nodes, freeing nodes,
finding the root of a node, and merging two nodes.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 Documentation/core-api/union_find.rst         | 101 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  86 +++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  24 +++++
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  33 ++++++
 6 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

diff --git a/Documentation/core-api/union_find.rst b/Documentation/core-api/union_find.rst
new file mode 100644
index 0000000000..38d63b16e5
--- /dev/null
+++ b/Documentation/core-api/union_find.rst
@@ -0,0 +1,101 @@
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
+When initializing the Union-Find data structure, a single pointer to the
+Union-Find instance needs to be passed. Initialize the parent pointer to point
+to itself and set the rank to 0.
+Example::
+
+	struct uf_node *my_node = vzalloc(sizeof(struct uf_node));
+	uf_nodes_init(my_node);
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
+	struct uf_node *root1 = uf_find(&my_node[0]);
+	struct uf_node *root2 = uf_find(&my_node[1]);
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
+	uf_union(&my_node[0], &my_node[1]);
diff --git a/Documentation/translations/zh_CN/core-api/union_find.rst b/Documentation/translations/zh_CN/core-api/union_find.rst
new file mode 100644
index 0000000000..e1b5ae88da
--- /dev/null
+++ b/Documentation/translations/zh_CN/core-api/union_find.rst
@@ -0,0 +1,86 @@
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
+初始化并查集时需要传入并查集实例的一个指针。初始化时，parent 指针指向自身，rank 设置
+为 0。
+示例::
+
+	struct uf_node *my_node = vzalloc(sizeof(struct uf_node));
+	uf_nodes_init(my_node);
+
+查找并查集的根节点
+----------------
+
+主要用于判断两个并查集是否属于一个集合，如果根相同，那么他们就是一个集合。在查找过程中
+会对路径进行压缩，提高后续查找效率。
+示例::
+
+	int connected;
+	struct uf_node *root1 = uf_find(&my_node[0]);
+	struct uf_node *root2 = uf_find(&my_node[1]);
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
+	uf_union(&my_node[0], &my_node[1]);
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
index 0000000000..56571c93a5
--- /dev/null
+++ b/include/linux/union_find.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_UNION_FIND_H
+#define __LINUX_UNION_FIND_H
+
+/* Define a union-find node struct */
+struct uf_node {
+	struct uf_node *parent;
+	unsigned int rank;
+};
+
+/* Allocate nodes and initialize to 0 */
+static inline void uf_nodes_init(struct uf_node *node)
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
index 0000000000..bb48b4b129
--- /dev/null
+++ b/lib/union_find.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/union_find.h>
+
+struct uf_node *uf_find(struct uf_node *node)
+{
+	struct uf_node *parent;
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


