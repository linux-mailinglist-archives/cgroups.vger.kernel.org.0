Return-Path: <cgroups+bounces-6711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1FFA441C5
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 15:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EAC18869BF
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E626A085;
	Tue, 25 Feb 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEar1t4h"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705233CFC;
	Tue, 25 Feb 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492286; cv=none; b=K86/bYJjseGDa8oZFQ4+pVAelNGlyeeJmJbCJ9+URQpiMJ7Pk6x8LvP5YUvAgrlf3/WeexOp+pW2naJL4BMPrNH5mC+VjX1K2qzyu9WEgsOpyJcwVD2a/e/d3jdIXDimLREcGPBvJWr5H590tNDZUo5xOg23y7K1xEmtHuGiLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492286; c=relaxed/simple;
	bh=sUXTHt6eh+QXI81EQBaYj0iPTuZrYTa5Od8UTyPzP8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IiSSdy4NADt1Ldyp7aAba6riAk+LkoDWtSFkgKperq4/zwAc0/O6MR2pgu6RKH5Qnui6/RbcOi/Um3DbrkkZcPjL1Ho+Qu+93InDV8+HlqMdvlxVIEqRe1Jh0ULbk7bECTB0GKqTEQ6UFwYM7XFsqGkwu0cj6bxfULNaC9+jQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEar1t4h; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740492285; x=1772028285;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sUXTHt6eh+QXI81EQBaYj0iPTuZrYTa5Od8UTyPzP8E=;
  b=fEar1t4how0iMWoj0GdcED7yPNQmSznw2pMM0KIUIBzmPI2k8ePuiCgE
   Obu+mBoSgc7Ud8WVy0SfVY05nUc/+zFwGtcFUF91CpjWYLRoJ2TUUeZcW
   bTotjmfaaRJLETOUjMDdQnryBK2KPu1BI/nvH8K7UDTzP+Od6hcyoUCcX
   aTajly2t5q1L3XLoG5ODRS/jZhvBGWR5xaooRrRCcIvviLmxjgCFZSWAt
   VU4jaZXrmMqSJIpxcV+qgcP3c6T7SywltR1bFABCbAp4mENht4frMd+oL
   d73QxuuLfSr+/Y9TqldzdpRlGP31fOOpDlNWwLvGCjeinnsGWu9SCVl/X
   A==;
X-CSE-ConnectionGUID: vqU87cMgQ6e9R/cKGVM8mQ==
X-CSE-MsgGUID: UdVqnBnOR5C9FkFe2TY7ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41424557"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41424557"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:04:44 -0800
X-CSE-ConnectionGUID: DLHCB871RPS+O8m+2dz66Q==
X-CSE-MsgGUID: vS2aVbs+RjSh1G++J6j2IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116590673"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 25 Feb 2025 06:04:38 -0800
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Michael Wang <yun.wang@linux.alibaba.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	David Rientjes <rientjes@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 0/3] sched/numa: Introduce per cgroup numa balance control 
Date: Tue, 25 Feb 2025 21:59:33 +0800
Message-Id: <cover.1740483690.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a per-cgroup interface to enable NUMA balancing
for specific cgroups. The system administrator needs to set
the NUMA balancing mode to NUMA_BALANCING_CGROUP=4 to enable
this feature. When in the NUMA_BALANCING_CGROUP mode, all
cgroups' NUMA balancing is disabled by default. After the
administrator enables this feature for a specific cgroup,
NUMA balancing for that cgroup is enabled.

This per-cgroup NUMA balancing control was once proposed in
2019 by Yun Wang[1]. Then, in 2024, Kaiyang Zhao mentioned
that he was working with Meta on per-cgroup NUMA control[2]
during a discussion with David Rientjes.

I could not find further discussion regarding per-cgroup NUMA
balancing from that point on. This set of RFC patches is a
rough and compile-passed version, and may have unhandled cases
(for example, THP). It has not been thoroughly tested and is
intended to initiate or resume the discussion on the topic of
per-cgroup NUMA load balancing.

The first patch is a NUMA load balancing statistics enhancement.
The second patch introduces per-cgroup NUMA balancing. The third
one enhances NUMA load balancing for the MPOL_INTERLEAVE policy.

Any feedback would be appreciated.

[1] https://lore.kernel.org/linux-fsdevel/60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com/
[2] https://lore.kernel.org/linux-mm/ZrukILyQhMAKWwTe@localhost.localhost/T/

Chen Yu (3):
  sched/numa: Introduce numa balance task migration and swap in
    schedstats
  sched/numa: Introduce per cgroup numa balance control
  sched/numa: Allow intervale memory allocation for numa balance

 include/linux/numa.h           |  1 +
 include/linux/sched.h          |  4 ++++
 include/linux/sched/sysctl.h   |  1 +
 include/linux/vm_event_item.h  |  2 ++
 include/uapi/linux/mempolicy.h |  1 +
 kernel/sched/core.c            | 42 ++++++++++++++++++++++++++++++++--
 kernel/sched/debug.c           |  4 ++++
 kernel/sched/fair.c            | 18 +++++++++++++++
 kernel/sched/sched.h           |  3 +++
 mm/memcontrol.c                |  2 ++
 mm/memory.c                    |  2 +-
 mm/mempolicy.c                 |  7 ++++++
 mm/mprotect.c                  |  5 ++--
 mm/vmstat.c                    |  2 ++
 14 files changed, 89 insertions(+), 5 deletions(-)

-- 
2.25.1


