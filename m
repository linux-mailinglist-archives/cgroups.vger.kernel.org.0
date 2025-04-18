Return-Path: <cgroups+bounces-7642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A174DA93E9A
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 22:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBD58E58B1
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48111238173;
	Fri, 18 Apr 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AevEJF20"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C423E340
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006425; cv=none; b=ug9NxCGpiZZK89td4WsUgTUwopSFa42pFP/nn12WZC6nmsRdRU8836jW53Oubzdgs4NEOLL60Td84ytcfcfZzvcM8MbbUtPWYAjpqj+/DdUnWXMJj3/SxtOQ14TCmImuWUHB1itaoaXDM1HtEul2lRdLQZnX7EAudKk3Fnkto1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006425; c=relaxed/simple;
	bh=wLnzr4bOfzqYdCAyeTv4QjUsgHNv49qasvWWQj0nzCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3MwpGRlhenMHP5hfHZzeAFvuTkkYKbXPfZFfoO8ErwvfCm61kuZA6iIvstiJw+F4KmGAVZ8Q3px94WCPBMZsI9QKTJ/elkKq0Hn0hIERYkQKwzuF6la4WlCQAXeB3sqdKL1s4/tLEkwj5iAWEbmXeMILTFbkrYH+LmjljtaeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AevEJF20; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745006410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Na1iVU527apBOW1sOmwLdGAvVcNB8dCTxjKe4PtoUU=;
	b=AevEJF208O05qljzylM/N2TRNMcrG0DH9Q0fNNroc3ECn9M7ewD/MHGjwTLpa6ruLstY1g
	s8K9HPCBGFZp6o+jfehX/o/lZGn9vrXlBEdUabsOm2yCcKRNILmod3n/lRcBS/evu4IWwa
	EgBimydmDaG9WYOddbgpwjrcn20weo4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: introduce non-blocking limit setting interfaces
Date: Fri, 18 Apr 2025 12:59:56 -0700
Message-ID: <20250418195956.64824-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Setting the max and high limits can trigger synchronous reclaim and/or
oom-kill if the usage is higher than the given limit. This behavior is
fine for newly created cgroups but it can cause issues for the node
controller while setting limits for existing cgroups.

In our production multi-tenant and overcommitted environment, we are
seeing priority inversion when the node controller dynamically adjusts
the limits of running jobs of different priorities. Based on the system
situation, the node controller may reduce the limits of lower priority
jobs and increase the limits of higher priority jobs. However we are
seeing node controller getting stuck for long period of time while
reclaiming from lower priority jobs while setting their limits and also
spends a lot of its own CPU.

One of the workaround we are trying is to fork a new process which sets
the limit of the lower priority job along with setting an alarm to get
itself killed if it get stuck in the reclaim for lower priority job.
However we are finding it very unreliable and costly. Either we need a
good enough time buffer for the alarm to be delivered after setting
limit and potentialy spend a lot of CPU in the reclaim or be unreliable
in setting the limit for much shorter but cheaper (less reclaim) alarms.

Let's introduce new limit setting interfaces which does not trigger
reclaim and/or oom-kill and let the processes in the target cgroup to
trigger reclaim and/or throttling and/or oom-kill in their next charge
request. This will make the node controller on multi-tenant
overcommitted environment much more reliable.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++++
 mm/memcontrol.c                         | 46 +++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8fb14ffab7d1..7b459c821afa 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1299,6 +1299,14 @@ PAGE_SIZE multiple when read back.
 	monitors the limited cgroup to alleviate heavy reclaim
 	pressure.
 
+  memory.high.nonblock
+        This is the same limit as memory.high but have different
+        behaviour for the writer of this interface. The program setting
+        the limit will not trigger reclaim synchronously if the
+        usage is higher than the limit and let the processes in the
+        target cgroup to trigger reclaim and/or get throttled on
+        hitting the high limit.
+
   memory.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
@@ -1316,6 +1324,14 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
+  memory.max.nonblock
+        This is the same limit as memory.max but have different
+        behaviour for the writer of this interface. The program setting
+        the limit will not trigger reclaim synchronously and/or trigger
+        the oom-kill if the usage is higher than the limit and let the
+        processes in the target cgroup to trigger reclaim and/or get
+        oom-killed on hitting their max limit.
+
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e2ea8b8a898..6ad1464b621a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4279,6 +4279,23 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static ssize_t memory_high_nonblock_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long high;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &high);
+	if (err)
+		return err;
+
+	page_counter_set_high(&memcg->memory, high);
+	memcg_wb_domain_size_changed(memcg);
+	return nbytes;
+}
+
 static int memory_max_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -4333,6 +4350,23 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static ssize_t memory_max_nonblock_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long max;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &max);
+	if (err)
+		return err;
+
+	xchg(&memcg->memory.max, max);
+	memcg_wb_domain_size_changed(memcg);
+	return nbytes;
+}
+
 /*
  * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
  * if any new events become available.
@@ -4557,12 +4591,24 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_high_show,
 		.write = memory_high_write,
 	},
+	{
+		.name = "high.nonblock",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_high_show,
+		.write = memory_high_nonblock_write,
+	},
 	{
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = memory_max_show,
 		.write = memory_max_write,
 	},
+	{
+		.name = "max.nonblock",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_max_show,
+		.write = memory_max_nonblock_write,
+	},
 	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.47.1


