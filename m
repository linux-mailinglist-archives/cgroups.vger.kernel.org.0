Return-Path: <cgroups+bounces-8062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA20AADD2F
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38D69A19ED
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134421A94F;
	Wed,  7 May 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7lU0qj1"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041120CCED;
	Wed,  7 May 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616934; cv=none; b=eQuzosE1kYszZHY26HlaTn0GBusAlvX1USr5Wigt0OJVc387rvbH7z+I/2w/yZfkVrgNX4oRKTYDraKjUrbl5FXIqceO7yNW2T+bk0RvYqZ25i1XVwR2/HDvdbD95OgzT8aahkb6BGkupNTYfYp100fB9SaSsKFC6LzxPAhxzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616934; c=relaxed/simple;
	bh=keSFJ17byZIacrkA9Q+V/bwj92nFNZoHf+fY/qM0Me0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMQmt56Gm7vT9W0R/oVAOgcHOwbTRXID2W6LNyG0jGjykrAFIFB9MNuWqhG9m7PnttlCo0qSOglXeZgqEQLixDIj7ntDnIQy7SWz/CgXNPqUmAMG8CE46EX0PXB7Y+WxM2XuF42lwq0u3t0L8da6/nbpfjhuTCpLsSZXAwbypGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7lU0qj1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746616933; x=1778152933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=keSFJ17byZIacrkA9Q+V/bwj92nFNZoHf+fY/qM0Me0=;
  b=k7lU0qj1/I3oO66APas+JruigaBfXaP5LVobdSZZtamaVKXmupfTCydy
   uOni5hshBq1jUl3ns4keypNrDNbTeVgU7K/OMfRPk6NAxqy+0/Xjn6Xht
   LV3QF8OJ0Of6fkvq2rezfHWKAPyHPDiEd/of/uyARxfI/8ySYR5Jr1wo1
   A+vTPF1zem6rfE5Mirz94Qmy/OCLahuafqUF2UXAantSEpncSpyxb0MT5
   Arad9QDo7w/3s95+eEQJ/Xp3BWchZRd6MP/L5ir0b7FN+Z/QZJDF+yB5f
   E14FE/dHGy1ereMPZHo5SKjR6XakmWpC8qs8lw0lHqcrJSZie/SqtU3DU
   A==;
X-CSE-ConnectionGUID: YluFXpkeQaqp/1aiWmMK3Q==
X-CSE-MsgGUID: uR24XAleQvWsIy7A1njhNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52155806"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="52155806"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:22:11 -0700
X-CSE-ConnectionGUID: jFtpUtg3R3G77mWFegnbEA==
X-CSE-MsgGUID: tJLTWUbyT1SwHxuf0Oe82Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="166974025"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa001.fm.intel.com with ESMTP; 07 May 2025 04:22:06 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: mkoutny@suse.com,
	Ingo Molnar <mingo@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Chen, Tim C" <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Jain, Ayush" <ayushjai@amd.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.chen.surf@foxmail.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4 0/2] sched/numa: add statistics of numa balance task migration
Date: Wed,  7 May 2025 19:14:53 +0800
Message-Id: <cover.1746611892.git.yu.c.chen@intel.com>
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

Patch 1 is a fix from Libo to avoid task swapping for kernel threads,
because Numa balance only cares about the user pages via VMA.

Patch 2 is the major change to expose the statistics of task migration and
swapping in corresponding files.

The reason to fold patch 1 and patch 2 into 1 patch set is that patch 1 is
necessary for patch 2 to avoid accessing a NULL mm_struct from a kernel
thread, which causes NULL pointer exception.

The Tested-by and Acked-by tags are preserved, because these tags are provided
in version 1 which has the p->mm check.

Previous version:
v3:
https://lore.kernel.org/lkml/20250430103623.3349842-1-yu.c.chen@intel.com/
v2:
https://lore.kernel.org/lkml/20250408101444.192519-1-yu.c.chen@intel.com/
v1:
https://lore.kernel.org/lkml/20250402010611.3204674-1-yu.c.chen@intel.com/

Chen Yu (1):
  sched/numa: add statistics of numa balance task migration

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


