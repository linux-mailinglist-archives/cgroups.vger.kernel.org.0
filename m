Return-Path: <cgroups+bounces-4278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B4952526
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A9284B6A
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3179414AD3B;
	Wed, 14 Aug 2024 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HBHvyvqn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19B14A4E1
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672838; cv=none; b=LILKJDlDA4e9hU75hvq9/CXQucLcXqDn96cphnvnM1C2c9nUHBZ4A06JFSeAQm+xgCiJoohdnfWrTOngj43/JTG/0JFgbuF7DiQ6WaJdQaHN++YvpR6//U0RLEI3QQMQD6xrQZhrQ1tn1xWe9+sYLYK4/A8U0iYU5AM+HeEpDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672838; c=relaxed/simple;
	bh=4nPlmXdtET7MVF2oXpX8zknFPgJ1pueCHJDwjPJOqaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJbFqapNjvz/gFOr+5//g3aBchGuVL4gaUg9C7/u3bFXBZDlH520xqU2+Rgu6KXVBpbsCq8Fv5UUVfnmeBN4e1skfDLfaWW1764QlDFqraZNb4lVu4b1tGR8pHR+pu95Y4afhBHWcVPDxsSHExeWBQEnXV2O6PfPYlO4zFSujIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HBHvyvqn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxBQAPwN/d0yRus9CPsgbp4gq2sSHEHQBj1gyuLTZQI=;
	b=HBHvyvqnJWDy2mfX8AyaYzjISdzwSgxz2cvwPXfH0XnskTfGEsloaA1BghnYM50KtOxdUo
	pLH2sSEIXZGGGiRvvssuaZ8nSapVbNgIOb3GN0fuNkxAI9knDZphSZMcqFUq8YXwUhtLt4
	7cNR0GdTGzxwAlyo2uAsX0niIultcOA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 3/4] memcg: initiate deprecation of oom_control
Date: Wed, 14 Aug 2024 15:00:20 -0700
Message-ID: <20240814220021.3208384-4-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-1-shakeel.butt@linux.dev>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
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
Changes since v1:
- Fix build (T.J. Mercier)

 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
 mm/memcontrol-v1.c                             | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 6831c6c16e3f..0042206414c8 100644
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
index e0bb54e42011..334a02597d9a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1907,6 +1907,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->register_event = mem_cgroup_usage_register_event;
 		event->unregister_event = mem_cgroup_usage_unregister_event;
 	} else if (!strcmp(name, "memory.oom_control")) {
+		pr_warn_once("oom_control is deprecated and will be removed. "
+			     "Please report your usecase to linux-mm-@kvack.org"
+			     " if you depend on this functionality. \n");
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
@@ -2754,6 +2757,10 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	pr_warn_once("oom_control is deprecated and will be removed. "
+		     "Please report your usecase to linux-mm-@kvack.org if you "
+		     "depend on this functionality. \n");
+
 	/* cannot set to root cgroup and only 0 and 1 are allowed */
 	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
 		return -EINVAL;
-- 
2.43.5


