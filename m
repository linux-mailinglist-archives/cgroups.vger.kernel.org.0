Return-Path: <cgroups+bounces-4279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B4952529
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2703EB225E5
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66114B97E;
	Wed, 14 Aug 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3mM4/fd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E214B970
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672843; cv=none; b=ddG2F52LF9knUPdTSN7KwCWHBug+qsduL5feYaQpSg7fu8SPbWV7gTTE09bT857gtLt2NoCH7YGu7M/ZBucSZPVe8iNyDGuNBz5DsBhyn5M4XaTxpgIQz/BjxNLeWqPBTk+CiqR1D1Pa9hPr+4sUoNyLvVAsq7fVI3n5Y0WDTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672843; c=relaxed/simple;
	bh=uvmJdKlphzCDj9J+1c4DYKQn2WXN+iiCPTHzulFPE/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbD4jWTnXOi51upaOdkWeEwQIe4JRDUGFANcuRUVYO/qvvkRT1ObVNaR4ATXDPll+fQuY5fvVMz/mHbvDdydE5e1BfjmoWnhc23Sc6kJRGonksWW/ylcJnE1RRQAFdnw2YC4Bd9V5xbLoudN6JxJr+qBVVvuns1AqAVvH3nkVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3mM4/fd; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTKRX6spDgpXKN9MCF3Pa/WT+sJ1zV3S3bnMyq0x3A4=;
	b=I3mM4/fdtZrE8ernV/ewmEGCnnv0Puhieiwj1WeFt7TAcdjW2hGuBxWLTrIULHCnqRNurT
	oiZYA9pG0E2wMZrCeKPKzwJ6sgUokA9GJcg3v8HdLCGRlbVuv9sI2eyRbbfeR+5NZM6qqt
	YIzUsK4ItOg3v+4dIOfOEedmgWMevSs=
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
Subject: [PATCH v2 4/4] memcg: initiate deprecation of pressure_level
Date: Wed, 14 Aug 2024 15:00:21 -0700
Message-ID: <20240814220021.3208384-5-shakeel.butt@linux.dev>
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
Changes since v1:
- Fix build (T.J. Mercier)

 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
 mm/memcontrol-v1.c                             | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0042206414c8..270501db9f4e 100644
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
index 334a02597d9a..52aecdae2c28 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1913,6 +1913,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
+		pr_warn_once("pressure_level is deprecated and will be removed. "
+			     "Please report your usecase to linux-mm-@kvack.org "
+			     "if you depend on this functionality. \n");
 		event->register_event = vmpressure_register_event;
 		event->unregister_event = vmpressure_unregister_event;
 	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
-- 
2.43.5


