Return-Path: <cgroups+bounces-8324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4639AC2334
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 14:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4ED1620D5
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD87404E;
	Fri, 23 May 2025 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBck4fu+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0E3C1F;
	Fri, 23 May 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005045; cv=none; b=GqG3wOCL3kz9otMbYCX3YvHl3JV8/cb0jhiaDRSaK6QCAPtysDC8X/3aRK9bjdYa+/fwSAByYzURsC4vBvPg6vDBU4LcVLcLoDEf7hOfgFMw0YUuOKAFexBtH2PNDe0eOYFoVDuyjJQOUdZta67ki1x9QcpjX6B/XRjxsCieyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005045; c=relaxed/simple;
	bh=Zia19yocWqcFtH5Li0XaRFMz+hChbIYHpNXvVfKumfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8vrUvcHRawtevKZ0JOaqkDa3Qhn4UKlXt1MUhKwwpsuz9XXbtkexkEW6Me9nCxwmKz8caUeBVMfHzbaFYTuBwAy4QNPlAMqi/InoQwJwQsG8ickq1LSWLm1JSfVyIXkTxv153QOFXHYOxJ0tgRDEJrrEKAUCgD/v15RmwkeDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBck4fu+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748005044; x=1779541044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zia19yocWqcFtH5Li0XaRFMz+hChbIYHpNXvVfKumfw=;
  b=QBck4fu+f1Rz6TxxlTQI8y2PJ9ncp+IcmWz45CJ9Pll7WvmkksTj3G5M
   jpN6Y5W6FZAzNsxQkKxMEeeMI11CpHFh7rr4DOT6aaF00Ixfeklslpziw
   RjiWCIp06lG4YHNBG7rhl6/X465ousjYEceosamKe678/kgSRzZPF8xaf
   jawlmBh42O4IXFeeMpMv2pLk8HAZtYDL9531nLE1LIVfw+hpnIVL+FDHu
   WfQz5OV8jqLla5mGe8VdbLFTNbzHrbr3Uy9qPwW2BhZ98jSrmXgKWZGji
   TQVnIzk83ko0hko8OOPQhjswSux2YBx24ymzWvXIFIgJ3/6dfjl5o6o3V
   w==;
X-CSE-ConnectionGUID: P+fZ9Qk1STqjrLW+9v9xrg==
X-CSE-MsgGUID: 5g4mpcvTRDmTWwC6uTc1lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61464557"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="61464557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 05:57:23 -0700
X-CSE-ConnectionGUID: iAphiYksSm+C/n+FfxfzKg==
X-CSE-MsgGUID: V0bcAz3KRKiJvhyx1nYg5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141196189"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa007.fm.intel.com with ESMTP; 23 May 2025 05:57:17 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: peterz@infradead.org,
	akpm@linux-foundation.org
Cc: mkoutny@suse.com,
	mingo@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mgorman@suse.de,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
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
Subject: [PATCH v5 0/2] sched/numa: add statistics of numa balance task migration
Date: Fri, 23 May 2025 20:48:02 +0800
Message-Id: <cover.1748002400.git.yu.c.chen@intel.com>
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

Changes since v4:
Skip the kernel thread in patch 1, by checking if the target thread
has PF_KTHREAD(Peter). Besides, remove the check for PF_IDLE, because
idle thread has PF_KTHREAD set already(Prateek).

Previous version:
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


