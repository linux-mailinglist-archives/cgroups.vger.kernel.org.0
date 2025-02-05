Return-Path: <cgroups+bounces-6440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5960A29C83
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B052188677F
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC9A215798;
	Wed,  5 Feb 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vleraxDx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8021505E
	for <cgroups@vger.kernel.org>; Wed,  5 Feb 2025 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794064; cv=none; b=ZeiMCgHtQgzYYX/oAeRmTFDlIauNC/tgyosdzJDwHDHXvpYlhPQt4sO3S7CWpHcJposdJqkhuGp0N/zdOpz7VTYw62UC9tvrO7eKBqYz2EaTGaygKY4Hqix+XTGcjqLjOrwIDvrjtKnkPWRfyGoyVNE/BCv8w4tgpR5dO7WZmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794064; c=relaxed/simple;
	bh=ERnqvNRB++raoAQ7+GxhU9ZMKYO3osaXrKdKeiHIdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVIK4F9bqt1/re34FGIURZ5GdIHcTVx+8xlh20CASv2uHjBYfKCzlTihKiN0g/VzNH9Sfd/vDQnDNOe5Mfo9ld0BH6JE4Fcv/qTeZ2HwmiyNs8YtmGRVfXkytoX3/voRNE+3CRooujSzf1twqEKgoCBYG1tElxg1wMustQ97il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vleraxDx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738794054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ai8Aqn7IROgaUIrbgq4/1Y3axK6h87UJk8fdhUbeihE=;
	b=vleraxDxa0qndMUXWy5/CS2ks4Nh3RbFMaEL7zydSp8ZhpUvQtqchUkIhxAWpJnXrdGcPL
	04E8kICgzTZrfSaxZhZfw3Gxy7mzCgi+GNlyxuiGANaArl4eqswh08g9Wz9cY/+UWf4fyF
	uvNm2o798gv06IfZ1pOS/KYBNJ4DCTs=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: add hierarchical effective limits for v2
Date: Wed,  5 Feb 2025 14:20:29 -0800
Message-ID: <20250205222029.2979048-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memcg-v1 exposes hierarchical_[memory|memsw]_limit counters in its
memory.stat file which applications can use to get their effective limit
which is the minimum of limits of itself and all of its ancestors. This
is pretty useful in environments where cgroup namespace is used and the
application does not have access to the full view of the cgroup
hierarchy. Let's expose effective limits for memcg v2 as well.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 +++++++++++++
 mm/memcontrol.c                         | 48 +++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e..175e9435ad5c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1311,6 +1311,14 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
+  memory.max.effective
+	A read-only single value file which exists on non-root cgroups.
+
+        The effective limit of the cgroup i.e. the minimum memory.max
+        of all ancestors including itself. This is useful for environments
+        where cgroup namespace is being used and the application does not
+        have full view of the hierarchy.
+
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
@@ -1726,6 +1734,14 @@ The following nested keys are defined.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.max.effective
+	A read-only single value file which exists on non-root cgroups.
+
+        The effective limit of the cgroup i.e. the minimum memory.swap.max
+        of all ancestors including itself. This is useful for environments
+        where cgroup namespace is being used and the application does not
+        have full view of the hierarchy.
+
   memory.swap.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
@@ -1766,6 +1782,14 @@ The following nested keys are defined.
 	limit, it will refuse to take any more stores before existing
 	entries fault back in or are written out to disk.
 
+  memory.zswap.max.effective
+	A read-only single value file which exists on non-root cgroups.
+
+        The effective limit of the cgroup i.e. the minimum memory.zswap.max
+        of all ancestors including itself. This is useful for environments
+        where cgroup namespace is being used and the application does not
+        have full view of the hierarchy.
+
   memory.zswap.writeback
 	A read-write single value file. The default value is "1".
 	Note that this setting is hierarchical, i.e. the writeback would be
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cae1c2e0cc71..8d21c1a44220 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4161,6 +4161,17 @@ static int memory_max_show(struct seq_file *m, void *v)
 		READ_ONCE(mem_cgroup_from_seq(m)->memory.max));
 }
 
+static int memory_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long max = PAGE_COUNTER_MAX;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg))
+		max = min(max, READ_ONCE(memcg->memory.max));
+
+	return seq_puts_memcg_tunable(m, max);
+}
+
 static ssize_t memory_max_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
@@ -4438,6 +4449,11 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_max_show,
 		.write = memory_max_write,
 	},
+	{
+		.name = "max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_max_effective_show,
+	},
 	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -5117,6 +5133,17 @@ static int swap_max_show(struct seq_file *m, void *v)
 		READ_ONCE(mem_cgroup_from_seq(m)->swap.max));
 }
 
+static int swap_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long max = PAGE_COUNTER_MAX;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg))
+		max = min(max, READ_ONCE(memcg->swap.max));
+
+	return seq_puts_memcg_tunable(m, max);
+}
+
 static ssize_t swap_max_write(struct kernfs_open_file *of,
 			      char *buf, size_t nbytes, loff_t off)
 {
@@ -5166,6 +5193,11 @@ static struct cftype swap_files[] = {
 		.seq_show = swap_max_show,
 		.write = swap_max_write,
 	},
+	{
+		.name = "swap.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_max_effective_show,
+	},
 	{
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -5308,6 +5340,17 @@ static int zswap_max_show(struct seq_file *m, void *v)
 		READ_ONCE(mem_cgroup_from_seq(m)->zswap_max));
 }
 
+static int zswap_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long max = PAGE_COUNTER_MAX;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg))
+		max = min(max, READ_ONCE(memcg->zswap_max));
+
+	return seq_puts_memcg_tunable(m, max);
+}
+
 static ssize_t zswap_max_write(struct kernfs_open_file *of,
 			       char *buf, size_t nbytes, loff_t off)
 {
@@ -5362,6 +5405,11 @@ static struct cftype zswap_files[] = {
 		.seq_show = zswap_max_show,
 		.write = zswap_max_write,
 	},
+	{
+		.name = "zswap.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = zswap_max_effective_show,
+	},
 	{
 		.name = "zswap.writeback",
 		.seq_show = zswap_writeback_show,
-- 
2.43.5


