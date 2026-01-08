Return-Path: <cgroups+bounces-12997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12736D06241
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 21:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C96430477E1
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 20:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEFE331205;
	Thu,  8 Jan 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AAJhU+QG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB26330B3F
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904745; cv=none; b=pdC3s+DChs2rnXAV3knfAZ8xRBZBPJBOAialU1a0pguVZrNlIEFlLRRt5OZwi3tKwEbu/5H692UC8j36YJyvGFExoSApGCvytF6XDeET5pERo9l9iDt2diFb56G1EhgWpusnLTf3VSExkKUHwmRFiRM2liJtBL7esvGkOL8cW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904745; c=relaxed/simple;
	bh=a5FayHYeLOjpSYndVEQNyEbTMfQR+C/FVM2n6KXYrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1O+Fn9gzhnqHNyRtAAEG7WYmJZCPzOHPBQQZKJprgmhg+GdTtThsqc6agrvKLUW99v0pL7xwTR78DuEBaLqQoIJF4+O48486pXF9hoqsu2tr/9QtPkON2j+ndx+yvZV2QjuRoKLjUB66UUsD+6hRGUsDbjISzrLjzByY7+5wNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AAJhU+QG; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so34659121cf.1
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904739; x=1768509539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRDiJ+UlJzmE9gGlU0qCIeblmwRaclHqLNtsuAzr4HM=;
        b=AAJhU+QGRlNWe4lqt0GifqyTq3VXjRFKFEaeOF3zUUdmCGLDtQCJuVwfCae5+OLl9Q
         I8c21JA5zmeklBxwY1CTf8h9SPlgGcA7DIa/1Y8cUBk+YkExbsGDIwYq1FIqoE2LCAVV
         PTCdoIG+LfI6qYBqTdv75rwfU5I3MK356ni6uKREs/ATTAsohSfn4u2fDHtYZN3yG1hH
         dlirk7CFoMIDjOM5p/k/cyVdebpjRH2FOPptO/jZcCFwCGnn4096ONOS8sVQU6hTliW+
         2IVQgg8fRoB5tUccO86rOR2auxmqOu5AXjasjRAs4VUKxl9ZTI3iDxoY7VVPIjYc++6n
         jCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904739; x=1768509539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rRDiJ+UlJzmE9gGlU0qCIeblmwRaclHqLNtsuAzr4HM=;
        b=QRsEJ5wkTyaE4awqyB35nrFIP60aZvfPOhRrAtVN2fvIr47ZkbrHKFOm42Pih6fXjw
         IeERy1i3MLwSWAxc7NfYLhTbgn8UxQM+0ytA/i8ujWP2Bui4FM6AUPeoqKT/SDSRB+0r
         7cC0pN2JLkSMTv6PG70q/+OkhaF53zjv5uh1JOnnEOPTYqzPSDmJ1VEau33HaWBPBJ94
         rIGEkVhidVhQJBnBcWPJKmeEhcfFKs4N2e8OjTxKOu68AQGWKpqswAlSefK/y31oTbwh
         FyaX59/CI1Iigbxei/kKArrQ2/mDV5aark2QyIfLwYIM0aUEJHqPyiNN1MOqIT8lO6Yd
         sHpA==
X-Forwarded-Encrypted: i=1; AJvYcCWgLHiXpjkuacIt86PrbAjKgc0eQwCYluQlCDBL0iYwx8kz2ZRt8nRyzrgNUwILrG5T6/EcjyGl@vger.kernel.org
X-Gm-Message-State: AOJu0YwujWwwimqu7ztNiCo0W/5Bp8RBRpDbsIWwgdmKBxKQBatjgbmp
	dswJfIgZE+PJ/LKB7WSNWwJwnBKexdAvGkFk/rmFroTQ3AmzSReOyaPr0DGv8ZesKdQ=
