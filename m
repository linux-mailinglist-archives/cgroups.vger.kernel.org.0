Return-Path: <cgroups+bounces-4263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62D952365
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20C81C215EC
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68B1C68AC;
	Wed, 14 Aug 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTxI/hF6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1601C5792
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667343; cv=none; b=nvLKaRE9TR0TawoukXKFBY2MRX3/u1L3F/5T3sHz9ysEOnJn6by28xGMxc+S5hJtt/3snXkSkKDyBwQ4WEg229lVXYuHxgUYUbDnuONMRoXxiiwRZKNyXZBfDl+qnkUmWoZoMrOlRMbciaelYuiRVXn4S7ReBk0/rkN6hqLEQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667343; c=relaxed/simple;
	bh=WZrqqayGdHruKCu2ZwbREPeaB65zaDXSWWVn3cpVHRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDSjy0Kb9BVQ50GK/A0Uv8myITY4veSQC+qJnyC0n+2TBvX7APxivaaa8ShRuvLKwd0wE0K6ei2MyK0Iap0r0llEskMjf7hXB+D7m3T38Y/JIaJffVPPLkWR1SIZ2ovJQDLo6NYL4wyhNKqDCr7yaCK1w+l+gVIlZHz9pNmtpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTxI/hF6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723667338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6nvSZOz9QE0QcmtJItvdiDiC1dkEI/UgvNP1v9wjb4=;
	b=RTxI/hF6U5aR5/x110KhdXByEqtBRQLDxyno0Bp2FH/8UaaMMtMvvQUEcE747xNGGj5ZAr
	Tzu6Y4xh7inGaVCiMWkjcaY2vnpDJ60HeDDaEXrgiX/nSjlgUooZ3qit0CZUAmseLcoV7m
	LRpmuCJdmOrvK95RxEn3g3Y/WyXoLRk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 3/4] memcg: initiate deprecation of oom_control
Date: Wed, 14 Aug 2024 13:28:24 -0700
Message-ID: <20240814202825.2694077-4-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-1-shakeel.butt@linux.dev>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The oom_control provides functionality to disable memcg oom-killer,
notifications on oom-kill and reading the stats regarding oom-kills.
This interface was mainly introduced to provide functionality for
userspace oom-killers. However it is not robust enough and only supports
OOM handling in the page fault path.

For v2, the users can use the combination of memory.events notifications
and memory.high interface to provide userspace OOM-killing functionality.
Let's start the deprecation process for v1 and gather the info on how
the current users are using this interface and work on providing a more
robust functionality in v2.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
 mm/memcontrol-v1.c                             | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index afe5e95e9f7b..74cea6712d06 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -92,6 +92,8 @@ Brief summary of control files.
                                      This knob is deprecated and shouldn't be
                                      used.
  memory.oom_control		     set/show oom controls.
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
  memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
@@ -846,8 +848,10 @@ It's applicable for root and non-root cgroup.
 
 .. _cgroup-v1-memory-oom-control:
 
-10. OOM Control
-===============
+10. OOM Control (DEPRECATED)
+============================
+
+THIS IS DEPRECATED!
 
 memory.oom_control file is for OOM notification and other controls.
 
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index e0bb54e42011..07343e338e4e 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1907,6 +1907,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->register_event = mem_cgroup_usage_register_event;
 		event->unregister_event = mem_cgroup_usage_unregister_event;
 	} else if (!strcmp(name, "memory.oom_control")) {
+		pr_warn_once("oom_control is deprecated and will be removed. "
+			     "Please report your usecase to linux-mm-@kvack.org"
+			     " if you depend on this functionality. \n";
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
@@ -2754,6 +2757,10 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	pr_warn_once("oom_control is deprecated and will be removed. "
+		     "Please report your usecase to linux-mm-@kvack.org if you "
+		     "depend on this functionality. \n";
+
 	/* cannot set to root cgroup and only 0 and 1 are allowed */
 	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
 		return -EINVAL;
-- 
2.43.5


