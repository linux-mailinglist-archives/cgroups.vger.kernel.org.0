Return-Path: <cgroups+bounces-8383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C98AC775F
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDCD17ABCDB
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F825229C;
	Thu, 29 May 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnmWJtIk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523C374D1;
	Thu, 29 May 2025 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494932; cv=none; b=IH7Kv/+VuFmpmHeBPcp85pnxAsYthr0cFLR91eN4cMTDOn8epRgmGuxdTteh2vwB8DZ7fiTr76YGmtu58A0YsqGFkcGSTtyh8D3GoMlJZ+8LiopqNFxpatzfcppecFnXmPm2zjSneP7Ky8TesZvJQu3yyhGybrSfB4VTzkeA7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494932; c=relaxed/simple;
	bh=K3tT8ayPay0EwSKZy1JU8tEbONSykiQ4PlOtU3Ckvn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+YDQEiEqd+KMHO0U/KfZO3rUpTNZlCPA6DjZxajy1UeMV2WvyhDxNjhxDSnF1ctcVfLoFJtIk303EOjNwV3fq3WfdtYbqPIpHiWg1bdJCoXFvdXoiRu9uhg8XhVEhHAv5aOp6d43VQsff4xbjv06A6vpacLW5mwHT/D5m+GmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnmWJtIk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748494931; x=1780030931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3tT8ayPay0EwSKZy1JU8tEbONSykiQ4PlOtU3Ckvn4=;
  b=mnmWJtIkr3V/4bgOOV5LKVyDw+jeTxMJ5zfJ1B1uAblA6csMQLfQ67/2
   ++CeRS9P9n9nC3gQR6bnnRu6CdAxW019HCFGfU7KtzDhcnjNtTLWEwJZi
   Xthz+cxw9JGwtaBIahzHoF/AH9UlQz4vguhhy/XrRflElWwnUau5lMUW1
   TmpUOoO2m9XTQj1jEKDt1Qs/D7ETd3xNBkncZDwZgx235No54jKtNkD8R
   lestXhU1su2rhuNFaZSgmd8h4MV3HZxRq1jx3uJflvUh/bNOhrNB0axyd
   o6+N4UUmtaQ9PAaqi42NPh75hn9AuHdRpaOJOivr1djYHkGhl2bWdzOBb
   A==;
X-CSE-ConnectionGUID: nhMpptmNSQOkmdAUeniI8Q==
X-CSE-MsgGUID: suRZ2cSkRauz0VFEX4YWlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61595272"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="61595272"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:02:10 -0700
X-CSE-ConnectionGUID: J0O0Tn4mTC2aWNBc8tvOYQ==
X-CSE-MsgGUID: mHzp68MQRZCdkoW42DzvQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="148737864"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa005.jf.intel.com with ESMTP; 28 May 2025 22:02:04 -0700
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
	Ayush Jain <Ayush.jain3@amd.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v6 1/2] sched/numa: fix task swap by skipping kernel threads
Date: Thu, 29 May 2025 12:54:04 +0800
Message-Id: <43d68b356b25d124f0d222ebedf3859e86eefb9f.1748493462.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1748493462.git.yu.c.chen@intel.com>
References: <cover.1748493462.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Libo Chen <libo.chen@oracle.com>

Task swapping is triggered when there are no idle CPUs in
task A's preferred node. In this case, the NUMA load balancer
chooses a task B on A's preferred node and swaps B with A. This
helps improve NUMA locality without introducing load imbalance
between nodes. In the current implementation, B's NUMA node
preference is not mandatory. That is to say, a kernel thread
might be incorrectly chosen as B. However, kernel thread and
user space thread that does not have mm are not supposed to be
covered by NUMA balancing because NUMA balancing only considers
user pages via VMAs.

According to Peter's suggestion for fixing this issue, we use
PF_KTHREAD to skip the kernel thread. curr->mm is also checked
because it is possible that user_mode_thread() might create a
user thread without an mm. As per Prateek's analysis, after
adding the PF_KTHREAD check, there is no need to further check
the PF_IDLE flag:
"
- play_idle_precise() already ensures PF_KTHREAD is set before adding
  PF_IDLE

- cpu_startup_entry() is only called from the startup thread which
  should be marked with PF_KTHREAD (based on my understanding looking at
  commit cff9b2332ab7 ("kernel/sched: Modify initial boot task idle
  setup"))
"

In summary, the check in task_numa_compare() now aligns with
task_tick_numa().

Suggested-by: Michal Koutny <mkoutny@suse.com>
Tested-by: Ayush Jain <Ayush.jain3@amd.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v5->v6:
Add Reviewed-by from Shakeel.
v4->v5:
Add PF_KTHREAD check, and remove PF_IDLE check(Prateek).
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 125912c0e9dd..68aa5941c8ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2273,7 +2273,8 @@ static bool task_numa_compare(struct task_numa_env *env,
 
 	rcu_read_lock();
 	cur = rcu_dereference(dst_rq->curr);
-	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
+	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
+		    !cur->mm))
 		cur = NULL;
 
 	/*
-- 
2.25.1


