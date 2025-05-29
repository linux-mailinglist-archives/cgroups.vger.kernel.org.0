Return-Path: <cgroups+bounces-8382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC8AC775C
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313DB1BA6792
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D789252296;
	Thu, 29 May 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwTaqbeH"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C0374D1;
	Thu, 29 May 2025 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494826; cv=none; b=YWsdCpsVahKOz5eowRDeQtPisrek2oM7PbpMBadgi6sjsF5qIaV7H5zGFLpFmlJA9/4YduGEu2hHh6wWL9jB7PHdl7J309zlSS6Vxj2F4DyciulVH4EeyD+EAfIotTFKs6dXvJgOjh2asGvJBJy9e+RWUZ1LlnNg0pSvAu5F93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494826; c=relaxed/simple;
	bh=Uj9KaTlKjZ04OwLsCy31/baS+zN3iU7xI+0xVMtauG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=blY3boxyVzq7wA0sB3vxiYKLUjcY9hZ4Bhzkd12Nj6mHQ5STX0+4CyLe+ILeCFYxdZZKNux6+2sufelJ4UUE0i8eU3gmZmM03AxgKUehbkcIsHS2vkfDi6hkDL2za74bwsY8iTQEsuvnQSbgVa8nozAVprGwy6CbiZMRuQb2ENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwTaqbeH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748494825; x=1780030825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uj9KaTlKjZ04OwLsCy31/baS+zN3iU7xI+0xVMtauG4=;
  b=bwTaqbeHE7O0inZMQrsNMOvcMZxmN6D0VIhuAmLM/LkkLXMyeFreILqq
   jc6njbzTn0Gr2XXuTIFiYDHmetYDgF/F/2JSuMj0FpOS4M0DO2PMNQuYY
   nDUz0h9QeRwI5UUiip6dE2sbePr+dWzbekhhMNcuVNFDlRvIW4n2cASpr
   YRccChTND/Qk9xYEBKTKsMsUYc3zLkpTTD1Tpr+D5p4cQbHYdIer87MrO
   8HkzKqDKxMNWvTYfcBBpyBvvBMQm8Wl8iIEzdiaOhV8CnoDRwyFu6ZlRL
   62VN51LynEr8/MCu+Q1tvcsYNu5obtof4pHQEpQn0my9Q13w2GdsomKhI
   g==;
X-CSE-ConnectionGUID: R5dJkOS7Rye9pGcrNI3RTQ==
X-CSE-MsgGUID: KLdUBbklQFC6xmiEBj/lvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49789212"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="49789212"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:00:24 -0700
X-CSE-ConnectionGUID: 6Yc4bf51SwCaqGHQMXw8dg==
X-CSE-MsgGUID: JbXJOqJWTOyPuhklUBvESA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143778407"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 28 May 2025 22:00:19 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: peterz@infradead.org,
	akpm@linux-foundation.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev
Cc: mingo@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mgorman@suse.de,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	tim.c.chen@intel.com,
	aubrey.li@intel.com,
	libo.chen@oracle.com,
	kprateek.nayak@amd.com,
	vineethr@linux.ibm.com,
	venkat88@linux.ibm.com,
	ayushjai@amd.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yu.chen.surf@foxmail.com,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v6 0/2] sched/numa: add statistics of numa balance task migration
Date: Thu, 29 May 2025 12:53:36 +0800
Message-Id: <cover.1748493462.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing the task migration and swap statistics in the following places:
/sys/fs/cgroup/{GROUP}/memory.stat
/proc/{PID}/sched
/proc/vmstat

These statistics facilitate a rapid evaluation of the performance and resource
utilization of the target workload.

Patch 1 is a fix from Libo to avoid task swapping for kernel threads
and user thread that does not have mm, because Numa balance only cares
about the user pages via VMA.

Patch 2 is the major change to expose the statistics of task migration and
swapping in corresponding files.

The reason to fold patch 1 and patch 2 into 1 patch set is that patch 1 is
necessary for patch 2 to avoid accessing a NULL mm_struct from a kernel
thread, which causes NULL pointer exception.

Changes since v5:
Enhance the git commit message to describe the reason why these events
are introduced in memory.stat/vmstat rather than cpu.stat.

Previous version:
v5:
https://lore.kernel.org/all/cover.1748002400.git.yu.c.chen@intel.com/
v4:
https://lore.kernel.org/all/cover.1746611892.git.yu.c.chen@intel.com/
v3:
https://lore.kernel.org/lkml/20250430103623.3349842-1-yu.c.chen@intel.com/
v2:
https://lore.kernel.org/lkml/20250408101444.192519-1-yu.c.chen@intel.com/
v1:
https://lore.kernel.org/lkml/20250402010611.3204674-1-yu.c.chen@intel.com/

Chen Yu (1):
  sched/numa: add statistics of numa balance task

Libo Chen (1):
  sched/numa: fix task swap by skipping kernel threads

 Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
 include/linux/sched.h                   | 4 ++++
 include/linux/vm_event_item.h           | 2 ++
 kernel/sched/core.c                     | 9 +++++++--
 kernel/sched/debug.c                    | 4 ++++
 kernel/sched/fair.c                     | 3 ++-
 mm/memcontrol.c                         | 2 ++
 mm/vmstat.c                             | 2 ++
 8 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.25.1