X-Gm-Gg: AY/fxX6sbrHum2LCLucvqzEnt/IhiCTMZPkEg7ohYNEslUFpeQWnhbe8tK8eKzNTSAY
	fGLDTg5JvVycYfLxb8uJkkAf679p5OoMeDnk6x0zYPXXSYor5R60lHAEU01+1IHrK3PPAC9Qbfz
	o42W11iaoudBHNPdxSaRBTrynRasVHxaf/mA8Xgg5zKoao8+VRRsauahm6Gj++mPfQvquNDepB2
	Qj6qFF3Eo4dFSPtLjZhSpqxaBndIDUBUGBWSAwFHnTK9FG1JeFwolu749xSAvF7TYQ+FqfoEWxY
	YbtDqNZkl/aMEef3dew/WSFP+1pqf3291srHXccd+nI3OLI9EEulzUBddgm5kSwXtwHWw4KIS9o
	ZoxU7VVu8TM2uQ1GKCRIqSlEzW0UYhrlwfjGeEJjEc/0S6Q/8NOl8NItKLsRzN+HhdiKI0IlqxD
	WTDz5UsJfqhL2PuQeF6GsmNdZAQ/UP5vb5UR8GkI5V9p2qkT4pF6hXICe8EfBNyNvrIi23Ae8fI
	cQ=
X-Google-Smtp-Source: AGHT+IFQyuUju0Z/aUbfqpVDbDingg5jj0Y3CKeme4WYcUfzCc6+dQALyvDYUzyj67d/yfod1gGU5A==
X-Received: by 2002:a05:622a:1101:b0:4ed:df09:a6a6 with SMTP id d75a77b69052e-4ffb48a8a54mr84063441cf.25.1767904738761;
        Thu, 08 Jan 2026 12:38:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:58 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 5/8] Documentation/admin-guide/cgroups: update docs for mems_allowed
Date: Thu,  8 Jan 2026 15:37:52 -0500
Message-ID: <20260108203755.1163107-6-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new information about mems_allowed and sysram_nodes, which says
mems_allowed may contain union(N_MEMORY, N_PRIVATE) nodes, while
sysram_nodes may only contain a subset of N_MEMORY nodes.

cpuset.mems.sysram is a new RO ABI which reports the list of
N_MEMORY nodes the cpuset is allowed to use, while
cpusets.mems and mems.effective may also contain N_PRIVATE.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../admin-guide/cgroup-v1/cpusets.rst         | 19 +++++++++++---
 Documentation/admin-guide/cgroup-v2.rst       | 26 +++++++++++++++++--
 Documentation/filesystems/proc.rst            |  2 +-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index c7909e5ac136..6d326056f7b4 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -158,21 +158,26 @@ new system calls are added for cpusets - all support for querying and
 modifying cpusets is via this cpuset file system.
 
 The /proc/<pid>/status file for each task has four added lines,
-displaying the task's cpus_allowed (on which CPUs it may be scheduled)
-and mems_allowed (on which Memory Nodes it may obtain memory),
-in the two formats seen in the following example::
+displaying the task's cpus_allowed (on which CPUs it may be scheduled),
+and mems_allowed (on which SystemRAM nodes it may obtain memory),
+in the formats seen in the following example::
 
   Cpus_allowed:   ffffffff,ffffffff,ffffffff,ffffffff
   Cpus_allowed_list:      0-127
   Mems_allowed:   ffffffff,ffffffff
   Mems_allowed_list:      0-63
 
+Note that Mems_allowed only shows SystemRAM nodes (N_MEMORY), not
+Private Nodes.  Private Nodes may be accessible via __GFP_THISNODE
+allocations if they appear in the task's cpuset.effective_mems.
+
 Each cpuset is represented by a directory in the cgroup file system
 containing (on top of the standard cgroup files) the following
 files describing that cpuset:
 
  - cpuset.cpus: list of CPUs in that cpuset
  - cpuset.mems: list of Memory Nodes in that cpuset
