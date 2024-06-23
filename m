Return-Path: <cgroups+bounces-3294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBCC913E2E
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9547F281253
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E8185084;
	Sun, 23 Jun 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeoLPD6B"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39592AD22
	for <cgroups@vger.kernel.org>; Sun, 23 Jun 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719175560; cv=none; b=VMux6ftO07NkyKDyGHxlI3510froNAlkNNLacZaS8nZvLHeGLYLaHUp66lK6asZuIIgwIhJXKcZJpZP7uQj0ux+1UfYaGpzbaZ7ARvBQNGnNvdPc71VnxBfu+G+rCIHqOxoYM0OX62nkOkQT+DZ1zfVT0L+JLiJohp0VsxiZHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719175560; c=relaxed/simple;
	bh=DPvRmvVmh2WgSV6K/Scm1uUzCJnRcqLxH5aT6E+qO74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvXfY4gRolGocv5Tr/UyEbyn6qFuUqtwWzx26x7wVUuxSpn9EfMBLNcfvDLzL4wL+D+NJGE58MgyYbzr4s4FjlKUP63RUB3QssWVKFs/BYAle+NTJ9WSNtjUzfQLoVuH1dFDjWPGY12K2z4bBZTV9ZlDqF/DR2M2ZGwKBzBMX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeoLPD6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719175557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AmwdkZVL5pji4wXYmdoU+z7q/J2B7KB9OGbcUZv8AJU=;
	b=TeoLPD6BPSnwyUJuHnodfjFEV2kXOUIcpFOMeeG2l7Pyfp/OUtT4QsOrdXFirVXcOqXfmP
	PrHw1Fvd7JUDTdr0PgOxGSxJVCjPkcni/9BQ75yRRAMy54XIPgi8yUwBo56vEYz9UgkBTn
	tmvl5z2d2cmG0HwJpEvtZKgQyRbRjbc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-wl9rvSoCNPCrgih4Gu1Jrg-1; Sun,
 23 Jun 2024 16:45:52 -0400
X-MC-Unique: wl9rvSoCNPCrgih4Gu1Jrg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26E48195608B;
	Sun, 23 Jun 2024 20:45:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AACD619560AE;
	Sun, 23 Jun 2024 20:45:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@kvack.org,
	Alex Kalenyuk <akalenyu@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] memcg: Add a new sysctl parameter for automatically setting memory.high
Date: Sun, 23 Jun 2024 16:45:14 -0400
Message-Id: <20240623204514.1032662-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

With memory cgroup v1, there is only a single "memory.limit_in_bytes"
to be set to specify the maximum amount of memory that is allowed to
be used. So a lot of memory cgroup using tools and applications allow
users to specify a single memory limit. When they migrate to cgroup
v2, they use the given memory limit to set memory.max and disregard
memory.high for the time being.

Without properly setting memory.high, these user space applications
cannot make use of the memory cgroup v2 ability to further reduce the
chance of OOM kills by throttling and early memory reclaim.

This patch adds a new sysctl parameter "vm/memory_high_autoset_ratio"
to enable setting "memory.high" automatically whenever "memory.max" is
set as long as "memory.high" hasn't been explicitly set before. This
will allow a system administrator or a middleware layer to greatly
reduce the chance of memory cgroup OOM kills without worrying about
how to properly set memory.high.

The new sysctl parameter will allow a range of 0-100. The default value
of 0 will disable memory.high auto setting. For any non-zero value "n",
the actual ratio used will be "n/(n+1)". A user cannot set a fraction
less than 1/2.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 10 ++++++
 include/linux/memcontrol.h              |  3 ++
 mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e86c968a7a0e..250ec39dd5af 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -46,6 +46,7 @@ Currently, these files are in /proc/sys/vm:
 - mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
 - memory_failure_early_kill
 - memory_failure_recovery
+- memory_high_autoset_ratio
 - min_free_kbytes
 - min_slab_ratio
 - min_unmapped_ratio
@@ -479,6 +480,15 @@ Enable memory failure recovery (when supported by the platform)
 0: Always panic on a memory failure.
 
 
+memory_high_autoset_ratio
+=========================
+
+Specify a ratio by which memory.high should be set as a fraction of
+memory.max if it hasn't been explicitly set before.  It allows a range
+of 0-100.  The default value of 0 means auto setting will be disabled.
+For any non-zero value "n", the actual ratio used will be "n/(n+1)".
+
+
 min_free_kbytes
 ===============
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..6be161a6b922 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -221,6 +221,9 @@ struct mem_cgroup {
 	 */
 	bool oom_group;
 
+	/* %true if memory.high has been explicitly set */
+	bool memory_high_set;
+
 	/* protected by memcg_oom_lock */
 	bool		oom_lock;
 	int		under_oom;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..2cfb000bf543 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -48,6 +48,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/spinlock.h>
+#include <linux/sysctl.h>
 #include <linux/eventfd.h>
 #include <linux/poll.h>
 #include <linux/sort.h>
@@ -6889,6 +6890,35 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
 }
 #endif
 
+/*
+ * The memory.high autoset ratio specifies a ratio by which memory.high
+ * should be set as a fraction of memory.max if it hasn't been explicitly
+ * set before. The default value of 0 means auto setting will be disabled.
+ * For any non-zero value "n", the actual ratio is "n/(n+1)".
+ */
+static int sysctl_memory_high_autoset_ratio;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table memcg_table[] = {
+	{
+		.procname	= "memory_high_autoset_ratio",
+		.data		= &sysctl_memory_high_autoset_ratio,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+};
+
+static inline void memcg_sysctl_init(void)
+{
+	register_sysctl_init("vm", memcg_table);
+}
+#else
+static void memcg_sysctl_init(void)	{ }
+#endif /* CONFIG_SYSCTL */
+
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
 {
 	if (value == PAGE_COUNTER_MAX)
@@ -6982,6 +7012,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		return err;
 
 	page_counter_set_high(&memcg->memory, high);
+	memcg->memory_high_set = true;
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
@@ -7023,6 +7054,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long max;
+	unsigned int high_ratio = sysctl_memory_high_autoset_ratio;
 	int err;
 
 	buf = strstrip(buf);
@@ -7032,6 +7064,13 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 	xchg(&memcg->memory.max, max);
 
+	if (high_ratio && !memcg->memory_high_set) {
+		/* Set memory.high as a fraction of memory.max */
+		unsigned long high = max * high_ratio / (high_ratio + 1);
+
+		page_counter_set_high(&memcg->memory, high);
+	}
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 
@@ -7977,6 +8016,8 @@ static int __init mem_cgroup_init(void)
 		soft_limit_tree.rb_tree_per_node[node] = rtpn;
 	}
 
+	memcg_sysctl_init();
+
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
-- 
2.39.3


