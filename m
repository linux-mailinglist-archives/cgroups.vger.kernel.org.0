Return-Path: <cgroups+bounces-4264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C290952366
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C541C214EF
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3581C57B7;
	Wed, 14 Aug 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYIww40y"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40C1B8EBE
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667350; cv=none; b=f3bJVa72qSfeWhuDzUh+ZyKWbYjOnuvs413xTe/OdVLR07bvdjtDU/0OstQf9SYFc+yVO0S42swHoRR965UeByxdKi+M4OiZ3xgjJBOc+IEixmvvEMv5hzgHmS+1Pglo/Ir06bJ7ZP4S9SVeJJGX1CfD1Pm8r41+RU0pAALpVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667350; c=relaxed/simple;
	bh=ZxXKk8CRxRvsA2lfcJFJ4euvtuZOpZlA6H8+DVhUuoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ppgc1aMG63YiNp2BopfpgMWI6CQqZXZ0LnWo1L92UYOa2WJeGd26PEBSrtSBJYfRCcEi2cRhwHfo77xNfcfbPVCHKKgYFRgg3/Aq/5AiACjtjsi3TVm/gnLNmVGhorJoJ/R1FoUDTdhYcNF8Jm8r2rDWfHFy41trOLkyLeYsxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYIww40y; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723667344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eCpg6JY4xdfuSX+uQFFlngNTZJeJ79jR/+n8cnnPGg=;
	b=uYIww40yZ2Xis6U+cV8wV/Qs15VdbFr767xvkUF6MKj22Z5GbZZ3gW76QyP813dZJJC4cN
	MmTNF4nMADLnjKP+viVJokLJazSp/Zr/b+oElSTlj+7+bo5blba50dZR8ER7c/fKvtdwrG
	2YVGk1D8gSWKSpDZE6ngs16vo+I9uI4=
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
Subject: [PATCH 4/4] memcg: initiate deprecation of pressure_level
Date: Wed, 14 Aug 2024 13:28:25 -0700
Message-ID: <20240814202825.2694077-5-shakeel.butt@linux.dev>
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

The pressure_level in memcg v1 provides memory pressure notifications to
the user space. At the moment it provides notifications for three levels
of memory pressure i.e. low, medium and critical, which are defined
based on internal memory reclaim implementation details. More
specifically the ratio or scanned and reclaimed pages during a memory
reclaim. However this is not robust as there are workloads with mostly
unreclaimable user memory or kernel memory.

For v2, the users can use PSI for memory pressure status of the system
or the cgroup. Let's start the deprecation process for pressure_level
and add warnings to gather the info on how the current users are using
this interface and how they can be used to PSI.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
 mm/memcontrol-v1.c                             | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 74cea6712d06..8ec1faf08b6b 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -86,6 +86,8 @@ Brief summary of control files.
                                      used.
  memory.force_empty		     trigger forced page reclaim
  memory.pressure_level		     set memory pressure notifications
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
  memory.move_charge_at_immigrate     set/show controls of moving charges
@@ -898,8 +900,10 @@ At reading, current status of OOM is shown.
           The number of processes belonging to this cgroup killed by any
           kind of OOM killer.
 
-11. Memory Pressure
-===================
+11. Memory Pressure (DEPRECATED)
+================================
+
+THIS IS DEPRECATED!
 
 The pressure level notifications can be used to monitor the memory
 allocation cost; based on the pressure, applications can implement
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 07343e338e4e..420c7d15f12a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1913,6 +1913,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
+		pr_warn_once("pressure_level is deprecated and will be removed. "
+			     "Please report your usecase to linux-mm-@kvack.org "
+			     "if you depend on this functionality. \n";
 		event->register_event = vmpressure_register_event;
 		event->unregister_event = vmpressure_unregister_event;
 	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
-- 
2.43.5