+ - cpuset.mems.sysram: read-only list of SystemRAM nodes (excludes Private Nodes)
  - cpuset.memory_migrate flag: if set, move pages to cpusets nodes
  - cpuset.cpu_exclusive flag: is cpu placement exclusive?
  - cpuset.mem_exclusive flag: is memory placement exclusive?
@@ -227,7 +232,9 @@ nodes with memory--using the cpuset_track_online_nodes() hook.
 
 The cpuset.effective_cpus and cpuset.effective_mems files are
 normally read-only copies of cpuset.cpus and cpuset.mems files
-respectively.  If the cpuset cgroup filesystem is mounted with the
+respectively.  The cpuset.effective_mems file may include both
+regular SystemRAM nodes (N_MEMORY) and Private Nodes (N_PRIVATE).
+If the cpuset cgroup filesystem is mounted with the
 special "cpuset_v2_mode" option, the behavior of these files will become
 similar to the corresponding files in cpuset v2.  In other words, hotplug
 events will not change cpuset.cpus and cpuset.mems.  Those events will
@@ -236,6 +243,10 @@ the actual cpus and memory nodes that are currently used by this cpuset.
 See Documentation/admin-guide/cgroup-v2.rst for more information about
 cpuset v2 behavior.
 
+The cpuset.mems.sysram file shows only the SystemRAM nodes (N_MEMORY)
+from cpuset.effective_mems, excluding any Private Nodes. This
+represents the nodes available for general memory allocation.
+
 
 1.4 What are exclusive cpusets ?
 --------------------------------
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..6af54efb84a2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2530,8 +2530,11 @@ Cpuset Interface Files
 	cpuset-enabled cgroups.
 
 	It lists the onlined memory nodes that are actually granted to
-	this cgroup by its parent. These memory nodes are allowed to
-	be used by tasks within the current cgroup.
+	this cgroup by its parent.  This includes both regular SystemRAM
+	nodes (N_MEMORY) and Private Nodes (N_PRIVATE) that provide
+	device-specific memory not intended for general consumption.
+	Tasks within this cgroup may access Private Nodes using explicit
+	__GFP_THISNODE allocations if the node is in this mask.
 
 	If "cpuset.mems" is empty, it shows all the memory nodes from the
 	parent cgroup that will be available to be used by this cgroup.
@@ -2541,6 +2544,25 @@ Cpuset Interface Files
 
 	Its value will be affected by memory nodes hotplug events.
 
+  cpuset.mems.sysram
+	A read-only multiple values file which exists on all
+	cpuset-enabled cgroups.
+
+	It lists the SystemRAM nodes (N_MEMORY) that are available for
+	general memory allocation by tasks within this cgroup.  This is
+	a subset of "cpuset.mems.effective" that excludes Private Nodes.
+
+	Normal page allocations are restricted to nodes in this mask.
+	The kernel page allocator, slab allocator, and compaction only
+	consider SystemRAM nodes when allocating memory for tasks.
+
+	Private Nodes are excluded from this mask because their memory
+	is managed by device drivers for specific purposes (e.g., CXL
+	compressed memory, accelerator memory) and should not be used
+	for general allocations.
+
+	Its value will be affected by memory nodes hotplug events.
+
   cpuset.cpus.exclusive
 	A read-write multiple values file which exists on non-root
 	cpuset-enabled cgroups.
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c92e95e28047..68f3d8ffc03b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -294,7 +294,7 @@ It's slow but very precise.
  Cpus_active_mm              mask of CPUs on which this process has an active
                              memory context
  Cpus_active_mm_list         Same as previous, but in "list format"
- Mems_allowed                mask of memory nodes allowed to this process
+ Mems_allowed                mask of SystemRAM nodes for general allocations
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
  nonvoluntary_ctxt_switches  number of non voluntary context switches
-- 
2.52.0


